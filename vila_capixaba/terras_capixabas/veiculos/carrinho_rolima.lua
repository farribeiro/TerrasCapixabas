-- terras_capixabas/veiculos/carrinho_rolima.lua

-- Local references for performance
local vector_add = vector.add
local vector_multiply = vector.multiply
local vector_distance = vector.distance
local math_sin = math.sin
local math_cos = math.cos
local math_rad = math.rad
local math_abs = math.abs
local math_floor = math.floor
local core_get_node = core.get_node
local core_sound_play = core.sound_play
local core_sound_stop = core.sound_stop

-- Carrinho Roliça Entity
core.register_entity("terras_capixabas:vh_carrinho_rolima", {
    initial_properties = {
        visual = "mesh",
        mesh = "carrinho_rolima.glb",
        textures = {"carrinho_rolima.png"},
        visual_size = {x=1, y=1},
        physical = true,
        collide_with_objects = false,
        collisionbox = {-1.0, 0.0, -2.0, 1.0, 0.5, 2.0},
        stepheight = 0.5,
        backface_culling = false
    },

    _driver = nil,
    _speed = 0,
    _acceleration = 0,
    _max_speed = 15,
    _sound_handle = nil,
    _current_anim = "",
    _is_driving = false,

    detach_driver = function(self)
        if not self._driver then return end
        local driver = self._driver
        if not driver or not driver:is_player() then
            self._driver = nil
            self._is_driving = false
            return
        end
        
        local name = driver:get_player_name()
        driver:set_detach()
        driver:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
        if player_api and player_api.player_attached then
            player_api.player_attached[name] = false
            player_api.set_animation(driver, "stand", 30, false)
        end
        self._driver = nil
        self._is_driving = false
        self._speed = 0
        self._acceleration = 0
        if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
    end,

    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end

        if not self._driver then
            local player_pos = clicker:get_pos()
            local vehicle_pos = self.object:get_pos()
            if vector_distance(player_pos, vehicle_pos) > 3 then return end

            self._driver = clicker
            self._is_driving = true
            self.object:set_properties({collide_with_objects = true})

            local name = clicker:get_player_name()
            clicker:set_attach(self.object, "", {x = 0, y = 2, z = 0}, {x = 0, y = 0, z = 0})
            clicker:set_eye_offset({x=0, y=1.2, z=0}, {x=0, y=0, z=0})
            
            if player_api and player_api.player_attached then
                player_api.player_attached[name] = true
                player_api.set_animation(clicker, "sit", 30, false)
            end
        else
            if self._driver ~= clicker then return end
            self:detach_driver()
        end
    end,

    on_step = function(self, dtime)
        local pos = self.object:get_pos()
        
        -- GRAVITY: Apply always
        self.object:set_acceleration({x = 0, y = -9.81, z = 0})
        
        -- Stop falling if on ground
        local node_below = core_get_node({x=pos.x, y=pos.y - 0.1, z=pos.z})
        if core.registered_nodes[node_below.name].walkable then
            local vel = self.object:get_velocity()
            if vel.y < 0 then
                self.object:set_velocity({x = vel.x, y = 0, z = vel.z})
            end
        end

        if not self._is_driving or not self._driver or not self._driver:is_player() then
            if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
            self.object:set_properties({collide_with_objects = false})
            self.object:set_velocity({x = 0, y = self.object:get_velocity().y, z = 0})
            if self._current_anim ~= "idle" then
                self.object:set_animation({x = 0, y = 0.4}, 1, 0)
                self._current_anim = "idle"
            end
            if self._driver and not self._driver:is_player() then
                self._driver = nil
                self._is_driving = false
            end
            return
        end

        local player = self._driver
        local ctrl = player:get_player_control()
        local yaw = self.object:get_yaw()

        if ctrl.jump then
            self:detach_driver()
            return
        end

        local acceleration = 0
        if ctrl.up then acceleration = 1 elseif ctrl.down then acceleration = -1 end
        self._acceleration = acceleration

        if self._acceleration ~= 0 then
            self._speed = self._speed + self._acceleration * 0.2
        else
            if self._speed > 0 then
                self._speed = self._speed - 0.1
                if self._speed < 0 then self._speed = 0 end
            elseif self._speed < 0 then
                self._speed = self._speed + 0.1
                if self._speed > 0 then self._speed = 0 end
            end
        end

        if self._speed > self._max_speed then self._speed = self._max_speed
        elseif self._speed < -self._max_speed then self._speed = -self._max_speed end

        if ctrl.left then yaw = yaw + math_rad(2)
        elseif ctrl.right then yaw = yaw - math_rad(2) end
        self.object:set_yaw(yaw)

        local direction = {x = -math_sin(yaw), y = 0, z = math_cos(yaw)}
        local velocity = vector_multiply(direction, self._speed)
        velocity.y = self.object:get_velocity().y
        self.object:set_velocity(velocity)

        -- Sound/Animation
        if math_abs(self._speed) > 0.1 then
            if not self._sound_handle then
                self._sound_handle = core_sound_play("rolima", {object = self.object, loop = true, gain = 0.7, max_hear_distance = 16})
            end
            local anim = self._speed > 0 and "forward" or "reverse"
            if self._current_anim ~= anim then
                self.object:set_animation({x=2, y=1}, (anim == "forward" and 2 or -2), 0)
                self._current_anim = anim
            end
        else
            if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
            if self._current_anim ~= "idle" then
                self.object:set_animation({x=0, y=0.4}, 1, 0)
                self._current_anim = "idle"
            end
        end
    end,

    on_detach_child = function(self, child)
        if child == self._driver then self:detach_driver() end
    end
})

core.register_craftitem("terras_capixabas:vh_carrinho_rolima_spawn_egg", {
    description = "Carrinho Roliça",
    inventory_image = "carrinho_rolima_inv.png",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.above
        pos.y = pos.y + 0.1
        local obj = core.add_entity(pos, "terras_capixabas:vh_carrinho_rolima")
        if obj and placer then obj:set_yaw(placer:get_look_horizontal()) end
        if not core.is_creative_enabled(placer:get_player_name()) then itemstack:take_item() end
        return itemstack
    end,
})