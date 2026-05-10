-- URUBU -----------------------------------------------------------

core.register_entity("terras_capixabas:urubu", {
initial_properties = {
physical              = false,
collide_with_objects  = false,
collisionbox          = {-0.25, -1.01, -0.25, 0.25, -0.5, 0.25},
visual                = "mesh",
mesh                  = "urubu.glb",
textures              = {"urubu.png"},
visual_size           = {x=1, y=1},
},

_animation_ranges = {
fly                   = {x=0.25, y=0.33},
stand                 = {x=0, y=0.08},
},

speed                 = 6,
flight_ceiling        = 20,
ellipse_radius_x      = 30,
ellipse_radius_z      = 15,

_mode                 = "sleeping",
_home_pos             = nil,
_direction            = nil,
_angle                = 0,
_height_progress      = 0,

on_activate = function(self, staticdata)
local pos             = self.object:get_pos()
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
self._direction       = {x=0, y=0, z=0}
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
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

on_step = function(self, dtime)
local pos    = self.object:get_pos()
local tod    = core.get_timeofday()
local is_day = tod > 0.23 and tod < 0.8

if self._mode == "sleeping" and is_day then
self._mode = "ascending"
self:set_animation("fly")
local angle_rad = math.rad(33)
local yaw = math.random() * 2 * math.pi
self._direction = {x=math.cos(yaw)*math.cos(angle_rad), y=math.sin(angle_rad), z=math.sin(yaw)*math.cos(angle_rad)}

elseif (self._mode == "ascending" or self._mode == "flying") and not is_day then
self._mode = "returning"
self:set_animation("fly")

elseif self._mode == "returning" and vector.distance(pos, self._home_pos) < 0.3 then
self.object:set_pos(self._home_pos)
self._mode = "sleeping"
self:set_animation("stand")
return
end

if self._mode == "ascending" then
local move_vec = vector.multiply(self._direction, self.speed * dtime)
local new_pos = vector.add(pos, move_vec)
if new_pos.y >= self.flight_ceiling then
new_pos.y = self.flight_ceiling
self._mode = "flying"
self._angle = math.atan2(pos.z - self._home_pos.z, pos.x - self._home_pos.x)
end
self.object:set_pos(new_pos)
self.object:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi/2)

elseif self._mode == "flying" then
self._angle = self._angle + (self.speed * dtime / ((self.ellipse_radius_x + self.ellipse_radius_z) / 2))
local target_x = self._home_pos.x + math.cos(self._angle) * self.ellipse_radius_x
local target_z = self._home_pos.z + math.sin(self._angle) * self.ellipse_radius_z
local target_y = self.flight_ceiling
self.object:set_pos({x=target_x, y=target_y, z=target_z})

local dx = -math.sin(self._angle) * self.ellipse_radius_x
local dz =  math.cos(self._angle) * self.ellipse_radius_z
self.object:set_yaw(math.atan2(dz, dx) - math.pi/2)

elseif self._mode == "returning" then
local dir_vec = vector.direction(pos, self._home_pos)
local move_vec = vector.multiply(dir_vec, self.speed * dtime)
local new_pos = vector.add(pos, move_vec)
if vector.distance(new_pos, self._home_pos) < 0.3 then new_pos = self._home_pos end
self.object:set_pos(new_pos)
self.object:set_yaw(math.atan2(dir_vec.z, dir_vec.x) - math.pi/2)
end
end,

})

core.register_craftitem("terras_capixabas:an_urubu_spawn_egg", {
description     = "Urubu Spawn Egg",
inventory_image = "urubu_inv.png",
on_place        = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos = pointed_thing.above
pos.y = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:urubu")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})