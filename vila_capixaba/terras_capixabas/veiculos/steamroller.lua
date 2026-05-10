-- terras_capixabas/veiculos/steamroller.lua

local vector_add, vector_multiply = vector.add, vector.multiply
local math_sin, math_cos, math_rad, math_abs, math_floor, math_max, math_min = math.sin, math.cos, math.rad, math.abs, math.floor, math.max, math.min
local core_get_node, core_set_node, core_remove_node, core_sound_play, core_sound_stop, core_chat_send_player = core.get_node, core.set_node, core.remove_node, core.sound_play, core.sound_stop, core.chat_send_player

-- Steamroller Entity
core.register_entity("terras_capixabas:vh_steamroller1", {
    initial_properties = {
        visual = "mesh", 
        mesh = "steamroller1.glb", 
        textures = {"steamroller1.png"},
        visual_size = {x = 1, y = 1}, 
        physical = true, 
        collide_with_objects = true,
        backface_culling = false, 
        -- FIX: Bottom Y changed from 0.0 to -0.5 to lift the vehicle out of the ground
        collisionbox = {-0.6, -0.5, -0.6, 0.6, 0.5, 1.5},
        stepheight = 1.1,
    },

    _driver = nil, _speed = 0, _acceleration = 0, _max_speed = 4,
    _sound_handle = nil, _idle_sound_handle = nil, _current_anim = "", _is_driving = false,
    paving_enabled = false, sneak_was_pressed = false, _pave_timer = 0,

    detach_driver = function(self)
        if not self._driver then return end
        local driver = self._driver
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
        self.paving_enabled = false

        if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
        if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) self._idle_sound_handle = nil end
    end,

    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end

        if not self._driver then
            if vector.distance(clicker:get_pos(), self.object:get_pos()) > 3 then return end
            
            self._driver = clicker
            self._is_driving = true

            local name = clicker:get_player_name()
            clicker:set_attach(self.object, "", {x = 0, y = 15, z = 4}, {x = 0, y = 0, z = 0})
            clicker:set_eye_offset({x=0, y=22, z=0}, {x=0, y=22, z=0})
            
            if player_api and player_api.player_attached then
                player_api.player_attached[name] = true
                player_api.set_animation(clicker, "sit", 30, false)
            end

            if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) end
            self._idle_sound_handle = core_sound_play("kombi_idle", {
                object = self.object, loop = true, gain = 0.5, max_hear_distance = 16
            })
            
            self.paving_enabled = false
        else
            if self._driver ~= clicker then return end
            self:detach_driver()
        end
    end,

    on_step = function(self, dtime)
        -- Apply Gravity
        self.object:set_acceleration({x = 0, y = -9.81, z = 0})

        if not self._is_driving or not self._driver or not self._driver:is_player() then
            local v = self.object:get_velocity()
            self.object:set_velocity({x = 0, y = v.y, z = 0})
            
            if self._current_anim ~= "idle" then
                self.object:set_animation({x = 0, y = 0.4}, 1, 0)
                self._current_anim = "idle"
            end
            return
        end

        local player = self._driver
        local ctrl = player:get_player_control()
        local pos = self.object:get_pos()
        local yaw = self.object:get_yaw()

        if ctrl.jump then
            self:detach_driver()
            return
        end

        -- Driving Logic
        local acceleration = 0
        if ctrl.up then acceleration = 1 elseif ctrl.down then acceleration = -1 end
        
        if acceleration ~= 0 then
            self._speed = self._speed + acceleration * 0.1
        else
            if self._speed > 0 then self._speed = math_max(0, self._speed - 0.1)
            elseif self._speed < 0 then self._speed = math_min(0, self._speed + 0.1) end
        end
        self._speed = math_max(math_min(self._speed, self._max_speed), -self._max_speed)

        if ctrl.left then yaw = yaw + math_rad(1.5) elseif ctrl.right then yaw = yaw - math_rad(1.5) end
        self.object:set_yaw(yaw)

        -- FIX: Corrected direction vector (Facing forward properly)
        local direction = {x = -math_sin(yaw), y = 0, z = math_cos(yaw)}
        local velocity = vector_multiply(direction, self._speed)
        velocity.y = self.object:get_velocity().y
        self.object:set_velocity(velocity)

        -- Paving Toggle
        if ctrl.sneak and not (self.sneak_was_pressed or false) then
            self.paving_enabled = not self.paving_enabled
            core_chat_send_player(player:get_player_name(), "Steamroller Paving: " .. (self.paving_enabled and "ON" or "OFF"))
        end
        self.sneak_was_pressed = ctrl.sneak

        -- Paving Logic
        if self.paving_enabled and math_abs(self._speed) > 0.1 then
            self._pave_timer = self._pave_timer + dtime
            if self._pave_timer > 0.1 then
                self._pave_timer = 0
                local side_dir = {x = math_cos(yaw), y = 0, z = math_sin(yaw)}
                local drum_center = vector_add(pos, vector_multiply(direction, 1.3))
                
                for offset = -1.5, 1.5, 1.0 do
                    local drum_pos = vector_add(drum_center, vector_multiply(side_dir, offset))
                    local p_top = {x=math_floor(drum_pos.x+0.5), y=math_floor(drum_pos.y+0.5), z=math_floor(drum_pos.z+0.5)}
                    local n_top = core_get_node(p_top)
                    
                    if n_top.name ~= "air" and core.registered_nodes[n_top.name] and not core.registered_nodes[n_top.name].walkable then
                        core_remove_node(p_top)
                    end

                    for y_off = 0, -1.5, -0.5 do
                        local p = {x=math_floor(drum_pos.x+0.5), y=math_floor(drum_pos.y+y_off+0.5), z=math_floor(drum_pos.z+0.5)}
                        local node = core_get_node(p)
                        if node.name ~= "air" and core.registered_nodes[node.name] and core.registered_nodes[node.name].walkable then
                            if node.name ~= "default:cobble" then
                                core_set_node(p, {name = "default:cobble"})
                            end
                            break
                        end
                    end
                end
            end
        end

        -- Sound and Animation
        if math_abs(self._speed) > 0.1 then
            if not self._sound_handle then
                self._sound_handle = core_sound_play("kombi", {object = self.object, loop = true, gain = 0.7})
            end
            local anim_speed = self._speed > 0 and 1 or -1
            if self._current_anim ~= (anim_speed > 0 and "forward" or "reverse") then
                self.object:set_animation({x = 2, y = 1}, anim_speed, 0)
                self._current_anim = anim_speed > 0 and "forward" or "reverse"
            end
        else
            if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
            if self._current_anim ~= "idle" then
                self.object:set_animation({x = 0, y = 0.4}, 1, 0)
                self._current_anim = "idle"
            end
        end
    end,

    on_detach_child = function(self, child)
        if child == self._driver then self:detach_driver() end
    end
})

-- Steamroller Spawn Egg
core.register_craftitem("terras_capixabas:vh_steamroller1_spawn_egg", {
    description = "Rolo Compressor",
    inventory_image = "steamroller1_inv.png",
    
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = pointed_thing.above
        -- Spawn at 0.1 to let it settle on the floor naturally
        pos.y = pos.y + 0.1 
        local obj = core.add_entity(pos, "terras_capixabas:vh_steamroller1")
        if obj and placer then
            obj:set_yaw(placer:get_look_horizontal())
        end
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end
})