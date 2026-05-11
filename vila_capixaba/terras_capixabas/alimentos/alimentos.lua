-- ALIMENTOS
core.register_node("terras_capixabas:alimentos1", {
  description = "Alimentos1",
  tiles = { "alimentos1.png" },
  drawtype = "mesh",
  mesh = "alimentos1.obj",
  paramtype =
  "light",
  paramtype2 = "facedir",
  backface_culling = true,
  groups = { snappy = 3, oddly_breakable_by_hand = 3 },
  walkable = false,
  selection_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 } }
})
core.register_node("terras_capixabas:bebidas", {
  description = "Bebidas",
  tiles = { "bebidas.png" },
  drawtype = "mesh",
  mesh = "bebidas.obj",
  paramtype = "light",
  paramtype2 =
  "facedir",
  groups = { snappy = 3, flammable = 2 },
  walkable = false,
  use_texture_alpha = "blend",
  backface_culling = false,
  selection_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 } }
})
-- MICROONDAS
local TEMPO_COZIMENTO = 5
-- SIMPLE IMAGE HUD SYSTEM (optimized)
local function remove_hud(player)
  if not player then return end
  local meta = player:get_meta()
  local id = meta:get_string("MW_IMG")
  if id ~= "" then player:hud_remove(tonumber(id)) end
  meta:set_string("MW_IMG", "")
end
local function show_hud(player)
  if not player then return end
  local meta = player:get_meta()
  if meta:get_string("MW_IMG") ~= "" then return end
  local id = player:hud_add({
    type = "image", -- updated to new format
    position = { x = 0.5, y = 0.4 },
    alignment = { x = 0, y = 0 },
    offset = { x = 0, y = 0 },
    text = "microondas_aviso.png",
    scale = { x = 1, y = 1 }
  })
  meta:set_string("MW_IMG", tostring(id))
end
-- track what node the player is currently looking at
local player_last_target = {}
core.register_globalstep(function()
  for _, player in ipairs(core.get_connected_players()) do
    local pos = player:get_pos()
    local eye = { x = pos.x, y = pos.y + 1.5, z = pos.z }
    local dir = player:get_look_dir()
    local ray = core.raycast(eye, { x = eye.x + dir.x * 4, y = eye.y + dir.y * 4, z = eye.z + dir.z * 4 }, false,
      false)
    local pointed = ray:next()
    local target_name = (pointed and pointed.type == "node") and core.get_node(pointed.under).name or nil
    if player_last_target[player] ~= target_name then
      if target_name and target_name:find("terras_capixabas:microondas") then
        show_hud(player)
      else
        remove_hud(
          player)
      end
      player_last_target[player] = target_name
    end
  end
end)
-- DESLIGADO (OFF)
core.register_node("terras_capixabas:microondas", {
  description = "Microondas",
  drawtype = "mesh",
  mesh = "microondas.obj",
  tiles = { "microondas.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, oddly_breakable_by_hand = 1 },
  walkable = false,
  on_rightclick = function(pos, node, clicker, itemstack)
    if itemstack:get_name() == "terras_capixabas:pizza_congelada" then
      itemstack:take_item()
      core.swap_node(pos, { name = "terras_capixabas:microondas_pizza_congelada", param2 = node.param2 })
      return itemstack
    end
    return itemstack
  end
})
-- PIZZA INSERIDA (FROZEN)
core.register_node("terras_capixabas:microondas_pizza_congelada", {
  drawtype = "mesh",
  mesh = "microondas_pizza_congelada.obj",
  tiles = { "microondas_pizza_congelada.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:microondas",
  on_rightclick = function(pos, node, clicker, itemstack)
    core.swap_node(pos, { name = "terras_capixabas:microondas_on", param2 = node.param2 })
    local id = core.sound_play("microondas_ligado", { pos = pos, loop = true, max_hear_distance = 10 })
    core.get_meta(pos):set_string("som", id or "")
    core.get_node_timer(pos):start(TEMPO_COZIMENTO)
    return itemstack
  end
})
-- COZINHANDO (ON)
core.register_node("terras_capixabas:microondas_on", {
  drawtype = "mesh",
  mesh = "microondas_on.obj",
  tiles = { { name = "microondas_on.png", animation = { type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.0 } } },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:microondas",
  on_timer = function(pos)
    local meta = core.get_meta(pos)
    local som = meta:get_string("som")
    if som ~= "" then core.sound_stop(tonumber(som)) end
    core.sound_play("microondas_acabou", { pos = pos, gain = 1, max_hear_distance = 10 })

    local node = core.get_node(pos)
    core.swap_node(pos, { name = "terras_capixabas:microondas_pizza_pronta", param2 = node.param2 })

    return false
  end
})
-- PRONTO (READY)
core.register_node("terras_capixabas:microondas_pizza_pronta", {
  drawtype = "mesh",
  mesh = "microondas_pizza_pronta.obj",
  tiles = { "microondas_pizza_pronta.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:microondas",
  on_rightclick = function(pos, node, clicker, itemstack)
    if not clicker or not clicker:is_player() then return itemstack end
    local stack = ItemStack("terras_capixabas:alm_pizza")
    local inv = clicker:get_inventory()
    if inv and inv:room_for_item("main", stack) then
      inv:add_item("main", stack)
    else
      core.add_item(clicker:get_pos(), stack)
    end
    core.swap_node(pos, { name = "terras_capixabas:microondas", param2 = node.param2 })
    return itemstack
  end
})
-- LIQUIDIFICADOR
local TEMPO_BATER = 5
-- SIMPLE IMAGE HUD SYSTEM (optimized)
local hud_delay = 0.5 -- seconds before hiding after looking away
local player_last_target = {}
ocal
player_hide_timer = {}

local function remove_hud(player)
  if not player then return end
  local meta = player:get_meta()
  local id = meta:get_string("LQ_IMG")
  if id ~= "" then player:hud_remove(tonumber(id)) end
  meta:set_string("LQ_IMG", "")
end
local function show_hud(player)
  if not player then return end
  local meta = player:get_meta()
  if meta:get_string("LQ_IMG") ~= "" then return end
  local id = player:hud_add({
    type = "image", -- updated field
    position = { x = 0.5, y = 0.4 },
    alignment = { x = 0, y = 0 },
    offset = { x = 0, y = 0 },
    text = "liquidificador_aviso.png",
    scale = { x = 1, y = 1 }
  })
  meta:set_string("LQ_IMG", tostring(id))
end
core.register_globalstep(function()
  for _, player in ipairs(core.get_connected_players()) do
    local pos = player:get_pos()
    local eye = { x = pos.x, y = pos.y + 1.5, z = pos.z }
    local dir = player:get_look_dir()
    local ray = core.raycast(eye, { x = eye.x + dir.x * 4, y = eye.y + dir.y * 4, z = eye.z + dir.z * 4 }, false,
      false)
    local pointed = ray:next()
    local target_name = (pointed and pointed.type == "node") and core.get_node(pointed.under).name or nil
    -- only update if the target changed
    if player_last_target[player] ~= target_name then
      if target_name and target_name:find("terras_capixabas:liquidificador") then
        show_hud(player)
        player_hide_timer[player] = nil
      else
        player_hide_timer[player] = os.clock() + hud_delay
      end
      player_last_target[player] = target_name
    end

    -- remove hud after delay if looking away
    if player_hide_timer[player] and os.clock() >= player_hide_timer[player] then
      remove_hud(player)
      player_hide_timer[player] = nil
    end
  end
end)
-- ESTADO DESLIGADO
core.register_node("terras_capixabas:liquidificador",
  {
    description = "Liquidificador",
    drawtype = "mesh",
    mesh = "liq_off.obj",
    tiles = { "liquidificador.png" },
    use_texture_alpha =
    "blend",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = { cracky = 2, oddly_breakable_by_hand = 1 },
    walkable = false,
    on_rightclick = function(
        pos, node, clicker, itemstack)
      if itemstack:get_name() == "terras_capixabas:alm_maca" then
        itemstack:take_item()
        core.swap_node(pos, { name = "terras_capixabas:liquidificador_maca", param2 = node.param2 })
        return itemstack
      end
      return itemstack
    end
  })
-- MACA
core.register_node("terras_capixabas:liquidificador_maca", {
  drawtype = "mesh",
  mesh = "liq_maca.obj",
  tiles = { "liquidificador.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:liquidificador",
  on_rightclick = function(pos, node, clicker, itemstack)
    if itemstack:get_name() == "terras_capixabas:alm_banana" then
      itemstack:take_item()
      core.swap_node(pos, { name = "terras_capixabas:liquidificador_maca_banana", param2 = node.param2 })
      return itemstack
    end
    return itemstack
  end
})
-- MACA + BANANA
core.register_node("terras_capixabas:liquidificador_maca_banana", {
  drawtype = "mesh",
  mesh = "liq_maca_banana.obj",
  tiles = { "liquidificador.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:liquidificador",
  on_rightclick = function(pos, node, clicker, itemstack)
    if itemstack:get_name() == "terras_capixabas:alm_leite_ccpl_morango" then
      itemstack:take_item()
      core.swap_node(pos, { name = "terras_capixabas:liquidificador_maca_banana_leite", param2 = node.param2 })
      return itemstack
    end
    return itemstack
  end
})
-- COMPLETO
core.register_node("terras_capixabas:liquidificador_maca_banana_leite", {
  drawtype = "mesh",
  mesh = "liq_maca_banana_leite.obj",
  tiles = { "liquidificador.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:liquidificador",
  on_rightclick = function(pos, node, clicker, itemstack)
    core.swap_node(pos, { name = "terras_capixabas:liquidificador_on", param2 = node.param2 })
    local id = core.sound_play("liquidificador", { pos = pos, loop = true, max_hear_distance = 10 })
    core.get_meta(pos):set_string("som", id or "")
    core.get_node_timer(pos):start(TEMPO_BATER)
    return itemstack
  end
})
-- BATENDO
core.register_node("terras_capixabas:liquidificador_on", {
  drawtype = "mesh",
  mesh = "liq_on.obj",
  tiles = { { name = "liq_on.png", animation = { type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.0 } } },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:liquidificador",
  on_timer = function(pos)
    local meta = core.get_meta(pos)
    local som = meta:get_string("som")
    if som ~= "" then core.sound_stop(tonumber(som)) end
    local node = core.get_node(pos)
    core.swap_node(pos, { name = "terras_capixabas:liquidificador_vitamina", param2 = node.param2 })
    return false
  end
})
-- VITAMINA
core.register_node("terras_capixabas:liquidificador_vitamina", {
  drawtype = "mesh",
  mesh = "liq_vitamina.obj",
  tiles = { "liquidificador.png" },
  use_texture_alpha = "blend",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { cracky = 2, not_in_creative_inventory = 1 },
  walkable = false,
  drop = "terras_capixabas:liquidificador",
  on_rightclick = function(pos, node, clicker, itemstack)
    if not clicker or not clicker:is_player() then return itemstack end
    local stack = ItemStack("terras_capixabas:alm_vitamina")
    local inv = clicker:get_inventory()
    if inv and inv:room_for_item("main", stack) then
      inv:add_item("main", stack)
    else
      core.add_item(clicker:get_pos(), stack)
    end
    core.swap_node(pos, { name = "terras_capixabas:liquidificador", param2 = node.param2 })
    return itemstack
  end
})
-- TORRADEIRA -
local modname = "terras_capixabas"
local function swap(pos, name)
  local n = core.get_node(pos)
  core.set_node(pos, { name = name, param2 = n.param2 })
end
-- Bread item (goes INTO the toaster)
core.register_craftitem(modname .. ":pao_de_forma", {
  description = "Pao de Forma",
  inventory_image = "pao_de_forma.png"
})
local function register_toaster(name, mesh, state)
  local def = {
    description = "Torradeira",
    tiles = { "torradeira.png" },
    drawtype = "mesh",
    mesh = mesh,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = { cracky = 2, oddly_breakable_by_hand = 2 }
  }
  if state ~= "empty" then def.groups.not_in_creative_inventory = 1 end
  if state == "empty" then
    def.on_rightclick = function(pos, node, clicker, itemstack)
      if not clicker or not clicker:is_player() then return itemstack end
      if itemstack:get_name() == modname .. ":pao_de_forma" then
        itemstack:take_item()
        swap(pos, modname .. ":torradeira_pao")
      end
      return itemstack
    end
  end
  if state == "bread" then
    def.on_rightclick = function(pos, node, clicker, itemstack)
      if not clicker or not clicker:is_player() then return itemstack end
      core.sound_play("toaster_down", { pos = pos, gain = 1.0, max_hear_distance = 10 })
      swap(pos, modname .. ":torradeira_ligada")
      core.get_node_timer(pos):start(5)
      return itemstack
    end
  end
  if state == "on" then
    def.on_timer = function(pos)
      core.sound_play("toaster_up", { pos = pos, gain = 1.0, max_hear_distance = 10 })
      swap(pos, modname .. ":torradeira_pao_torrado")
    end
  end
  if state == "ready" then
    def.on_rightclick = function(pos, node, clicker, itemstack)
      if not clicker or not clicker:is_player() then return itemstack end
      local stack = ItemStack(modname .. ":alm_pao_torrado")
      local inv = clicker:get_inventory()
      if inv and inv:room_for_item("main", stack) then
        inv:add_item("main", stack)
      else
        core.add_item(clicker:get_pos(), stack)
      end
      swap(pos, modname .. ":torradeira")
      return itemstack
    end
  end
  core.register_node(modname .. ":" .. name, def)
end
-- Register all toaster visual states
register_toaster("torradeira", "torradeira.obj", "empty")
register_toaster("torradeira_pao", "torradeira_pao.obj", "bread")
register_toaster("torradeira_ligada", "torradeira_ligada.obj", "on")
register_toaster("torradeira_pao_torrado", "torradeira_pao_torrado.obj", "ready")
-- SIMPLE IMAGE HUD SYSTEM (optimized)
local HUD_IMAGE = "torradeira_aviso.png"
local HUD_META = "TR_IMG"
local hud_delay = 0.5
local player_last_target = {}
local player_hide_timer = {}

local function remove_hud(player)
  if not player then return end
  local meta = player:get_meta()
  local id = meta:get_string(HUD_META)
  if id ~= "" then player:hud_remove(tonumber(id)) end
  meta:set_string(HUD_META, "")
end
local function show_hud(player)
  if not player then return end
  local meta = player:get_meta()
  if meta:get_string(HUD_META) ~= "" then return end
  local id = player:hud_add({
    type = "image", -- updated field
    position = { x = 0.5, y = 0.4 },
    alignment = { x = 0, y = 0 },
    offset = { x = 0, y = 0 },
    text = HUD_IMAGE,
    scale = { x = 1, y = 1 }
  })
  meta:set_string(HUD_META, tostring(id))
end
core.register_globalstep(function()
  for _, player in ipairs(core.get_connected_players()) do
    local pos = player:get_pos()
    local eye = { x = pos.x, y = pos.y + 1.5, z = pos.z }
    local look_dir = player:get_look_dir()
    local ray = core.raycast(eye,
      { x = eye.x + look_dir.x * 4, y = eye.y + look_dir.y * 4, z = eye.z + look_dir.z * 4 },
      false, false)
    local pointed = ray:next()
    local target_name = (pointed and pointed.type == "node") and core.get_node(pointed.under).name or nil

    if player_last_target[player] ~= target_name then
      if target_name and target_name:find("terras_capixabas:torradeira") then
        show_hud(player)
        player_hide_timer[player] = nil
      else
        player_hide_timer[player] = os.clock() + hud_delay
      end
      player_last_target[player] = target_name
    end

    if player_hide_timer[player] and os.clock() >= player_hide_timer[player] then
      remove_hud(player)
      player_hide_timer[player] = nil
    end
  end
end)
-- -

local function create_mclanche_node(name, mesh, next_node, sound)
  core.register_node("terras_capixabas:" .. name,
    {
      description = name == "mclanche" and "Mclanche" or "",
      tiles = { "mclanche.png" },
      drawtype = "mesh",
      mesh = mesh,
      paramtype = "light",
      paramtype2 = "facedir",
      groups = { snappy = 3, flammable = 2, not_in_creative_inventory = (name ~= "mclanche") and 1 or 0 },
      walkable = false,
      use_texture_alpha = "clip",
      backface_culling = false,
      selection_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 } },
      on_rightclick = function(
          pos, node, clicker, itemstack, pointed_thing)
        if not next_node then return end
        if sound then core.sound_play(sound, { to_player = clicker:get_player_name(), gain = 1.0 }) end
        core.swap_node(pos, { name = "terras_capixabas:" .. next_node, param2 = node.param2 })
      end
    })
end
-- Register all nodes with sounds only (messages removed)
create_mclanche_node("mclanche", "mclanche.obj", "mclanche2", "eat")
create_mclanche_node("mclanche2", "mclanche2.obj", "mclanche3", "eat")
create_mclanche_node("mclanche3", "mclanche3.obj", "mclanche4", "drink")
create_mclanche_node("mclanche4", "mclanche4.obj", nil, nil)
local function create_salgadinhos_node(name, mesh, next_node, sound)
  core.register_node("terras_capixabas:" .. name,
    {
      description = name == "salgadinhos_caixa1" and "Caixa de Salgadinhos" or "",
      tiles = { "salgadinhos_caixa.png" },
      drawtype = "mesh",
      mesh = mesh,
      paramtype = "light",
      paramtype2 = "facedir",
      groups = { snappy = 3, flammable = 2, not_in_creative_inventory = (name ~= "salgadinhos_caixa1") and 1 or 0 },
      walkable = false,
      use_texture_alpha = "clip",
      backface_culling = false,
      selection_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 } },
      on_rightclick = function(
          pos, node, clicker, itemstack, pointed_thing)
        if not next_node then return end
        if sound then core.sound_play(sound, { to_player = clicker:get_player_name(), gain = 1.0 }) end
        core.swap_node(pos, { name = "terras_capixabas:" .. next_node, param2 = node.param2 })
      end
    })
end
-- Register the 5 stages of eating snacks
-- Stage 1 to 4 play the "eat" sound. Stage 5 is empty and has no next node.
create_salgadinhos_node("salgadinhos_caixa1", "salgadinhos_caixa1.obj", "salgadinhos_caixa2", "eat")
create_salgadinhos_node("salgadinhos_caixa2", "salgadinhos_caixa2.obj", "salgadinhos_caixa3", "eat")
create_salgadinhos_node("salgadinhos_caixa3", "salgadinhos_caixa3.obj", "salgadinhos_caixa4", "eat")
create_salgadinhos_node("salgadinhos_caixa4", "salgadinhos_caixa4.obj", "salgadinhos_caixa5", "eat")
create_salgadinhos_node("salgadinhos_caixa5", "salgadinhos_caixa5.obj", nil, nil)
local function create_pizza_node(name, texture, next_node, sound)
  core.register_node("terras_capixabas:" .. name, {
    description = name == "pizza_caixa" and "Pizza" or "",
    tiles = { texture },    -- Each node uses its specific texture (pizza_caixa1.png, etc.)
    drawtype = "mesh",
    mesh = "pizza_caixa.obj", -- All stages use the same mesh
    paramtype = "light",
    paramtype2 = "facedir",
    groups = { snappy = 3, flammable = 2, not_in_creative_inventory = (name ~= "pizza_caixa") and 1 or 0 },
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
      type = "fixed",
      fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
      if not next_node then return end
      if sound then core.sound_play(sound, { to_player = clicker:get_player_name(), gain = 1.0 }) end
      core.swap_node(pos, { name = "terras_capixabas:" .. next_node, param2 = node.param2 })
    end
  })
end
-- Register the pizza stages (Pizza 1 is the full box, Pizza 5 is empty)
create_pizza_node("pizza_caixa", "pizza_caixa1.png", "pizza_caixa2", "eat")
create_pizza_node("pizza_caixa2", "pizza_caixa2.png", "pizza_caixa3", "eat")
create_pizza_node("pizza_caixa3", "pizza_caixa3.png", "pizza_caixa4", "eat")
create_pizza_node("pizza_caixa4", "pizza_caixa4.png", "pizza_caixa5", "eat")
create_pizza_node("pizza_caixa5", "pizza_caixa5.png", nil, nil)
core.register_node("terras_capixabas:refris", {
  description = "Refris",
  tiles = { "refris.png" },
  drawtype = "mesh",
  mesh = "refris.obj",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = { snappy = 3, flammable = 2 },
  walkable = false,
  use_texture_alpha = "blend",
  backface_culling = false,
  selection_box = { type = "fixed", fixed = { -0.5, -0.5, -0.5, 0.5, 0, 0.5 } }
})
