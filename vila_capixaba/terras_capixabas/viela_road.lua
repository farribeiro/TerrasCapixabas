local item1="terras_capixabas:viela1"
local item2="terras_capixabas:viela2"

minetest.register_tool(item1,{
description="Viela 1",
inventory_image="viela.png"
})

minetest.register_tool(item2,{
description="Viela 2",
inventory_image="viela.png"
})

local function round_pos(pos)
return{x=math.floor(pos.x+0.5),y=math.floor(pos.y+0.5),z=math.floor(pos.z+0.5)}
end

local function can_replace(pos,player)
if minetest.is_protected(pos,player:get_player_name()) then return false end
local node=minetest.get_node_or_nil(pos)
if not node or node.name=="ignore" or node.name=="air" then return false end
local def=minetest.registered_nodes[node.name]
if not def then return false end
if def.walkable and minetest.get_item_group(node.name,"liquid")==0 then
return true
end
return false
end

minetest.register_globalstep(function(dtime)
for _,player in ipairs(minetest.get_connected_players()) do
local wield=player:get_wielded_item():get_name()
if wield==item1 or wield==item2 then

local pos=player:get_pos()
local under=round_pos({x=pos.x,y=pos.y-1,z=pos.z})

if can_replace(under,player) then
minetest.set_node(under,{name="default:mossycobble"})
end

if wield==item2 then
local yaw=player:get_look_horizontal()
local dir=minetest.yaw_to_dir(yaw)
local right=round_pos({x=dir.z,y=0,z=-dir.x})
local right_pos={x=under.x+right.x,y=under.y,z=under.z+right.z}

if can_replace(right_pos,player) then
minetest.set_node(right_pos,{name="default:mossycobble"})
end
end

end
end
end)
