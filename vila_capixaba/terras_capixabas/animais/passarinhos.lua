-- PASSARINHOS -------------------------------------------------------------------

local bird_defs = {
{name="araponga", mesh="passarinho.glb", sound="araponga"},
{name="bemtevi",  mesh="passarinho.glb", sound="bemtevi"},
{name="pardal",   mesh="passarinho.glb", sound="pardal"},
{name="periquito",mesh="passarinho.glb", sound="periquito"},
{name="picapau",  mesh="passarinho_picapau.glb", sound="picapau"},
{name="rolinha",  mesh="passarinho.glb", sound="rolinha"}
}

local anims = {
fly   = {x=0,    y=0.5},
stand = {x=0.75, y=1}
}

local bounds = {
x = {-491, -340},
z = {-432, -180}
}

local function rand_dir_y(y)
local a = math.random() * math.pi * 2
return vector.normalize({x=math.cos(a), y=y or 0, z=math.sin(a)})
end

local function register_bird(def)

core.register_entity("terras_capixabas:"..def.name, {

initial_properties = {
physical = false,
collide_with_objects = false,
collisionbox = {-0.25,-1.01,-0.25, 0.25,-0.5,0.25},
visual = "mesh",
mesh = def.mesh,
textures = {def.name..".png"},
visual_size = {x=1,y=1},
},

_animation_ranges = anims,

chirp_interval = 7,
speed = 6,
flight_ceiling = 15,

_mode = "sleeping",
_home_pos = nil,
_direction = nil,
_last_chirp = 0,

on_activate = function(self, staticdata)
local pos = self.object:get_pos()

if staticdata and staticdata ~= "" then
local d = core.deserialize(staticdata) or {}
self._home_pos  = d.home or vector.round(pos)
self._mode      = d.mode or "sleeping"
self._direction = d.dir or {x=0,y=0,z=0}
else
self._home_pos  = vector.round(pos)
self._mode      = "sleeping"
self._direction = {x=0,y=0,z=0}
end

self._last_chirp = 0
self:set_animation(self._mode == "sleeping" and "stand" or "fly")
end,

get_staticdata = function(self)
return core.serialize({
home = self._home_pos,
mode = self._mode,
dir  = self._direction
})
end,

set_animation = function(self, a)
local r = self._animation_ranges[a]
if r then self.object:set_animation({x=r.x,y=r.y},1,1,true) end
end,

play_chirp = function(self)
core.sound_play(def.sound, {
object = self.object,
gain = 1,
max_hear_distance = 16
})
end,

on_step = function(self, dtime)
local obj = self.object
local pos = obj:get_pos()
local tod = core.get_timeofday()
local is_day = tod > 0.23 and tod < 0.8

-- chirps
if self._mode ~= "sleeping" then
self._last_chirp = self._last_chirp + dtime
if self._last_chirp >= self.chirp_interval then
self:play_chirp()
self._last_chirp = 0
end
end

-- state transitions
if self._mode == "sleeping" and is_day then
self._mode = "ascending"
self:set_animation("fly")
self._direction = rand_dir_y(math.sin(math.rad(33)))

elseif (self._mode == "ascending" or self._mode == "flying") and not is_day then
self._mode = "returning"
self:set_animation("fly")

elseif self._mode == "returning" then
local dx = pos.x - self._home_pos.x
local dy = pos.y - self._home_pos.y
local dz = pos.z - self._home_pos.z
if dx*dx + dy*dy + dz*dz < 0.09 then
obj:set_pos(self._home_pos)
self._mode = "sleeping"
self:set_animation("stand")
return
end
end

-- movement
if self._mode == "ascending" then
local np = vector.add(pos, vector.multiply(self._direction, self.speed * dtime))
if np.y >= self.flight_ceiling then
np.y = self.flight_ceiling
self._mode = "flying"
self._direction = rand_dir_y(0)
end
obj:set_pos(np)
obj:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi/2)

elseif self._mode == "flying" then
local np = vector.add(pos, vector.multiply(self._direction, self.speed * dtime))

-- bounds bounce
if np.x < bounds.x[1] or np.x > bounds.x[2] then self._direction.x = -self._direction.x end
if np.z < bounds.z[1] or np.z > bounds.z[2] then self._direction.z = -self._direction.z end
if np.y >= self.flight_ceiling then self._direction.y = -math.abs(self._direction.y) end
if np.y <= 2 then self._direction.y =  math.abs(self._direction.y) end

self._direction = vector.normalize(self._direction)
np = vector.add(pos, vector.multiply(self._direction, self.speed * dtime))
np.y = math.min(np.y, self.flight_ceiling)

obj:set_pos(np)
obj:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi/2)

elseif self._mode == "returning" then
local dir = vector.direction(pos, self._home_pos)
local np = vector.add(pos, vector.multiply(dir, self.speed * dtime))
obj:set_pos(np)
obj:set_yaw(math.atan2(dir.z, dir.x) - math.pi/2)
end
end,
})

core.register_craftitem("terras_capixabas:an_"..def.name.."_spawn_egg", {
description = def.name.." Spawn Egg",
inventory_image = def.name.."_inv.png",
on_place = function(itemstack, placer, pointed)
if pointed.type ~= "node" then return itemstack end
local pos = vector.add(pointed.above, {x=0,y=0.5,z=0})
core.add_entity(pos, "terras_capixabas:"..def.name)
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})

end

for _, def in ipairs(bird_defs) do
register_bird(def)
end
