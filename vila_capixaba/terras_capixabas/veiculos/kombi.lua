-- terras_capixabas/veiculos/kombi.lua

local vector_multiply, vector_distance = vector.multiply, vector.distance
local math_sin, math_cos, math_rad, math_abs = math.sin, math.cos, math.rad, math.abs
local core_sound_play, core_sound_stop = core.sound_play, core.sound_stop

-- Generic Kombi Entity Definition Function
local function create_kombi_entity(name, texture, description, inventory_image)
    core.register_entity(name, {
        initial_properties = {
            visual = "mesh", 
            mesh = "kombi.glb", 
            textures = {texture},
            visual_size = {x=1, y=1}, 
            physical = true, 
            collide_with_objects = true, -- Changed to true for better physics stability
            collisionbox = {-0.8, 0.0, -1.2, 0.8, 1.5, 1.2},
            stepheight = 0.6, 
            backface_culling = false
        },

        _driver = nil, _speed = 0, _acceleration = 0, _max_speed = 15,
        _sound_handle = nil, _idle_sound_handle = nil, _current_anim = "", _is_driving = false,

        detach_driver = function(self)
            if not self._driver then return end
            local driver = self._driver
            local player_name = driver:get_player_name()
            
            driver:set_detach()
            driver:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
            
            if player_api and player_api.player_attached then
                player_api.player_attached[player_name] = false
                player_api.set_animation(driver, "stand", 30, false)
            end
            
            self._driver = nil
            self._is_driving = false
            self._speed = 0
            
            if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
            if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) self._idle_sound_handle = nil end
        end,

        on_rightclick = function(self, clicker)
            if not clicker or not clicker:is_player() then return end

            if not self._driver then
                if vector_distance(clicker:get_pos(), self.object:get_pos()) > 3 then return end

                self._driver = clicker
                self._is_driving = true
                local name = clicker:get_player_name()

                -- FIX: Changed rotation from 0 to math.pi (180 degrees) so player faces forward
                clicker:set_attach(self.object, "", {x = 0, y = 10.5, z = 0}, {x = 0, y = math.pi, z = 0})
                clicker:set_eye_offset({x=0,y=12,z=0},{x=0,y=6,z=0})
                
                if player_api and player_api.player_attached then
                    player_api.player_attached[name] = true
                    player_api.set_animation(clicker, "sit", 30, false)
                end

                if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) end
                self._idle_sound_handle = core_sound_play("kombi_idle", {
                    object = self.object, loop = true, gain = 0.5, max_hear_distance = 16
                })
            else
                if self._driver ~= clicker then return end
                self:detach_driver()
            end
        end,

        on_step = function(self, dtime)
            -- Apply constant gravity
            self.object:set_acceleration({x = 0, y = -9.81, z = 0})

            if not self._is_driving or not self._driver or not self._driver:is_player() then
                local v = self.object:get_velocity()
                self.object:set_velocity({x = 0, y = v.y, z = 0})
                
                if self._current_anim ~= "idle" then
                    self.object:set_animation({x = 0, y = 0.4}, 1, 0)
                    self._current_anim = "idle"
                end
                
                -- Cleanup sounds if player disconnected
                if self._driver and not self._driver:is_player() then
                    self:detach_driver()
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

            -- FIX: Movement logic (Up = Forward, Down = Backward)
            local accel = 0
            if ctrl.up then 
                accel = 1 
            elseif ctrl.down then 
                accel = -1 
            end

            if accel ~= 0 then
                self._speed = self._speed + (accel * 0.2)
            else
                -- Friction
                if self._speed > 0 then self._speed = math.max(0, self._speed - 0.1)
                elseif self._speed < 0 then self._speed = math.min(0, self._speed + 0.1) end
            end

            if self._speed > self._max_speed then self._speed = self._max_speed
            elseif self._speed < -self._max_speed then self._speed = -self._max_speed end

            -- Steering
            if ctrl.left then yaw = yaw + math_rad(2) 
            elseif ctrl.right then yaw = yaw - math_rad(2) end
            self.object:set_yaw(yaw)

            -- Apply Velocity 
            -- Note: direction z is usually math.cos(yaw) for forward in Luanti
            local direction = {x = -math_sin(yaw), y = 0, z = math_cos(yaw)}
            local velocity = vector_multiply(direction, self._speed)
            velocity.y = self.object:get_velocity().y
            self.object:set_velocity(velocity)

            -- Sound Control
            if math_abs(self._speed) > 0.1 then
                if self._idle_sound_handle then core_sound_stop(self._idle_sound_handle) self._idle_sound_handle = nil end
                if not self._sound_handle then
                    self._sound_handle = core_sound_play("kombi", {object = self.object, loop = true, gain = 0.7})
                end
            else
                if self._sound_handle then core_sound_stop(self._sound_handle) self._sound_handle = nil end
                if not self._idle_sound_handle then
                    self._idle_sound_handle = core_sound_play("kombi_idle", {object = self.object, loop = true, gain = 0.5})
                end
            end

            -- Animation Control
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

    -- Register spawn egg
    core.register_craftitem(name .. "_spawn_egg", {
        description = description,
        inventory_image = inventory_image,
        
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type ~= "node" then return itemstack end
            
            -- FIX: Spawning at +0.1 to prevent "air flying" glitch caused by node collision
            local pos = pointed_thing.above
            pos.y = pos.y + 0.1
            
            local obj = core.add_entity(pos, name)
            if obj and placer then
                obj:set_yaw(placer:get_look_horizontal())
            end
            if not core.is_creative_enabled(placer:get_player_name()) then
                itemstack:take_item()
            end
            return itemstack
        end
    })
end

-- Register all Kombi variants
create_kombi_entity("terras_capixabas:vh_kombi_azul", "kombi_azul.png", "Kombi Azul", "kombi_azul_inv.png")
create_kombi_entity("terras_capixabas:vh_kombi_azul_celeste", "kombi_azul_celeste.png", "Kombi Azul Celeste", "kombi_azul_celeste_inv.png")
create_kombi_entity("terras_capixabas:vh_kombi_vermelha", "kombi_vermelha.png", "Kombi Vermelha", "kombi_vermelha_inv.png")