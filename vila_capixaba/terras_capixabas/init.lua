local S=core.get_mod_storage()

core.register_on_generated(function(minp,maxp)
local k=core.pos_to_string(minp)
if S:get_int(k)==1 then return end
S:set_int(k,1)
end)

local old_add=core.add_entity
core.add_entity=function(pos,name,...)
return old_add(pos,name,...)
end

core.register_on_joinplayer(function(player,last_login)
player:set_camera({mode="third"})
core.after(0.1,function()
if not core.is_player(player) then return end
player:set_camera({mode="any"})
end)
end)

-- CARREGAMENTOS -------------------------------
local modpath=core.get_modpath("terras_capixabas")
local scripts={
"/alimentos/alimentos.lua",
"/animais/vagalume.lua",
"/animais/borboletas.lua",
"/animais/caes.lua",
"/animais/caranguejo.lua",
"/animais/gaivota.lua",
"/animais/grilo.lua",
"/animais/mariposa.lua",
"/animais/morcego.lua",
"/animais/onivoros.lua",
"/animais/passarinhos.lua",
"/animais/peixes.lua",
"/animais/ratinho.lua",
"/animais/sapo.lua",
"/animais/test_entity.lua",
"/animais/urubu.lua",
"/construcao/construcao.lua",
"/funcionalidades.lua",
"/favela.lua",
"/itens/itens.lua",
"/mobilia/mobilia.lua",
"/npcs/main/npc_registration.lua",
"/npcs/behaviors/eat_drink_behavior.lua",
"/npcs/asa_delta.lua",
"/npcs/carroca.lua",
"/npcs/folclore_npcs.lua",
"/npcs/ghost.lua",
"/npcs/patinete_boy.lua",
"/npcs/picoleteiro.lua",
"/npcs/pipoqueiro.lua",
"/npcs/quebra_queixeiro.lua",
"/npcs/test_block.lua",
"/npc_poses/npc_poses.lua",
"/objetos_de_rua/objetos_de_rua.lua",
"/plantas/plantas.lua",
"/sprites/sprites.lua",
"/veiculos/bicicleta_monark.lua",
"/veiculos/brasilia.lua",
"/veiculos/brasilia_vendedora.lua",
"/veiculos/boia_pneu.lua",
"/veiculos/bulldozer.lua",
"/veiculos/cacamba.lua",
"/veiculos/caminhaozinho.lua",
"/veiculos/carrinho_ferreo.lua",
"/veiculos/carrinho_rolima.lua",
"/veiculos/carro_carnavalesco.lua",
"/veiculos/disco_voador.lua",
"/veiculos/dodge_van.lua",
"/veiculos/ford_landau.lua",
"/veiculos/fumace.lua",
"/veiculos/fusca.lua",
"/veiculos/jetski.lua",
"/veiculos/kombi.lua",
"/veiculos/kombi_carroceria.lua",
"/veiculos/moto.lua",
"/veiculos/onibus.lua",
"/veiculos/rural.lua",
"/veiculos/scania.lua",
"/veiculos/steamroller.lua",
"/veiculos/trem.lua",
"/veiculos/veraneio.lua",
}

for _,s in ipairs(scripts) do dofile(modpath..s) end

-- -------------------------------
-- NPC VENDOR SPAWNER
-- -------------------------------
local npc_vendor_list={
{name="terras_capixabas:pe_mrt",pos={x=-381,y=4.5,z=-266},yaw=1.5708},
{name="terras_capixabas:pe_carlos",pos={x=-394,y=4.5,z=-254},yaw=1.5708},
{name="terras_capixabas:pe_adel",pos={x=-364,y=4.5,z=-246},yaw=3.14159},
{name="terras_capixabas:pe_jessica",pos={x=-414,y=4.5,z=-369},yaw=3.14159},
{name="terras_capixabas:pe_old2",pos={x=-415,y=4.5,z=-320},yaw=4.71239},
{name="terras_capixabas:pe_professor",pos={x=-390,y=9.5,z=-331},yaw=3.14159},
{name="terras_capixabas:pe_playmobil",pos={x=-380,y=9.5,z=-331},yaw=3.14159},
{name="terras_capixabas:pe_ted",pos={x=-371,y=10.5,z=-298},yaw=4.71239},
{name="terras_capixabas:pe_cammy",pos={x=-385,y=4.5,z=-394},yaw=0},
{name="terras_capixabas:pe_carlos",pos={x=-390,y=4.5,z=-374},yaw=3.14159},
{name="terras_capixabas:pe_old1",pos={x=-441,y=4.5,z=-387},yaw=3.14159},
{name="terras_capixabas:pe_old3",pos={x=-464,y=4.5,z=-283},yaw=3.14159},
{name="terras_capixabas:pe_old3",pos={x=-414,y=4.5,z=-244},yaw=3.14159},
{name="terras_capixabas:pe_sargento",pos={x=-389,y=4.5,z=-320},yaw=1.5708},
{name="terras_capixabas:pe_soldado",pos={x=-385,y=4.5,z=-322},yaw=1.5708},
{name="terras_capixabas:pe_soldado",pos={x=-376,y=4.5,z=-316},yaw=1.5708},
{name="terras_capixabas:pe_carlos",pos={x=-394,y=5.5,z=-277},yaw=1.5708},
}

local function spawn_all_vendors()
for _,def in ipairs(npc_vendor_list) do
if core.registered_entities[def.name] then
local e=core.add_entity(def.pos,def.name)
if e then
if def.yaw then e:set_yaw(def.yaw) end
local lua=e:get_luaentity()
if lua then
lua.state="idle"
lua.walking=false
lua.moving=false
if lua.set_animation then lua:set_animation("idle") end
e:set_velocity({x=0,y=0,z=0})
end
end
end
end
end

core.register_craftitem("terras_capixabas:npc_vendor_spawner",{
description="NPC Vendor Spawner",
inventory_image="npc_vendor_spawner.png",
on_use=function(itemstack,user,pointed_thing)
spawn_all_vendors()
return itemstack
end,
})