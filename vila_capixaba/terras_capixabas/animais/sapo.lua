-- SAPO -----------------------------------------------------------

core.register_entity("terras_capixabas:sapo", {
initial_properties = {
physical = false,
collide_with_objects = false,
collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
visual = "mesh",
mesh = "sapo.glb",
textures = {"sapo.png"},
visual_size = {x=1, y=1},
backface_culling = false,
},

_animation_ranges = {
hop = {x=0, y=11.67},
},

_mode = "hidden",
_home_pos = nil,
_chirp_timer = 0,

on_activate = function(self, staticdata)
local pos = vector.round(self.object:get_pos())
if staticdata and staticdata ~= "" then
  local data = core.deserialize(staticdata)
  if data then
    self._home_pos = data._home_pos or pos
    self._mode = data._mode or "hidden"
    self._chirp_timer = data._chirp_timer or 0
  end
end
if not self._home_pos then self._home_pos = pos end
self.object:set_properties({is_visible = (self._mode == "visible")})
self:set_animation("hop")
end,

get_staticdata = function(self)
return core.serialize({
  _home_pos = self._home_pos,
  _mode = self._mode,
  _chirp_timer = self._chirp_timer,
})
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

on_step = function(self, dtime)
local tod = core.get_timeofday()
local is_night = tod < 0.23 or tod > 0.8

self._chirp_timer = self._chirp_timer + dtime

if is_night and self._mode == "hidden" then
  self._mode = "visible"
  self.object:set_properties({is_visible=true})
  self:set_animation("hop")
elseif not is_night and self._mode == "visible" then
  self._mode = "hidden"
  self.object:set_properties({is_visible=false})
end

if self._mode == "visible" and self._chirp_timer >= 10 then
  core.sound_play("sapo", {object=self.object, gain=1, max_hear_distance=16})
  self._chirp_timer = 0
end
end,
})


core.register_craftitem("terras_capixabas:an_sapo", {
description              = "Sapo Spawn Egg",
inventory_image          = "sapo_inv.png",
on_place                 = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos               = pointed_thing.above
pos.y                   = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:sapo")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})