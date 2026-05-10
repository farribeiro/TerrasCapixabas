-- TEST ENTITY - SIMPLE LEFT/RIGHT MOVEMENT WITH 1-BLOCK CLIMBING

core.register_entity("terras_capixabas:test_entity", { -- Registers the entity "terras_capixabas:test_entity"

initial_properties = { 
visual = "mesh",                    
mesh = "test_entity.glb",         
textures = {"test_entity.png"},       
visual_size = {x=1, y=1},               
physical = true,                      
collisionbox = {-0.4, 0, -0.4, 0.4, 1.0, 0.4},        
weight = 5, 
automatic_face_movement_max_rotation_per_sec = 30, -- Entity rotates toward movement automatically (degrees/sec)
},

-- PRELIMINARIES -------------------------------------------------------------------------------------
_start_pos = nil, -- Começa parado
_phase = 0, -- Movement phase: 0 = waiting, 1 = moving right, 2 = moving left
_timer = 0, -- Timer for delays (2-second later)
_target = nil, -- The current movement destination (left or right point)

on_activate = function(self, staticdata) 
self._timer = 0 -- Reset the timer
self._phase = 0 -- Start in waiting phase
self._start_pos = self.object:get_pos() -- Save the current position as the base point
self.object:set_velocity({x=0, y=0, z=0}) -- Stop any velocity at spawn

-- BEGIN -------------------------------------------------------------------------------------

-- Apply gravity (Y = -10)
self.object:set_acceleration({x=0, y=-10, z=0}) 
end,

on_step = function(self, dtime)
    -- Get current position and direction
    local pos = self.object:get_pos()
    local dir_x = (self._phase == 1) and 1 or -1  -- 1 = right, -1 = left

    -- Initialize target if missing (better initialization)
    if not self._target or not self._start_pos then
        self._start_pos = vector.round(pos)
        self._target = {
            x = self._start_pos.x + (self._phase == 1 and 2 or -2),
            y = self._start_pos.y,
            z = self._start_pos.z
        }
        return  -- Skip this step to let positions settle
    end

    -- Face the direction of movement
    self.object:set_yaw((self._phase == 1) and -math.pi / 2 or math.pi / 2)

    -- Improved obstacle detection (checks at foot and knee level)
    local ray_start = {x = pos.x, y = pos.y + 0.1, z = pos.z}
    local ray_end = {x = pos.x + dir_x * 0.6, y = pos.y + 0.1, z = pos.z}  -- Slightly shorter ray
    local ray = core.raycast(ray_start, ray_end, false, true)
    local hit = ray:next()

    if hit and hit.type == "node" then
        -- Check if the obstacle is climbable
        local hit_pos = hit.under
        local node_above = {x = hit_pos.x, y = hit_pos.y + 1, z = hit_pos.z}
        local node_above_def = core.get_node(node_above)

        if not core.registered_nodes[node_above_def.name].walkable then
            -- More controlled climbing
            local vel = self.object:get_velocity()
            vel.y = 5  -- Slightly reduced from 6 for better control
            vel.x = dir_x * 0.5  -- Keep some horizontal momentum
            self.object:set_velocity(vel)
            return
        else
            -- Unclimbable: stop and turn around
            self.object:set_velocity({x = 0, y = 0, z = 0})
            self._phase = (self._phase == 1) and 2 or 1
            self._target.x = self._start_pos.x + (self._phase == 1 and 2 or -2)
            return
        end
    end

    -- Check if we've reached the target
    local dist = math.abs(pos.x - self._target.x)
    if dist < 0.2 then  -- Slightly increased threshold
        -- Reached target: switch direction
        self._phase = (self._phase == 1) and 2 or 1
        self._target.x = self._start_pos.x + (self._phase == 1 and 2 or -2)
        -- Brief pause at turn points
        self.object:set_velocity({x = 0, y = 0, z = 0})
        return
    end

    -- Normal movement with velocity
    local vel = {
        x = dir_x * 1.2,  -- Slightly faster speed
        y = self.object:get_velocity().y,  -- Preserve vertical velocity
        z = 0
    }
    self.object:set_velocity(vel)
end,

on_punch = function(self) 
self.object:remove() -- Instantly delete entity when punched (no HP used)
end
})


core.register_craftitem("terras_capixabas:test_entity_inv", {
    description = "Test Entity Egg",
    inventory_image = "test_entity_inv.png",
    on_place = function(itemstack, placer, pointed_thing)  -- Places entity when used
        if pointed_thing.type == "node" then
            local pos = pointed_thing.under
            core.add_entity({x=pos.x, y=pos.y+1, z=pos.z}, "terras_capixabas:test_entity")
            itemstack:take_item()  -- Consume the egg
        end
        return itemstack
    end
})