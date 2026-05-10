-- VAGALUME -----------------------------------------------------------

core.register_entity("terras_capixabas:vagalume", {
initial_properties = {
physical = false,
collide_with_objects = false,
collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
visual = "mesh",
mesh = "vagalume.glb",
textures = {"vagalume.png"},
visual_size = {x=1, y=1},
backface_culling = false,
glow = core.LIGHT_MAX,
},

_animation_ranges = {
glow = {x=0, y=3},
},

_mode = "hidden",
_home_pos = nil,
_target_pos = nil,

on_activate = function(self, staticdata)
local pos = vector.round(self.object:get_pos())
if staticdata and staticdata ~= "" then
  local data = core.deserialize(staticdata)
  if data then
    self._home_pos = data._home_pos or pos
    self._mode = data._mode or "hidden"
    self._target_pos = data._target_pos
  end
end
if not self._home_pos then self._home_pos = pos end
self.object:set_pos(self._home_pos)
self.object:set_properties({is_visible = (self._mode == "visible")})
self:set_animation("glow")
end,

get_staticdata = function(self)
return core.serialize({
  _home_pos = self._home_pos,
  _mode = self._mode,
  _target_pos = self._target_pos
})
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

pick_new_target = function(self)
if not self._home_pos then return end
local offset_x = math.random(-4, 4)
local offset_z = math.random(-4, 4)
local offset_y = math.random(-0.5, 0.5)
self._target_pos = {
  x = self._home_pos.x + offset_x,
  y = self._home_pos.y + offset_y,
  z = self._home_pos.z + offset_z
}
end,

on_step = function(self, dtime)
if not self._home_pos then return end

local pos = self.object:get_pos()
if vector.distance(pos, self._home_pos) > 10 then
  self.object:set_pos(self._home_pos)
  self._target_pos = nil
end

local tod = core.get_timeofday()
local is_night = tod < 0.23 or tod > 0.8

if is_night and self._mode == "hidden" then
  self._mode = "visible"
  self.object:set_properties({is_visible = true})
  self:set_animation("glow")
  self:pick_new_target()
elseif not is_night and self._mode == "visible" then
  self._mode = "hidden"
  self.object:set_properties({is_visible = false})
  self._target_pos = nil
end

if self._mode == "visible" and self._target_pos then
  local dir = vector.direction(pos, self._target_pos)
  local dist = vector.distance(pos, self._target_pos)
  local speed = 1.5
  local step = speed * dtime
  if dist < step then
    self.object:set_pos(self._target_pos)
    self:pick_new_target()
  else
    local move = vector.multiply(dir, step)
    self.object:set_pos(vector.add(pos, move))
    self.object:set_yaw(math.atan2(dir.z, dir.x) - math.pi/2)
  end
end
end,
})



core.register_craftitem("terras_capixabas:an_vagalume", {
description              = "Vagalume Spawn Egg",
inventory_image          = "vagalume_inv.png",
on_place                 = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos               = pointed_thing.above
pos.y                   = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:vagalume")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})