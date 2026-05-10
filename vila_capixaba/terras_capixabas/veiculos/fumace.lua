-- terras_capixabas/veiculos/fumace.lua

local vector_multiply, vector_distance = vector.multiply, vector.distance
local math_sin, math_cos, math_rad, math_abs = math.sin, math.cos, math.rad, math.abs
local core_sound_play, core_sound_stop = core.sound_play, core.sound_stop

core.register_entity("terras_capixabas:vh_fumace", {
    initial_properties = {
        visual = "mesh", 
        mesh = "fumace.glb", 
        textures = {"fumace.png"},
        visual_size = {x=1, y=1}, 
        physical = true, 
        collide_with_objects = true,
        collisionbox = {-0.8, 0.0, -1.2, 0.8, 1.5, 1.2}, 
        stepheight = 0.6, -- Matched to Veraneio for consistency
        backface_culling = false
    },

    _driver = nil, 
    _speed = 0, 
    _acceleration = 0, 
    _max_speed = 15,
    _sound_handle = nil, 
    _idle_sound_handle = nil, 
    _current_anim = "", 
    _is_driving = false,

    detach_driver = function(self)
        if not self._driver then return end
        local driver = self._driver
        local name = driver:get_player_name()
        
        driver:set_detach()
        driver:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
        
        if player_api and player_api.player_attached and player_api.set_animation then 
            player_api.player_attached[name] = false
            player_api.set_animation(driver, "stand", 30, false) 
        end
        
        if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
        if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) self._idle_sound_handle = nil end
        
        self._driver = nil
        self._is_driving = false
        self._speed = 0
    end,

    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end

        if not self._driver then
            if vector_distance(clicker:get_pos(), self.object:get_pos()) > 3 then return end

            self._driver = clicker
            self._is_driving = true
            local name = clicker:get_player_name()

            -- Attachment points (Adjusted for Fumacê scale)
            clicker:set_attach(self.object, "", {x = 0, y = 5.5, z = 0}, {x = 0, y = 0, z = 0})
            clicker:set_eye_offset({x=0,y=8,z=0},{x=0,y=6,z=0})
            
            if player_api and player_api.player_attached and player_api.set_animation then 
                player_api.player_attached[name] = true
                player_api.set_animation(clicker, "sit", 30, false) 
            end

            self._idle_sound_handle = core_sound_play("kombi", {
                object = self.object, loop = true, gain = 0.5, max_hear_distance = 16
            })
        else
            if self._driver ~= clicker then return end
            self:detach_driver()
        end
    end,

    on_step = function(self, dtime)
        -- Constant Gravity applied every step
        self.object:set_acceleration({x = 0, y = -9.81, z = 0})

        if not self._is_driving or not self._driver or not self._driver:is_player() then
            -- Stop movement if no driver
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
        local yaw = self.object:get_yaw()
        
        if ctrl.jump then 
            self:detach_driver()
            return 
        end
        
        -- Acceleration Logic
        local accel = 0
        if ctrl.up then accel = 1 elseif ctrl.down then accel = -1 end
        
        if accel ~= 0 then 
            self._speed = self._speed + (accel * 0.2)
        else
            -- Natural friction
            if self._speed > 0 then self._speed = math.max(0, self._speed - 0.1)
            elseif self._speed < 0 then self._speed = math.min(0, self._speed + 0.1) end
        end
        
        -- Clamp Speed
        if self._speed > self._max_speed then self._speed = self._max_speed 
        elseif self._speed < -self._max_speed then self._speed = -self._max_speed end
        
        -- Steering
        if ctrl.left then yaw = yaw + math_rad(2) 
        elseif ctrl.right then yaw = yaw - math_rad(2) end
        self.object:set_yaw(yaw)
        
        -- Apply Velocity
        local direction = {x = -math_sin(yaw), y = 0, z = math_cos(yaw)}
        local velocity = vector_multiply(direction, self._speed)
        velocity.y = self.object:get_velocity().y -- Retain gravity/falling velocity
        self.object:set_velocity(velocity)
        
        -- Sound Logic
        if math_abs(self._speed) > 0.1 then
            if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) self._idle_sound_handle = nil end
            if not self._sound_handle then 
                self._sound_handle = core_sound_play("kombi_idle", {object = self.object, loop = true, gain = 0.7}) 
            end
        else
            if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
            if not self._idle_sound_handle then 
                self._idle_sound_handle = core_sound_play("kombi", {object = self.object, loop = true, gain = 0.5}) 
            end
        end
        
        -- Animation Logic
        if self._speed > 0 then 
            if self._current_anim ~= "forward" then 
                self.object:set_animation({x=2, y=1}, 1, 0)
                self._current_anim = "forward" 
            end
        elseif self._speed < 0 then 
            if self._current_anim ~= "reverse" then 
                self.object:set_animation({x=2, y=1}, -1, 0)
                self._current_anim = "reverse" 
            end
        else 
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

-- Fumacê Spawn Egg
core.register_craftitem("terras_capixabas:vh_fumace_spawn_egg", {
    description = "Fumace", 
    inventory_image = "fumace_inv.png",
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        
        local pos = pointed_thing.above
        pos.y = pos.y + 0.1 -- Small offset to prevent physical engine "pop"
        
        local obj = core.add_entity(pos, "terras_capixabas:vh_fumace")
        if obj and placer then 
            obj:set_yaw(placer:get_look_horizontal())
        end
        if not core.is_creative_enabled(placer:get_player_name()) then 
            itemstack:take_item() 
        end
        return itemstack
    end
})