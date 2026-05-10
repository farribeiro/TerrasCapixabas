local sit_behavior = {}

-- Global table to track which players are sitting down
sit_behavior.sitting_players = {}

function sit_behavior.on_rightclick(pos, node, clicker)
    if not clicker or not clicker:is_player() then
        return
    end

    local player_name = clicker:get_player_name()
    
    -- Check if player is already sitting
    if sit_behavior.sitting_players[player_name] then
        -- Already sitting, stand up
        sit_behavior.stand_up(clicker)
        return
    end

    -- Check if someone else is already in this chair
    local objs = core.get_objects_inside_radius(pos, 0.5)
    for _, obj in ipairs(objs) do
        if obj:is_player() and obj:get_player_name() ~= player_name then
            return  -- Someone else is here
        end
    end

    -- Get chair direction
    local direction = core.facedir_to_dir(node.param2)

    -- Calculate sitting position - FIXED: Changed from 0.5 to 0.25 for half block
    local sit_pos = vector.add(pos, {
        x = direction.x * -0.2,
        y = 0.15,  -- FIXED: Half block height (was 0.5 = full block)
        z = direction.z * -0.2
    })
    
    -- Set position and look direction
    clicker:set_pos(sit_pos)
    clicker:set_look_horizontal(core.dir_to_yaw(vector.multiply(direction, -1)))

    -- Apply physics overrides
    clicker:set_physics_override({
        speed = 0, 
        jump = 0, 
        gravity = 0
    })
    
    -- Set eye offset for sitting position
    clicker:set_eye_offset({x=0, y=-2, z=0}, {x=0, y=-2, z=0})
    
    -- Try to use default mod's animation system if available
    if default and default.player_set_animation then
        default.player_attached[player_name] = true
        default.player_set_animation(clicker, "sit", 30)
    else
        -- Fallback: use sitting animation frames (81-160 for sitting)
        clicker:set_animation({x = 81, y = 160}, 30, 0, true)
    end
    
    -- Store sitting state
    clicker:get_meta():set_string("terras_capixabas:sitting", "true")
    sit_behavior.sitting_players[player_name] = {
        chair_pos = vector.new(pos),
        direction = direction
    }
end

function sit_behavior.stand_up(player)
    if not player or not player:is_player() then
        return
    end
    
    local player_name = player:get_player_name()
    
    -- Reset eye offset
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
    
    -- Pop up slightly to clear the chair
    local current_pos = player:get_pos()
    player:set_pos({
        x = current_pos.x,
        y = current_pos.y + 0.5,
        z = current_pos.z
    })
    
    -- Clear sitting state
    player:get_meta():set_string("terras_capixabas:sitting", "false")
    sit_behavior.sitting_players[player_name] = nil
end

function sit_behavior.on_destruct(pos)
    for player_name, data in pairs(sit_behavior.sitting_players) do
        if vector.distance(pos, data.chair_pos) < 1.5 then
            local player = core.get_player_by_name(player_name)
            if player then
                sit_behavior.stand_up(player)
            end
        end
    end
end

-- Check if a chair can be dug
function sit_behavior.can_dig_chair(pos, player)
    for player_name, data in pairs(sit_behavior.sitting_players) do
        if vector.distance(pos, data.chair_pos) < 1.5 then
            return false
        end
    end
    return true
end

function sit_behavior.globalstep()
    for player_name, data in pairs(sit_behavior.sitting_players) do
        local player = core.get_player_by_name(player_name)
        if player and player:is_player() then
            local ctrl = player:get_player_control()
            
            -- Check if player is trying to move
            if ctrl.jump or ctrl.sneak or 
               ctrl.up or ctrl.down or 
               ctrl.left or ctrl.right then
                sit_behavior.stand_up(player)
            else
                -- If using default mod, animation is already handled
                -- If not, reinforce animation with delayed call
                if not default or not default.player_set_animation then
                    core.after(0, function()
                        if sit_behavior.sitting_players[player_name] then
                            player:set_animation({x = 81, y = 160}, 30, 0, true)
                            -- Also reinforce the eye offset
                            player:set_eye_offset({x=0, y=-2, z=0}, {x=0, y=-2, z=0})
                        end
                    end)
                end
                
                -- Keep player in position (prevent drift) - FIXED: Changed from 0.5 to 0.25
                local current_pos = player:get_pos()
                local target_pos = vector.add(data.chair_pos, {
                    x = data.direction.x * -0.2,
                    y = 0.15,  -- FIXED: Half block height (was 0.5)
                    z = data.direction.z * -0.2
                })
                
                if vector.distance(current_pos, target_pos) > 0.1 then
                    player:set_pos(target_pos)
                end
            end
        else
            -- Player disconnected or not found, clean up
            sit_behavior.sitting_players[player_name] = nil
        end
    end
end

-- Register globalstep
core.register_globalstep(function(dtime)
    sit_behavior.globalstep()
end)

return sit_behavior