local function rnd(list)return list[math.random(#list)]end

local C={"terras_capixabas:parede_concreto","terras_capixabas:concreto1","terras_capixabas:concreto2","terras_capixabas:concreto3"}
local S={"terras_capixabas:piso_sinteco","terras_capixabas:piso_vovo_banheiro_chao","terras_capixabas:piso1","terras_capixabas:piso_branco","terras_capixabas:piso_vovo_cozinha"}
local D={"terras_capixabas:porta","terras_capixabas:porta_branca"}
local W={"terras_capixabas:janela_closed","terras_capixabas:janela_branca_closed","terras_capixabas:janela_colonial_closed"}
local J="terras_capixabas:janela_colonial_1x2"
local T={"terras_capixabas:telha_amianto","terras_capixabas:telha_colonial"}
local CX={"terras_capixabas:caixadagua","terras_capixabas:caixadagua2"}

local GR={"terras_capixabas:grade_2madeiras","terras_capixabas:grade_colonial","terras_capixabas:grade_losangulo","terras_capixabas:grade_ferro","terras_capixabas:grade_parapeito_vidro_verde"}
local TR={"terras_capixabas:toco_marrom","terras_capixabas:toco_branco","terras_capixabas:toco_verde","terras_capixabas:toco_vermelho","terras_capixabas:toco_azul"}

local B={
"brick","terras_capixabas:club_parede","terras_capixabas:parede_abacate","terras_capixabas:parede_amarela",
"terras_capixabas:parede_azul","terras_capixabas:parede_azul2","terras_capixabas:parede_azul_claro",
"terras_capixabas:parede_branca","terras_capixabas:parede_concreto","terras_capixabas:parede_laranja",
"terras_capixabas:parede_laranja_claro","terras_capixabas:parede_magenta","terras_capixabas:parede_marrom",
"terras_capixabas:parede_prata","terras_capixabas:parede_rosa","terras_capixabas:parede_roxa",
"terras_capixabas:parede_verde","terras_capixabas:parede_verde_agua","terras_capixabas:parede_verde_bebe",
"terras_capixabas:parede_verde_esmeralda","terras_capixabas:parede_vermelha",
"terras_capixabas:parede_vovo_banheiro","terras_capixabas:parede_vovo_beige"
}

-- undo storage
local last_changes = {}

local function start_record()
last_changes = {}
end

local function record_node(pos)
local old = minetest.get_node(pos)
table.insert(last_changes,{pos={x=pos.x,y=pos.y,z=pos.z},node=old})
end

local function set_node_record(pos,node)
record_node(pos)
minetest.set_node(pos,node)
end

minetest.register_chatcommand("errei",{
description="Apaga a ultima casa ou palafita",
func=function(name)
for i=#last_changes,1,-1 do
local c=last_changes[i]
minetest.set_node(c.pos,c.node)
end
last_changes={}
return true,"Desfeito."
end
})

local function pick(ch,rot,wall,floor,roof,win,col,gr,tr,layer_id,row_id)
if ch=="A" then return {name="air"} end
if ch=="C" then return {name="terras_capixabas:concreto3"} end
if ch=="S" then return {name=floor} end
if ch=="B" then return {name=wall} end
if ch=="T" then return {name=roof} end
if ch=="X" then return {name=rnd(CX)} end
if ch=="2" then
local r=rot
if layer_id==1 and row_id==2 and (col==1 or col==7) then
r=(rot+1)%4
end
if layer_id==1 and row_id==3 then
r=(rot+1)%4
end
return {name=gr,param2=r}
end
if ch=="R" then return {name=tr} end
if ch=="G" or ch=="W" or ch=="J" or ch=="D" then
local r=rot
if col==2 then r=(rot+1)%4 elseif col==8 then r=(rot+3)%4 end
if ch=="G" or ch=="W" then return {name=win,param2=r} end
if ch=="J" then return {name=J,param2=r,jwin=true} end
if ch=="D" then return {name=rnd(D),param2=r,door=true} end
end
return nil
end

local L0={"AAAAAAAAA","ACCCCCCCA","ACSSSSSCA","ACSSSSSCA","ACSSSSSCA","ACSSSSSCA","ACSSSSSCA","ACSSSSSCA","ACSSSSSCA","ACSSSSSCA","AAAAAAAAA"}

local L1={
{"AAAAAAAAA","ABBBBDBBA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ADAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABBDBBBBA","AAAAAAAAA"},
{"AAAAAAAAA","ABBBBBDBA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ADAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABDBBBBBA","AAAAAAAAA"},
{"AAAAAAAAA","ABBBDBBBA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ADAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABBBDBBBA","AAAAAAAAA"}
}

local L2={
{"AAAAAAAAA","ABGABABBA","AGAAAAAAA","AAAAAAAGA","ABAAAAABA","AAAAAAABA","ABAAAAABA","AGAAAAAAA","AAAAAAAGA","ABBABGABA","AAAAAAAAA"},
{"AAAAAAAAA","ABJBJBABA","AGAAAAAAA","AAAAAAAGA","ABAAAAABA","AAAAAAABA","ABAAAAABA","AGAAAAAAA","AAAAAAAGA","ABABJBJBA","AAAAAAAAA"},
{"AAAAAAAAA","ABJBABJBA","AGAAAAAAA","AAAAAAAGA","ABAAAAABA","AAAAAAABA","ABAAAAABA","AGAAAAAAA","AAAAAAAGA","ABJBABJBA","AAAAAAAAA"}
}

local L3={
{"AAAAAAAAA","ABBBBBBBA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABBBBBBBA","AAAAAAAAA"},
{"AAAAAAAAA","ABABABBBA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABBBABABA","AAAAAAAAA"},
{"AAAAAAAAA","ABABBBABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABABBBABA","AAAAAAAAA"}
}

local L4={"AAAAAAAAA","ABBBBBBBA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABAAAAABA","ABBBBBBBA","AAAAAAAAA"}
local L5={"TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT","TTTTTTTTT"}
local L6={"AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAXAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA"}
local L7={"AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA","AAAAAAAAA"}

local V0={"CCCCCCC","CCCCCCC","CCCCCCC"}
local V1={"2AAAAA2","2AAAAA2","C22222C"}
local V2={"AAAAAAA","AAAAAAA","RAAAAAR"}
local V3={"AAAAAAA","AAAAAAA","RAAAAAR"}
local V4={"AAAAAAA","AAAAAAA","RAAAAAR"}
local V5={"TTTTTTT","TTTTTTT","TTTTTTT"}

local dirs={[0]={f={x=0,z=1},l={x=1,z=0}},[1]={f={x=1,z=0},l={x=0,z=-1}},[2]={f={x=0,z=-1},l={x=-1,z=0}},[3]={f={x=-1,z=0},l={x=0,z=1}}}

local function place_layer(origin,layer,y,rot,wall,floor,roof,win,layer_id,gr,tr)
if not layer then return end
local d=dirs[rot]
local h=#layer
for zi=1,h do
local z=h-zi+1
local row=layer[z]
for x=1,#row do
local ch=row:sub(x,x)
local node=pick(ch,rot,wall,floor,roof,win,x,gr,tr,layer_id,zi)
if node then
local dx=(x-1)*d.l.x+(zi-1)*d.f.x
local dz=(x-1)*d.l.z+(zi-1)*d.f.z
local p={x=origin.x+dx,y=origin.y+y,z=origin.z+dz}
if not(layer_id==0 and node.name=="air") then
set_node_record(p,{name=node.name,param2=node.param2})
end
if node.door or node.jwin then
local above={x=p.x,y=p.y+1,z=p.z}
set_node_record(above,{name="air"})
end
end
end
end
end

local function clear_air_shell(pos,rot)
local d=dirs[rot]
for y=1,7 do
for zi=-1,11 do
for xi=-1,9 do
if xi==-1 or xi==9 or zi==-1 or zi==11 then
local dx=xi*d.l.x+zi*d.f.x
local dz=xi*d.l.z+zi*d.f.z
local p={x=pos.x+dx,y=pos.y+y,z=pos.z+dz}
set_node_record(p,{name="air"})
end
end
end
end
end

local function build_varanda(pos,rot,wall,floor,roof,win)
local d=dirs[rot]
local gr=rnd(GR)
local tr=rnd(TR)
local front={
x=pos.x-d.f.x*2+d.l.x*1,
y=pos.y,
z=pos.z-d.f.z*2+d.l.z*1
}
place_layer(front,V0,0,rot,wall,floor,roof,win,0,gr,tr)
place_layer(front,V1,1,rot,wall,floor,roof,win,1,gr,tr)
place_layer(front,V2,2,rot,wall,floor,roof,win,2,gr,tr)
place_layer(front,V3,3,rot,wall,floor,roof,win,3,gr,tr)
place_layer(front,V4,4,rot,wall,floor,roof,win,4,gr,tr)
place_layer(front,V5,5,rot,wall,floor,roof,win,5,gr,tr)
end

local function build_house(pos,player)
start_record()
local rot=minetest.dir_to_facedir(player:get_look_dir())%4
local wall=rnd(B)
local floor=rnd(S)
local roof=rnd(T)
local win=rnd(W)
local design=math.random(3)

place_layer(pos,L0,0,rot,wall,floor,roof,win,0)
place_layer(pos,L1[design],1,rot,wall,floor,roof,win,1)
place_layer(pos,L2[design],2,rot,wall,floor,roof,win,2)
place_layer(pos,L3[design],3,rot,wall,floor,roof,win,3)
place_layer(pos,L4,4,rot,wall,floor,roof,win,4)
place_layer(pos,L5,5,rot,wall,floor,roof,win,5)
place_layer(pos,L6,6,rot,wall,floor,roof,win,6)
place_layer(pos,L7,7,rot,wall,floor,roof,win,7)

clear_air_shell(pos,rot)

if math.random()<0.5 then
build_varanda(pos,rot,wall,floor,roof,win)
end
end

minetest.register_craftitem("terras_capixabas:casa_favela",{
description="Casa Favela",
inventory_image="casa_favela.png",
on_place=function(itemstack,user,pointed)
if not user or not pointed or pointed.type~="node" then return itemstack end
build_house(pointed.under,user)
return itemstack
end
})

minetest.register_craftitem("terras_capixabas:palafita",{
description="Palafita",
inventory_image="palafita.png",
on_place=function(itemstack,user,pointed)
if not user or not pointed or pointed.type~="node" then return itemstack end

start_record()
local pos = pointed.above
local node_name = "terras_capixabas:concreto3"

for height = 0, 19 do
local check_pos = {x = pos.x, y = pos.y + height, z = pos.z}
local node = minetest.get_node(check_pos)

if node.name ~= "air" and node.name ~= "ignore" then
break
end

set_node_record(check_pos, {name = node_name})

if height == 19 then
for remove_height = 0, 19 do
local remove_pos = {x = pos.x, y = pos.y + remove_height, z = pos.z}
set_node_record(remove_pos, {name = "air"})
end
break
end
end

return itemstack
end
})
