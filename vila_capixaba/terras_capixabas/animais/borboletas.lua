-- BORBOLETAS -----------------------------------------------------------------------------

local function register_butterfly(name, texture, inv_image, description)

core.register_entity("terras_capixabas:" .. name, {
initial_properties = {
physical = false,
collide_with_objects = false,
collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
visual = "mesh",
mesh = "borboleta.glb",
textures = {texture},
visual_size = {x=1, y=1},
backface_culling = false,
},

_animation_ranges = {fly = {x=0, y=5.9167}},
_mode = "hidden",
_home_pos = nil,
animating = false,
check_timer = 0,

on_activate = function(self, staticdata)
local pos = self.object:get_pos()
self._home_pos = pos and vector.round(pos) or nil
self._mode = "hidden"
self.animating = false
self.check_timer = 0
self.object:set_properties({is_visible=false})
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then
self.object:set_animation({x=range.x, y=range.y}, 1, 1, true)
end
end,

on_step = function(self, dtime)
self.check_timer = self.check_timer + dtime
if self.check_timer < 0.5 then return end
self.check_timer = 0

local tod = core.get_timeofday()
local is_day = tod > 0.23 and tod < 0.8

if is_day and self._mode == "hidden" then
self._mode = "visible"
self.object:set_properties({is_visible=true})
elseif not is_day and self._mode == "visible" then
self._mode = "hidden"
self.object:set_properties({is_visible=false})
self.animating = false
self.object:set_animation({x=0,y=0},0,0,false)
return
end

if self._mode ~= "visible" then return end

local pos = self.object:get_pos()
if not pos then return end
local active = false
local r2 = 100

for _,player in ipairs(core.get_connected_players()) do
local ppos = player:get_pos()
if ppos then
local dx = pos.x - ppos.x
local dy = pos.y - ppos.y
local dz = pos.z - ppos.z
if (dx*dx + dy*dy + dz*dz) <= r2 then
active = true
break
end
end
end

if active and not self.animating then
self:set_animation("fly")
self.animating = true
elseif not active and self.animating then
self.object:set_animation({x=0,y=0},0,0,false)
self.animating = false
end
end,
})

core.register_craftitem("terras_capixabas:an_" .. name, {
description = description,
inventory_image = inv_image,
on_place = function(itemstack, placer, pointed_thing)
if pointed_thing.type ~= "node" then return itemstack end
local pos = pointed_thing.above
pos.y = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:" .. name)
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})

end


-- Register each butterfly here:
register_butterfly("borboleta_azul", "borboleta_azul.png", "borboleta_azul_inv.png", "Borboleta Azul Spawn Egg")
register_butterfly("borboleta_laranja", "borboleta_laranja.png", "borboleta_laranja_inv.png", "Borboleta Laranja Spawn Egg")
register_butterfly("lavadeira", "lavadeira.png", "lavadeira_inv.png", "Lavadeira Spawn Egg")