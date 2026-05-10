local function is_water(pos)
local nn=minetest.get_node(pos).name
return minetest.get_item_group(nn,"water")~=0
end

local function get_velocity(v,yaw,y)
local x=-math.sin(yaw)*v
local z=math.cos(yaw)*v
return{x=x,y=y,z=z}
end

local function get_v(v)
return math.sqrt(v.x^2+v.z^2)
end

local textures={"jetski.png","jetski_vermelha.png","jetski_azul.png"}

local jetski={
initial_properties={
physical=true,
collisionbox={-0.6,-0.35,-0.6,0.6,0.3,0.6},
visual="mesh",
mesh="jetski.glb",
textures={"jetski.png"},
},
driver=nil,
v=0,
last_v=0,
removed=false,
sound_handle=nil,
sound_state=nil,
tex=nil
}

function jetski.on_activate(self,staticdata)
self.object:set_armor_groups({immortal=1})
self.v=0
self.last_v=0

if staticdata and staticdata~="" then
local data=minetest.deserialize(staticdata)
if data then
self.v=data.v or 0
self.tex=data.tex
end
end

if not self.tex then
self.tex=textures[math.random(#textures)]
end

self.object:set_properties({textures={self.tex}})
end

function jetski.on_rightclick(self,clicker)
if not clicker or not clicker:is_player() then return end
local name=clicker:get_player_name()
if self.driver and name==self.driver then
clicker:set_detach()
player_api.player_attached[name]=false
self.driver=nil
if self.sound_handle then minetest.sound_stop(self.sound_handle) end
self.sound_handle=nil
self.sound_state=nil
player_api.set_animation(clicker,"stand",30)
else
if not self.driver then
clicker:set_attach(self.object,"",{x=0,y=4,z=0},{x=0,y=0,z=0})
self.driver=name
player_api.player_attached[name]=true
player_api.set_animation(clicker,"sit",30)
clicker:set_look_horizontal(self.object:get_yaw())
self.sound_handle=minetest.sound_play("kombi_idle",{object=self.object,loop=true,gain=0.6})
self.sound_state="idle"
end
end
end

function jetski.on_detach_child(self,child)
if child then
local pname=child:get_player_name()
if pname then player_api.player_attached[pname]=false end
end
self.driver=nil
if self.sound_handle then minetest.sound_stop(self.sound_handle) end
self.sound_handle=nil
self.sound_state=nil
end

function jetski.get_staticdata(self)
return minetest.serialize({v=self.v,tex=self.tex})
end

function jetski.on_punch(self,puncher)
if not puncher or not puncher:is_player() or self.removed then return end
local name=puncher:get_player_name()
if self.driver and name==self.driver then
puncher:set_detach()
player_api.player_attached[name]=false
self.driver=nil
end
if not self.driver then
self.removed=true
local inv=puncher:get_inventory()
local item="terras_capixabas:jetski"
if not minetest.is_creative_enabled(name) or not inv:contains_item("main",item) then
local leftover=inv:add_item("main",item)
if not leftover:is_empty() then
minetest.add_item(self.object:get_pos(),leftover)
end
end
minetest.after(0.1,function()self.object:remove()end)
end
end

function jetski.on_step(self,dtime)
self.v=get_v(self.object:get_velocity())*math.sign(self.v)

if self.driver then
local driver=minetest.get_player_by_name(self.driver)
if driver then
local ctrl=driver:get_player_control()

if ctrl.jump then
local name=self.driver
driver:set_detach()
player_api.player_attached[name]=false
self.driver=nil
if self.sound_handle then minetest.sound_stop(self.sound_handle) end
self.sound_handle=nil
self.sound_state=nil
return
end

if ctrl.up then
self.v=self.v+dtime*6
elseif ctrl.down then
self.v=self.v-dtime*4
end

if ctrl.left then
if self.v<0 then
self.object:set_yaw(self.object:get_yaw()+dtime*1.2)
else
self.object:set_yaw(self.object:get_yaw()+dtime*1.2)
end
elseif ctrl.right then
if self.v<0 then
self.object:set_yaw(self.object:get_yaw()-dtime*1.2)
else
self.object:set_yaw(self.object:get_yaw()-dtime*1.2)
end
end

if math.abs(self.v)>0.5 then
if self.sound_state~="move" then
if self.sound_handle then minetest.sound_stop(self.sound_handle) end
self.sound_handle=minetest.sound_play("kombi",{object=self.object,loop=true,gain=0.8})
self.sound_state="move"
end
else
if self.sound_state~="idle" then
if self.sound_handle then minetest.sound_stop(self.sound_handle) end
self.sound_handle=minetest.sound_play("kombi_idle",{object=self.object,loop=true,gain=0.6})
self.sound_state="idle"
end
end
end
end

local drag=dtime*math.sign(self.v)*(0.01+0.0796*self.v*self.v)
if math.abs(self.v)<=math.abs(drag) then
self.v=0
else
self.v=self.v-drag
end

local p=self.object:get_pos()
p.y=p.y-0.5
local new_velo
local new_acce={x=0,y=0,z=0}

if not is_water(p) then
local nodedef=minetest.registered_nodes[minetest.get_node(p).name]
if(not nodedef)or nodedef.walkable then
self.v=0
new_acce={x=0,y=1,z=0}
else
new_acce={x=0,y=-9.8,z=0}
end
new_velo=get_velocity(self.v,self.object:get_yaw(),self.object:get_velocity().y)
self.object:set_pos(self.object:get_pos())
else
p.y=p.y+1
if is_water(p) then
local y=self.object:get_velocity().y
if y>=5 then
y=5
elseif y<0 then
new_acce={x=0,y=20,z=0}
else
new_acce={x=0,y=5,z=0}
end
new_velo=get_velocity(self.v,self.object:get_yaw(),y)
self.object:set_pos(self.object:get_pos())
else
new_acce={x=0,y=0,z=0}
if math.abs(self.object:get_velocity().y)<1 then
local pos=self.object:get_pos()
pos.y=math.floor(pos.y)+0.5
self.object:set_pos(pos)
new_velo=get_velocity(self.v,self.object:get_yaw(),0)
else
new_velo=get_velocity(self.v,self.object:get_yaw(),self.object:get_velocity().y)
self.object:set_pos(self.object:get_pos())
end
end
end

self.object:set_velocity(new_velo)
self.object:set_acceleration(new_acce)
end

minetest.register_entity("terras_capixabas:jetski",jetski)

minetest.register_craftitem("terras_capixabas:jetski",{
description="Jetski",
inventory_image="jetski_inv.png",
liquids_pointable=true,
on_place=function(itemstack,placer,pointed_thing)
if pointed_thing.type~="node" then return itemstack end
if not is_water(pointed_thing.under) then return itemstack end
local pos=pointed_thing.under
pos.y=pos.y+0.5
local obj=minetest.add_entity(pos,"terras_capixabas:jetski")
if obj and placer then
obj:set_yaw(placer:get_look_horizontal())
if not minetest.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
end
return itemstack
end
})
