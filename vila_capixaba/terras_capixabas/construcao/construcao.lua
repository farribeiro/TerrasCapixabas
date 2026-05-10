-- CONSTRUÇÃO -----------------------------------------------------------------

local stone_sounds = {
    footstep = {name = "default_hard_footstep", gain = 0.3},
    dig = {name = "default_dig_cracky", gain = 0.4},
    dug = {name = "default_hard_break", gain = 0.9},
    place = {name = "default_place_node_hard", gain = 0.5}
}


-- SUBSTITUIÇÕES DE TEXTURAS OFICIAIS DE LUANTI ------------------------------------------------------------

core.override_item("default:cobble", {tiles = {"paralelepipedo.png"}})
core.override_item("default:mossycobble", {tiles = {"paralelepipedo_limo.png"}})
core.override_item("default:brick", {tiles = {"lajota.png"}})
core.override_item("default:dirt", {tiles = {"terra_vermelha.png"}})
core.override_item("default:dirt_with_grass", {tiles = {"grama.png", "default_dirt.png", "grama_lado.png"}})
core.override_item("default:goldblock", {tiles = {"ouro.png"}})
core.override_item("default:gravel", {tiles = {"gravel.png"}})
core.override_item("default:leaves", {tiles = {"leaves_mango.png"}})
core.override_item("default:sand", {tiles = {"areia.png"}})
core.override_item("default:stone", {tiles = {"pedra_basalto.png"}})
core.override_item("default:tree", {tiles = {"tree_top.png", "tree.png"}})
core.override_item("default:aspen_tree", {tiles = {"tronco_coqueiro_top.png", "tronco_coqueiro.png"}})
core.override_item("default:aspen_leaves", {tiles = {"folha_coqueiro.png"}})
core.override_item("default:jungleleaves", {tiles = {"folha_mangueira.png"}})
core.override_item("default:jungletree", {tiles = {"tree_top.png", "tree.png"}})


-- BLOCOS NORMAIS ----------------------------------------------------

local function get_sound(name)
 if name=="metal" then return default.node_sound_metal_defaults()
 elseif name=="wood" then return default.node_sound_wood_defaults()
 elseif name=="sand" then return default.node_sound_sand_defaults()
 else return stone_sounds end
end

local function get_groups(name)
 if name=="wood" then return {choppy=2}
 elseif name=="sand" then return {crumbly=2}
 elseif name=="sand_falling" then return {crumbly=3, falling_node=1, sand=1}
 else return {cracky=2} end
end

local simple_nodes={
{"areia_branca","Areia Branca","sand"},
{"areia_molhada","Areia Molhada","sand_falling"},
{"brita","Brita","stone"},
{"calcada","Calçada","stone"},
{"calcada_carioca1","Calçada Carioca 1","stone"},
{"calcada_carioca2","Calçada Carioca 2","stone"},
{"carpete_vermelho","Carpete Vermelho","sand"},
{"carpete_vermelho2","Carpete Vermelho","sand"},
{"club_chao","chao de Clube","stone"},
{"club_parede","Parede de Clube","stone"},
{"comongol","Comongol","stone"},
{"concreto1","Concreto 1","stone"},
{"concreto2","Concreto 2","stone"},
{"concreto3","Concreto 3","stone"},
{"coral_amarelo","Coral Amarelo","stone"},
{"coral_azul","Coral  Azul","stone"},
{"coral_lilas","Coral  Lilás","stone"},
{"coral_rosa","Coral  Rosa","stone"},
{"coral_vermelho","Coral Vermelho","stone"},
{"ferro","Ferro","metal"},
{"madeira_painel","painel de Madeira","wood"},
{"mogno","Madeira de Mogno","wood"},
{"muro_bloco","Muro de Bloco","stone"},
{"muro_chapiscado","Muro Chapiscado","stone"},
{"paralelepipedo_colmeia","Paralelepípedo Colméia","stone"},
{"parede_abacate","Parede Abacate","stone"},
{"parede_amarela","Parede Amarela","stone"},
{"parede_azul","Parede Azul","stone"},
{"parede_azul2","Parede Azul","stone"},
{"parede_azul_claro","Parede Azul Claro","stone"},
{"parede_branca","Parede Branca","stone"},
{"parede_concreto","parede_concreto","stone"},
{"parede_laranja","Parede Laranja","stone"},
{"parede_laranja_claro","Parede Laranja Claro","stone"},
{"parede_magenta","Parede Magenta","stone"},
{"parede_marrom","parede_marrom","stone"},
{"parede_prata","Parede Prata","stone"},
{"parede_roxa","Parede Purple","stone"},
{"parede_rosa","Parede Rosa","stone"},
{"parede_verde","parede_verde","stone"},
{"parede_verde_agua","Parede Verde Água","stone"},
{"parede_verde_bebe","Parede Verde Bebê","stone"},
{"parede_verde_esmeralda","Parede Verde Esmeralda","stone"},
{"parede_vermelha","Parede Vermelha","stone"},
{"parede_vovo_banheiro","Parede Vovo Banheiro","stone"},
{"parede_vovo_beige","Parede Vovo Beige","stone"},
{"piso1","Piso 1","stone"},
{"piso2","Piso 2","stone"},
{"piso_azul","Piso Azul","stone"},
{"piso_branco","Piso Branco","stone"},
{"piso_pastilha_azul","Pastilha Azul","stone"},
{"piso_pastilha_beige","Pastilha Beige","stone"},
{"piso_pastilha_verde","Pastilha Verde","stone"},
{"piso_piscina","Piso Piscina","stone"},
{"piso_sinteco","Sinteco","stone"},
{"piso_verde_bebe","Piso Verde Bebê","stone"},
{"piso_verde_cana","piso_verde_cana","stone"},
{"piso_vovo_banheiro_chao","Piso Vovo chao do banheiro","stone"},
{"piso_vovo_cozinha","Piso Vovo Cozinha","stone"},
{"piso_vovo_cozinha_chao","Piso Vovo chao da Cozinha","stone"},
{"piso_vovo_fundos","Piso Vovo Fundos","stone"},
{"piso_vovo_sala","piso_vovo_sala","stone"},
{"piso_vovo_varanda","Piso Vovo Varanda","stone"},
{"talba","Talba","wood"},
{"talba_azul","Talba Azul","wood"},
{"telha_amianto","Telha de Amianto","stone"},
{"telha_colonial","Telha Colonial","stone"},
{"terra_barrenta","Terra Barrenta","sand"},
{"terra_fertil","Terra Fertil","sand"},
{"terra_arenosa","Terra Arenosa","sand"},
{"terra_rosada","Terra Rosada","sand"},
{"terra_rosada2","Terra Rosada2","sand"},
}

for _,def in ipairs(simple_nodes) do
 core.register_node("terras_capixabas:"..def[1], {
  description=def[2],
  tiles={def[1]..".png"},
  groups=get_groups(def[3]),
  sounds=get_sound(def[3])
 })
end

-- SLABS ----------------------------------

local function register_custom_slab(name, description, texture)
    local modname = "terras_capixabas"
    local slab_name = modname .. ":" .. name .. "_slab"
    local full_block_name = modname .. ":" .. name

    core.register_node(slab_name, {
        description = description .. " Slab",
        tiles = {texture},
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0, 0.5}, -- Bottom half
            },
        },
        paramtype = "light",
        paramtype2 = "facedir",
        groups = {cracky = 3, slab = 1},
        sounds = default.node_sound_stone_defaults(),
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            local above = {x = pos.x, y = pos.y + 1, z = pos.z}
            local below = {x = pos.x, y = pos.y - 1, z = pos.z}
            local node_above = core.get_node(above)
            local node_below = core.get_node(below)

            -- If stacked with another identical slab, replace with full block
            if node_below.name == slab_name then
                core.remove_node(pos)
                core.remove_node(below)
                core.set_node(below, {name = full_block_name})
            elseif node_above.name == slab_name then
                core.remove_node(pos)
                core.remove_node(above)
                core.set_node(pos, {name = full_block_name})
            end
        end,
    })
end

register_custom_slab("areia_branca", "Areia Branca", "areia_branca.png")
register_custom_slab("areia", "Areia", "areia.png")
register_custom_slab("asfalto", "Asfalto", "asfalto.png")
register_custom_slab("asfalto_linha", "Linha de Asfalto", "asfalto_linha.png")
register_custom_slab("asfalto_faixa_pedestre", "Faixa de Pedestre", "asfalto_faixa_pedestre.png")
register_custom_slab("brita", "Brita", "brita.png")
register_custom_slab("paralelepipedo", "Paralelepípedo", "paralelepipedo.png")
register_custom_slab("paralelepipedo_colmeia", "Paralelepípedo Colméia", "paralelepipedo_colmeia.png")
register_custom_slab("telha_amianto", "Telha Amianto", "telha_amianto.png")
register_custom_slab("telha_colonial", "Telha Colonial", "telha_colonial.png")
register_custom_slab("terra_arenosa", "Terra Arenosa", "terra_arenosa.png")
register_custom_slab("terra_barrenta", "terra_barrenta", "terra_barrenta.png")


-- -----------------------------------------------------------------

core.register_node("terras_capixabas:grama_escura", {
    description = "Grama Escura",
    tiles = {"grama_escura.png"},
    groups = {snappy = 2, footstep = 3, grass = 1},  -- Added 'footstep' and 'grass' groups
    sounds = {
        footstep = {name = "default_grass_footstep", gain = 0.4},
        dig = {name = "default_dig_snappy", gain = 0.4},
        dug = {name = "default_grass_footstep", gain = 0.4},  -- Using grass footstep for dug sound
        place = {name = "default_place_node", gain = 1.0},  -- Added placement sound
    },
})


core.register_node("terras_capixabas:vovo_cozinha_parede_vovo_beige", {
    description = "vovo_cozinha_parede_vovo_beige",
    tiles = {
        "parede_vovo_beige.png",     -- top
        "parede_vovo_beige.png",  -- bottom
        "parede_vovo_beige.png",   -- right
        "parede_vovo_beige.png",    -- left
        "parede_vovo_beige.png",    -- back
        "piso_vovo_cozinha.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})

core.register_node("terras_capixabas:vovo_banheiro_cozinha", {
    description = "vovo_banheiro_cozinha",
    tiles = {
        "piso_vovo_cozinha.png",     -- top
        "piso_vovo_cozinha.png",  -- bottom
        "piso_vovo_cozinha.png",   -- right
        "piso_vovo_cozinha.png",    -- left
        "piso_vovo_cozinha.png",    -- back
        "parede_vovo_banheiro.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})

core.register_node("terras_capixabas:vovo_banheiro_parede_beige", {
    description = "vovo_banheiro_parede_beige",
    tiles = {
        "parede_vovo_beige.png",     -- top
        "parede_vovo_beige.png",  -- bottom
        "parede_vovo_beige.png",   -- right
        "parede_vovo_beige.png",    -- left
        "parede_vovo_beige.png",    -- back
        "parede_vovo_banheiro.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})

core.register_node("terras_capixabas:palha", {
    description = "Bloco de Palha",
    tiles = {
        "palha_top.png", -- Top
        "palha_top.png", -- Bottom
        "palha.png",     -- Right
        "palha.png",     -- Left
        "palha.png",     -- Front
        "palha.png"      -- Back
    },
    paramtype = "light",
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {snappy = 3, flammable = 4},
    sounds = default.node_sound_leaves_defaults(), -- Straw-like sounds
})


core.register_node("terras_capixabas:cerca_arame_toco", {
    description = "Cerca Arame Toco",
    tiles = {"cerca_arame.png"},
    drawtype = "mesh",
    mesh = "cerca_arame_toco.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
    }
})

core.register_node("terras_capixabas:cerca_arame", {
    description = "Cerca Arame Farpado",
    tiles = {"cerca_arame.png"},
    drawtype = "mesh",
    mesh = "cerca_arame.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
    }
})

core.register_node("terras_capixabas:cerca_arame_esq", {
    description = "Cerca Arame Farpado Esquina",
    tiles = {"cerca_arame.png"},
    drawtype = "mesh",
    mesh = "cerca_arame_esq.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.5, -0.125, 2, 1.5, 0.125},   -- Horizontal segment (X axis)
            {-0.125, -0.5, -0.1, 0.125, 1.5, 2.1},   -- Vertical segment (Z axis)
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125},   -- Horizontal segment (X axis)
            {-0.125, -0.5, -0.1, 0.125, 1.5, 2.2},   -- Vertical segment (Z axis)
        }
    }
})

core.register_node("terras_capixabas:cerca_verde_toco", {
    description = "Cerca Verde Toco",
    tiles = {"cerca_verde.png"},
    drawtype = "mesh",
    mesh = "cerca_verde_toco.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
    }
})

core.register_node("terras_capixabas:cerca_verde", {
    description = "Cerca Verde",
    tiles = {"cerca_verde.png"},
    drawtype = "mesh",
    mesh = "cerca_verde.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
    }
})


core.register_node("terras_capixabas:cerca_verde_esq", {
    description = "Cerca Verde Esquina",
    tiles = {"cerca_verde.png"},
    drawtype = "mesh",
    mesh = "cerca_verde_esq.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125},   -- Horizontal segment (X axis)
            {-0.125, -0.5, -0.1, 0.125, 1.5, 2},   -- Vertical segment (Z axis)
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125},   -- Horizontal segment (X axis)
            {-0.125, -0.5, -0.1, 0.125, 1.5, 2},   -- Vertical segment (Z axis)
        }
    }
})

core.register_node("terras_capixabas:cerca_verde_portao", {
    description = "Cerca Portao",
    tiles = {"cerca_verde.png"},
    drawtype = "mesh",
    mesh = "cerca_verde_portao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:cerca_verde_portao_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:cerca_verde_portao_opened", {
    description = "Cerca Portao (Aberto)",
    tiles = {"cerca_verde.png"},
    drawtype = "mesh",
    mesh = "cerca_verde_portao_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "clip",
	backface_culling = true,
    backface_culling = false,
    drop = "terras_capixabas:cerca_verde",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 2, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:cerca_verde_portao", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})


local arame_textures = {
    "grade_2madeiras.png",
    "grade_aco.png",
    "grade_antiga.png",
    "grade_box_verde.png",
    "grade_colonial.png",
    "grade_eletrica.png",
    "grade_ferro.png",
    "grade_losangulo.png",
    "grade_losangulo2.png",
    "grade_parapeito_vidro_verde.png",
}

for _, texture in ipairs(arame_textures) do
    local name_suffix = texture:match("grade_(.+)%.png") or "variant"
    local walkable_flag = name_suffix ~= "box_verde"

    core.register_node("terras_capixabas:grade_" .. name_suffix, {
        description = "Grade " .. name_suffix:gsub("^%l", string.upper),
        tiles = {texture},
        drawtype = "mesh",
        mesh = "grade.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        backface_culling = true,
        use_texture_alpha = "blend",
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        sounds = default.node_sound_metal_defaults(),
        walkable = walkable_flag,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
        },
    })
end


local arame_textures = {
	"gradil_azul.png",
	"gradil_branco.png",
	"gradil_verde.png",
	"gradil_bifu_azul.png",
	"gradil_bifu_branco.png",
	"gradil_bifu_verde.png",
	"gradil_viga_azul.png",
	"gradil_viga_branco.png",
	"gradil_viga_verde.png",

    -- Add your other 5 texture filenames here
}

for _, texture in ipairs(arame_textures) do
    local name_suffix = texture:match("gradil_(.+)%.png") or "variant"
    core.register_node("terras_capixabas:gradil_" .. name_suffix, {
        description = "Gradil " .. name_suffix:gsub("^%l", string.upper),
        tiles = {texture},
        drawtype = "mesh",
        mesh = "grade.obj",
        paramtype = "light",
        paramtype2 = "facedir",
		backface_culling = true,
        use_texture_alpha = "clip",
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        sounds = default.node_sound_metal_defaults(),
        walkable = true,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1},
        },
    })
end

local arame_textures = {
    
	"gradil_viga_azul.png",
	"gradil_viga_branco.png",
	"gradil_viga_verde.png",

    -- Add your other 5 texture filenames here
}

for _, texture in ipairs(arame_textures) do
    local name_suffix = texture:match("gradil_viga_(.+)%.png") or "variant"
    core.register_node("terras_capixabas:grade_esquina" .. name_suffix, {
        description = "Gradil Viga" .. name_suffix:gsub("^%l", string.upper),
        tiles = {texture},
        drawtype = "mesh",
        mesh = "grade_esquina.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        sounds = default.node_sound_metal_defaults(),
        walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.125, -0.5, -0.125, 0.5, 0.5, 0.125},   -- Horizontal segment (X axis)
            {-0.125, -0.5, -0.1, 0.125, 0.5, 0.5},   -- Vertical segment (Z axis)
        }
    },
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.1, -0.5, -0.125, 0.5, 0.5, 0.125},   -- Horizontal segment (X axis)
            {-0.125, -0.5, -0.1, 0.125, 0.5, 0.5},   -- Vertical segment (Z axis)
        }
    }
})
end


core.register_node("terras_capixabas:cuminheira", {
    description = "Cuminheira",
    tiles = {"cuminheira.png"},
    drawtype = "mesh",
    mesh = "cuminheira.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
    }
})

core.register_node("terras_capixabas:cuminheira2", {
    description = "Cuminheira2",
    tiles = {"cuminheira2.png"},
    drawtype = "mesh",
    mesh = "cuminheira2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})


core.register_node("terras_capixabas:grade_janela_vovo", {
    description = "grade_janela_vovo",
    tiles = {"grade_janela_vovo.png"},
    drawtype = "mesh",
    mesh = "grade_janela_vovo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-1.5, -0.5, 0.3, 1.5, 0.5, 0.7}
    }
})

-- ----

core.register_node("terras_capixabas:cano_laje", {
    description = "cano_laje",
    tiles = {"cano_laje.png"},
    drawtype = "mesh",
    mesh = "cano_laje.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, -0.5, 0.1, -0.3, -0.3}
    }
})


core.register_node("terras_capixabas:cano_laje_vertical", {
    description = "cano_laje_vertical",
    tiles = {"cano_laje.png"},
    drawtype = "mesh",
    mesh = "cano_laje_vertical.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.1, -0.5, 0.2, 0.1, 0.5, 0.4}
    }
})
-- ---------------------------------

core.register_node("terras_capixabas:bloquete", {
    description = "bloquete",
    tiles = {
        "bloquete.png",     -- top
        "terra_alaranjada.png",  -- bottom
        "grama_lado.png",   -- right
        "grama_lado.png",    -- left
        "grama_lado.png",    -- back
        "grama_lado.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, stone = 1},
    is_ground_content = false
})

core.register_node("terras_capixabas:bloquete_light", {
    description = "bloquete Light",
    tiles = {
        "bloquete_light.png",     -- top
        "terra_alaranjada.png",  -- bottom
        "grama_lado_claro.png",   -- right
        "grama_lado_claro.png",    -- left
        "grama_lado_claro.png",    -- back
        "grama_lado_claro.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, stone = 1},
    is_ground_content = false
})

core.register_node("terras_capixabas:dirtroad", {
    description = "Dirtroad",
    tiles = {
        "dirtroad.png",     -- top
        "terra_alaranjada.png",  -- bottom
        "grama_lado.png",   -- right
        "grama_lado.png",    -- left
        "grama_lado.png",    -- back
        "grama_lado.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, stone = 1},
    is_ground_content = false
})

core.register_node("terras_capixabas:dirtroad_light", {
    description = "Dirtroad Light",
    tiles = {
        "dirtroad_light.png",     -- top
        "terra_alaranjada.png",  -- bottom
        "grama_lado_claro.png",   -- right
        "grama_lado_claro.png",    -- left
        "grama_lado_claro.png",    -- back
        "grama_lado_claro.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 2, stone = 1},
    is_ground_content = false
})

core.register_node("terras_capixabas:calcada_meiofio", {
    description = "calcada_meiofio",
    tiles = {
        "calcada_meiofio_top.png",     -- top
        "calcada.png",  -- bottom
        "calcada_meiofio_front.png",   -- right
        "calcada_meiofio_front.png",    -- left
        "calcada.png",    -- back
        "calcada_meiofio_front.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})

core.register_node("terras_capixabas:calcada_meiofio_corner", {
    description = "calcada_meiofio_corner",
    tiles = {
        "calcada_meiofio_corner_top.png",     -- top
        "calcada.png",  -- bottom
        "calcada_meiofio_front.png",   -- right
        "calcada_meiofio_front.png",    -- left
        "calcada.png",    -- back
        "calcada_meiofio_front.png"    -- front
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})


-- COLORIZED BLOCKS --------------------------------------------------

local modname = core.get_current_modname() or "terras_capixabas"
local texture_file = "testColorBlock.png"

-- Color definitions (add more if needed)
local colors = {
    {name = "red",    hex = "#FF3A3A"},
    {name = "green",  hex = "#00A800"},
    {name = "blue",   hex = "#4856A5"},
    {name = "yellow", hex = "#D3C745"},
    {name = "purple", hex = "#5D4BD1"},
}

-- Proper texture coloring that preserves patterns
for _, color in ipairs(colors) do
    core.register_node(modname..":color_block_"..color.name, {
        description = color.name:gsub("^%l", string.upper).." Color Block",
        tiles = {
            texture_file.."^[multiply:"..color.hex  -- This preserves the texture!
        },
        paramtype = "light",
        groups = {cracky = 3, oddly_breakable_by_hand = 1},
        is_ground_content = false,
    })
end

core.log("action", "["..modname.."] Registered "..#colors.." textured color blocks")

-- MUROS ARQUITETÔNICOS -------------------------------

-- List of textures and their display names
local textures = {
    {file = "parede_abacate.png", name = "Abacate"},
	{file = "parede_amarela.png", name = "Amarelo"},
	{file = "parede_azul.png", name = "Azul"},
    {file = "parede_azul_claro.png", name = "Azul Claro"},
	{file = "parede_vovo_beige.png", name = "Beige Vovo"},
	{file = "parede_branca.png", name = "Branco"},
    {file = "parede_concreto.png", name = "de Concreto"},
    {file = "parede_verde.png", name = "Verde"},
	{file = "parede_magenta.png", name = "Magenta"},
	{file = "parede_laranja.png", name = "Laranja"},
    {file = "parede_laranja_claro.png", name = "Laranja Claro"},
	{file = "parede_prata.png", name = "Prata"},
	{file = "parede_rosa.png", name = "Rosa"},
	{file = "parede_roxa.png", name = "Roxo"},
	{file = "parede_verde_agua.png", name = "Verde Agua"},
	{file = "parede_verde_bebe.png", name = "Verde Bebe"},
	{file = "parede_verde_esmeralda.png", name = "Verde Esmeralda"},
	{file = "parede_vermelha.png", name = "Vermelho"},
	{file = "lajota.png", name = "Lajota"},
	{file = "lajotaviga.png", name = "LajotaViga"},
	{file = "muro_bloco.png", name = "Bloco"},
	{file = "muro_chapiscado.png", name = "Chapisco"},
	{file = "muro_bloco_vigae.png", name = "Bloco Viga Esquerda"},
	{file = "muro_bloco_vigad.png", name = "Bloco Viga Direita"},
	{file = "piso_azul.png", name = "Piso Azul"},
	{file = "piso_verde_bebe.png", name = "Piso Verde Bebe"},
	{file = "piso_vovo_banheiro_chao.png", name = "Piso Vovo Banheiro Chao"},
	{file = "piso_vovo_cozinha_chao.png", name = "Piso Vovo Cozinha Chao"},
    -- Add more textures here as needed
}

-- Base node definitions
local nodes = {
    {
        name = "muro",
        description = "Muro",
        node_box = {
            type = "fixed",
            fixed = {{-0.5, -0.5, -0.1875, 0.5, 0.5, 0.1875}},
        },
    },
    {
        name = "viga",
        description = "Viga",
        node_box = {
            type = "fixed",
            fixed = {{-0.1875, -0.5, -0.1875, 0.1875, 0.5, 0.1875}},
        },
    },
    {
        name = "muro_esquina_centro",
        description = "Muro Esquina",
        node_box = {
            type = "fixed",
            fixed = {
                {0, -0.5, -0.1875, 0.5, 0.5, 0.1875},
                {-0.1875, -0.5, 0, 0.1875, 0.5, 0.5},
                {-0.1875, -0.5, -0.1875, 0, 0.5, 0},
            },
        },
        collision_box = {
            type = "fixed",
            fixed = {
                {0, -0.5, -0.1875, 0.5, 0.5, 0.1875},
                {-0.1875, -0.5, 0, 0.1875, 0.5, 0.5},
                {-0.1875, -0.5, -0.1875, 0, 0.5, 0},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {0, -0.5, -0.1875, 0.5, 0.5, 0.1875},
                {-0.1875, -0.5, 0, 0.1875, 0.5, 0.5},
                {-0.1875, -0.5, -0.1875, 0, 0.5, 0},
            },
        },
    },
    {
        name = "muro_parapeito",
        description = "Muro Parapeito",
        node_box = {
            type = "fixed",
            fixed = {{-0.5, -0.5, -0.5, 0.5, 0.5, -0.125}},
        },
    },
    {
        name = "viga_parapeito",
        description = "Viga Parapeito",
        node_box = {
            type = "fixed",
            fixed = {{-0.1875, -0.5, -0.5, 0.1875, 0.5, -0.125}},
        },
    },
    {
        name = "muro_esquina_parapeito",
        description = "Muro Parapeito Esquina",
        node_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.125},
                {-0.5, -0.5, -0.5, -0.125, 0.5, 0.5},
            },
        },
        collision_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.125},
                {-0.5, -0.5, -0.5, -0.125, 0.5, 0.5},
            },
        },
        selection_box = {
            type = "fixed",
            fixed = {
                {-0.5, -0.5, -0.5, 0.5, 0.5, -0.125},
                {-0.5, -0.5, -0.5, -0.125, 0.5, 0.5},
            },
        },
    },
}

-- Register nodes for each texture
for _, texture in ipairs(textures) do
    for _, node in ipairs(nodes) do
        local node_name = "terras_capixabas:" .. node.name .. "_" .. texture.name:lower():gsub(" ", "_")
        local description = node.description .. " " .. texture.name
        local node_definition = {
            description = description,
            tiles = {texture.file},
            drawtype = "nodebox",
            paramtype = "light",
            paramtype2 = "facedir",
            sunlight_propagates = true,
            node_box = node.node_box,
            groups = {cracky = 3, oddly_breakable_by_hand = 3},
        }
        -- Add collision_box and selection_box if they exist
        if node.collision_box then
            node_definition.collision_box = node.collision_box
        end
        if node.selection_box then
            node_definition.selection_box = node.selection_box
        end
        core.register_node(node_name, node_definition)
    end
end

-- -----------------------------------------------------------------

-- List of all your texture names
local textures = {
    "muro_grade_azul_celeste.png",
    "muro_grade_verde_monitor.png",
    -- Add the remaining 22 texture filenames here
}

for _, tex in ipairs(textures) do
    local texname = tex:match("muro_grade_(.+)%.png") or "default"
    core.register_node("terras_capixabas:muro_grade_" .. texname, {
        description = "Muro com Grade (" .. texname:gsub("_", " ") .. ")",
        tiles = {tex},
        drawtype = "mesh",
        mesh = "muro_grade.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        walkable = true,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
        },
    })
end

-- -----------------------------------------------------------

local textures = {
    "muro_grade_viga_azul_celeste.png",
    "muro_grade_viga_verde_monitor.png",
    -- Add the remaining 22 texture filenames here
}

for _, tex in ipairs(textures) do
    local texname = tex:match("muro_grade_viga_(.+)%.png") or "default"
    core.register_node("terras_capixabas:muro_grade_viga_" .. texname, {
        description = "Muro Viga com Grade (" .. texname:gsub("_", " ") .. ")",
        tiles = {tex},
        drawtype = "mesh",
        mesh = "muro_grade_viga.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        walkable = true,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
        },
    })
end

-- -----------------------------------------------

local textures = {
    "grade_viga_azulclaro.png",
    "grade_viga_verde_monitor.png",
"grade_viga_abacate_grade.png",
"grade_viga_abacate_grade2madeiras.png",
"grade_viga_abacate_grade_colonial.png",
"grade_viga_azul_grade.png",
"grade_viga_azul_grade2madeiras.png",
"grade_viga_azul_grade_colonial.png",
"grade_viga_azulclaro_grade2madeiras.png",
"grade_viga_piso_beige_grade.png",
"grade_viga_beige_grade.png",
"grade_viga_beige_grade2madeiras.png",
"grade_viga_beige_grade_colonial.png",
"grade_viga_branca_grade.png",
"grade_viga_branca_grade2madeiras.png",
"grade_viga_branca_grade_colonial.png",
"grade_viga_laranja1_grade.png",
"grade_viga_laranja1_grade2madeiras.png",
"grade_viga_laranja1_grade_colonial.png",
"grade_viga_laranja2_grade.png",
"grade_viga_laranja2_grade2madeiras.png",
"grade_viga_laranja2_grade_colonial.png",
"grade_viga_laranja3_grade.png",
"grade_viga_laranja3_grade2madeiras.png",
"grade_viga_laranja3_grade_colonial.png",
"grade_viga_lilas_grade.png",
"grade_viga_lilas_grade2madeiras.png",
"grade_viga_lilas_grade_colonial.png",
"grade_viga_monitor1_grade.png",
"grade_viga_monitor1_grade2madeiras.png",
"grade_viga_monitor1_grade_colonial.png",
"grade_viga_monitor2_grade.png",
"grade_viga_monitor2_grade2madeiras.png",
"grade_viga_monitor2_grade_colonial.png",
"grade_viga_rosa_grade.png",
"grade_viga_rosa_grade2madeiras.png",
"grade_viga_rosa_grade_colonial.png",
"grade_viga_verde_bebe_grade.png",
"grade_viga_verde_bebe_grade2madeiras.png",
"grade_viga_verde_bebe_grade_colonial.png",
"grade_viga_vermelha_grade.png",
"grade_viga_vermelha_grade2madeiras.png",
"grade_viga_vermelha_gradecolonial.png",


    -- Add the remaining 22 texture filenames here
}

for _, tex in ipairs(textures) do
    local texname = tex:match("grade_viga_(.+)%.png") or "default"
    core.register_node("terras_capixabas:grade_viga_" .. texname, {
        description = "Grade com Viga (" .. texname:gsub("_", " ") .. ")",
        tiles = {tex},
        drawtype = "mesh",
        mesh = "grade_viga.obj",
        paramtype = "light",
        paramtype2 = "facedir",
        use_texture_alpha = "clip",
        groups = {cracky = 3, oddly_breakable_by_hand = 2},
        walkable = true,
        selection_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
        },
        collision_box = {
            type = "fixed",
            fixed = {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2},
        },
    })
end

-- ----------
core.register_node("terras_capixabas:muro_vidro", {
    description = "muro_vidro",
    tiles = {"muro_vidro.png"},
    drawtype = "mesh",
    mesh = "muro_vidro.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "blend",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.3, 0.5, -0.3, 0.3}
    },
    sounds = default.node_sound_glass_defaults()
})


-- TELHADOS ------------

core.register_node("terras_capixabas:telhado_diagonal_colonial", {
    description = "telhado_diagonal_colonial",
    tiles = {"telhado_diagonal_colonial.png"},
    drawtype = "mesh",
    mesh = "telhado_diagonal.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_colonial3m", {
    description = "Telhado Colonial 3m",
    tiles = {"telhado1mcolonial.png"},
    drawtype = "mesh",
    mesh = "telhado3m.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_colonial10m", {
    description = "Telhado Colonial 10m",
    tiles = {"telhado1mcolonial.png"},
    drawtype = "mesh",
    mesh = "telhado10m.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_amianto3m", {
    description = "Telhado amianto 3m",
    tiles = {"telhado1mamianto.png"},
    drawtype = "mesh",
    mesh = "telhado3m.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_amianto10m", {
    description = "Telhado amianto 10m",
    tiles = {"telhado1mamianto.png"},
    drawtype = "mesh",
    mesh = "telhado10m.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_diagonal_amianto", {
    description = "telhado_diagonal_amianto",
    tiles = {"telhado_diagonal_amianto.png"},
    drawtype = "mesh",
    mesh = "telhado_diagonal.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_colonial1mcanto", {
    description = "Telhado Colonial 1m canto",
    tiles = {"telhado1mcolonial.png"},
    drawtype = "mesh",
    mesh = "telhado1mcanto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_colonial1mcont", {
    description = "Telhado Colonial 1m continuaçao",
    tiles = {"telhado1mcolonial.png"},
    drawtype = "mesh",
    mesh = "telhado1mcont.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_amianto1mcanto", {
    description = "Telhado Amianto 1m canto",
    tiles = {"telhado1mamianto.png"},
    drawtype = "mesh",
    mesh = "telhado1mcanto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_amianto1mcont", {
    description = "Telhado Amianto 1m continuaçao",
    tiles = {"telhado1mamianto.png"},
    drawtype = "mesh",
    mesh = "telhado1mcont.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- ---------------------------------------------

core.register_node("terras_capixabas:telhado_colonial2mcanto", {
    description = "Telhado Colonial 2m canto",
    tiles = {"telhado1mcolonial.png"},
    drawtype = "mesh",
    mesh = "telhado2mcanto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    }
})
core.register_node("terras_capixabas:telhado_colonial2mcont", {
    description = "Telhado Colonial 2m continuaçao",
    tiles = {"telhado1mcolonial.png"},
    drawtype = "mesh",
    mesh = "telhado2mcont.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_amianto2mcanto", {
    description = "Telhado Amianto 2m canto",
    tiles = {"telhado1mamianto.png"},
    drawtype = "mesh",
    mesh = "telhado2mcanto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    }
})

core.register_node("terras_capixabas:telhado_amianto2mcont", {
    description = "Telhado Amianto 2m continuaçao",
    tiles = {"telhado1mamianto.png"},
    drawtype = "mesh",
    mesh = "telhado2mcont.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.3, -1.5, 0.5, 0, 0.5}
    }
})

core.register_node("terras_capixabas:telha_amianto1m", {
    description = "Telha de Amianto 1m",
    tiles = {"telha_amianto1m.png"},
    drawtype = "mesh",
    mesh = "telha_amianto1m.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
    }
})

core.register_node("terras_capixabas:telhao1m", {
    description = "Telhao de Amianto 1m",
    tiles = {"telha_amianto1m.png"},
    drawtype = "mesh",
    mesh = "telhao1m.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.2, 0.5}
    }
})

local custom_waters = {
    {name = "piscina", desc = "Agua de Piscina", tint = {a = 150, r = 40, g = 70, b = 40}},
    {name = "rio",     desc = "Agua de Rio",     tint = {a = 150, r = 40, g = 70, b = 40}},
    {name = "esgoto",  desc = "Agua de Esgoto",  tint = {a = 150, r = 40, g = 70, b = 40}},
}

for _, water in ipairs(custom_waters) do
    -- SOURCE
    core.register_node("terras_capixabas:agua_" .. water.name .. "_source", {
        description = water.desc,
        drawtype = "liquid",
        tiles = {{
            name = "agua_" .. water.name .. "_source_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}
        }},
        use_texture_alpha = "blend",
        special_tiles = {{
            name = "agua_" .. water.name .. "_source_animated.png",
            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
            backface_culling = false
        }},
        paramtype = "light",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        is_ground_content = false,
        liquidtype = "source",
        liquid_alternative_flowing = "terras_capixabas:agua_" .. water.name .. "_flowing",
        liquid_alternative_source = "terras_capixabas:agua_" .. water.name .. "_source",
        liquid_viscosity = 1,
        liquid_renewable = false,
        liquid_range = 2,
        post_effect_color = water.tint,
        groups = {water = 3, liquid = 3, cools_lava = 1}
    })

    -- FLOWING
    core.register_node("terras_capixabas:agua_" .. water.name .. "_flowing", {
        description = "Flowing " .. water.desc,
        drawtype = "flowingliquid",
        tiles = {"agua_" .. water.name .. ".png"},
        use_texture_alpha = "blend",
        special_tiles = {
            {
                name = "agua_" .. water.name .. "_flowing_animated.png",
                animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8},
                backface_culling = false
            },
            {
                name = "agua_" .. water.name .. "_flowing_animated.png",
                animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8},
                backface_culling = true
            }
        },
        paramtype = "light",
        paramtype2 = "flowingliquid",
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        is_ground_content = false,
        liquidtype = "flowing",
        liquid_alternative_flowing = "terras_capixabas:agua_" .. water.name .. "_flowing",
        liquid_alternative_source = "terras_capixabas:agua_" .. water.name .. "_source",
        liquid_viscosity = 2,
        liquid_renewable = false,
        liquid_range = 2,
        post_effect_color = water.tint,
        groups = {water = 3, liquid = 3, not_in_creative_inventory = 1}
    })
end

-- OCEAN WATER OVERRIDE (PNG color & alpha only)
core.override_item("default:water_source", {
    tiles = {{

        name = "default_water_source_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0}

    }},
    special_tiles = {{
        name = "default_water_source_animated.png",
        animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
        backface_culling = false
    }},
    use_texture_alpha = "blend"
})

core.override_item("default:water_flowing", {
    tiles = {"default_water.png"},
    special_tiles = {
        { name = "default_water_flowing_animated.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8}, backface_culling = false },
        { name = "default_water_flowing_animated.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8}, backface_culling = true }
    },
    use_texture_alpha = "blend"
})
