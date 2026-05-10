-- Helper functions
local M = {}

function M.is_water(node)
    return node and core.registered_nodes[node.name] and 
           core.registered_nodes[node.name].groups and 
           core.registered_nodes[node.name].groups.water
end

function M.get_node_sound(pos, sound_type)
    local node = core.get_node_or_nil(pos)
    local def = node and core.registered_nodes[node.name]
    return def and def.sounds and (def.sounds[sound_type] and def.sounds[sound_type].name or def.sounds[sound_type])
end

function M.generate_unique_id()
    return "npc_" .. core.get_us_time() .. "_" .. math.random(1000, 9999)
end

function M.serialize_state(self)
    return core.serialize({
        state = self.state,
        frozen = self.frozen,
        spawn_pos = self.spawn_pos,
        sidewalk_direction = self.sidewalk_direction,
        id = self.id,
        wander_target = self.wander_target,
        stop_timer = self.stop_timer,
        following = self.following,
        following_player_name = self.following_player and self.following_player:get_player_name() or nil,
        current_animation = self.current_animation
    })
end

function M.deserialize_state(staticdata)
    if staticdata and staticdata ~= "" then
        return core.deserialize(staticdata)
    end
    return nil
end

return M