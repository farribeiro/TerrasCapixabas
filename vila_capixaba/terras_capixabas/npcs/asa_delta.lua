-- asa_delta -----------------------------------------------------------

core.register_entity("terras_capixabas:asa_delta", {
initial_properties = {
physical              = false,
collide_with_objects  = false,
collisionbox          = {-0.25, -1.01, -0.25, 0.25, -0.5, 0.25},
visual                = "mesh",
mesh                  = "asa_delta.glb",
textures              = {"asa_delta.png"},
visual_size           = {x=0.85, y=0.85},
backface_culling      = false,
static_save           = true,
},

_animation_ranges = {
fly   = {x=0.25, y=0.33},
stand = {x=0,    y=0.08},
},

speed            = 6,
flight_ceiling   = 20,
ellipse_radius_x = 30,
ellipse_radius_z = 15,

_mode            = "sleeping",
_home_pos        = nil,
_direction       = nil,
_angle           = 0,
_height_progress = 0,

on_activate = function(self, staticdata)
local pos = self.object:get_pos()
if staticdata and staticdata ~= "" then
local data            = core.deserialize(staticdata) or {}
self._home_pos        = data.home_pos or vector.round(pos)
self._mode            = data.mode or "sleeping"
self._angle           = data.angle or 0
self._height_progress = data.height_progress or 0
else
self._home_pos        = vector.round(pos)
self._mode            = "sleeping"
self._angle           = 0
self._height_progress = 0
end
self._direction = vector.zero()
self:set_animation((self._mode == "sleeping") and "stand" or "fly")
end,

get_staticdata = function(self)
return core.serialize({
home_pos        = self._home_pos,
mode            = self._mode,
angle           = self._angle,
height_progress = self._height_progress,
})
end,

set_animation = function(self, anim)
local r = self._animation_ranges[anim]
if r then self.object:set_animation({x=r.x, y=r.y}, 1, 1, true) end
end,

on_step = function(self, dtime, moveresult)
local pos    = self.object:get_pos()
local tod    = core.get_timeofday()
local is_day = tod > 0.23 and tod < 0.8

if self._mode == "sleeping" and is_day then
self._mode = "ascending"
self:set_animation("fly")
local dir = vector.random_direction()
dir.y = math.sin(math.rad(33))
self._direction = vector.normalize(dir)

elseif (self._mode == "ascending" or self._mode == "flying") and not is_day then
self._mode = "returning"
self:set_animation("fly")

elseif self._mode == "returning" and vector.distance(pos, self._home_pos) < 0.3 then
self.object:move_to(self._home_pos)
self._mode = "sleeping"
self:set_animation("stand")
return
end

if self._mode == "ascending" then
local move_vec = vector.multiply(self._direction, self.speed * dtime)
local new_pos  = vector.add(pos, move_vec)
if new_pos.y >= self.flight_ceiling then
new_pos.y = self.flight_ceiling
self._mode = "flying"
self._angle = math.atan2(pos.z - self._home_pos.z, pos.x - self._home_pos.x)
end
self.object:move_to(new_pos)
self.object:set_rotation(vector.dir_to_rotation(self._direction))

elseif self._mode == "flying" then
self._angle = self._angle + (self.speed * dtime / ((self.ellipse_radius_x + self.ellipse_radius_z) / 2))
local target = {
x = self._home_pos.x + math.cos(self._angle) * self.ellipse_radius_x,
y = self.flight_ceiling,
z = self._home_pos.z + math.sin(self._angle) * self.ellipse_radius_z,
}
self.object:move_to(target)
local tangent = {
x = -math.sin(self._angle) * self.ellipse_radius_x,
y = 0,
z =  math.cos(self._angle) * self.ellipse_radius_z,
}
self.object:set_rotation(vector.dir_to_rotation(tangent))

elseif self._mode == "returning" then
local dir = vector.direction(pos, self._home_pos)
local move_vec = vector.multiply(dir, self.speed * dtime)
local new_pos  = vector.add(pos, move_vec)
if vector.distance(new_pos, self._home_pos) < 0.3 then new_pos = self._home_pos end
self.object:move_to(new_pos)
self.object:set_rotation(vector.dir_to_rotation(dir))
end
end,
})


core.register_craftitem("terras_capixabas:asa_delta_spawn_egg", {
description     = "asa_delta Spawn Egg",
inventory_image = "asa_delta_inv.png",
on_place        = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos = pointed_thing.above
pos.y = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:asa_delta")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})