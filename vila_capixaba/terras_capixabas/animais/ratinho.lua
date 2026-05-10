-- RATINHO -----------------------------------------------------------

core.register_entity("terras_capixabas:ratinho", {
initial_properties       = {
physical                 = true,
collide_with_objects     = true,
collisionbox             = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
visual                   = "mesh",
mesh                     = "ratinho.glb",
textures                 = {"ratinho.png"},
visual_size              = {x=1, y=1},
backface_culling         = false,
stepheight               = 1.1,
},

_animation_ranges        = {
walk                     = {x=0,    y=0.5},
stand                    = {x=0.75, y=1},
},

_mode                    = "hidden",
_home_pos                = nil,
_state                   = "idle",
_target_pos              = nil,
_direction_angle         = 0,
_pause_timer             = 0,

on_activate = function(self, staticdata)
local pos = self.object:get_pos()
if staticdata and staticdata ~= "" then
local data                = core.deserialize(staticdata) or {}
self._home_pos            = data.home_pos or vector.round(pos)
self._direction_angle     = data.direction_angle or 0
self._state               = data.state or "idle"
self._target_pos          = data.target_pos
else
self._home_pos            = vector.round(pos)
self._direction_angle     = 0
self._state               = "idle"
self._target_pos          = nil
end
self._mode                = "hidden"
self._pause_timer         = 0
self._speed               = 1.5  -- fixed movement speed (blocks per second)
self.object:set_acceleration({x=0, y=0, z=0})
self.object:set_properties({is_visible=false, physical=false, collide_with_objects=false})
self:set_animation("stand")
end,

get_staticdata = function(self)
return core.serialize({
home_pos        = self._home_pos,
direction_angle = self._direction_angle,
state           = self._state,
target_pos      = self._target_pos,
})
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

pick_new_direction = function(self)
self._direction_angle = math.random() * math.pi * 2
local dx = math.cos(self._direction_angle) * 5
local dz = math.sin(self._direction_angle) * 5
self._target_pos = {
x = self._home_pos.x + dx,
y = self._home_pos.y,
z = self._home_pos.z + dz
}
self._state = "to_target"
self:set_animation("walk")
self.object:set_yaw(self._direction_angle - math.pi/2)
end,

on_step = function(self, dtime)
local tod      = core.get_timeofday()
local is_day   = tod > 0.23 and tod < 0.8

if is_day and self._mode == "hidden" then
self._mode = "visible"
self.object:set_properties({is_visible=true})
self:pick_new_direction()

elseif not is_day and self._mode == "visible" then
self._mode = "hidden"
self.object:set_properties({is_visible=false})
return
end

if self._mode == "hidden" then return end

local pos = self.object:get_pos()

if self._state == "to_target" then
local dist_to_home   = vector.distance(pos, self._home_pos)
local dist_to_target = vector.distance(pos, self._target_pos)

-- Pause halfway
if dist_to_home >= 2.5 and self._pause_timer == 0 then
self._state = "pause"
self:set_animation("stand")
self._pause_timer = 1
return
end

-- Check if reached target
if dist_to_target < 0.2 then
self._state = "returning"
local angle_back = math.atan2(self._home_pos.z - pos.z, self._home_pos.x - pos.x)
self.object:set_yaw(angle_back - math.pi/2)
self:set_animation("walk")
return
end

-- Move explicitly towards target (constant speed, no velocity)
local dir = vector.direction(pos, self._target_pos)
local move_vector = vector.multiply(dir, self._speed * dtime)
local new_pos = vector.add(pos, move_vector)
self.object:set_pos(new_pos)

elseif self._state == "pause" then
self._pause_timer = self._pause_timer - dtime
if self._pause_timer <= 0 then
self._state = "to_target"
self:set_animation("walk")
self.object:set_yaw(self._direction_angle - math.pi/2)
end

elseif self._state == "returning" then
local dist = vector.distance(pos, self._home_pos)
if dist < 0.2 then
self:pick_new_direction()
return
end
local dir = vector.direction(pos, self._home_pos)
local move_vector = vector.multiply(dir, self._speed * dtime)
local new_pos = vector.add(pos, move_vector)
self.object:set_pos(new_pos)
self.object:set_yaw(math.atan2(dir.z, dir.x) - math.pi/2)
end
end,

on_punch = function(self)
self.object:remove()
end,

})

core.register_craftitem("terras_capixabas:an_ratinho_inv", {
description              = "Ratinho Spawn Egg",
inventory_image          = "ratinho_inv.png",
on_place                 = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos               = pointed_thing.above
pos.y                   = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:ratinho")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})