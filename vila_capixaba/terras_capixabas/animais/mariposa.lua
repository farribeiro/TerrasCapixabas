-- MARIPOSA -----------------------------------------------------------

core.register_entity("terras_capixabas:mariposa", {
initial_properties       = {
physical                 = false,
collide_with_objects     = false,
collisionbox             = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
visual                   = "mesh",
mesh                     = "borboleta.glb",
textures                 = {"mariposa.png"},
visual_size              = {x=1, y=1},
backface_culling         = false,
},

_animation_ranges        = {
fly                      = {x=0, y=5.9167},
},

_mode                    = "hidden",
_home_pos                = nil,

on_activate = function(self, staticdata)
local pos                = self.object:get_pos()
self._home_pos           = vector.round(pos)
self._mode               = "hidden"
self.object:set_properties({is_visible=false})
self:set_animation("fly")
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

on_step = function(self, dtime)
local tod = core.get_timeofday()
local is_night = tod < 0.23 or tod > 0.8

if is_night and self._mode == "hidden" then
self._mode = "visible"
self.object:set_properties({is_visible=true})
self:set_animation("fly")
elseif not is_night and self._mode == "visible" then
self._mode = "hidden"
self.object:set_properties({is_visible=false})
end
end,
})

core.register_craftitem("terras_capixabas:an_mariposa", {
description              = "Mariposa Spawn Egg",
inventory_image          = "mariposa_inv.png",
on_place                 = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos               = pointed_thing.above
pos.y                   = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:mariposa")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})