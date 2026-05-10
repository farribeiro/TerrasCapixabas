-- PLANTAS

core.register_node("terras_capixabas:pl_agave", {
    description = "Capixaba Agave",
    tiles = {"agave.png"},
    drawtype = "mesh",
    mesh = "agave.obj",
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

core.register_node("terras_capixabas:pl_agave_grande", {
    description = "Capixaba Agave Grande",
    tiles = {"agave_grande.png"},
    drawtype = "mesh",
    mesh = "agave_grande.obj",
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

-- PLANTAS RASTEIRAS -----------------------------------------------------------

local rast_nodes={
{"pl_algas", "Algas", "algas", "blend"},
{"estrelas", "Estrelas", "estrelas", "clip"},
{"pl_folhas_caidas", "Folhas Caídas", "folhas_caidas", "clip"},
{"pl_folhas_secas", "Folhas Secas", "folhas_secas", "clip"},
{"pl_rasteira_lambari", "Lambari", "rasteira_lambari", "clip"},
{"pl_rasteira_salsadapraia", "Salsa da Praia", "rasteira_salsadapraia", "clip"},
}

for _,def in ipairs(rast_nodes) do
core.register_node("terras_capixabas:"..def[1], {
description = def[2],
tiles = {def[3]..".png"},
drawtype = "mesh",
mesh = "planta_rasteira.obj",
paramtype = "light",
paramtype2 = "facedir",
groups = {snappy = 3, oddly_breakable_by_hand = 3},
walkable = false,
use_texture_alpha = def[4],
backface_culling = true,
selection_box = {
type = "fixed",
fixed = {-0.5, -0.6, -0.5, 0.5, -0.4, 0.5}
},
})
end

-- ----------------------

local function register_pote_planta(name, description)
    core.register_node("terras_capixabas:" .. name, {
        description = description,
        tiles = {name .. ".png"},
        drawtype = "mesh",
        mesh = "pl_pote_planta.obj",
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
end

register_pote_planta("pl_pote_caladio",   "Pote com Caládio")
register_pote_planta("pl_pote_chanana",   "Pote com Chananã")
register_pote_planta("pl_pote_samambaia", "Pote com Samambaia")


-- PLANTAS

-- Define all plants with optional visual_scale
local plants = {
    -- Default visual_scale (1.0, so not set)
    {name = "bananeirinha"},
    {name = "chanana"},
    {name = "chapisco_roxo"},
    {name = "copo_leite"},
    {name = "crizanto"},
    {name = "mato"},
	{name = "sao_jorge"},
    {name = "tulipa_rosa"},
    {name = "vinca"},

    -- visual_scale = 2.0
	{name = "ave_paraiso", visual_scale = 2.0},
	{name = "dedo", visual_scale = 2.0},
    {name = "dracena_vermelha", visual_scale = 2.0},
    {name = "heliconia", visual_scale = 2.0},
	{name = "heliconia2", visual_scale = 2.0},
    {name = "hibisco", visual_scale = 2.0},
    {name = "hibisco_rosa", visual_scale = 2.0},
    {name = "planta_fan", visual_scale = 2.0},
    {name = "mato_alto", visual_scale = 2.0},

    -- visual_scale = 4.0
    {name = "aceroleira", visual_scale = 4.0},
    {name = "amoreira", visual_scale = 4.0},
    {name = "cana", visual_scale = 4.0},
	{name = "coqueirinho", visual_scale = 4.0},
    {name = "espetadinha2d", visual_scale = 4.0},
    {name = "mamona2", visual_scale = 4.0},
	{name = "palheta", visual_scale = 4.0},
    {name = "pitangueira", visual_scale = 4.0},

-- visual_scale = 8.0
	{name = "flamboyant_amarelo", visual_scale = 8.0},
	{name = "flamboyant_vermelho", visual_scale = 8.0},

    -- visual_scale = 16.0
    {name = "arvore", visual_scale = 16.0},
    {name = "arvore_grande2d", visual_scale = 16.0},
    {name = "castanheira2d", visual_scale = 16.0},
    {name = "coqueiro2D", visual_scale = 16.0},
	{name = "eucalipto2", visual_scale = 16.0}
}

-- Function to register a plant node
local function register_plant(def)
  local name = def.name
  local visual_scale = def.visual_scale -- may be nil (optional)

  core.register_node("terras_capixabas:pl_" .. name, {
    description = name, -- You can replace this with capitalized/descriptive names
    drawtype = "plantlike",
    tiles = {name .. ".png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    use_texture_alpha = "clip",
    special_tiles = {
        {name = name .. ".png", tileable_vertical = false}
    },
    buildable_to = true,
    waving = 1,
    inventory_image = name .. ".png",
    wield_image = name .. ".png",
    visual_size = {x = 1, y = 1},
    visual_scale = visual_scale,
    groups = {snappy = 3, flora = 0, attached_node = 1},
    sounds = default.node_sound_leaves_defaults(),
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
    }
  })
end

-- Register all plants in the list
for _, def in ipairs(plants) do
  register_plant(def)
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

-- Allfaces_optional
local allfaces_plants = {
    {name = "bushes", desc = "Bushes", groups = {tree = 1, choppy = 2, flammable = 2}},
    {name = "folha_bananeira", desc = "Folha de Bananeira", leaf = true},
    {name = "folha_castanheira", desc = "Folha de Castanheira", leaf = true},
    {name = "folha_coqueiro", desc = "Folha de Coqueiro", leaf = true},
    {name = "folhas_salgueiro", desc = "Salgueiro Leaves", leaf = true},
    {name = "folhas_salgueiro_vine", desc = "Salgueiro Vinha", leaf = true}
}

for _, p in ipairs(allfaces_plants) do
  local n = "terras_capixabas:pl_" .. p.name
  local t = p.name .. ".png"
  local d = {
    description = p.desc,
    drawtype = "allfaces_optional",
    tiles = {t},
    paramtype = "light",
    use_texture_alpha = "clip",
    walkable = true,
    groups = p.groups or {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    sounds = default.node_sound_leaves_defaults()
  }
  if p.leaf then
    d.waving = 1
    d.sunlight_propagates = true
    d.backface_culling = false
    d.after_place_node = default.after_place_leaves
    d.drop = {max_items = 1, items = {{items = {"terras_capixabas:" .. p.name}}}}
  end
  core.register_node(n, d)
end

-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

-- Mesh
local mesh_defs = {
  -- {name, desc, mesh, tile, groups, walkable, selection_box}
  {"boxplant",              "Planta Caixinha",         "boxplant",         "boxplant",         {tree=1, choppy=2, flammable=2}, true},
  {"boxplant_florida",      "Planta Caixinha Florida", "boxplant",         "boxplant_florida", {tree=1, choppy=2, flammable=2}, true},
  {"muro_vinha",            "Vinha de Muro",           "muro_vinha",       "muro_vinha",       {snappy=3, leafdecay=3, flammable=2, leaves=1}, false, {-0.5,-0.5,0.6,0.5,0.5,0.8}},
  {"muro_vinha2",           "Vinha de Muro 2",         "muro_vinha",       "muro_vinha2",      {snappy=3, leafdecay=3, flammable=2, leaves=1}, false, {-0.5,-0.5,0.6,0.5,0.5,0.8}},
  {"muro_vinha_capa",       "muro_vinha_capa",         "muro_vinha_capa",  "muro_vinha",       {snappy=3, leafdecay=3, flammable=2, leaves=1}, false, {-0.5,-0.5,-0.3,0.5,-0.2,0.3}},
  {"muro_vinha2_capa",      "muro_vinha2_capa",        "muro_vinha_capa",  "muro_vinha2",      {snappy=3, leafdecay=3, flammable=2, leaves=1}, false, {-0.5,-0.5,-0.3,0.5,-0.2,0.3}},
  {"paudagua",              "Pau D´água",              "paudagua",         "paudagua",         {tree=1, choppy=2, flammable=2}, false}
}

for _, def in ipairs(mesh_defs) do
  local name, desc, mesh, tile, groups, walk, box = unpack(def)
  core.register_node("terras_capixabas:pl_" .. name, {
    description = desc,
    drawtype = "mesh",
    mesh = mesh .. ".obj",
    tiles = {tile .. ".png"},
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    backface_culling = true,
    walkable = walk,
    groups = groups,
    selection_box = {
      type = "fixed",
      fixed = box or {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
  })
end


-- Normal (Trunks)
core.register_node("terras_capixabas:pl_bananeira_tronco", {
    description = "Tronco de Bananeira",
    tiles = {
        "bananeira_tronco_top.png",
        "bananeira_tronco_top.png",
        "bananeira_tronco.png",
        "bananeira_tronco.png",
        "bananeira_tronco.png",
        "bananeira_tronco.png"
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})

core.register_node("terras_capixabas:pl_coqueiro_tronco", {
    description = "Tronco de coqueiro",
    tiles = {
        "coqueiro_tronco_top.png",
        "coqueiro_tronco_top.png",
        "coqueiro_tronco.png",
        "coqueiro_tronco.png",
        "coqueiro_tronco.png",
        "coqueiro_tronco.png"
    },
    drawtype = "normal",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2},
    sounds = default.node_sound_wood_defaults(),
    is_ground_content = false
})

core.register_node("terras_capixabas:pl_bananeira", {
    description = "Bananeira",
    tiles = {"bananeira.png"},
    drawtype = "mesh",
    mesh = "bananeira.obj",
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


core.register_node("terras_capixabas:castanheira", {
    description = "Castanheira",
    tiles = {"castanheira.png"},
    drawtype = "mesh",
    mesh = "castanheira.obj",
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

core.register_node("terras_capixabas:castanheira_galho", {
    description = "castanheira_galho",
    tiles = {"castanheira_galho.png"},
    drawtype = "mesh",
    mesh = "castanheira_galho.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:castanheira_galho_vertical", {
    description = "castanheira_galho_vertical",
    tiles = {"castanheira_galho.png"},
    drawtype = "mesh",
    mesh = "castanheira_galho_vertical.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:pl_coqueiro", {
    description = "coqueiro",
    tiles = {"coqueiro.png"},
    drawtype = "mesh",
    mesh = "coqueiro.obj",
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

core.register_node("terras_capixabas:pl_coqueiro_tombado", {
    description = "coqueiro_tombado",
    tiles = {"coqueiro.png"},
    drawtype = "mesh",
    mesh = "coqueiro_tombado.obj",
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

core.register_node("terras_capixabas:pl_coqueirinhos", {
    description = "coqueirinhos",
    tiles = {"coqueirinhos.png"},
    drawtype = "mesh",
    mesh = "coqueirinhos.obj",
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


core.register_node("terras_capixabas:pl_mamao", {
    description = "mamao",
    tiles = {"mamao.png"},
    drawtype = "mesh",
    mesh = "mamao.obj",
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

core.register_node("terras_capixabas:pl_mamona", {
    description = "mamona",
    tiles = {"mamao.png"},
    drawtype = "mesh",
    mesh = "mamona.obj",
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

core.register_node("terras_capixabas:pl_samambaia_pendurada", {
    description = "samambaia_pendurada",
    tiles = {"samambaia_pendurada.png"},
    drawtype = "mesh",
    mesh = "samambaia_pendurada.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
selection_box = {
    type = "fixed",
    fixed = { -0.34375, -3.40625, -0.34375, 0.34375, 0.5, 0.34375 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.28125, -1.4375, -0.28125, 0.28125, -1.0625, 0.28125 }, -- Pot
        { -0.31257, -3.40625, -0.31313, 0.31257, -0.96875, 0.31313 } -- Leaves
    }
}
})

core.register_node("terras_capixabas:pl_samambaia_tripe", {
    description = "samambaia_tripe",
    tiles = {"samambaia_tripe.png"},
    drawtype = "mesh",
    mesh = "samambaia_tripe.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
selection_box = {
    type = "fixed",
    fixed = { -0.31257, -0.52134, -0.31313, 0.31257, 1.9375, 0.31313 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.28125, 1.5625, -0.28125, 0.28125, 1.9375, 0.28125 }, -- Pot
        { -0.31257, -0.5, -0.31313, 0.31257, 1.9375, 0.31313 }, -- Leaves
        { -0.25, -0.52134, -0.29999, 0.25, 1.53125, 0.36249 } -- Tripod legs
    }
}
})

-- ------

core.register_node("terras_capixabas:pl_taboa", {
description = "Taboa",
drawtype = "plantlike_rooted",
waving = 1,
tiles = {"default_dirt.png"},
special_tiles = {{name = "taboa.png"}},
paramtype = "light",
paramtype2 = "leveled",
groups = {snappy = 3, flammable = 2},
walkable = false,
selection_box = {
type = "fixed",
fixed = {
{-0.5,-0.5,-0.5,0.5,0.5,0.5},
{-2/16,0.5,-2/16,2/16,2.5,2/16},
},
},
node_dig_prediction = "default:dirt",
node_placement_prediction = "",
sounds = default.node_sound_leaves_defaults(),

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.under
local player_name = placer:get_player_name()
local node_under = minetest.get_node(pos)
local can_place_on =
minetest.get_item_group(node_under.name,"soil") > 0 or
minetest.get_item_group(node_under.name,"sand") > 0
if not can_place_on then return itemstack end
local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}
local node_above = minetest.get_node(pos_above)
local is_water = minetest.get_item_group(node_above.name,"water") > 0
if is_water then
if not minetest.is_protected(pos,player_name) and
not minetest.is_protected(pos_above,player_name) then
minetest.set_node(pos,{
name="terras_capixabas:pl_taboa",
param2=32
})
if not minetest.is_creative_enabled(player_name) then
itemstack:take_item()
end
end
end
return itemstack
end,

after_dig_node = function(pos, oldnode, oldmetadata, digger)
local node_below = minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z})
minetest.set_node(pos,node_below)
end
})


-- ---------

core.register_node("terras_capixabas:alga_amarela", {
description = "Alga Amarela",
drawtype = "plantlike_rooted",
waving = 1,
tiles = {"default_sand.png"},
special_tiles = {{name = "alga_amarela.png"}},
paramtype = "light",
paramtype2 = "leveled",
groups = {snappy = 3, flammable = 2},
walkable = false,
selection_box = {
type = "fixed",
fixed = {
{-0.5,-0.5,-0.5,0.5,0.5,0.5},
{-6/16,0.5,-6/16,6/16,1.0,6/16},
},
},
node_dig_prediction = "default:sand",
node_placement_prediction = "",
sounds = default.node_sound_leaves_defaults(),

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.under
local player_name = placer:get_player_name()
local node_under = minetest.get_node(pos)
local is_sand = minetest.get_item_group(node_under.name, "sand") > 0
if not is_sand then return itemstack end
local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
local node_above = minetest.get_node(pos_above)
local is_water = minetest.get_item_group(node_above.name, "water") > 0
if is_water then
if not minetest.is_protected(pos, player_name) and
not minetest.is_protected(pos_above, player_name) then
minetest.set_node(pos,{
name="terras_capixabas:alga_amarela",
param2=16
})
if not minetest.is_creative_enabled(player_name) then
itemstack:take_item()
end
end
end
return itemstack
end,

after_dig_node = function(pos, oldnode, oldmetadata, digger)
minetest.set_node(pos,{name="default:sand"})
end
})

-- ----------------

core.register_node("terras_capixabas:alga_rosa", {
description = "Alga Amarela",
drawtype = "plantlike_rooted",
waving = 1,
tiles = {"default_sand.png"},
special_tiles = {{name = "alga_rosa.png"}},
paramtype = "light",
paramtype2 = "leveled",
groups = {snappy = 3, flammable = 2},
walkable = false,
selection_box = {
type = "fixed",
fixed = {
{-0.5,-0.5,-0.5,0.5,0.5,0.5},
{-6/16,0.5,-6/16,6/16,1.0,6/16},
},
},
node_dig_prediction = "default:sand",
node_placement_prediction = "",
sounds = default.node_sound_leaves_defaults(),

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.under
local player_name = placer:get_player_name()
local node_under = minetest.get_node(pos)
local is_sand = minetest.get_item_group(node_under.name, "sand") > 0
if not is_sand then return itemstack end
local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
local node_above = minetest.get_node(pos_above)
local is_water = minetest.get_item_group(node_above.name, "water") > 0
if is_water then
if not minetest.is_protected(pos, player_name) and
not minetest.is_protected(pos_above, player_name) then
minetest.set_node(pos,{
name="terras_capixabas:alga_rosa",
param2=16
})
if not minetest.is_creative_enabled(player_name) then
itemstack:take_item()
end
end
end
return itemstack
end,

after_dig_node = function(pos, oldnode, oldmetadata, digger)
minetest.set_node(pos,{name="default:sand"})
end
})

-- -----------------------

core.register_node("terras_capixabas:alga_vermelha", {
description = "Alga Amarela",
drawtype = "plantlike_rooted",
waving = 1,
tiles = {"default_sand.png"},
special_tiles = {{name = "alga_vermelha.png"}},
paramtype = "light",
paramtype2 = "leveled",
groups = {snappy = 3, flammable = 2},
walkable = false,
selection_box = {
type = "fixed",
fixed = {
{-0.5,-0.5,-0.5,0.5,0.5,0.5},
{-6/16,0.5,-6/16,6/16,1.0,6/16},
},
},
node_dig_prediction = "default:sand",
node_placement_prediction = "",
sounds = default.node_sound_leaves_defaults(),

on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.under
local player_name = placer:get_player_name()
local node_under = minetest.get_node(pos)
local is_sand = minetest.get_item_group(node_under.name, "sand") > 0
if not is_sand then return itemstack end
local pos_above = {x = pos.x, y = pos.y + 1, z = pos.z}
local node_above = minetest.get_node(pos_above)
local is_water = minetest.get_item_group(node_above.name, "water") > 0
if is_water then
if not minetest.is_protected(pos, player_name) and
not minetest.is_protected(pos_above, player_name) then
minetest.set_node(pos,{
name="terras_capixabas:alga_vermelha",
param2=16
})
if not minetest.is_creative_enabled(player_name) then
itemstack:take_item()
end
end
end
return itemstack
end,

after_dig_node = function(pos, oldnode, oldmetadata, digger)
minetest.set_node(pos,{name="default:sand"})
end
})

-- ---------------------------

core.register_node("terras_capixabas:pl_taboa_fina", {
    description = "Taboa Fina",
    drawtype = "nodebox",
    tiles = {"taboa_fina.png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,  -- allows walking through
    use_texture_alpha = "clip",
    waving = 1,
    floodable = true,
    inventory_image = "taboa_fina.png",
    wield_image = "taboa_fina.png",

    groups = {
        snappy = 3,
        flora = 0,
        dig_immediate = 3
    },

    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            -- First quad (north-south)
            {-0.01, -0.5, -0.5, 0.01, 0.5, 0.5},
            -- Second quad (east-west)
            {-0.5, -0.5, -0.01, 0.5, 0.5, 0.01}
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    -- REMOVE this or make it empty to allow walking through
    collision_box = {
        type = "fixed",
        fixed = {}
    }
})


core.register_node("terras_capixabas:pl_taboa_fina_galho", {
    description = "Taboa Fina",
    drawtype = "nodebox",
    tiles = {"taboa_fina_galho.png"},
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,  -- allows walking through
    use_texture_alpha = "clip",
    waving = 1,
    floodable = true,
    inventory_image = "taboa_fina_galho.png",
    wield_image = "taboa_fina_galho.png",

    groups = {
        snappy = 3,
        flora = 0,
        dig_immediate = 3
    },

    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            -- First quad (north-south)
            {-0.01, -0.5, -0.5, 0.01, 0.5, 0.5},
            -- Second quad (east-west)
            {-0.5, -0.5, -0.01, 0.5, 0.5, 0.01}
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    -- REMOVE this or make it empty to allow walking through
    collision_box = {
        type = "fixed",
        fixed = {}
    }
})

-- -------------------
-- abacateiro

-- ARVORE DE abacate

local modname = "terras_capixabas"

-- TRONCO
core.register_node(modname..":pl_abacateiro_tronco",{
  description="Tronco de abacateiro",
  tiles={
    "abacateiro_tronco_top.png",   -- top
    "abacateiro_tronco_top.png",   -- bottom
    "abacateiro_tronco.png",       -- right
    "abacateiro_tronco.png",       -- left
    "abacateiro_tronco.png",       -- back
    "abacateiro_tronco.png"        -- front
  },
  paramtype2="facedir",
  groups={tree=1,choppy=2,flammable=2},
  sounds=default.node_sound_wood_defaults(),
  on_place=core.rotate_node
})

-- FOLHAS
core.register_node(modname..":pl_folha_abacateiro",{
  description="Folhas de abacateiro",
  drawtype="allfaces_optional",
  tiles={"folha_abacateiro.png"},
  paramtype="light",
  groups={snappy=3,leafdecay=3,flammable=2,leaves=1},
  sounds=default.node_sound_leaves_defaults()
})

-- abacate ITEM
core.register_craftitem(modname..":pl_abacate",{
  description="abacate",
  inventory_image="pl_abacate.png",
  on_secondary_use=function(itemstack,user,pointed_thing)
    local name=user:get_player_name()
    local meta=user:get_meta()
    local hunger=tonumber(meta:get_string("hunger")) or 10
    meta:set_string("hunger",tostring(math.min(10,hunger+1)))
    core.sound_play("eat",{to_player=name})
    itemstack:take_item()
    return itemstack
  end
})

-- abacate PENDURADO
core.register_node(modname..":pl_abacate_pendurado",{
description="abacate",
drawtype="plantlike",
tiles={"pl_abacate.png"},
inventory_image="pl_abacate.png",
wield_image="pl_abacate.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_abacate",

selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},

on_punch=function(pos)
core.remove_node(pos)
core.get_node_timer(pos):start(10)
end,

on_timer=function(pos)
local acima={x=pos.x,y=pos.y+1,z=pos.z}
if core.get_node(acima).name==modname..":pl_folha_abacateiro" then
core.set_node(pos,{name=modname..":pl_abacate_pendurado"})
end
end
})


-- MUDA DE abacateiro
core.register_node(modname..":pl_muda_abacateiro",{
  description="Muda de abacateiro",
  drawtype="plantlike",
  tiles={"muda_abacateiro.png"},
  inventory_image="muda_abacateiro.png",
  wield_image="muda_abacateiro.png",
  paramtype="light",
  walkable=false,
  groups={snappy=2,dig_immediate=3,flammable=3,attached_node=1,sapling=1},
  sounds=default.node_sound_leaves_defaults(),

  on_construct=function(pos)
    core.get_node_timer(pos):start(5)
  end,

  on_timer=function(pos)
    core.remove_node(pos)

    -- TRONCO (5 blocks - from Code 2 for taller tree)
    for y=0,4 do
      core.set_node(
        {x=pos.x, y=pos.y+y, z=pos.z},
        {name=modname..":pl_abacateiro_tronco"}
      )
    end

    -- FOLHAS + LÓGICA TIPO MACIEIRA (from Code 2 for fuller canopy)
    for x=-2,2 do
      for y=3,6 do
        for z=-2,2 do
          if math.random(1,2)==1 then
            local p={x=pos.x+x,y=pos.y+y,z=pos.z+z}
            core.set_node(p,{name=modname..":pl_folha_abacateiro"})

            local abaixo={x=p.x,y=p.y-1,z=p.z}
            if core.get_node(abaixo).name=="air"
            and math.random(1,8)==1 then
              core.set_node(abaixo,{name=modname..":pl_abacate_pendurado"})
            end
          end
        end
      end
    end
  end
})
-- -------------------------------------------------

-- ARVORE bananeira

local modname = "terras_capixabas"

-- TRONCO
core.register_node(modname..":pl_bananeira_tronco",{
  description="Tronco de bananeira",
  tiles={
    "bananeira_tronco_top.png",   -- top
    "bananeira_tronco_top.png",   -- bottom
    "bananeira_tronco.png",       -- right
    "bananeira_tronco.png",       -- left
    "bananeira_tronco.png",       -- back
    "bananeira_tronco.png"        -- front
  },
  paramtype2="facedir",
  groups={tree=1,choppy=2,flammable=2},
  sounds=default.node_sound_wood_defaults(),
  on_place=core.rotate_node
})


-- FOLHAS
core.register_node(modname..":pl_folha_bananeira",{
  description="Folhas de bananeira",
  drawtype="allfaces_optional",
  tiles={"folha_bananeira.png"},
  paramtype="light",
  groups={snappy=3,leafdecay=3,flammable=2,leaves=1},
  sounds=default.node_sound_leaves_defaults()
})

-- banana ITEM
core.register_craftitem(modname..":pl_banana",{
  description="banana",
  inventory_image="pl_banana.png",
  on_secondary_use=function(itemstack,user,pointed_thing)
    local name=user:get_player_name()
    local meta=user:get_meta()
    local hunger=tonumber(meta:get_string("hunger")) or 10
    meta:set_string("hunger",tostring(math.min(10,hunger+1)))
    core.sound_play("eat",{to_player=name})
    itemstack:take_item()
    return itemstack
  end
})

-- banana PENDURADO
core.register_node(modname..":pl_banana_pendurado",{
description="banana",
drawtype="plantlike",
tiles={"pl_banana.png"},
inventory_image="pl_banana.png",
wield_image="pl_banana.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_banana",

selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},

on_punch=function(pos)
core.remove_node(pos)
core.get_node_timer(pos):start(10)
end,

on_timer=function(pos)
local acima={x=pos.x,y=pos.y+1,z=pos.z}
if core.get_node(acima).name==modname..":pl_folha_bananeira" then
core.set_node(pos,{name=modname..":pl_banana_pendurado"})
end
end
})



-- MUDA DE bananeira
core.register_node(modname..":pl_muda_bananeira",{
description="Muda de bananeira",
drawtype="plantlike",
tiles={"muda_bananeira.png"},
inventory_image="muda_bananeira.png",
wield_image="muda_bananeira.png",
paramtype="light",
walkable=false,
groups={snappy=2,dig_immediate=3,flammable=3,attached_node=1,sapling=1},
sounds=default.node_sound_leaves_defaults(),

on_construct=function(pos)
core.get_node_timer(pos):start(5)
end,

on_timer=function(pos)
core.remove_node(pos)

-- TRONCO (4 blocks)
for y=0,3 do
core.set_node({x=pos.x,y=pos.y+y,z=pos.z},{name=modname..":pl_bananeira_tronco"})
end

-- CANOPY
local leaf_coords={
-- y=3
{x=0,y=3,z=0},{x=-1,y=3,z=0},{x=1,y=3,z=0},
{x=-2,y=3,z=0},{x=2,y=3,z=0},{x=0,y=3,z=-2},{x=0,y=3,z=2},
-- y=4
{x=0,y=4,z=0},{x=-1,y=4,z=0},{x=1,y=4,z=0},
{x=-1,y=4,z=-1},{x=-1,y=4,z=1},{x=1,y=4,z=-1},{x=1,y=4,z=1},
-- y=5
{x=0,y=5,z=0},{x=-1,y=5,z=0},{x=1,y=5,z=0}
}

for _,p in ipairs(leaf_coords) do
local leaf_pos={x=pos.x+p.x,y=pos.y+p.y,z=pos.z+p.z}
local node_here=core.get_node(leaf_pos).name
if node_here~=modname..":pl_bananeira_tronco" then
core.set_node(leaf_pos,{name=modname..":pl_folha_bananeira"})
end
end

-- EXTRA TOP LEAF
local top_leaf={x=pos.x,y=pos.y+6,z=pos.z}
if core.get_node(top_leaf).name=="air" then
core.set_node(top_leaf,{name=modname..":pl_folha_bananeira"})
end

-- banana PENDURADO (single fruit beside trunk)
local fruit_pos={x=pos.x+1,y=pos.y+2,z=pos.z}
if core.get_node(fruit_pos).name=="air" then
core.set_node(fruit_pos,{name=modname..":pl_banana_pendurado"})
end

end
})


-- --------------------------------------------------------------------

-- ARVORE DE carambola

local modname = "terras_capixabas"

-- TRONCO
minetest.register_node(modname..":pl_caramboleira_tronco",{
  description="Tronco de caramboleira",
  tiles={
    "caramboleira_tronco_top.png",   -- top
    "caramboleira_tronco_top.png",   -- bottom
    "caramboleira_tronco.png",       -- right
    "caramboleira_tronco.png",       -- left
    "caramboleira_tronco.png",       -- back
    "caramboleira_tronco.png"        -- front
  },
  paramtype2="facedir",
  groups={tree=1,choppy=2,flammable=2},
  sounds=default.node_sound_wood_defaults(),
  on_place=minetest.rotate_node
})

-- FOLHAS
minetest.register_node(modname..":pl_folha_caramboleira",{
  description="Folhas de caramboleira",
  drawtype="allfaces_optional",
  tiles={"folha_caramboleira.png"},
  paramtype="light",
  groups={snappy=3,leafdecay=3,flammable=2,leaves=1},
  sounds=default.node_sound_leaves_defaults()
})

-- carambola ITEM
minetest.register_craftitem(modname..":pl_carambola",{
  description="carambola",
  inventory_image="pl_carambola.png",
  on_secondary_use=function(itemstack,user,pointed_thing)
    local name=user:get_player_name()
    local meta=user:get_meta()
    local hunger=tonumber(meta:get_string("hunger")) or 10
    meta:set_string("hunger",tostring(math.min(10,hunger+1)))
    minetest.sound_play("eat",{to_player=name})
    itemstack:take_item()
    return itemstack
  end
})

-- Carambola pendurada
minetest.register_node(modname..":pl_carambola_pendurado",{
description="carambola",
drawtype="plantlike",
tiles={"pl_carambola.png"},
inventory_image="pl_carambola.png",
wield_image="pl_carambola.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_carambola",

selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},

on_punch=function(pos)
minetest.remove_node(pos)
minetest.get_node_timer(pos):start(10)
end,

on_timer=function(pos)
local acima={x=pos.x,y=pos.y+1,z=pos.z}
if minetest.get_node(acima).name==modname..":pl_folha_caramboleira" then
minetest.set_node(pos,{name=modname..":pl_carambola_pendurado"})
end
end
})


-- MUDA DE caramboleira
minetest.register_node(modname..":pl_muda_caramboleira",{
  description="Muda de caramboleira",
  drawtype="plantlike",
  tiles={"muda_caramboleira.png"},
  inventory_image="muda_caramboleira.png",
  wield_image="muda_caramboleira.png",
  paramtype="light",
  walkable=false,
  groups={snappy=2,dig_immediate=3,flammable=3,attached_node=1,sapling=1},
  sounds=default.node_sound_leaves_defaults(),

  on_construct=function(pos)
    minetest.get_node_timer(pos):start(5)
  end,

  on_timer=function(pos)
    minetest.remove_node(pos)

    -- TRONCO (5 blocks - from Code 2 for taller tree)
    for y=0,4 do
      minetest.set_node(
        {x=pos.x, y=pos.y+y, z=pos.z},
        {name=modname..":pl_caramboleira_tronco"}
      )
    end

    -- FOLHAS + LÓGICA TIPO MACIEIRA (from Code 2 for fuller canopy)
    for x=-2,2 do
      for y=3,6 do
        for z=-2,2 do
          if math.random(1,2)==1 then
            local p={x=pos.x+x,y=pos.y+y,z=pos.z+z}
            minetest.set_node(p,{name=modname..":pl_folha_caramboleira"})

            local abaixo={x=p.x,y=p.y-1,z=p.z}
            if minetest.get_node(abaixo).name=="air"
            and math.random(1,8)==1 then
              minetest.set_node(abaixo,{name=modname..":pl_carambola_pendurado"})
            end
          end
        end
      end
    end
  end
})


-- -------------------------------------------------------------------

-- ARVORE COQUEIRO

local modname = "terras_capixabas"

-- TRONCO
core.register_node(modname..":pl_coqueiro_tronco",{
  description="Tronco de coqueiro",
  tiles={
    "tronco_coqueiro_top.png",
    "tronco_coqueiro_top.png",
    "tronco_coqueiro.png",
    "tronco_coqueiro.png",
    "tronco_coqueiro.png",
    "tronco_coqueiro.png"
  },
  paramtype2="facedir",
  groups={tree=1,choppy=2,flammable=2},
  sounds=default.node_sound_wood_defaults(),
  on_place=core.rotate_node
})

-- FOLHAS
core.register_node(modname..":pl_folha_coqueiro",{
  description="Folhas de Coqueiro",
  drawtype="allfaces_optional",
  tiles={"folha_coqueiro.png"},
  paramtype="light",
  groups={snappy=3,leafdecay=3,flammable=2,leaves=1},
  sounds=default.node_sound_leaves_defaults()
})

-- COCO ITEM
core.register_craftitem(modname..":pl_coco",{
  description="Coco",
  inventory_image="pl_coco.png",
  on_secondary_use=function(itemstack,user)
    local name=user:get_player_name()
    local meta=user:get_meta()
    local hunger=tonumber(meta:get_string("hunger")) or 10
    meta:set_string("hunger",tostring(math.min(10,hunger+1)))
    core.sound_play("eat",{to_player=name})
    itemstack:take_item()
    return itemstack
  end
})

-- COCO PENDURADO
core.register_node(modname..":pl_coco_pendurado",{
description="Coco",
drawtype="plantlike",
tiles={"pl_coco.png"},
inventory_image="pl_coco.png",
wield_image="pl_coco.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_coco",

selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},

on_punch=function(pos)
core.remove_node(pos)
core.get_node_timer(pos):start(10)
end,

on_timer=function(pos)
local above={x=pos.x,y=pos.y+1,z=pos.z}
if core.get_node(above).name==modname..":pl_folha_coqueiro" then
core.set_node(pos,{name=modname..":pl_coco_pendurado"})
end
end
})


-- MUDA DE COQUEIRO
core.register_node(modname..":pl_muda_coco",{
  description="Muda de Coqueiro",
  drawtype="plantlike",
  tiles={"muda_coco.png"},
  inventory_image="muda_coco.png",
  wield_image="muda_coco.png",
  paramtype="light",
  walkable=false,
  groups={snappy=2,dig_immediate=3,flammable=3,attached_node=1,sapling=1},
  sounds=default.node_sound_leaves_defaults(),

  on_construct=function(pos)
    core.get_node_timer(pos):start(5)
  end,

  on_timer=function(pos)
    core.remove_node(pos)

    -- TRUNK (y = 0 to 5)
    for y=0,5 do
      core.set_node(
        {x=pos.x,y=pos.y+y,z=pos.z},
        {name=modname..":pl_coqueiro_tronco"}
      )
    end

    -- CANOPY DESIGN (X + Z)
    local pattern={
      {0,10},{0,9},
      {-2,8},{-1,8},{0,8},{1,8},{2,8},
      {-3,7},{0,7},{3,7},
      {-2,6},{-1,6},{0,6},{1,6},{2,6},
      {-3,5},{3,5}
    }

    local leaf_coords={}

    for _,v in ipairs(pattern) do
      table.insert(leaf_coords,{x=v[1],y=v[2],z=0})
      table.insert(leaf_coords,{x=0,y=v[2],z=v[1]})
    end

    for _,p in ipairs(leaf_coords) do
      local lp={x=pos.x+p.x,y=pos.y+p.y,z=pos.z+p.z}
      if core.get_node(lp).name~=modname..":pl_coqueiro_tronco" then
        core.set_node(lp,{name=modname..":pl_folha_coqueiro"})
      end
    end

    -- COCONUTS (ONLY NEXT TO TOP TRUNK, y = 5)
    local coconuts_placed=0
    local trunk_y=pos.y+5
    local coconut_spots={}

    for dx=-1,1 do
      for dz=-1,1 do
        if not (dx==0 and dz==0) then
          local spot={x=pos.x+dx,y=trunk_y,z=pos.z+dz}
          local above={x=spot.x,y=spot.y+1,z=spot.z}

          if core.get_node(spot).name=="air"
          and core.get_node(above).name==modname..":pl_folha_coqueiro" then
            table.insert(coconut_spots,spot)
          end
        end
      end
    end

    while coconuts_placed<4 and #coconut_spots>0 do
      local i=math.random(#coconut_spots)
      core.set_node(coconut_spots[i],{name=modname..":pl_coco_pendurado"})
      table.remove(coconut_spots,i)
      coconuts_placed=coconuts_placed+1
    end
  end
})

-- ----------------------------------------------------

-- ARVORE COQUEIRO TOMBADO
local modname = "terras_capixabas"

-- TRONCO
core.register_node(modname..":pl_coqueiro_tronco", {
    description = "Tronco de coqueiro",
    tiles = {
        "tronco_coqueiro_top.png",
        "tronco_coqueiro_top.png",
        "tronco_coqueiro.png",
        "tronco_coqueiro.png",
        "tronco_coqueiro.png",
        "tronco_coqueiro.png"
    },
    paramtype2 = "facedir",
    groups = {tree=1, choppy=2, flammable=2},
    sounds = default.node_sound_wood_defaults(),
    on_place = core.rotate_node
})

-- FOLHAS
core.register_node(modname..":pl_folha_coqueiro", {
    description = "Folhas de Coqueiro",
    drawtype = "allfaces_optional",
    tiles = {"folha_coqueiro.png"},
    paramtype = "light",
    groups = {snappy=3, leafdecay=3, flammable=2, leaves=1},
    sounds = default.node_sound_leaves_defaults()
})

-- COCO ITEM
core.register_craftitem(modname..":pl_coco", {
    description = "Coco",
    inventory_image = "pl_coco.png",
    on_secondary_use = function(itemstack, user)
        local name = user:get_player_name()
        local meta = user:get_meta()
        local hunger = tonumber(meta:get_string("hunger")) or 10
        meta:set_string("hunger", tostring(math.min(10, hunger + 1)))
        core.sound_play("eat", {to_player = name})
        itemstack:take_item()
        return itemstack
    end
})

-- COCO PENDURADO
core.register_node(modname..":pl_coco_pendurado",{
description="Coco",
drawtype="plantlike",
tiles={"pl_coco.png"},
inventory_image="pl_coco.png",
wield_image="pl_coco.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_coco",
selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},
on_punch=function(pos)
core.remove_node(pos)
end,
})


-- MUDA DE COQUEIRO TOMBADO
core.register_node(modname..":pl_muda_coqueiro_tombado", {
    description = "Muda de Coqueiro Tombado",
    drawtype = "plantlike",
    tiles = {"muda_coqueiro_tombado.png"},
    inventory_image = "muda_coqueiro_tombado.png",
    wield_image = "muda_coqueiro_tombado.png",
    paramtype = "light",
    paramtype2 = "facedir",
    walkable = false,
    groups = {snappy=2, dig_immediate=3, flammable=3, attached_node=1, sapling=1},
    sounds = default.node_sound_leaves_defaults(),

    on_place = function(itemstack, placer, pt)
        return core.rotate_node(itemstack, placer, pt)
    end,

    on_construct = function(pos)
        core.get_node_timer(pos):start(5)
    end,

    on_timer = function(pos)
        local node = core.get_node(pos)
        local facedir = node.param2
        
        -- Map facedir to growth direction
        local dirs = {
            [0] = {x = 0, z = 1},  -- North
            [1] = {x = 1, z = 0},  -- East
            [2] = {x = 0, z = -1}, -- South
            [3] = {x = -1, z = 0}, -- West
        }
        local d = dirs[facedir] or {x = 0, z = 1}

        core.remove_node(pos)

        -- TRUNK SHAPE: {horizontal_dist, height}
        -- Starts at 0,0 (the sapling pos)
        local trunk_shape = {
            {0,0}, {1,0}, {2,0}, {3,0}, 
            {4,1}, {5,1}, {6,1},        
            {7,2}, {8,2},               
            {9,3},                      
            {10,4}                      
        }

        local top_pos = pos

        for _, v in ipairs(trunk_shape) do
            local trunk_pos = {
                x = pos.x + (d.x * v[1]),
                y = pos.y + v[2],
                z = pos.z + (d.z * v[1])
            }
            top_pos = trunk_pos
            core.set_node(trunk_pos, {name = modname..":pl_coqueiro_tronco", param2 = facedir})
        end

        -- CANOPY
        local pattern = {
            {0,10}, {0,9},
            {-2,8}, {-1,8}, {0,8}, {1,8}, {2,8},
            {-3,7}, {0,7}, {3,7},
            {-2,6}, {-1,6}, {0,6}, {1,6}, {2,6},
            {-3,5}, {3,5}
        }

        for _, v in ipairs(pattern) do
            local leaf_offsets = {
                {x=v[1], y=v[2]-5, z=0},
                {x=0,    y=v[2]-5, z=v[1]}
            }
            for _, off in ipairs(leaf_offsets) do
                local lp = {x=top_pos.x + off.x, y=top_pos.y + off.y, z=top_pos.z + off.z}
                if core.get_node(lp).name == "air" then
                    core.set_node(lp, {name = modname..":pl_folha_coqueiro"})
                end
            end
        end

        -- COCONUTS (Fixed height)
        local count = 0
        for dx = -1, 1 do
            for dz = -1, 1 do
                if count < 4 and not (dx == 0 and dz == 0) then
                    -- Placement at top_pos.y puts them level with the trunk's tip
                    local cp = {x=top_pos.x + dx, y=top_pos.y, z=top_pos.z + dz}
                    local above = {x=cp.x, y=cp.y + 1, z=cp.z}
                    
                    -- Check if it's air and if there's a leaf above to "hang" from
                    if core.get_node(cp).name == "air" and 
                       core.get_node(above).name == modname..":pl_folha_coqueiro" then
                        core.set_node(cp, {name = modname..":pl_coco_pendurado"})
                        count = count + 1
                    end
                end
            end
        end
    end
})



-- ------------------------------------------------------

-- laranjeira

-- ARVORE DE laranja

local modname = "terras_capixabas"

-- TRONCO
core.register_node(modname..":pl_laranjeira_tronco",{
  description="Tronco de laranjeira",
  tiles={
    "laranjeira_tronco_top.png",   -- top
    "laranjeira_tronco_top.png",   -- bottom
    "laranjeira_tronco.png",       -- right
    "laranjeira_tronco.png",       -- left
    "laranjeira_tronco.png",       -- back
    "laranjeira_tronco.png"        -- front
  },
  paramtype2="facedir",
  groups={tree=1,choppy=2,flammable=2},
  sounds=default.node_sound_wood_defaults(),
  on_place=core.rotate_node
})

-- FOLHAS
core.register_node(modname..":pl_folha_laranjeira",{
  description="Folhas de laranjeira",
  drawtype="allfaces_optional",
  tiles={"folha_laranjeira.png"},
  paramtype="light",
  groups={snappy=3,leafdecay=3,flammable=2,leaves=1},
  sounds=default.node_sound_leaves_defaults()
})

-- laranja ITEM
core.register_craftitem(modname..":pl_laranja",{
  description="laranja",
  inventory_image="pl_laranja.png",
  on_secondary_use=function(itemstack,user,pointed_thing)
    local name=user:get_player_name()
    local meta=user:get_meta()
    local hunger=tonumber(meta:get_string("hunger")) or 10
    meta:set_string("hunger",tostring(math.min(10,hunger+1)))
    core.sound_play("eat",{to_player=name})
    itemstack:take_item()
    return itemstack
  end
})

-- laranja PENDURADO
core.register_node(modname..":pl_laranja_pendurado",{
description="laranja",
drawtype="plantlike",
tiles={"pl_laranja.png"},
inventory_image="pl_laranja.png",
wield_image="pl_laranja.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_laranja",

selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},

on_punch=function(pos)
core.remove_node(pos)
core.get_node_timer(pos):start(10)
end,

on_timer=function(pos)
local acima={x=pos.x,y=pos.y+1,z=pos.z}
if core.get_node(acima).name==modname..":pl_folha_laranjeira" then
core.set_node(pos,{name=modname..":pl_laranja_pendurado"})
end
end
})


-- MUDA DE laranjeira
core.register_node(modname..":pl_muda_laranjeira",{
  description="Muda de laranjeira",
  drawtype="plantlike",
  tiles={"muda_laranjeira.png"},
  inventory_image="muda_laranjeira.png",
  wield_image="muda_laranjeira.png",
  paramtype="light",
  walkable=false,
  groups={snappy=2,dig_immediate=3,flammable=3,attached_node=1,sapling=1},
  sounds=default.node_sound_leaves_defaults(),

  on_construct=function(pos)
    core.get_node_timer(pos):start(5)
  end,

  on_timer=function(pos)
    core.remove_node(pos)

    -- TRONCO (5 blocks - from Code 2 for taller tree)
    for y=0,4 do
      core.set_node(
        {x=pos.x, y=pos.y+y, z=pos.z},
        {name=modname..":pl_laranjeira_tronco"}
      )
    end

    -- FOLHAS + LÓGICA TIPO MACIEIRA (from Code 2 for fuller canopy)
    for x=-2,2 do
      for y=3,6 do
        for z=-2,2 do
          if math.random(1,2)==1 then
            local p={x=pos.x+x,y=pos.y+y,z=pos.z+z}
            core.set_node(p,{name=modname..":pl_folha_laranjeira"})

            local abaixo={x=p.x,y=p.y-1,z=p.z}
            if core.get_node(abaixo).name=="air"
            and math.random(1,8)==1 then
              core.set_node(abaixo,{name=modname..":pl_laranja_pendurado"})
            end
          end
        end
      end
    end
  end
})

-- ------------------------------------------------------

-- MANGUEIRA

-- ARVORE DE manga

local modname = "terras_capixabas"

-- TRONCO
core.register_node(modname..":pl_mangueira_tronco",{
  description="Tronco de mangueira",
  tiles={
    "mangueira_tronco_top.png",   -- top
    "mangueira_tronco_top.png",   -- bottom
    "mangueira_tronco.png",       -- right
    "mangueira_tronco.png",       -- left
    "mangueira_tronco.png",       -- back
    "mangueira_tronco.png"        -- front
  },
  paramtype2="facedir",
  groups={tree=1,choppy=2,flammable=2},
  sounds=default.node_sound_wood_defaults(),
  on_place=core.rotate_node
})

-- FOLHAS
core.register_node(modname..":pl_folha_mangueira",{
  description="Folhas de mangueira",
  drawtype="allfaces_optional",
  tiles={"folha_mangueira.png"},
  paramtype="light",
  groups={snappy=3,leafdecay=3,flammable=2,leaves=1},
  sounds=default.node_sound_leaves_defaults()
})

-- manga ITEM
core.register_craftitem(modname..":pl_manga",{
  description="manga",
  inventory_image="pl_manga.png",
  on_secondary_use=function(itemstack,user,pointed_thing)
    local name=user:get_player_name()
    local meta=user:get_meta()
    local hunger=tonumber(meta:get_string("hunger")) or 10
    meta:set_string("hunger",tostring(math.min(10,hunger+1)))
    core.sound_play("eat",{to_player=name})
    itemstack:take_item()
    return itemstack
  end
})

-- manga PENDURADO
core.register_node(modname..":pl_manga_pendurado",{
description="manga",
drawtype="plantlike",
tiles={"pl_manga.png"},
inventory_image="pl_manga.png",
wield_image="pl_manga.png",
paramtype="light",
sunlight_propagates=true,
walkable=false,
buildable_to=true,
groups={snappy=3,flammable=2,attached_node=1},
drop=modname..":pl_manga",

selection_box={type="fixed",fixed={-0.3,-0.5,-0.3,0.3,0.3,0.3}},

on_punch=function(pos)
core.remove_node(pos)
core.get_node_timer(pos):start(10)
end,

on_timer=function(pos)
local acima={x=pos.x,y=pos.y+1,z=pos.z}
if core.get_node(acima).name==modname..":pl_folha_mangueira" then
core.set_node(pos,{name=modname..":pl_manga_pendurado"})
end
end
})


-- MUDA DE mangueira
core.register_node(modname..":pl_muda_manga",{
  description="Muda de mangueira",
  drawtype="plantlike",
  tiles={"muda_manga.png"},
  inventory_image="muda_manga.png",
  wield_image="muda_manga.png",
  paramtype="light",
  walkable=false,
  groups={snappy=2,dig_immediate=3,flammable=3,attached_node=1,sapling=1},
  sounds=default.node_sound_leaves_defaults(),

  on_construct=function(pos)
    core.get_node_timer(pos):start(5)
  end,

  on_timer=function(pos)
    core.remove_node(pos)

    -- TRONCO (5 blocks - from Code 2 for taller tree)
    for y=0,4 do
      core.set_node(
        {x=pos.x, y=pos.y+y, z=pos.z},
        {name=modname..":pl_mangueira_tronco"}
      )
    end

    -- FOLHAS + LÓGICA TIPO MACIEIRA (from Code 2 for fuller canopy)
    for x=-2,2 do
      for y=3,6 do
        for z=-2,2 do
          if math.random(1,2)==1 then
            local p={x=pos.x+x,y=pos.y+y,z=pos.z+z}
            core.set_node(p,{name=modname..":pl_folha_mangueira"})

            local abaixo={x=p.x,y=p.y-1,z=p.z}
            if core.get_node(abaixo).name=="air"
            and math.random(1,8)==1 then
              core.set_node(abaixo,{name=modname..":pl_manga_pendurado"})
            end
          end
        end
      end
    end
  end
})
