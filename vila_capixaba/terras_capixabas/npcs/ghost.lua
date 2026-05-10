core.register_node("terras_capixabas:upc_ghost", {
    description = "upc_ghost",
    tiles = {"ghost.png"},
    drawtype = "mesh",
    mesh = "ghost.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})