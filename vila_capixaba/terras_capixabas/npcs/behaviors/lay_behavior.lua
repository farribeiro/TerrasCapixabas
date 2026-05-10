local lay_behavior = {}

-- Global table to track which players are laying down (like default.player_attached)
lay_behavior.laying_players = {}

function lay_behavior.on_rightclick(pos, node, clicker)
    if not clicker or not clicker:is_player() then
        return
    end

    local player_name = clicker:get_player_name()
    
    -- Check if player is already laying
    if lay_behavior.laying_players[player_name] then
        -- Already laying, stand up
        lay_behavior.stand_up(clicker)
        return
    end

    -- Check if someone else is already in this bed
    local objs = core.get_objects_inside_radius(pos, 0.5)
    for _, obj in ipairs(objs) do
        if obj:is_player() and obj:get_player_name() ~= player_name then
            return  -- Someone else is here
        end
    end

    -- Get bed direction
    local direction = core.facedir_to_dir(node.param2)

    -- Calculate laying position - player should be ON the bed surface
    -- The eye offset will only affect the visual model, not the actual position
    local bed_surface_height = 0.07  -- Height of bed surface
    
    local lay_pos = vector.add(pos, {
        x = direction.x * -0.5,
        y = bed_surface_height,  -- Player position is ON the bed
        z = direction.z * -0.5
    })
    
    -- Set position and look direction
    clicker:set_pos(lay_pos)
    clicker:set_look_horizontal(core.dir_to_yaw(vector.multiply(direction, -1)))

    -- Apply physics overrides
    clicker:set_physics_override({
        speed = 0, 
        jump = 0, 
        gravity = 0
    })
    
    -- Set eye offset for laying position
    -- First param: first-person camera offset (normal height)
    -- Second param: third-person model offset (moves visual model down)
    -- We use a SMALLER offset since player is already on bed surface
    clicker:set_eye_offset({x=0, y=0, z=-0}, {x=0, y=-3, z=-2})
    
    -- Try to use default mod's animation system if available
    if default and default.player_set_animation then
        default.player_attached[player_name] = true
        default.player_set_animation(clicker, "lay", 30)
    else
        -- Fallback: use direct animation with more stable frame range
        clicker:set_animation({x = 162, y = 166}, 30, 0, true)
    end
    
    -- Store laying state in multiple ways
    clicker:get_meta():set_string("terras_capixabas:laying", "true")
    lay_behavior.laying_players[player_name] = {
        bed_pos = vector.new(pos),
        direction = direction,
        bed_surface_height = bed_surface_height
    }
end

function lay_behavior.stand_up(player)
    if not player or not player:is_player() then
        return
    end
    
    local player_name = player:get_player_name()
    
    -- Reset eye offset for both first-person and third-person
    player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
    
    -- Reset physics
    player:set_physics_override({
        speed = 1, 
        jump = 1, 
        gravity = 1
    })
    
    -- Set animation
    if default and default.player_set_animation then
        default.player_attached[player_name] = false
        default.player_set_animation(player, "stand", 30)
    else
        player:set_animation({x = 0, y = 79}, 30, 0, true)
    end
    
    -- Pop up slightly to clear the bed
    local current_pos = player:get_pos()
    player:set_pos({
        x = current_pos.x,
        y = current_pos.y + 0.5,
        z = current_pos.z
    })
    
    -- Clear laying state
    player:get_meta():set_string("terras_capixabas:laying", "false")
    lay_behavior.laying_players[player_name] = nil
end

function lay_behavior.on_destruct(pos)
    for player_name, data in pairs(lay_behavior.laying_players) do
        if vector.distance(pos, data.bed_pos) < 1.5 then
            local player = core.get_player_by_name(player_name)
            if player then
                lay_behavior.stand_up(player)
            end
        end
    end
end

-- Check if a bed can be dug (prevent digging when someone is lying on it)
function lay_behavior.can_dig_bed(pos, player)
    for player_name, data in pairs(lay_behavior.laying_players) do
        if vector.distance(pos, data.bed_pos) < 1.5 then
            return false
        end
    end
    return true
end

function lay_behavior.globalstep()
    for player_name, data in pairs(lay_behavior.laying_players) do
        local player = core.get_player_by_name(player_name)
        if player and player:is_player() then
            local ctrl = player:get_player_control()
            
            -- Check if player is trying to move
            if ctrl.jump or ctrl.sneak or 
               ctrl.up or ctrl.down or 
               ctrl.left or ctrl.right then
                lay_behavior.stand_up(player)
            else
                -- If using default mod, animation is already handled
                -- If not, reinforce animation with delayed call
                if not default or not default.player_set_animation then
                    core.after(0, function()
                        if lay_behavior.laying_players[player_name] then
                            player:set_animation({x = 162, y = 166}, 30, 0, true)
                            -- Also reinforce the eye offset
                            player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=-3, z=0})
                        end
                    end)
                end
                
                -- Keep player in correct position (prevent drift)
                local current_pos = player:get_pos()
                local target_pos = vector.add(data.bed_pos, {
                    x = data.direction.x * -0.5,
                    y = data.bed_surface_height,
                    z = data.direction.z * -0.5
                })
                
                if vector.distance(current_pos, target_pos) > 0.1 then
                    player:set_pos(target_pos)
                end
            end
        else
            -- Player disconnected or not found, clean up
            lay_behavior.laying_players[player_name] = nil
        end
    end
end

-- Register globalstep
core.register_globalstep(function(dtime)
    lay_behavior.globalstep()
end)

return lay_behavior