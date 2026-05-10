-- SPRITES -----------------------------------------------

core.register_node("terras_capixabas:smurf", {
    description = "Smurf",
    drawtype = "nodebox",
    tiles = {"smurf.png"},  -- should be 16x16 with the sprite correctly placed
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    walkable = false,
    sunlight_propagates = true,

    groups = {snappy = 3, dig_immediate = 3},
    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.01, 0.5, 0.5, 0.01}
    },

    collision_box = {
        type = "fixed",
        fixed = {}
    }
})


core.register_node("terras_capixabas:smurfette", {
    description = "Smurfette",
    drawtype = "nodebox",
    tiles = {"smurfette.png"},  -- should be 16x16 with the sprite correctly placed
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    walkable = false,
    sunlight_propagates = true,

    groups = {snappy = 3, dig_immediate = 3},
    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.01, 0.5, 0.5, 0.01}
    },

    collision_box = {
        type = "fixed",
        fixed = {}
    }
})

core.register_node("terras_capixabas:pitfall", {
    description = "Pitfall",
    drawtype = "nodebox",
    tiles = {"pitfall.png"},  -- should be 16x16 with the sprite correctly placed
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    walkable = false,
    sunlight_propagates = true,

    groups = {snappy = 3, dig_immediate = 3},
    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.01, 0.5, 0.5, 0.01}
    },

    collision_box = {
        type = "fixed",
        fixed = {}
    }
})

core.register_node("terras_capixabas:mario", {
    description = "mario",
    drawtype = "nodebox",
    tiles = {"mario.png"},  -- should be 16x16 with the sprite correctly placed
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    walkable = false,
    sunlight_propagates = true,

    groups = {snappy = 3, dig_immediate = 3},
    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.01, 0.5, 0.5, 0.01}
    },

    collision_box = {
        type = "fixed",
        fixed = {}
    }
})