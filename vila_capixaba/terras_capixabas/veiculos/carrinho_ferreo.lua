-- terras_capixabas/veiculos/carrinho_ferreo.lua

local vector_distance = vector.distance
local vector_new = vector.new
local math_abs = math.abs
local math_floor = math.floor
local core_get_node = core.get_node
local core_sound_play = core.sound_play
local core_sound_stop = core.sound_stop
local get_item_group = core.get_item_group

local carts = {
    "terras_capixabas:carrinho_ferreo1",
    "terras_capixabas:carrinho_ferreo2",
    "terras_capixabas:carrinho_ferreo3"
}

local function find_rail_below(pos)
    local check_pos = {x = pos.x, y = pos.y - 0.3, z = pos.z}
    local node = core_get_node(check_pos)
    if get_item_group(node.name, "rail") > 0 then
        return true, check_pos
    end
    check_pos = {x = pos.x, y = pos.y - 0.6, z = pos.z}
    node = core_get_node(check_pos)
    if get_item_group(node.name, "rail") > 0 then
        return true, check_pos
    end
    check_pos = {x = pos.x, y = pos.y, z = pos.z}
    node = core_get_node(check_pos)
    if get_item_group(node.name, "rail") > 0 then
        return true, check_pos
    end
    return false
end

local function find_best_rail(pos)
    local best_rail = nil
    local best_dist = 3.0
    for y_offset = -1.0, 0.5, 0.3 do
        local check_pos = {x = pos.x, y = pos.y + y_offset, z = pos.z}
        local node = core_get_node(check_pos)
        if get_item_group(node.name, "rail") > 0 then
            local dist = math_abs(y_offset)
            if dist < best_dist then
                best_dist = dist
                best_rail = check_pos
            end
        end
    end
    if not best_rail then
        local offsets = {
            {x = 0.3, y = -0.3, z = 0},
            {x = -0.3, y = -0.3, z = 0},
            {x = 0, y = -0.3, z = 0.3},
            {x = 0, y = -0.3, z = -0.3}
        }
        for _, offset in ipairs(offsets) do
            local check_pos = {
                x = pos.x + offset.x,
                y = pos.y + offset.y,
                z = pos.z + offset.z
            }
            local node = core_get_node(check_pos)
            if get_item_group(node.name, "rail") > 0 then
                local dist = vector_distance(pos, check_pos)
                if dist < best_dist then
                    best_dist = dist
                    best_rail = check_pos
                end
            end
        end
    end
    if best_rail then
        return true, best_rail
    end
    return false
end

local function get_rail_direction(pos)
    if not pos then return vector_new(0, 0, -1) end
    local node = core_get_node(pos)
    local name = node.name or ""
    local dir = vector_new(0, 0, -1)
    if name:find("_x") or name:find("_ew") then
        dir = vector_new(-1, 0, 0)
    elseif name:find("_z") or name:find("_ns") then
        dir = vector_new(0, 0, -1)
    elseif name:find("_slope") or name:find("inclinado") then
        if name:find("_x") then
            dir = vector_new(-1, 0.5, 0)
        else
            dir = vector_new(0, 0.5, -1)
        end
    else
        local param2 = node.param2 or 0
        if param2 == 0 then dir = vector_new(0, 0, -1)
        elseif param2 == 1 then dir = vector_new(-1, 0, 0)
        elseif param2 == 2 then dir = vector_new(0, 0, 1)
        elseif param2 == 3 then dir = vector_new(1, 0, 0) end
    end
    return dir
end

local function register_cart(name, texture)
    core.register_entity(name, {
        initial_properties = {
            visual = "mesh",
            mesh = "carrinho_ferreo.glb",
            textures = {texture},
            visual_size = {x = 1, y = 1},
            physical = true,
            collide_with_objects = true,
            collisionbox = {-0.5, -1.1, -0.5, 0.5, -1, 0.5},
            stepheight = 0.6,
            backface_culling = false
        },

        _driver = nil,
        _speed = 0,
        _max_speed = 4.5,
        _accel_rate = 0.15,
        _friction = 0.05,
        _is_riding = false,
        _sound_handle = nil,
        _direction = vector_new(0, 0, -1),
        _last_rail_pos = nil,
        _target_y = nil,
        _smooth_factor = 0.3,

        detach_driver = function(self)
            if not self._driver then return end
            local driver = self._driver
            driver:set_detach()
            driver:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
            if player_api and player_api.player_attached and player_api.set_animation then
                player_api.player_attached[driver:get_player_name()] = false
                player_api.set_animation(driver, "stand", 30, false)
            end
            if self._sound_handle then
                core_sound_stop(self._sound_handle)
                self._sound_handle = nil
            end
            self._driver = nil
            self._is_riding = false
            self._speed = 0
        end,

        on_rightclick = function(self, clicker)
            if not clicker or not clicker:is_player() then return end
            if not self._driver then
                if vector_distance(clicker:get_pos(), self.object:get_pos()) > 3 then return end
                self._driver = clicker
                self._is_riding = true
                clicker:set_attach(self.object, "", {x = 0, y = -8, z = 0}, {x = 0, y = 180, z = 0})
                clicker:set_eye_offset({x = 0, y = -2, z = 0}, {x = 0, y = 0, z = 0})
                if player_api and player_api.player_attached and player_api.set_animation then
                    player_api.player_attached[clicker:get_player_name()] = true
                    player_api.set_animation(clicker, "sit", 30, false)
                end
            else
                if self._driver == clicker then
                    self:detach_driver()
                end
            end
        end,

        on_step = function(self, dtime)
            local pos = self.object:get_pos()
            if not pos then return end
            local onrail, railpos = find_rail_below(pos)
            if not onrail then
                onrail, railpos = find_best_rail(pos)
            end

            if onrail and railpos then
                self.object:set_acceleration({x = 0, y = 0, z = 0})
                local target_y = railpos.y + 0.3
                local current_y = pos.y
                local new_y
                if self._target_y == nil then
                    self._target_y = target_y
                end
                self._target_y = self._target_y + (target_y - self._target_y) * 0.1
                if math_abs(current_y - self._target_y) > 0.01 then
                    new_y = current_y + (self._target_y - current_y) * 0.2
                else
                    new_y = self._target_y
                end
                self.object:set_pos({x = pos.x, y = new_y, z = pos.z})

                if not self._last_rail_pos or
                   vector_distance(railpos, self._last_rail_pos) > 0.5 then
                    self._direction = get_rail_direction(railpos)
                    self._last_rail_pos = railpos
                end

                if self._is_riding and self._driver and self._driver:is_player() then
                    local ctrl = self._driver:get_player_control()
                    if ctrl.jump or ctrl.aux1 then
                        self:detach_driver()
                        return
                    end
                    if ctrl.up then
                        self._speed = self._speed + self._accel_rate
                    elseif ctrl.down then
                        self._speed = self._speed - self._accel_rate
                    else
                        if self._speed > 0 then
                            self._speed = math.max(0, self._speed - self._friction)
                        elseif self._speed < 0 then
                            self._speed = math.min(0, self._speed + self._friction)
                        end
                    end
                    if self._speed > self._max_speed then
                        self._speed = self._max_speed
                    elseif self._speed < -self._max_speed then
                        self._speed = -self._max_speed
                    end
                end

                local velocity = {
                    x = self._direction.x * self._speed,
                    y = self._direction.y * math_abs(self._speed) * 0.2,
                    z = self._direction.z * self._speed
                }
                self.object:set_velocity(velocity)

                if math_abs(self._speed) > 0.1 then
                    if not self._sound_handle then
                        self._sound_handle = core_sound_play("vagao", {
                            object = self.object,
                            loop = true,
                            gain = 0.5,
                            max_hear_distance = 16
                        })
                    end
                else
                    if self._sound_handle then
                        core_sound_stop(self._sound_handle)
                        self._sound_handle = nil
                    end
                end
            else
                self.object:set_acceleration({x = 0, y = -9.81, z = 0})
                self._speed = 0
                self._target_y = nil
                if self._sound_handle then
                    core_sound_stop(self._sound_handle)
                    self._sound_handle = nil
                end
            end
        end,

        on_detach_child = function(self, child)
            if child == self._driver then
                self:detach_driver()
            end
        end,

        on_activate = function(self, staticdata, dtime)
            self._speed = 0
            self._target_y = nil
        end
    })
end

register_cart("terras_capixabas:carrinho_ferreo1", "carrinho_ferreo1.png")
register_cart("terras_capixabas:carrinho_ferreo2", "carrinho_ferreo2.png")
register_cart("terras_capixabas:carrinho_ferreo3", "carrinho_ferreo3.png")

core.register_craftitem("terras_capixabas:carrinho_ferreo_spawn_egg", {
    description = "Carrinho Ferreo",
    inventory_image = "carrinho_ferreo_inv.png",
    sound = {footstep = "terras_capixabas_ferro_footstep"},

    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.above
        local _, railpos = find_rail_below(pos)
        if railpos then
            pos.y = railpos.y + 0.3
        end
        local choice = carts[math.random(#carts)]
        core.add_entity(pos, choice)
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end
})
