-- BEIJAFLOR -----------------------------------------------------------

core.register_entity("terras_capixabas:beijaflor", {
initial_properties = {
physical              = false,
collide_with_objects  = false,
collisionbox          = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
visual                = "mesh",
mesh                  = "beijaflor.glb",
textures              = {"beijaflor.png"},
visual_size           = {x=1, y=1},
backface_culling = false,
},

_animation_range = {x=0, y=11.9167},

on_activate = function(self, staticdata)
self.object:set_animation(self._animation_range, 1, 1, true)
self._visible = true
end,

on_step = function(self, dtime)
local tod = core.get_timeofday()
local is_day = tod > 0.23 and tod < 0.8

if is_day and not self._visible then
self.object:set_properties({
    visual_size = {x=1, y=1},
    collisionbox = {-0.25, -0.5, -0.25, 0.25, 0.5, 0.25},
})
self._visible = true

elseif not is_day and self._visible then
self.object:set_properties({
    visual_size = {x=0, y=0},
    collisionbox = {0, 0, 0, 0, 0, 0},
})
self._visible = false
end
end,
})

core.register_craftitem("terras_capixabas:an_beijaflor_spawn_egg", {
description     = "beijaflor Spawn Egg",
inventory_image = "beijaflor_inv.png",
on_place        = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos = pointed_thing.above
pos.y = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:beijaflor")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})
