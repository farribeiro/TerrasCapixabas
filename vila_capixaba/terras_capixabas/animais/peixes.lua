-- PEIXES -----------------------------------------------------------

-- Simple local function, no global table needed
local function register_fish(name, texture, egg_texture)
    core.register_entity("terras_capixabas:" .. name, {
        initial_properties = {
            physical = false,
            collide_with_objects = false,
            collisionbox = {-0.25, 0, -0.25, 0.25, 0.1, 0.25},
            visual = "mesh",
            mesh = "peixe.glb",
            textures = {texture},
            visual_size = {x=1, y=1},
            backface_culling = false,
        },

        _animation_ranges = {swim = {x=0, y=1}},

        _home_pos = nil,
        _direction_angle = 0,
        _change_timer = 0,

        on_activate = function(self, staticdata)
            local pos = self.object:get_pos()
            self._home_pos = vector.round(pos)
            self._direction_angle = math.random() * math.pi * 2
            self._change_timer = 0
            self.object:set_properties({is_visible=true})
            self:set_animation("swim")
            self.object:set_yaw(self._direction_angle - math.pi/2)
        end,

        set_animation = function(self, anim)
            local range = self._animation_ranges[anim]
            if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
        end,

        on_step = function(self, dtime)
            local pos = self.object:get_pos()

            -- Check node below
            local node_below = core.get_node_or_nil({x=pos.x, y=pos.y - 0.5, z=pos.z})
            if not node_below then
                self.object:remove()
                return
            end

            -- Check if node is water or belongs to terras_capixabas mod namespace
            local is_water = core.get_item_group(node_below.name, "water") > 0
            local is_mod_node = node_below.name:sub(1, #("terras_capixabas:")) == "terras_capixabas:"

            if not (is_water or is_mod_node) then
                self.object:remove()
                return
            end

            self._change_timer = self._change_timer + dtime

            -- Change direction every 5 seconds
            if self._change_timer >= 5 then
                self._direction_angle = math.random() * math.pi * 2
                self.object:set_yaw(self._direction_angle - math.pi/2)
                self._change_timer = 0
            end

            -- Stay within 5 blocks of spawn point
            local dist_to_home = vector.distance({x=pos.x, y=0, z=pos.z}, {x=self._home_pos.x, y=0, z=self._home_pos.z})
            if dist_to_home >= 5 then
                local angle_back = math.atan2(self._home_pos.z - pos.z, self._home_pos.x - pos.x)
                self._direction_angle = angle_back
                self.object:set_yaw(self._direction_angle - math.pi/2)
            end

            -- Detect obstacle in front (ignores all terras_capixabas nodes)
            local dir_x = math.cos(self._direction_angle)
            local dir_z = math.sin(self._direction_angle)
            local forward_pos = {x = pos.x + dir_x * 0.6, y = pos.y, z = pos.z + dir_z * 0.6}
            local node_ahead = core.get_node_or_nil(forward_pos)

            if node_ahead then
                local ahead_is_water = core.get_item_group(node_ahead.name, "water") > 0
                local ahead_is_mod_node = node_ahead.name:sub(1, #("terras_capixabas:")) == "terras_capixabas:"
                if (not ahead_is_water) and (not ahead_is_mod_node) then
                    self._direction_angle = self._direction_angle + math.pi
                    self.object:set_yaw(self._direction_angle - math.pi/2)
                end
            end

            -- Move forward at original speed
            self.object:set_velocity({x = dir_x * 1, y = 0, z = dir_z * 0.3})
        end,

        on_punch = function(self)
            self.object:remove()
        end,
    })

    -- Spawn egg registration
    core.register_craftitem("terras_capixabas:an_" .. name, {
        description = name:gsub("^%l", string.upper):gsub("_", " ") .. " Spawn Egg",
        inventory_image = egg_texture,
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type == "node" then
                local pos = pointed_thing.above
                pos.y = pos.y + 0.1 -- keep fish inside water node
                core.add_entity(pos, "terras_capixabas:" .. name)
                if not core.is_creative_enabled(placer:get_player_name()) then
                    itemstack:take_item()
                end
                return itemstack
            end
        end
    })
end

-- Register all fish in one line each
register_fish("peixe_dory", "peixe_dory.png", "peixe_dory.png")
register_fish("peixe_nemo", "peixe_nemo.png", "peixe_nemo.png")
register_fish("peixe_aqua", "peixe_aqua.png", "peixe_aqua.png")
register_fish("peixe_cinza", "peixe_cinza.png", "peixe_cinza.png")