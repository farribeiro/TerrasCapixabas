-- gaivota -----------------------------------------------------------

core.register_entity("terras_capixabas:gaivota", {
initial_properties = {
physical = false,
collide_with_objects = false,
collisionbox = {-0.25, -1.01, -0.25, 0.25, -0.5, 0.25},
visual = "mesh",
mesh = "gaivota.glb",
textures = {"gaivota.png"},
visual_size = {x=1, y=1},
},

_animation_ranges = {
fly = {x=0, y=1},
stand = {x=1.25, y=1.5},
},

chirp_interval = 7,
speed = 6,
flight_ceiling = 15,

_mode = "sleeping",
_home_pos = nil,
_flight_center = nil,
_direction = nil,
_last_chirp = 0,
_height_progress = 0,

on_activate = function(self, staticdata)
local pos = self.object:get_pos()
if staticdata and staticdata ~= "" then
local data = core.deserialize(staticdata) or {}
self._home_pos = data._home_pos or vector.round(pos)
self._mode = data._mode or "sleeping"
self._direction = data._direction or {x=0,y=0,z=0}
self._height_progress = data._height_progress or 0
else
self._home_pos = vector.new(-327, 5.5, -242)
self._mode = "sleeping"
self._direction = {x=0, y=0, z=0}
self._height_progress = 0
end
self._last_chirp = 0
self:set_animation((self._mode == "sleeping") and "stand" or "fly")
end,

get_staticdata = function(self)
return core.serialize({
_home_pos = self._home_pos,
_mode = self._mode,
_direction = self._direction,
_height_progress = self._height_progress
})
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

play_chirp = function(self)
core.sound_play("gaivota", {object = self.object, gain = 1, max_hear_distance = 16})
end,

on_step = function(self, dtime)
local pos = self.object:get_pos()
local tod = core.get_timeofday()
local is_day = tod > 0.23 and tod < 0.8

if self._mode ~= "sleeping" then
self._last_chirp = self._last_chirp + dtime
if self._last_chirp >= self.chirp_interval then self:play_chirp() self._last_chirp = 0 end
end

local dist_to_home = vector.distance(pos, self._home_pos)
local near_home = dist_to_home < 8

if self._mode == "sleeping" and is_day then
self._mode = "ascending"
self:set_animation("fly")
if dist_to_home > 1 then
self._direction = vector.normalize({x=self._home_pos.x - pos.x, y=0, z=self._home_pos.z - pos.z})
self._direction.y = math.sin(math.rad(90))
else
local angle_rad = math.rad(35)
self._direction = {x=0, y=math.sin(angle_rad), z=-math.cos(angle_rad)}
end

elseif (self._mode == "ascending" or self._mode == "flying") and not is_day then
self._mode = "returning"
self:set_animation("fly")

elseif self._mode == "returning" then
local dir_vec = vector.direction(pos, self._home_pos)
local move_vec = vector.multiply(dir_vec, self.speed * dtime)
local new_pos = vector.add(pos, move_vec)
new_pos.x = -327
if near_home then
if pos.y > self._home_pos.y then
new_pos.y = math.max(new_pos.y - self.speed * dtime, self._home_pos.y)
else
new_pos.y = self._home_pos.y
end
if vector.distance(new_pos, self._home_pos) < 0.3 then
new_pos = self._home_pos
self._mode = "sleeping"
self:set_animation("stand")
end
end
self.object:set_pos(new_pos)
self.object:set_yaw(math.atan2(dir_vec.z, dir_vec.x) - math.pi/2)
return
end

if self._mode == "ascending" then
local move_vec = vector.multiply(self._direction, self.speed * dtime)
local new_pos = vector.add(pos, move_vec)
if new_pos.y >= self.flight_ceiling then
new_pos.y = self.flight_ceiling
self._mode = "flying"
self._direction = {x=0, y=0, z=-1}
end
self.object:set_pos(new_pos)
self.object:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi/2)

elseif self._mode == "flying" then
local move_vec = vector.multiply(self._direction, self.speed * dtime)
local new_pos = vector.add(pos, move_vec)

local bounced = false
if new_pos.z < -432 then new_pos.z = -432 self._direction.z = 1 bounced = true end
if new_pos.z > -180 then new_pos.z = -180 self._direction.z = -1 bounced = true end

new_pos.y = math.min(new_pos.y, self.flight_ceiling)
self.object:set_pos(new_pos)
self.object:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi/2)
end
end,
})


core.register_craftitem("terras_capixabas:an_gaivota_spawn_egg", {
description = "Gaivota Spawn Egg",
inventory_image = "gaivota_inv.png",
on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos = pointed_thing.above
pos.y = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:gaivota")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})