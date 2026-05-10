local utils = dofile(core.get_modpath("terras_capixabas") .. "/npcs/main/utils.lua")

-- Local references
local vec_round, vec_dist, vec_dir, vec_add, vec_mul, vec_sub = 
    vector.round, vector.distance, vector.direction, vector.add, vector.multiply, vector.subtract
local math_random, math_pi, atan2, cos, sin, abs, sqrt, min, max = 
    math.random, math.pi, math.atan2, math.cos, math.sin, math.abs, math.sqrt, math.min, math.max
local get_node, registered_nodes, get_player = 
    core.get_node_or_nil, core.registered_nodes, core.get_player_by_name
local get_objects = core.get_objects_inside_radius
local find_path = core.find_path

local M = {}

-- Configuration
local CONFIG = {
    collision_radius = 1.2,
    collision_force = 2.0,
    path_update_interval = 2.0,
    footstep_interval = 0.4,
    footstep_gain = 0.3,
    pathfinding_max_distance = 50,
    pathfinding_jump = true,
    pathfinding_drop = true,
    sidewalk_range = 30,
    max_wander_distance = 5, -- FIXED: Rigid 5 block patrol radius
    min_follow_distance = 2,
    max_follow_distance = 30,
    walk_speed = 1.5,        -- Adjusted for realistic pace
    min_stop_time = 3.0,     -- FIXED: Realistic pause
    max_stop_time = 6.0,
    gravity = -9.81,
    idle_chance = 0.4,       -- Chance to pause at waypoint
}

-- Robust 2D distance to prevent "Arithmetic on Y (nil)" crashes
local function get_dist_2d(p1, p2)
    if not p1 or not p2 then return 0 end
    local dx = p2.x - p1.x
    local dz = p2.z - p1.z
    return sqrt(dx * dx + dz * dz)
end

-- Animation definitions
local ANIMATIONS = {
    idle = {start = 0, stop = 0, speed = 1},
    sit = {start = 0.2, stop = 0.3, speed = 1},
    lay = {start = 0.4, stop = 0.5, speed = 1},
    stand_balcony = {start = 0.6, stop = 0.7, speed = 1},
    lay_on_belly = {start = 0.8, stop = 0.9, speed = 1},
    dance = {start = 1, stop = 1.6, speed = 1},
    walk = {start = 1.8, stop = 2.4, speed = 1},
}

-- State categories
local STATIC_STATES = {
    sit = true, lay = true, stand_balcony = true, 
    lay_on_belly = true, dance = true
}

function M.set_animation(self, anim)
    if not self.object or self.current_animation == anim then return end
    local a = self.animations[anim]
    if not a then return end
    if self.name == "terras_capixabas:carroca" and anim == "walk" then
        self.object:set_animation({x = 0.0, y = 2.0}, a.speed, 0, 0.1)
    else
        self.object:set_animation({x = a.start, y = a.stop}, a.speed, 0, 0.1)
    end
    self.current_animation = anim
end

function M.calculate_avoidance(self, pos)
    local avoidance = {x = 0, y = 0, z = 0}
    local nearby = get_objects(pos, CONFIG.collision_radius)
    local count = 0
    
    for _, obj in ipairs(nearby) do
        if obj ~= self.object then
            local entity = obj:get_luaentity()
            if entity and (entity._is_npc or entity.npc_id) then
                local opos = obj:get_pos()
                local diff = vec_sub(pos, opos)
                local dist = vec_dist(pos, opos)
                
                if dist < CONFIG.collision_radius and dist > 0.1 then
                    local force = (CONFIG.collision_radius - dist) / CONFIG.collision_radius
                    avoidance.x = avoidance.x + (diff.x / dist) * force
                    avoidance.z = avoidance.z + (diff.z / dist) * force
                    count = count + 1
                end
            end
        end
    end
    
    if count > 0 then
        local mag = sqrt(avoidance.x^2 + avoidance.z^2)
        if mag > 0 then
            avoidance.x = (avoidance.x / mag) * CONFIG.collision_force
            avoidance.z = (avoidance.z / mag) * CONFIG.collision_force
        end
    end
    return avoidance
end

function M.update_path(self, pos)
    if not find_path or (core.features and not core.features.find_path) then
        return false
    end
    
    self.path_update_timer = (self.path_update_timer or 0) + (self.timer or 0)
    if self.path_update_timer < CONFIG.path_update_interval then
        return self.path ~= nil
    end
    self.path_update_timer = 0
    
    local dist = vec_dist(pos, self.spawn_pos)
    if dist < 10 or dist > CONFIG.pathfinding_max_distance then
        self.path = nil
        return false
    end
    
    local path = find_path(pos, self.spawn_pos, 1, CONFIG.pathfinding_jump, CONFIG.pathfinding_drop)
    if path and #path > 1 then
        if vec_dist(pos, path[1]) < 0.5 then
            table.remove(path, 1)
        end
        self.path = path
        self.path_index = 1
        return true
    else
        self.path = nil
        return false
    end
end

function M.get_move_direction(self, pos, target_pos)
    if self.path and self.path_index then
        local waypoint = self.path[self.path_index]
        if waypoint then
            local dist = vec_dist(pos, waypoint)
            if dist < 1.0 then
                self.path_index = self.path_index + 1
                if self.path_index > #self.path then
                    self.path = nil
                else
                    waypoint = self.path[self.path_index]
                end
            end
            if waypoint then
                return vec_dir(pos, waypoint), true
            end
        else
            self.path = nil
        end
    end
    return vec_dir(pos, target_pos), false
end

function M.get_staticdata(self)
    return utils.serialize_state({
        id = self.id,
        state = self.state,
        spawn_pos = self.spawn_pos,
        wander_target = self.wander_target,
        sidewalk_direction = self.sidewalk_direction,
        sidewalk_start_z = self.sidewalk_start_z,
        following = self.following,
        following_player_name = self.following_player_name,
        frozen = self.frozen,
        stop_timer = self.stop_timer,
        path = self.path,
        path_index = self.path_index,
    })
end

function M.on_activate(self, staticdata, dtime_s)
    local data = {}
    if staticdata and staticdata ~= "" then
        data = utils.deserialize_state(staticdata) or {}
    end
    
    self.id = data.id or utils.generate_unique_id()
    self.state = data.state or "walk"
    local pos = self.object:get_pos()
    self.spawn_pos = data.spawn_pos or {x = pos.x, y = pos.y, z = pos.z}
    self.frozen = data.frozen or false
    self.wander_target = data.wander_target
    self.stop_timer = data.stop_timer or 0
    
    self.sidewalk_direction = data.sidewalk_direction or 1
    self.sidewalk_start_z = data.sidewalk_start_z
    
    self.following_player_name = data.following_player_name
    self.path = data.path
    self.path_index = data.path_index
    
    self._is_npc = true
    self.timer = 0
    self.footstep_timer = 0
    self.following_player = nil
    self.path_update_timer = 0
    self._last_yaw = 0
    
    self.object:set_acceleration({x = 0, y = CONFIG.gravity, z = 0})
    self.object:set_armor_groups({fleshy = 100}) -- API Compliance
    
    self.animations = ANIMATIONS
    self.current_animation = nil
    
    if self.following_player_name then
        local player = get_player(self.following_player_name)
        if player and player:is_player() then
            self.following_player = player
        else
            self.state = "walk"
            self.following_player_name = nil
        end
    end
    
    local state_animations = {
        sit = "sit", lay = "lay", stand_balcony = "stand_balcony",
        lay_on_belly = "lay_on_belly", dance = "dance"
    }
    local anim = state_animations[self.state]
    if anim then
        M.set_animation(self, anim)
    elseif self.frozen or self.state == "stopped" then
        M.set_animation(self, "idle")
    end
end

local function dir_to_yaw(dir)
    if dir.x == 0 and dir.z == 0 then
        return nil
    end
    return atan2(dir.z, dir.x) - math_pi/2
end

function M.play_footstep(self, pos)
    if self.footstep_timer < CONFIG.footstep_interval then return end
    self.footstep_timer = 0
    local below = get_node({x = pos.x, y = pos.y - 0.5, z = pos.z})
    if not below then return end
    local node_def = registered_nodes[below.name]
    if not node_def then return end
    local sound = (node_def.sounds and node_def.sounds.footstep) or "default_footstep"
    core.sound_play(sound, {object = self.object, gain = CONFIG.footstep_gain, max_hear_distance = 10})
end

function M.on_step(self, dtime)
    if not self.object or not self.object:get_luaentity() then return end
    
    self.timer = (self.timer or 0) + dtime
    self.footstep_timer = (self.footstep_timer or 0) + dtime
    
    local current_vel = self.object:get_velocity()
    
    if STATIC_STATES[self.state] or self.frozen or self.state == "stopped" then
        self.object:set_velocity({x = 0, y = current_vel.y, z = 0})
        local anim = (self.state == "stopped") and "idle" or self.state
        if self.current_animation ~= anim then
            M.set_animation(self, anim)
        end
        return
    end
    
    local pos = self.object:get_pos()
    local is_moving = false
    local target_yaw = self._last_yaw
    local velocity = {x = 0, y = current_vel.y, z = 0}
    
    if self.state == "follow" then
        is_moving, velocity, target_yaw = M.get_follow_velocity(self, pos, dtime)
    elseif self.state == "sidewalk" then
        is_moving, velocity, target_yaw = M.get_sidewalk_velocity(self, pos, dtime)
        if is_moving then M.play_footstep(self, pos) end
    elseif self.state == "walk" then
        is_moving, velocity, target_yaw = M.get_wander_velocity(self, pos, dtime)
        if is_moving then M.play_footstep(self, pos) end
    end
    
    velocity.y = current_vel.y

    if is_moving then
        local avoidance = M.calculate_avoidance(self, pos)
        velocity.x = velocity.x + avoidance.x
        velocity.z = velocity.z + avoidance.z
        
        self.object:set_velocity(velocity)
        
        if target_yaw ~= nil and abs((target_yaw or 0) - (self._last_yaw or 0)) > 0.01 then
            self.object:set_yaw(target_yaw)
            self._last_yaw = target_yaw
        end
        
        M.set_animation(self, "walk")
    else
        self.object:set_velocity({x = 0, y = velocity.y, z = 0})
        M.set_animation(self, "idle")
    end
end

function M.get_follow_velocity(self, pos, dtime)
    if not self.following_player or not self.following_player:is_player() then
        self.state = "walk"
        return false, {x = 0, y = 0, z = 0}, nil
    end
    
    local ppos = self.following_player:get_pos()
    local dist = vec_dist(pos, ppos)
    
    if dist > CONFIG.max_follow_distance then
        self.state = "walk"
        return false, {x = 0, y = 0, z = 0}, nil
    end
    
    if dist > CONFIG.min_follow_distance then
        local dir = vec_dir(pos, ppos)
        local yaw = dir_to_yaw(dir)
        local vel = {
            x = dir.x * CONFIG.walk_speed,
            y = 0,
            z = dir.z * CONFIG.walk_speed
        }
        return true, vel, yaw
    end
    
    return false, {x = 0, y = 0, z = 0}, nil
end

function M.get_sidewalk_velocity(self, pos, dtime)
    if not self.sidewalk_start_z then
        self.sidewalk_start_z = pos.z
    end
    
    -- COMPLIANT SMART SLAB LOGIC: Check for obstacles and cliffs, not slab names
    local check_pos = {x = pos.x, y = pos.y, z = pos.z + self.sidewalk_direction * 1.5}
    local n_head = get_node({x = check_pos.x, y = check_pos.y + 0.5, z = check_pos.z})
    local n_feet = get_node({x = check_pos.x, y = check_pos.y - 0.5, z = check_pos.z})
    local n_deep = get_node({x = check_pos.x, y = check_pos.y - 1.5, z = check_pos.z})
    
    local is_blocked = n_head and registered_nodes[n_head.name] and registered_nodes[n_head.name].walkable
    local is_cliff = (n_feet and not (registered_nodes[n_feet.name] and registered_nodes[n_feet.name].walkable)) and
                     (n_deep and not (registered_nodes[n_deep.name] and registered_nodes[n_deep.name].walkable))
    
    -- Reverse only on range limit, wall, or cliff
    if abs(pos.z - self.sidewalk_start_z) > CONFIG.sidewalk_range or is_blocked or is_cliff then
        self.sidewalk_direction = -self.sidewalk_direction
        self.sidewalk_start_z = pos.z
    end
    
    local yaw = self.sidewalk_direction < 0 and math_pi or 0
    local vel = {
        x = 0,
        y = 0,
        z = CONFIG.walk_speed * self.sidewalk_direction
    }
    
    return true, vel, yaw
end

function M.get_wander_velocity(self, pos, dtime)
    if self.stop_timer and self.stop_timer > 0 then
        self.stop_timer = max(0, self.stop_timer - dtime)
        return false, {x = 0, y = 0, z = 0}, nil
    end

    if self.wander_target then
        local d_target = get_dist_2d(pos, self.wander_target)
        local d_spawn = get_dist_2d(self.spawn_pos, self.wander_target)
        
        local dx = self.wander_target.x - pos.x
        local dz = self.wander_target.z - pos.z
        local mag = sqrt(dx*dx + dz*dz)
        if mag < 0.01 then self.wander_target = nil return false, {x=0,y=0,z=0}, nil end
        local dir = {x = dx/mag, z = dz/mag}

        local head_pos = {x = pos.x + dir.x * 1.2, y = pos.y + 0.5, z = pos.z + dir.z * 1.2}
        local feet_pos = {x = pos.x + dir.x * 1.2, y = pos.y - 0.5, z = pos.z + dir.z * 1.2}
        local deep_pos = {x = pos.x + dir.x * 1.2, y = pos.y - 1.5, z = pos.z + dir.z * 1.2}

        local n_head = get_node(head_pos)
        local n_feet = get_node(feet_pos)
        local n_deep = get_node(deep_pos)

        local is_blocked = n_head and registered_nodes[n_head.name] and registered_nodes[n_head.name].walkable
        local is_cliff = (n_feet and not (registered_nodes[n_feet.name] and registered_nodes[n_feet.name].walkable)) and
                         (n_deep and not (registered_nodes[n_deep.name] and registered_nodes[n_deep.name].walkable))

        if d_target < 0.6 or d_spawn > CONFIG.max_wander_distance or is_blocked or is_cliff then
            self.wander_target = nil
            self.stop_timer = math_random(CONFIG.min_stop_time, CONFIG.max_stop_time)
            return false, {x = 0, y = 0, z = 0}, nil
        end

        local vel = {
            x = dir.x * CONFIG.walk_speed,
            y = 0,
            z = dir.z * CONFIG.walk_speed
        }
        return true, vel, (atan2(dz, dx) - math_pi/2)
    end
    
    local angle = math_random() * 2 * math_pi
    local radius = math_random(2, CONFIG.max_wander_distance)
    self.wander_target = {
        x = self.spawn_pos.x + cos(angle) * radius,
        y = self.spawn_pos.y,
        z = self.spawn_pos.z + sin(angle) * radius
    }
    
    return false, {x = 0, y = 0, z = 0}, nil
end

return M