-- FUNCIONALIDADES ----------------------------------------------------------------

core.register_chatcommand("grab", {
    description = "Pick up exactly what you're looking at",
    func = function(name)
        local player = core.get_player_by_name(name)
        if not player then return false, "Player not found" end

        -- Advanced raycasting with collision detection
        local pos = player:get_pos()
        pos.y = pos.y + 1.5 -- Eye level
        local ray = core.raycast(
            pos,
            pos + vector.multiply(player:get_look_dir(), 12),
            true, -- Objects
            false -- Liquids
        )

        local pointed
        for hit in ray do
            if hit.type == "node" then
                pointed = hit
                break
            end
        end

        if not pointed then return false, "Not looking at a node" end

        local node = core.get_node(pointed.under)
        if node.name == "air" then return false, "No node here" end

        -- Get the exact node (including facedir and other metadata)
        local meta = core.get_meta(pointed.under):to_table()
        local itemstack = ItemStack({
            name = node.name,
            count = 1, -- Single item
            metadata = meta.fields and next(meta.fields) and meta.fields or nil
        })

        -- Special handling for nodeboxes and models
        local def = core.registered_nodes[node.name]
        if def and (def.drawtype == "nodebox" or def.drawtype == "mesh") then
            itemstack:get_meta():set_string("node_box", core.serialize(def.node_box))
        end

        if player:get_inventory():add_item("main", itemstack) then
            core.sound_play("default_place_node_hard", {
                to_player = name,
                gain = 0.8
            })
            return true, "Grabbed "..node.name
        else
            return false, "Inventory full"
        end
    end
})