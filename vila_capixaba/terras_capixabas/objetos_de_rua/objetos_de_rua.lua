-- OBJETOS DE RUA -----------------------------------------------------------------

local last_onda={}

local onda_def={
initial_properties={
physical=false,
collide_with_objects=false,
collisionbox={0,0,0,0,0,0},
visual="mesh",
mesh="onda.glb",
textures={"onda.png"},
pointable=false,
static_save=true
},
on_activate=function(self,staticdata,dtime_s)
self.object:set_acceleration({x=0,y=0,z=0})
self.object:set_animation({x=0,y=45},1,0,true)
end
}

core.register_entity("terras_capixabas:onda",onda_def)

core.register_craftitem("terras_capixabas:onda_inv",{
description="Onda",
inventory_image="onda_inv.png",
on_place=function(itemstack,placer,pointed_thing)
if pointed_thing.type~="node" then return itemstack end
local pos=pointed_thing.above
local obj=core.add_entity(pos,"terras_capixabas:onda")
if obj and placer then
local epos=obj:get_pos()
local ppos=placer:get_pos()
local dir=vector.direction(epos,ppos)
local yaw=math.atan2(dir.z,dir.x)-math.pi/2
obj:set_yaw(yaw)
local name=placer:get_player_name()
last_onda[name]=obj
end
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})

core.register_chatcommand("undo",{
description="Remove last placed onda",
func=function(name)
local obj=last_onda[name]
if obj and obj:get_pos() then
obj:remove()
last_onda[name]=nil
return true,"Last onda removed."
end
return false,"No onda to undo."
end
})



core.register_node("terras_capixabas:floor_plan", {
    description = "Floor Plan",
    tiles = {"floor_plan.png"},
    drawtype = "mesh",
	visual_scale = 16.0,
    mesh = "floor_plan.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_cone", {
    description = "Cone de Rua",
    tiles = {"rua_cone.png"},
    drawtype = "mesh",
    mesh = "rua_cone.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:amarelinha", {
    description = "Amarelinha",
    tiles = {"amarelinha.png"},
    drawtype = "mesh",
    mesh = "amarelinha.obj",
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

core.register_node("terras_capixabas:balanco_arvore", {
    description = "balanco_arvore",
    tiles = {"balanco_arvore.png"},
    drawtype = "mesh",
    mesh = "balanco_arvore.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:bandeira", {
    description = "Bandeira",
    drawtype = "mesh",
    mesh = "bandeira.obj",
    tiles = {{
        name = "bandeira.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 26,  -- Width of each frame in pixels
            aspect_h = 20,  -- Height of each frame in pixels
            length = 1    -- Total time to cycle through all frames
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})


core.register_node("terras_capixabas:rua_banca_jornal", {
    description = "rua_banca_jornal",
    tiles = {"rua_banca_jornal.png"},
    drawtype = "mesh",
    mesh = "rua_banca_jornal.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:bebedouro_beijaflor", {
    description = "Bebedouro Beijaflor",
    tiles = {"bebedouro_beijaflor.png"},
    drawtype = "mesh",
    mesh = "bebedouro_beijaflor.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "blend",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})


core.register_node("terras_capixabas:porta_rolante_azul", {
    description = "Porta Rolante Azul",
    tiles = {"porta_rolante_azul.png"},
    drawtype = "mesh",
    mesh = "porta_rolante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 1, metal = 1},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_rolante_azul_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_rolante_azul_opened", {
    description = "Porta Rolante Azul Aberta",
    tiles = {"porta_rolante_azul.png"},
    drawtype = "mesh",
    mesh = "porta_rolante_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 1, metal = 1, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:porta_rolante_azul_opened",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_rolante_azul", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_rolante_branca", {
    description = "Porta Rolante Branca",
    tiles = {"porta_rolante_branca.png"},
    drawtype = "mesh",
    mesh = "porta_rolante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 1, metal = 1},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_rolante_branca_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_rolante_branca_opened", {
    description = "Porta Rolante Branca Aberta",
    tiles = {"porta_rolante_branca.png"},
    drawtype = "mesh",
    mesh = "porta_rolante_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 1, metal = 1, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:porta_rolante_branca_opened",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_rolante_branca", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_rolante_vermelha", {
    description = "Porta Rolante Vermelha",
    tiles = {"porta_rolante_vermelha.png"},
    drawtype = "mesh",
    mesh = "porta_rolante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 1, metal = 1},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_rolante_vermelha_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_rolante_vermelha_opened", {
    description = "Porta Rolante Vermelha Aberta",
    tiles = {"porta_rolante_vermelha.png"},
    drawtype = "mesh",
    mesh = "porta_rolante_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 1, metal = 1, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:porta_rolante_vermelha_opened",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_rolante_vermelha", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

-- ---------------------------------------------------------------------

core.register_node("terras_capixabas:barraca_praia", {
    description = "barraca_praia",
    tiles = {"barraca_praia.png"},
    drawtype = "mesh",
    mesh = "barraca_praia.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:barraca_praia_pipoca", {
    description = "barraca_praia_pipoca",
    tiles = {"barraca_praia_pipoca.png"},
    drawtype = "mesh",
    mesh = "barraca_praia_pipoca.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "blend",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})


core.register_node("terras_capixabas:teto_palha", {
    description = "teto_palha",
    tiles = {"palha_top.png"},
    paramtype = "light",
    paramtype2 = "none",
    walkable = true,
    pointable = true,
    buildable_to = false,
    sunlight_propagates = true,
    drawtype = "nodebox",

    node_box = {
        type = "fixed",
        fixed = {
            -- 2 pixels tall (2/16 of a node)
            {-0.5, -0.5, -0.5, 0.5, -0.5 + (2/16), 0.5},
        },
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.5 + (2/16), 0.5},
    },

    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.5 + (2/16), 0.5},
    },

    groups = {snappy = 3, oddly_breakable_by_hand = 3, flammable = 1},
    sounds = default.node_sound_leaves_defaults(),
})



core.register_node("terras_capixabas:rua_transformador", {
    description = "rua_transformador",
    tiles = {"rua_transformador.png"},
    drawtype = "mesh",
    mesh = "rua_transformador.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_tumba1", {
    description = "rua_tumba1",
    tiles = {"rua_tumba1.png"},
    drawtype = "mesh",
    mesh = "rua_tumba1.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2}
        }
    }
})


core.register_node("terras_capixabas:rua_tumba2", {
    description = "rua_tumba2",
    tiles = {"rua_tumba2.png"},
    drawtype = "mesh",
    mesh = "rua_tumba2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.2, 0.5, 0.3, 0.2}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.2, 0.5, 0.5, 0.2}
        }
    }
})

core.register_node("terras_capixabas:rua_tumba3", {
    description = "rua_tumba3",
    tiles = {"rua_tumba3.png"},
    drawtype = "mesh",
    mesh = "rua_tumba3.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -1.5, 0.5, -0.1, 0.5}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -1.5, 0.5, -0.1, 0.5}
        }
    }
})

-- PIPAS ---------------------------------------------------------

local pipas = {
 {"pipa_abobora", "pipa_abobora.png"},
 {"pipa_fla", "pipa_fla.png"},
 {"pipa_flu", "pipa_flu.png"},
 {"pipa_sp", "pipa_sp.png"}
}

for _, def in ipairs(pipas) do
 local name, texture = def[1], def[2]
 core.register_node("terras_capixabas:"..name, {
  description = name,
  tiles = {texture},
  drawtype = "mesh",
  mesh = "pipa.obj",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = {snappy = 3, flammable = 2},
  walkable = false,
  use_texture_alpha = "clip",
  selection_box = {type = "fixed", fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}}
 })
end

-- -------------------------------------------------------------------

core.register_node("terras_capixabas:pipa_ratinho", {
    description = "pipa_ratinho",
    tiles = {"pipa_ratinho.png"},
    drawtype = "mesh",
    mesh = "pipa_ratinho.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:pipa_catreco", {
    description = "pipa_catreco",
    tiles = {"pipa_catreco.png"},
    drawtype = "mesh",
    mesh = "pipa_catreco.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})



core.register_node("terras_capixabas:rua_rede_volley", {
    description = "rua_rede_volley",
    tiles = {"rua_rede_volley.png"},
    drawtype = "mesh",
    mesh = "rua_rede_volley.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})


core.register_node("terras_capixabas:rua_cacamba_entulho", {
    description = "rua_cacamba_entulho",
    tiles = {"rua_cacamba_entulho.png"},
    drawtype = "mesh",
    mesh = "rua_cacamba_entulho.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
selection_box = {
    type = "fixed",
    fixed = { -1.25026, -0.5, -1.00033, 1.25026, 0.875, 1.00033 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -1.25026, -0.5, -1.00033, 1.25026, 0.75, 1.00033 }, -- Main body
        { -1.25026, 0.375, -1.00033, 1.25026, 0.375, 1.00033 }, -- Middle layer
        { -1.0315, 0.25, -0.96879, 0.1565, 0.875, 0.96902 } -- Top debris
    }
}
})

-- LETREIROS --------------

local letreiros = {
  "bank","club","gym","hotel","job","mecanica","mercado","pizza","pm","shopping"
}

local function register_letreiro(name)
core.register_node("terras_capixabas:letreiro_"..name,{
description="letreiro_"..name,
tiles={"letreiro_"..name..".png"},
drawtype="mesh",mesh="letreiro.obj",
paramtype="light",paramtype2="facedir",
backface_culling=true,walkable=false,
groups={cracky=3,oddly_breakable_by_hand=2},
selection_box={type="fixed",fixed={-1.5,-0.5,0.3,1.5,0.5,0.7}}
})
end

for _,name in ipairs(letreiros) do register_letreiro(name) end


-- ----------------------------------------------------------

core.register_node("terras_capixabas:mesa", {
    description = "Mesa",
    tiles = {"mesa.png"},
    drawtype = "mesh",
    mesh = "mesa.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:sinuca", {
    description = "Sinuca",
    tiles = {"sinuca.png"},
    drawtype = "mesh",
    mesh = "sinuca.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
selection_box = {
    type = "fixed",
    fixed = { -1.25, -0.5, -1.0625, 1.25, 0.5, 1.0625 }
},
collision_box = {
    type = "fixed",
    fixed = { -1.25, -0.5, -1.0625, 1.25, 0.5, 1.0625 }
},
})

core.register_node("terras_capixabas:sombrinha_praia", {
    description = "Sombrinha de Praia",
    tiles = {"sombrinha_praia.png"},
    inventory_image = "sombrinha_praia.png",
    drawtype = "mesh",
    mesh = "sombrinha_praia.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then
            return itemstack
        end

        local pos = pointed_thing.above
        local node_name = "terras_capixabas:sombrinha_praia_" .. math.random(1, 3)

        local placer_dir = core.dir_to_facedir(placer:get_look_dir())
        core.set_node(pos, {name = node_name, param2 = placer_dir})

        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end

        return itemstack
    end
})

core.register_node("terras_capixabas:sombrinha_praia_1", {
    description = "Sombrinha de Praia Variant 1",
    tiles = {"sombrinha_praia.png"},  -- Use first texture
    drawtype = "mesh",
    mesh = "sombrinha_praia.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:sombrinha_praia_2", {
    description = "Sombrinha de Praia Variant 2",
    tiles = {"sombrinha_praia2.png"},  -- Use second texture
    drawtype = "mesh",
    mesh = "sombrinha_praia.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:sombrinha_praia_3", {
    description = "Sombrinha de Praia Variant 3",
    tiles = {"sombrinha_praia3.png"},  -- Use third texture
    drawtype = "mesh",
    mesh = "sombrinha_praia.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- -----------------------------------------------------------

core.register_node("terras_capixabas:rua_orelhao", {
    description = "rua_orelhao",
    tiles = {"rua_orelhao.png"},
    drawtype = "mesh",
    mesh = "rua_orelhao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_orelhao_oi", {
    description = "rua_orelhao oi",
    tiles = {"rua_orelhao_oi.png"},
    drawtype = "mesh",
    mesh = "rua_orelhao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_orelhao_vivo", {
    description = "rua_orelhao vivo",
    tiles = {"rua_orelhao_vivo.png"},
    drawtype = "mesh",
    mesh = "rua_orelhao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_cruzeiro", {
    description = "bandeira_janela_cruzeiro",
    tiles = {"bandeira_janela_cruzeiro.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_flamengo", {
    description = "bandeira_janela_flamengo",
    tiles = {"bandeira_janela_flamengo.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_fluminense", {
    description = "bandeira_janela_fluminense",
    tiles = {"bandeira_janela_fluminense.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_gremio", {
    description = "bandeira_janela_gremio",
    tiles = {"bandeira_janela_gremio.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_palmeiras", {
    description = "bandeira_janela_palmeiras",
    tiles = {"bandeira_janela_palmeiras.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_sao_paulo", {
    description = "bandeira_janela_sao_paulo",
    tiles = {"bandeira_janela_sao_paulo.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_bandeira_janela_vasco", {
    description = "bandeira_janela_vasco",
    tiles = {"bandeira_janela_vasco.png"},
    drawtype = "mesh",
    mesh = "bandeira_janela_flamengo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_trailer", {
    description = "rua_trailer",
    tiles = {"rua_trailer.png"},
    drawtype = "mesh",
    mesh = "rua_trailer.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
selection_box = {
    type = "fixed",
    fixed = { -2.15625, -0.5, -1.04515, 2.0, 3, 1.09375 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -2.0, 0.0, -1.09375, 2.0, 0.5, 1.09375 }, -- Main body
        { -2.15625, 0.0, -0.25, -1.96875, 0.125, 0.25 }, -- Front section
        { -1.5, 1.0, -1.4375, 1.5, 1.0, -0.8125 }, -- Top front
        { -2.0, 2.46875, -1.04515, 2.0, 3.0, -1.125 }, -- Slanted roof
        { 1.6875, -0.46783, -0.53033, 1.9375, 0.59283, 0.53033 }, -- Side extension
        { -1.5625, -0.5, 0.625, -0.8125, 0.25, 0.875 }, -- Wheel 1
        { -1.5625, -0.5, -0.875, -0.8125, 0.25, -0.625 } -- Wheel 2
    }
}
})

core.register_node("terras_capixabas:rua_lixeira_branca", {
    description = "rua_lixeira_branca",
    tiles = {"rua_lixeira_branca.png"},
    drawtype = "mesh",
    mesh = "rua_lixeira.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
-- rua_lixeira.obj
selection_box = {
    type = "fixed",
    fixed = { -0.4375, -0.5, -0.3125, 0.4375, 0.875, 0.3125 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.4375, 0.375, -0.3125, 0.4375, 0.875, 0.3125 }, -- Main body
        { -0.0625, -0.5, -0.0625, 0.0625, 0.375, 0.0625 } -- Base
    }
}
})

core.register_node("terras_capixabas:rua_lixeira_vermelha", {
    description = "rua_lixeira_vermelha",
    tiles = {"rua_lixeira_vermelha.png"},
    drawtype = "mesh",
    mesh = "rua_lixeira.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
selection_box = {
    type = "fixed",
    fixed = { -0.4375, -0.5, -0.3125, 0.4375, 0.875, 0.3125 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.4375, 0.375, -0.3125, 0.4375, 0.875, 0.3125 }, -- Main body
        { -0.0625, -0.5, -0.0625, 0.0625, 0.375, 0.0625 } -- Base
    }
}
})

core.register_node("terras_capixabas:rua_hidrante", {
    description = "rua_hidrante",
    tiles = {"rua_hidrante.png"},
    drawtype = "mesh",
    mesh = "rua_hidrante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
-- rua_hidrante.obj
selection_box = {
    type = "fixed",
    fixed = { -0.25, -0.5, -0.3125, 0.25, 0.5, 0.1875 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875 }, -- Base
        { -0.125, -0.375, -0.125, 0.125, 0.125, 0.125 }, -- Middle section
        { -0.1875, 0.125, -0.1875, 0.1875, 0.3125, 0.1875 }, -- Upper section
        { -0.125, 0.3125, -0.125, 0.125, 0.5, 0.125 }, -- Top
        { -0.125, -0.15625, -0.3125, 0.125, 0.03125, -0.125 }, -- Side extension 1
        { -0.25, -0.15625, -0.09375, -0.125, 0.03125, 0.09375 } -- Side extension 2
    }
}
})

core.register_node("terras_capixabas:rua_mesa", {
    description = "rua_mesa",
    tiles = {"rua_mesa.png"},
    drawtype = "mesh",
    mesh = "rua_mesa.obj",
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


core.register_entity("terras_capixabas:balanco", {
initial_properties = {
physical = false,
collide_with_objects = false,
visual = "mesh",
visual_size = {x = 1, y = 1},
mesh = "balanco.glb",
textures = {"balanco.png"},
static_save = true,
pointable = true,
},

animating = false,
check_timer = 0,

on_activate = function(self, staticdata, dtime_s)
self.animating = false
self.check_timer = 0
end,

on_step = function(self, dtime)
self.check_timer = self.check_timer + dtime
if self.check_timer < 0.5 then return end
self.check_timer = 0

local pos = self.object:get_pos()
if not pos then return end
local active = false
local r2 = 100

for _,player in ipairs(core.get_connected_players()) do
local ppos = player:get_pos()
if ppos then
local dx = pos.x - ppos.x
local dy = pos.y - ppos.y
local dz = pos.z - ppos.z
if (dx*dx + dy*dy + dz*dz) <= r2 then
active = true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x = 0, y = 44}, 1, 0, true)
self.animating = true
elseif not active and self.animating then
self.object:set_animation({x = 0, y = 0}, 0, 0, false)
self.animating = false
end
end,

on_rightclick = function(self, clicker)
end,
})


-- Spawn Egg
core.register_craftitem("terras_capixabas:balanco_egg", {
description = "balanco",
inventory_image = "balanco_inv.png",
stack_max = 99,

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.above
core.add_entity(pos, "terras_capixabas:balanco")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end,
})


core.register_entity("terras_capixabas:escorregador", {
initial_properties = {
physical = false,
collide_with_objects = false,
visual = "mesh",
visual_size = {x = 1, y = 1},
mesh = "escorregador.glb",
textures = {"escorregador.png"},
static_save = true,
pointable = true,
},

animating = false,
check_timer = 0,

on_activate = function(self, staticdata, dtime_s)
self.animating = false
self.check_timer = 0
end,

on_step = function(self, dtime)
self.check_timer = self.check_timer + dtime
if self.check_timer < 0.5 then return end
self.check_timer = 0

local pos = self.object:get_pos()
if not pos then return end
local active = false
local r2 = 100

for _,player in ipairs(core.get_connected_players()) do
local ppos = player:get_pos()
if ppos then
local dx = pos.x - ppos.x
local dy = pos.y - ppos.y
local dz = pos.z - ppos.z
if (dx*dx + dy*dy + dz*dz) <= r2 then
active = true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x = 0, y = 228}, 1, 0, true)
self.animating = true
elseif not active and self.animating then
self.object:set_animation({x = 0, y = 0}, 0, 0, false)
self.animating = false
end
end,

on_rightclick = function(self, clicker)
end,
})



-- Spawn Egg
core.register_craftitem("terras_capixabas:escorregador_egg", {
description = "escorregador",
inventory_image = "escorregador_inv.png",
stack_max = 99,

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.above
core.add_entity(pos, "terras_capixabas:escorregador")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end,
})


core.register_entity("terras_capixabas:gangorra", {
initial_properties = {
physical = false,
collide_with_objects = false,
visual = "mesh",
visual_size = {x = 1, y = 1},
mesh = "gangorra.glb",
textures = {"gangorra.png"},
static_save = true,
pointable = true,
},

animating = false,
check_timer = 0,

on_activate = function(self, staticdata, dtime_s)
self.animating = false
self.check_timer = 0
end,

on_step = function(self, dtime)
self.check_timer = self.check_timer + dtime
if self.check_timer < 0.5 then return end
self.check_timer = 0

local pos = self.object:get_pos()
if not pos then return end
local active = false
local r2 = 100

for _,player in ipairs(core.get_connected_players()) do
local ppos = player:get_pos()
if ppos then
local dx = pos.x - ppos.x
local dy = pos.y - ppos.y
local dz = pos.z - ppos.z
if (dx*dx + dy*dy + dz*dz) <= r2 then
active = true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x = 0, y = 30}, 1, 0, true)
self.animating = true
elseif not active and self.animating then
self.object:set_animation({x = 0, y = 0}, 0, 0, false)
self.animating = false
end
end,

on_rightclick = function(self, clicker)
end,
})



-- Spawn Egg
core.register_craftitem("terras_capixabas:gangorra_egg", {
description = "gangorra",
inventory_image = "gangorra_inv.png",
stack_max = 99,

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.above
core.add_entity(pos, "terras_capixabas:gangorra")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end,
})

core.register_node("terras_capixabas:p_marimba", {
    description = "p_marimba",
    tiles = {"p_marimba.png"},
    drawtype = "mesh",
    mesh = "pendurado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:p_pipa_abobora", {
    description = "p_pipa_abobora",
    tiles = {"p_pipa_abobora.png"},
    drawtype = "mesh",
    mesh = "pendurado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:p_pipa_fla", {
    description = "p_pipa_fla",
    tiles = {"p_pipa_fla.png"},
    drawtype = "mesh",
    mesh = "pendurado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:p_pipa_flu", {
    description = "p_pipa_flu",
    tiles = {"p_pipa_flu.png"},
    drawtype = "mesh",
    mesh = "pendurado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:p_pipa_sp", {
    description = "p_pipa_sp",
    tiles = {"p_pipa_sp.png"},
    drawtype = "mesh",
    mesh = "pendurado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:p_tenis", {
    description = "p_tenis",
    tiles = {"p_tenis.png"},
    drawtype = "mesh",
    mesh = "pendurado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:postefio", {
    description = "postefio",
    tiles = {"postefio.png"},
    drawtype = "mesh",
    mesh = "postefio.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:postefio_canto", {
    description = "postefio_canto",
    tiles = {"postefio.png"},
    drawtype = "mesh",
    mesh = "postefio_canto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    use_texture_alpha = "clip",	
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.5, 0.2, 0.5, 0.5}
    }
})



-- LUZ NOTURNA

-- Light ON node (emits light, hidden from inventory)
core.register_node("terras_capixabas:light_on", {
    description = "Light (On)",
    tiles = {"light_block.png"},
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    light_source = core.LIGHT_MAX,  -- Maximum light
    groups = {snappy = 3, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- Light OFF node (no light, visible and placeable)
core.register_node("terras_capixabas:light_off", {
    description = "Invisible Light Block",
    tiles = {"light_block.png"},
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    light_source = 0,  -- No light
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_abm({
    label = "Light switch day/night",
    nodenames = {"terras_capixabas:light_on", "terras_capixabas:light_off"},
    interval = 10,  -- Runs every 10 seconds
    chance = 1,     -- Always runs

    action = function(pos, node)
        local time_of_day = core.get_timeofday()

        if time_of_day > 0.2 and time_of_day < 0.8 then
            -- Daytime: turn OFF
            if node.name == "terras_capixabas:light_on" then
                core.swap_node(pos, {name = "terras_capixabas:light_off", param2 = node.param2})
            end
        else
            -- Nighttime: turn ON
            if node.name == "terras_capixabas:light_off" then
                core.swap_node(pos, {name = "terras_capixabas:light_on", param2 = node.param2})
            end
        end
    end
})

core.register_node("terras_capixabas:placa_cafe", {
    description = "placa_cafe",
    tiles = {"placa_cafe.png"},
    drawtype = "mesh",
    mesh = "placa_cafe.obj",
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

core.register_node("terras_capixabas:placa_onibus", {
    description = "placa_onibus",
    tiles = {"placa_onibus.png"},
    drawtype = "mesh",
    mesh = "placa_onibus.obj",
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

core.register_node("terras_capixabas:placa_pare", {
    description = "Capixaba placa_pare",
    tiles = {"placa_pare.png"},
    drawtype = "mesh",
    mesh = "placa_sinalizacao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:placa_proibido", {
    description = "Capixaba placa_proibido",
    tiles = {"placa_proibido.png"},
    drawtype = "mesh",
    mesh = "placa_sinalizacao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:placa_velocidade", {
    description = "Capixaba placa_velocidade",
    tiles = {"placa_velocidade.png"},
    drawtype = "mesh",
    mesh = "placa_sinalizacao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:placa_vire", {
    description = "Capixaba placa_vire",
    tiles = {"placa_vire.png"},
    drawtype = "mesh",
    mesh = "placa_sinalizacao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:poste", {
    description = "Poste de Luz",
    tiles = {"poste.png"},
    drawtype = "mesh",
    mesh = "poste.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:poste_cimento", {
    description = "Poste de Luz Cimento",
    tiles = {"poste_cimento.png"},
    drawtype = "mesh",
    mesh = "poste.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:rua_semaforo", {
    description = "rua_semaforo",
    tiles = {"rua_semaforo.png"},
    drawtype = "mesh",
    mesh = "rua_semaforo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:toto", {
    description = "Toto",
    tiles = {"toto.png"},
    drawtype = "mesh",
    mesh = "toto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
selection_box = {
    type = "fixed",
    fixed = { -1.25, -0.5, -1.0625, 1.25, 0.5, 1.0625 }
},
collision_box = {
    type = "fixed",
    fixed = { -1.25, -0.5, -1.0625, 1.25, 0.5, 1.0625 }
},
})

core.register_node("terras_capixabas:bandeirinha1", {
    description = "Bandeirinha 1",
    tiles = {"bandeirinha1.png"},
    drawtype = "mesh",
    mesh = "bandeirinha.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:bandeirinha1_canto", {
    description = "Bandeirinha 1 Canto",
    tiles = {"bandeirinha1.png"},
    drawtype = "mesh",
    mesh = "bandeirinha_canto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:bandeirinha2", {
    description = "Bandeirinha 2",
    tiles = {"bandeirinha2.png"},
    drawtype = "mesh",
    mesh = "bandeirinha.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:bandeirinha2_canto", {
    description = "Bandeirinha 2 Canto",
    tiles = {"bandeirinha2.png"},
    drawtype = "mesh",
    mesh = "bandeirinha_canto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- COISAS DO PARQUINHO

core.register_entity("terras_capixabas:rodopio", {
initial_properties = {
physical = false,
collide_with_objects = false,
visual = "mesh",
visual_size = {x = 1, y = 1},
mesh = "rodopio.glb",
textures = {"rodopio.png"},
static_save = true,
pointable = true,
},

animating = false,
check_timer = 0,

on_activate = function(self, staticdata, dtime_s)
self.animating = false
self.check_timer = 0
end,

on_step = function(self, dtime)
self.check_timer = self.check_timer + dtime
if self.check_timer < 0.5 then return end
self.check_timer = 0

local pos = self.object:get_pos()
if not pos then return end
local active = false
local r2 = 100 -- 10^2

for _,player in ipairs(core.get_connected_players()) do
local ppos = player:get_pos()
if ppos then
local dx = pos.x - ppos.x
local dy = pos.y - ppos.y
local dz = pos.z - ppos.z
if (dx*dx + dy*dy + dz*dz) <= r2 then
active = true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x = 0, y = 90}, 1, 0, true)
self.animating = true
elseif not active and self.animating then
self.object:set_animation({x = 0, y = 0}, 0, 0, false)
self.animating = false
end
end,

on_rightclick = function(self, clicker)
end,
})


-- Spawn Egg
core.register_craftitem("terras_capixabas:rodopio_egg", {
description = "Rodopio",
inventory_image = "rodopio_inv.png",
stack_max = 99,

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.above
core.add_entity(pos, "terras_capixabas:rodopio")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end,
})



-- ----------
local tocos = {
 {"toco_azul", "Toco Azul"},
 {"toco_branco", "Toco Branco"},
 {"toco_marrom", "Toco Marrom"},
 {"toco_verde", "Toco Verde"},
 {"toco_vermelho", "Toco Vermelho"}
}

for _, def in ipairs(tocos) do
 core.register_node("terras_capixabas:"..def[1], {
  description = def[2],
  tiles = {def[1]..".png"},
  drawtype = "mesh",
  mesh = "toco.obj",
  paramtype = "light",
  backface_culling = true,
  groups = {cracky = 3, oddly_breakable_by_hand = 2},
  walkable = true,
  selection_box = {
   type = "fixed",
   fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}
  },
  collision_box = {
   type = "fixed",
   fixed = {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}
  }
 })
end