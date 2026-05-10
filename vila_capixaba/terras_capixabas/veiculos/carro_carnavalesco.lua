-- terras_capixabas/veiculos/carro_carnavalesco.lua

local vector_round=vector.round
local math_abs=math.abs
local core_sound_play=core.sound_play
local core_sound_stop=core.sound_stop
local get_players=core.get_connected_players

core.register_entity("terras_capixabas:carro_carnavalesco",{
initial_properties={
physical=true,
collide_with_objects=true,
collisionbox={-1.5,-0.5,-3,1.5,0,3},
selectionbox={-1.5,-0.5,-3,1.5,0,3},
visual="mesh",
mesh="carro_carnavalesco.glb",
textures={"carro_carnavalesco.png"},
static_save=true,
backface_culling=false,
},

spawn_pos=nil,
direction=1,
speed=1,
max_offset=5,
current_offset=0,
last_z=nil,
sound_handle=nil,
playing_music=false,
playing_anim=false,

on_activate=function(self,staticdata)
local pos=self.object:get_pos()
if staticdata and staticdata~="" then
local data=core.deserialize(staticdata) or {}
self.spawn_pos=data.spawn_pos or vector_round(pos)
else
self.spawn_pos=vector_round(pos)
end
self.current_offset=0
self.direction=1
self.last_z=pos.z
self.object:set_animation({x=0,y=0},0,0,false)
end,

get_staticdata=function(self)
return core.serialize({spawn_pos=self.spawn_pos})
end,

on_step=function(self,dtime)
if not self.spawn_pos then return end

-- movement
self.current_offset=self.current_offset+(self.direction*self.speed*dtime)
if math_abs(self.current_offset)>=self.max_offset then
self.current_offset=self.max_offset*self.direction
self.direction=-self.direction
end

local new_z=self.spawn_pos.z+self.current_offset
local pos=self.object:get_pos()
self.object:set_pos({x=self.spawn_pos.x,y=self.spawn_pos.y,z=new_z})

-- delta movement
local dz=new_z-(self.last_z or new_z)
self.last_z=new_z

-- carry players only if standing still
for _,player in ipairs(get_players()) do
local ppos=player:get_pos()
local vel=player:get_velocity()

if ppos.x>pos.x-1.5 and ppos.x<pos.x+1.5
and ppos.z>new_z-3 and ppos.z<new_z+3
and math_abs(ppos.y-(pos.y+0.2))<0.8 then

-- only carry if not walking
if math_abs(vel.x)<0.1 and math_abs(vel.z)<0.1 then
player:set_pos({x=ppos.x,y=ppos.y,z=ppos.z+dz})
end
end
end
end,

on_rightclick=function(self,clicker)
if not self.playing_music then
self.sound_handle=core_sound_play("jardineira",{object=self.object,loop=true,gain=1.0,max_hear_distance=32})
self.object:set_animation({x=0,y=83},1,0,true)
self.playing_music=true
self.playing_anim=true
else
if self.sound_handle then
core_sound_stop(self.sound_handle)
self.sound_handle=nil
end
self.object:set_animation({x=0,y=0},0,0,false)
self.playing_music=false
self.playing_anim=false
end
end,

on_punch=function(self,puncher)
if self.sound_handle then
core_sound_stop(self.sound_handle)
self.sound_handle=nil
end
self.object:remove()
end,

on_deactivate=function(self)
if self.sound_handle then
core_sound_stop(self.sound_handle)
self.sound_handle=nil
end
end
})

core.register_craftitem("terras_capixabas:vh_carro_carnavalesco",{
description="Carro Carnavalesco",
inventory_image="carro_carnavalesco_inv.png",
on_place=function(itemstack,placer,pointed_thing)
if pointed_thing.type~="node" then return itemstack end
core.add_entity(pointed_thing.above,"terras_capixabas:carro_carnavalesco")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})
