-- NPC Control Panel and interaction
local M = {
    clicked_npc = nil
}

-- Define all actions
M.actions = {
    "Change Clothes",
    "Follow Me", 
    "Stop Following",
    "Wander",
    "Freeze",
    "Unfreeze",
    "Teleport Here",
    "Kill",
    "Count Nearby",
    "Get Position",
    "Clone",
    "Sit",
    "Lay",
    "Stand Balcony",
    "Lay on Belly",
    "Dance",
    "Walk on Sidewalk"
}

function M.on_rightclick(self, clicker)
    local player_name = clicker:get_player_name()
    M.clicked_npc = self
    M.show_control_panel(player_name)
end

function M.build_formspec(fields)
    fields = fields or {}
    local npc_name = fields.npc_name or ""
    local skin_name = fields.skin_name or ""
    local clone_amount = fields.clone_amount or ""
    local results_text = fields.results_text or "No action performed yet"
    
    -- Start building formspec with modern features
    local formspec = {
        "formspec_version[6]",
        "size[12,11]",
        "no_prepend[]",
        "real_coordinates[true]",
        "position[0.5,0.5]",
        "anchor[0.5,0.5]",
        "padding[0.05,0.05]",
        
        -- Title
        "label[0.5,0.5;NPC Control Panel]",
        
        -- NPC Name input
        "field[0.5,1.0;11,0.8;npc_name;NPC Name;" .. core.formspec_escape(npc_name) .. "]",
    }
    
    local col1_actions = {
        "Change Clothes", "Follow Me", "Stop Following", 
        "Wander", "Freeze", "Unfreeze"
    }
    
    for i, action in ipairs(col1_actions) do
        local y = 1.8 + (i-1) * 0.9
        table.insert(formspec, "button[0.5," .. y .. ";3.3,0.8;action_" .. action .. ";" .. action .. "]")
    end
    
    local col2_actions = {
        "Teleport Here", "Kill", "Count Nearby", 
        "Get Position", "Clone", "Sit"
    }
    
    for i, action in ipairs(col2_actions) do
        local y = 1.8 + (i-1) * 0.9
        table.insert(formspec, "button[4.2," .. y .. ";3.3,0.8;action_" .. action .. ";" .. action .. "]")
    end
    
    local col3_actions = {
        "Lay", "Stand Balcony", "Lay on Belly", 
        "Dance", "Walk on Sidewalk"
    }
    
    for i, action in ipairs(col3_actions) do
        local y = 1.8 + (i-1) * 0.9
        table.insert(formspec, "button[7.9," .. y .. ";3.3,0.8;action_" .. action .. ";" .. action .. "]")
    end
    
    table.insert(formspec, "label[0.5,7.2;Skin Name (for clothes change):]")
    table.insert(formspec, "field[0.5,7.6;3.8,0.8;skin_name;;" .. core.formspec_escape(skin_name) .. "]")
    
    table.insert(formspec, "label[4.5,7.2;Clone Amount (default 1):]")
    table.insert(formspec, "field[4.5,7.6;3.8,0.8;clone_amount;;" .. core.formspec_escape(clone_amount) .. "]")
    
    table.insert(formspec, "button[0.5,8.5;5.5,0.8;show_skins;Show Available Skins]")
    table.insert(formspec, "button[6.0,8.5;5.5,0.8;close;Close]")
    
    table.insert(formspec, "box[0.5,9.4;11,1.2;#33333380]")
    table.insert(formspec, "textarea[0.5,9.4;11,1.2;;;" .. core.formspec_escape(results_text) .. "]")
    
    return table.concat(formspec, "")
end

function M.show_control_panel(player_name, fields)
    local formspec = M.build_formspec(fields)
    core.show_formspec(player_name, "terras_capixabas:npc_control_form", formspec)
end

function M.handle_form_submission(player, fields)
    local player_name = player:get_player_name()
    local results = {}
    
    if fields.close or fields.quit then
        return true
    end
    
    if fields.show_skins then
        local skins = core.get_dir_list(core.get_modpath("terras_capixabas") .. "/textures", false) or {}
        local skin_list = table.concat(skins, ", ")
        table.insert(results, "Available skins: " .. skin_list)
    end
    
    local selected_action = nil
    for _, action in ipairs(M.actions) do
        if fields["action_" .. action] then
            selected_action = action
            break
        end
    end
    
    if selected_action then
        local npc = M.clicked_npc
        if not npc or not npc.object or not npc.object:get_luaentity() then
            table.insert(results, "No NPC selected or NPC no longer exists")
        else
            local luaent = npc.object:get_luaentity()
            local display_name = luaent.name or "unknown"
            
            if selected_action == "Change Clothes" and fields.skin_name and fields.skin_name ~= "" then
                local skin_name = fields.skin_name:gsub(".png$", "")
                local texture = skin_name .. ".png"
                npc.object:set_properties({textures = {texture}})
                table.insert(results, display_name .. ": Changed to " .. texture)

            elseif selected_action == "Kill" then
                local target_name = luaent.name
                local count = 0
                local pos = npc.object:get_pos()

                for _, obj in ipairs(core.get_objects_inside_radius(pos, 3)) do
                    local e = obj:get_luaentity()
                    if e and e.name == target_name then
                        obj:remove()
                        count = count + 1
                    end
                end

                table.insert(results, "Killed " .. count .. " instance(s) of " .. display_name)

            elseif selected_action == "Follow Me" then
                npc.following = true
                npc.following_player = player
                npc.state = "follow"
                npc.frozen = false
                npc:set_animation("walk")
                table.insert(results, display_name .. " is now following you")

            elseif selected_action == "Stop Following" then
                npc.following = false
                npc.following_player = nil
                npc.state = "stopped"
                npc.frozen = false
                npc:set_animation("idle")
                table.insert(results, display_name .. " stopped following")

            elseif selected_action == "Wander" then
                npc.following = false
                npc.following_player = nil
                npc.state = "walk"
                npc.frozen = false
                npc.wander_target = nil
                npc.stop_timer = 0
                npc:set_animation("walk")
                table.insert(results, display_name .. " is now wandering")

            elseif selected_action == "Freeze" then
                npc.frozen = true
                npc.object:set_velocity({x=0, y=0, z=0})
                table.insert(results, display_name .. " is now frozen")

            elseif selected_action == "Unfreeze" then
                npc.frozen = false
                table.insert(results, display_name .. " is now unfrozen")

            elseif selected_action == "Teleport Here" then
                local pos = player:get_pos()
                local new_pos = {x=pos.x+1, y=pos.y, z=pos.z+1}
                npc.object:set_pos(new_pos)
                npc.spawn_pos = vector.round(new_pos)
                table.insert(results, "Teleported " .. display_name .. " to you")

            elseif selected_action == "Get Position" then
                table.insert(results, display_name .. " at " .. core.pos_to_string(npc.object:get_pos()))

            elseif selected_action == "Clone" then
                local amount = tonumber(fields.clone_amount) or 1
                local pos = player:get_pos()
                for i = 1, amount do
                    local offset = {x = math.random(-3, 3), y = 1, z = math.random(-3, 3)}
                    local new_pos = vector.add(pos, offset)
                    core.add_entity(new_pos, luaent.name)
                end
                table.insert(results, "Cloned " .. display_name .. " " .. amount .. " times")

            elseif selected_action == "Count Nearby" then
                local pos = player:get_pos()
                local objs = core.get_objects_inside_radius(pos, 10)
                local found_npcs = {}
                for _, obj in ipairs(objs) do
                    local luaent = obj:get_luaentity()
                    if luaent and luaent.name and luaent.name:match("^terras_capixabas:") then
                        table.insert(found_npcs, {name = luaent.name or "unknown"})
                    end
                end
                if #found_npcs == 0 then
                    table.insert(results, "No NPCs found nearby")
                else
                    local names = {}
                    for _, npc in ipairs(found_npcs) do
                        table.insert(names, npc.name)
                    end
                    table.insert(results, string.format("Found %d NPCs: %s", #found_npcs, table.concat(names, ", ")))
                end
            end
        end
    end
    
    if #results > 0 then
        fields.results_text = table.concat(results, ", ")
    end
    
    M.show_control_panel(player_name, fields)
    return true
end

core.register_on_player_receive_fields(function(player, formname, fields)
    if formname ~= "terras_capixabas:npc_control_form" then return end
    return M.handle_form_submission(player, fields)
end)

return M
