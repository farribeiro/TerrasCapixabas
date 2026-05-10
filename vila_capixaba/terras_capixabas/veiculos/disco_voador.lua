-- Local references for performance
local vector_add = vector.add
local vector_multiply = vector.multiply
local math_sin = math.sin
local math_cos = math.cos
local math_rad = math.rad
local math_abs = math.abs
local core_sound_play = core.sound_play
local core_sound_stop = core.sound_stop

-- Generic M200X Entity Definition Function
local function create_m200x_entity(name, texture, description, inventory_image)
    core.register_entity(name, {
        initial_properties = {
            visual = "mesh",
            mesh = "m200x.glb",
            textures = {texture},
            visual_size = {x = 1, y = 1},
            physical = true,
            collide_with_objects = true,
            collisionbox = {-1.0, 0.0, -2.0, 1.0, 0.5, 2.0},
            stepheight = 1.0,
            backface_culling = false,
            eye_height = 9  -- MOVED HERE from outside initial_properties - THIS WAS THE FIX
        },
        
        _driver = nil,
        _speed = 0,
        _yaw = 0,
        _max_speed = 15,
        _idle_sound_handle = nil,
        _physics_timer = 0,
        _bob_timer = 0,
        _off_pending = false, -- New: Tracks if we are waiting to land to shut down
        _shutdown_timer = 0,   -- New: The 1 second delay timer
        seat_pos = {x = 0, y = 6, z = 1},
        seat_rot = {x = 0, y = 0, z = 0},
        sounds = {
            idle = "m200x_idle"
        },

        on_activate = function(self, staticdata, dtime_s)
            self.object:set_velocity({x = 0, y = 0, z = 0})
            self.object:set_acceleration({x = 0, y = -4.9, z = 0}) 
            self.object:set_rotation({x = 0, y = 0, z = 0})
            self.object:set_animation({x = 0, y = 0}, 0, 0)
        end,

        detach_driver = function(self)
            if not self._driver then return end
            local driver = self._driver
            local player_name = driver:get_player_name()
            
            driver:set_detach()
            driver:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
            
            if player_api and player_api.player_attached then
                player_api.player_attached[player_name] = false
                player_api.set_animation(driver, "stand", 30, false)
            end
            
            -- Prepare for landing sequence
            local v = self.object:get_velocity()
            self.object:set_velocity({x = 0, y = v.y, z = 0}) -- Kill horizontal drift
            
            self._off_pending = true -- Start the "waiting for floor" logic
            self._shutdown_timer = 0
            self._driver = nil
            self._speed = 0
            
            -- Note: We DO NOT stop sound or animation here anymore!
        end,

        on_rightclick = function(self, clicker)
            if not clicker or not clicker:is_player() then return end
            
            if self._driver == clicker then
                self:detach_driver()
                return
            end
            
            if not self._driver then
                self._driver = clicker
                self._off_pending = false -- Cancel shutdown if someone hops back in
                local player_name = clicker:get_player_name()
                
                clicker:set_attach(self.object, "", self.seat_pos, self.seat_rot, nil, {x = 0, y = self.initial_properties.eye_height, z = 0})
                player_api.player_attached[player_name] = true
                
                core.after(0.1, function()
                    if self._driver then
                        clicker:set_eye_offset({x = 0, y = self.initial_properties.eye_height, z = 0}, {x = 0, y = 0, z = -5})
                    end
                end)
                
                if player_api and player_api.set_animation then
                    player_api.set_animation(clicker, "sit", 30, false)
                end
                
                -- Power on
                self.object:set_animation({x = 0, y = 0.46}, 1, 0, true) 
                if not self._idle_sound_handle then
                    self._idle_sound_handle = core_sound_play(self.sounds.idle or "", {
                        object = self.object, gain = 1.0, loop = true
                    })
                end
            end
        end,

        on_step = function(self, dtime)
            local driver = self._driver
            local velocity = self.object:get_velocity()
            
            -- EMPTY / LANDING SEQUENCE LOGIC
            if not driver or not driver:is_player() then
                -- Apply half gravity
                self.object:set_acceleration({x = 0, y = -4.9, z = 0})
                self.object:set_rotation({x = 0, y = self.object:get_yaw(), z = 0})

                -- Sequence: Are we still in the air?
                if self._off_pending then
                    -- If vertical velocity is near zero, we have touched the floor
                    if math_abs(velocity.y) < 0.1 then
                        self._shutdown_timer = self._shutdown_timer + dtime
                        if self._shutdown_timer >= 1.0 then
                            -- SHUTDOWN EVERYTHING
                            self.object:set_animation({x = 0, y = 0}, 0, 0)
                            if self._idle_sound_handle then 
                                core_sound_stop(self._idle_sound_handle) 
                                self._idle_sound_handle = nil 
                            end
                            self._off_pending = false
                        end
                    end
                else
                    -- Totally off state (no driver, already landed)
                    -- Just making sure horizontal stays dead
                    if math_abs(velocity.x) > 0.1 or math_abs(velocity.z) > 0.1 then
                        self.object:set_velocity({x = 0, y = velocity.y, z = 0})
                    end
                end
                return
            end
            
            -- DRIVER IS INSIDE
            self._physics_timer = self._physics_timer + dtime
            if self._physics_timer < 0.05 then return end
            self._physics_timer = 0
            
            local ctrl = driver:get_player_control()
            local yaw = self.object:get_yaw()
            
            -- Tilt & Rotation
            local target_pitch = 0
            if ctrl.up then target_pitch = -0.17 
            elseif ctrl.down then target_pitch = 0.17 end
            
            if ctrl.left then yaw = yaw + math_rad(2) 
            elseif ctrl.right then yaw = yaw - math_rad(2) end

            self.object:set_yaw(yaw)
            self.object:set_rotation({x = target_pitch, y = yaw, z = 0})
            
            -- Speed
            local accel = 0
            if ctrl.up then accel = 1 elseif ctrl.down then accel = -1 end
            self._speed = math.min(self._max_speed, math.max(-self._max_speed, self._speed + accel * 0.5))
            if accel == 0 then self._speed = self._speed * 0.95 end
            
            local direction = {x = -math_sin(yaw), y = 0, z = math_cos(yaw)}
            local move_vel = vector_multiply(direction, self._speed)
            
            -- Hover / Bobbing
            self.object:set_acceleration({x = 0, y = 0, z = 0})
            self._bob_timer = self._bob_timer + dtime
            
            if ctrl.jump then 
                move_vel.y = 5
            elseif ctrl.sneak then 
                move_vel.y = -5
            else
                move_vel.y = math_sin(self._bob_timer * 3) * 0.2
            end
            
            self.object:set_velocity(move_vel)
            
            -- Maintain Sound
            if not self._idle_sound_handle then
                self._idle_sound_handle = core_sound_play(self.sounds.idle or "", {
                    object = self.object, gain = 1.0, loop = true
                })
            end
        end,

        on_detach_child = function(self, child)
            if child == self._driver then self:detach_driver() end
        end
    })

    core.register_craftitem(name .. "_spawn", {
        description = description,
        inventory_image = inventory_image,
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type ~= "node" then return itemstack end
            local pos = vector_add(pointed_thing.above, {x = 0, y = 0.5, z = 0})
            local entity = core.add_entity(pos, name)
            if entity and placer then
                entity:set_yaw(placer:get_look_horizontal())
            end
            if not core.is_creative_enabled(placer:get_player_name()) then
                itemstack:take_item()
            end
            return itemstack
        end
    })
end

-- Register variants
create_m200x_entity("terras_capixabas:vh_m200x", "m200x.png", "M200X Flying Saucer", "m200x_inv.png")
create_m200x_entity("terras_capixabas:vh_m200x_vermelho", "m200x_vermelho.png", "M200X Vermelho", "m200x_vermelho_inv.png")
create_m200x_entity("terras_capixabas:vh_m200x_verde", "m200x_verde.png", "M200X Verde", "m200x_verde_inv.png")