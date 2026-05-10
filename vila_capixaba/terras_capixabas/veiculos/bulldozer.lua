-- terras_capixabas/veiculos/bulldozer.lua

-- Local references for performance
local vector_add = vector.add
local vector_multiply = vector.multiply
local math_rad = math.rad
local math_random = math.random
local core_get_node = core.get_node
local core_remove_node = core.remove_node
local core_sound_play = core.sound_play
local core_sound_stop = core.sound_stop
local core_yaw_to_dir = core.yaw_to_dir
local core_chat_send_player = core.chat_send_player

-- Bulldozer Entity for Luanti (Dynamic Physics Version)
core.register_entity("terras_capixabas:vh_bulldozer1", {
    initial_properties = {
        visual = "mesh",
        mesh = "bulldozer.glb",
        textures = {"bulldozer1.png"},
        visual_size = {x = 1, y = 1},
        physical = true,
        collide_with_objects = true,
        backface_culling = false,
        collisionbox = {-0.8, -1, -0.8, 0.8, 1.0, 1.5},
        stepheight = 1.1, -- Default to climbing mode
    },

    driver = nil,
    yaw = 0,
    speed = 0,
    bulldoze_enabled = false, 
    sneak_was_pressed = false,
    idle_sound = nil,
    move_sound = nil,
    bulldoze_timer = 0,
    ground_timer = 0,

    detach_driver = function(self)
        if not self.driver then return end
        local driver = self.driver
        if not driver or not driver:is_player() then
            self.driver = nil
            return
        end
        
        if self.idle_sound then core_sound_stop(self.idle_sound) self.idle_sound = nil end
        if self.move_sound then core_sound_stop(self.move_sound) self.move_sound = nil end
        local name = driver:get_player_name()
        driver:set_detach()
        -- RESET EYE OFFSET when detaching
        driver:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
        if player_api and player_api.player_attached then
            player_api.player_attached[name] = false
            player_api.set_animation(driver, "stand", 30, false)
        end
        self.driver = nil
        self.speed = 0
        self.bulldoze_enabled = false
        self.object:set_properties({stepheight = 1.1})
        self.object:set_velocity({x=0, y=0, z=0})
    end,

    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end

        if not self.driver then
            self.driver = clicker
            self.yaw = self.object:get_yaw()
            -- seat position followed by rotation
            clicker:set_attach(self.object, "", {x = 0, y = 10, z = -6}, {x = 0, y = 0, z = 0})
            -- ADD EYE OFFSET for proper first-person view at head height
            clicker:set_eye_offset({x=0, y=16, z=10}, {x=0, y=0, z=0})

            local name = clicker:get_player_name()
            if player_api and player_api.player_attached then
                player_api.player_attached[name] = true
                player_api.set_animation(clicker, "sit", 30, false)
            end

            self.idle_sound = core_sound_play("kombi_idle", {
                object = self.object, loop = true, gain = 0.5, max_hear_distance = 16
            })
            
            self.bulldoze_enabled = false 
            -- Ensure properties are reset when entering
            self.object:set_properties({stepheight = 1.1})
        else
            if self.driver ~= clicker then return end
            self:detach_driver()
        end
    end,

    on_step = function(self, dtime)
        local obj = self.object
        local pos = obj:get_pos()

        -- Basic Gravity
        self.ground_timer = self.ground_timer + dtime
        if self.ground_timer > 0.2 then
            self.ground_timer = 0
            local below = core_get_node({x = pos.x, y = pos.y - 0.5, z = pos.z})
            local def = core.registered_nodes[below.name]
            if not def or not def.walkable then
                obj:set_acceleration({x = 0, y = -9.8, z = 0})
            else
                obj:set_acceleration({x = 0, y = 0, z = 0})
                local v = obj:get_velocity()
                if v.y ~= 0 then obj:set_velocity({x = v.x, y = 0, z = v.z}) end
            end
        end

        -- FIXED: Check if driver exists and is still a player
        if not self.driver or not self.driver:is_player() then
            if self.idle_sound then core_sound_stop(self.idle_sound) self.idle_sound = nil end
            if self.move_sound then core_sound_stop(self.move_sound) self.move_sound = nil end
            self.object:set_velocity({x = 0, y = self.object:get_velocity().y, z = 0})
            
            -- Reset driver reference if it's invalid
            if self.driver and not self.driver:is_player() then
                self.driver = nil
            end
            
            return
        end
        
        local ctrl = self.driver:get_player_control()

        if ctrl.jump then
            self:detach_driver()
            return
        end

        -- TOGGLE LOGIC WITH PROPERTY SWAP
        if ctrl.sneak and not self.sneak_was_pressed then
            self.bulldoze_enabled = not self.bulldoze_enabled
            if self.bulldoze_enabled then
                -- Lower blade: Prevent climbing, enable plowing
                obj:set_properties({stepheight = 0.1})
                core_chat_send_player(self.driver:get_player_name(), "Bulldozer: PLOWING MODE (Blade Down)")
            else
                -- Raise blade: Allow climbing, disable plowing
                obj:set_properties({stepheight = 1.1})
                core_chat_send_player(self.driver:get_player_name(), "Bulldozer: TRAVEL MODE (Blade Up)")
            end
        end
        self.sneak_was_pressed = ctrl.sneak

        -- Movement
        if ctrl.up then self.speed = 4.5
        elseif ctrl.down then self.speed = -3.5
        else self.speed = 0 end

        if ctrl.left then self.yaw = self.yaw + math_rad(2.5)
        elseif ctrl.right then self.yaw = self.yaw - math_rad(2.5) end

        obj:set_yaw(self.yaw)
        local dir = core_yaw_to_dir(self.yaw)
        local current_v = obj:get_velocity()
        obj:set_velocity({x = dir.x * self.speed, y = current_v.y, z = dir.z * self.speed})

        -- Sound
        if self.speed ~= 0 then
            if not self.move_sound then
                self.move_sound = core_sound_play("kombi", {object = obj, loop = true, gain = 0.7, max_hear_distance = 16})
            end
        else
            if self.move_sound then core_sound_stop(self.move_sound) self.move_sound = nil end
        end

        ---------------------------------------------------------
        -- DYNAMIC PLOWING LOGIC
        ---------------------------------------------------------
        if self.bulldoze_enabled and self.speed > 0 then 
            self.bulldoze_timer = self.bulldoze_timer + dtime
            if self.bulldoze_timer > 0.05 then
                self.bulldoze_timer = 0

                local side_dir = core_yaw_to_dir(self.yaw + math_rad(90))
                
                -- Check a wide area 
                for side_offset = -1.2, 1.2, 0.6 do
                    for height_offset = -0.2, 1.8, 0.5 do
                        -- Look FURTHER forward (1.7) so the engine clears the block 
                        -- BEFORE the collision box (which ends at 1.5) hits it.
                        local blade_p = vector_add(pos, vector_multiply(dir, 1.7))
                        blade_p = vector_add(blade_p, vector_multiply(side_dir, side_offset))
                        blade_p.y = blade_p.y + height_offset
                        
                        local n = core_get_node(blade_p)
                        if n.name ~= "air" and n.name ~= "ignore" then
                            local def = core.registered_nodes[n.name]
                            if def and def.walkable and def.drawtype ~= "liquid" then
                                core_remove_node(blade_p)
                                if math_random(1, 10) == 1 then
                                    core_sound_play("default_dug_node", {pos = blade_p, gain = 0.2, max_hear_distance = 8})
                                end
                            -- Handle plants/grass specifically if they aren't walkable
                            elseif def and not def.walkable and n.name ~= "air" then
                                core_remove_node(blade_p)
                            end
                        end
                    end
                end
            end
        end
    end,

    on_detach_child = function(self, child)
        if child == self.driver then
            self:detach_driver()
        end
    end
})

-- Bulldozer Spawn Egg (Inventory Item)
core.register_craftitem("terras_capixabas:vh_bulldozer1_spawn_egg", {
    description = "Pá Mecânica",
    inventory_image = "bulldozer1_inv.png",

    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then
            return itemstack
        end

        local pos = pointed_thing.above
        pos.y = pos.y + 0.5

        local obj = core.add_entity(pos, "terras_capixabas:vh_bulldozer1")
        if obj and placer then
            obj:set_yaw(placer:get_look_horizontal())
            obj:get_luaentity().driver = nil
        end

        local player_name = placer:get_player_name()
        if not core.is_creative_enabled(player_name) then
            itemstack:take_item()
        end

        return itemstack
    end,
})