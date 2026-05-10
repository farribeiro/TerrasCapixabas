math.randomseed(os.time())

-- pose list (ALPHABETICAL, WITHOUT StFNpc / .obj)
local poses = {
"Dance",
"HandPoint",
"LayBed",
"LayBedUp",
"LayFloorDwn",
"LayFloorUp",
"Phone",
"SitChair",
"SitFloor",
"StandBalcony",
"Swim",
"Volley",
"Walk",
"Waving"
}

-- inventory texture PER pose
local pose_inv = {
Walk = "pose_Walk.png",
StandBalcony = "pose_StandBalcony.png",
HandPoint = "pose_HandPoint.png",
Waving = "pose_Waving.png",
Phone = "pose_Phone.png",
Volley = "pose_Volley.png",
Dance = "pose_Dance.png",
SitChair = "pose_SitChair.png",
SitFloor = "pose_SitFloor.png",
LayFloorUp = "pose_LayFloorUp.png",
LayFloorDwn = "pose_LayFloorDwn.png",
LayBed = "pose_LayBed.png",
LayBedUp = "pose_LayBedUp.png",
Swim = "pose_Swim.png"
}

-- texture list WITHOUT .png
local textures = {
"pe_adel","pe_adriana","pe_ale","pe_alexia","pe_anel","pe_ariana","pe_ashley",
"pe_bear","pe_becky","pe_bikinigirl","pe_bikinigirl2","pe_bilza","pe_bolsonaro",
"pe_brittany","pe_bruce","pe_cammy","pe_carla","pe_carlos","pe_cascao",
"pe_cebolinha","pe_chunli","pe_ciro_gomes","pe_cuca","pe_curupira","pe_diane",
"pe_dreneas","pe_drstrange","pe_dude","pe_elaine","pe_estudante1",
"pe_estudante2","pe_estudante3","pe_estudante4","pe_estudante5","pe_estudante6",
"pe_estudante7","pe_estudante8","pe_fafa","pe_felicia","pe_franjinha",
"pe_garota_patins","pe_garoto1","pe_gato","pe_gisele","pe_goofy","pe_gori",
"pe_heman","pe_india","pe_indiana","pe_indio","pe_jada","pe_jasmine",
"pe_jessica","pe_juana","pe_karas","pe_lane","pe_latina","pe_luil","pe_lula",
"pe_mada","pe_madruga","pe_magali","pe_mai_shiranui","pe_maravilha","pe_mary",
"pe_mary_bikini","pe_michael","pe_minotauro","pe_monica","pe_monstro",
"pe_motorista","pe_mrt","pe_nativo","pe_npc1","pe_npc1_bikini","pe_npc2",
"pe_npc2_bikini","pe_npc3","pe_npc3_bikini","pe_old1","pe_old2","pe_old3",
"pe_peewee","pe_playmobil","pe_poca","pe_princesa","pe_professor","pe_ryu",
"pe_saci","pe_sargento","pe_scooby","pe_shazam","pe_soldado","pe_spectreman",
"pe_stephanie","pe_taz","pe_ted","pe_tiririca","pe_trocador","pe_vampira","pe_vampiro"
}

-- register all hidden static npc mesh nodes
for _,pose in ipairs(poses) do
for _,tex in ipairs(textures) do
core.register_node("terras_capixabas:StFNpc"..pose.."_"..tex, {
drawtype = "mesh",
visual_size = {x = 1, y = 1},
mesh = "StFNpc"..pose..".obj",
tiles = {tex..".png"},
paramtype = "light",
paramtype2 = "facedir",
use_texture_alpha = "clip",
walkable = false,
groups = {
cracky = 3,
oddly_breakable_by_hand = 2,
not_in_creative_inventory = 1
},
selection_box = {
type = "fixed",
fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
}
})
end
end

-- one placer PER pose (alphabetically ordered in inventory)
for _,pose in ipairs(poses) do
core.register_node("terras_capixabas:static_npc_"..pose:lower(), {
description = "pose_"..pose,
inventory_image = pose_inv[pose],
wield_image = pose_inv[pose],

groups = {cracky = 3, oddly_breakable_by_hand = 2},
on_place = function(itemstack, placer, pointed)
if not pointed or pointed.type ~= "node" then return itemstack end
local pos = pointed.above
local tex = textures[math.random(#textures)]

core.set_node(pos, {
name = "terras_capixabas:StFNpc"..pose.."_"..tex,
param2 = core.dir_to_facedir(placer:get_look_dir())
})

if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})
end
