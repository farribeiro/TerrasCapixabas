-- PICOLETEIRO -----------------------------------------------------------

core.register_entity("terras_capixabas:picoleteiro", {
initial_properties       = {
physical                 = true,
collide_with_objects     = true,
collisionbox             = {-0.3, 0, -0.3, 0.3, 1.8, 0.3},
visual                   = "mesh",
mesh                     = "picoleteiro.glb",
textures                 = {"picoleteiro.png"},
visual_size              = {x=0.85, y=0.85},
backface_culling         = false,
},

_animation_ranges        = {
walking                  = {x=0, y=1},
},

_mode                    = "hidden",
_home_pos                = nil,
_phase                   = 1,
_z_min                   = nil,
_z_max                   = nil,
_sound_timer             = 0,
_sound_toggle            = true,

on_activate = function(self, staticdata)
local pos                = self.object:get_pos()
if staticdata and staticdata ~= "" then
local data               = core.deserialize(staticdata) or {}
self._home_pos           = data.home_pos or vector.round(pos)
self._phase              = data.phase or 1
self._z_min              = data.z_min or (self._home_pos.z - 10)
self._z_max              = data.z_max or (self._home_pos.z + 10)
else
self._home_pos           = vector.round(pos)
self._phase              = 1
self._z_min              = self._home_pos.z - 10
self._z_max              = self._home_pos.z + 10
end
self._mode               = "hidden"
self._sound_timer        = 0
self._sound_toggle       = true
self.object:set_acceleration({x=0, y=-10, z=0})
self.object:set_properties({is_visible=false})
self:set_animation("walking")
end,

get_staticdata = function(self)
return core.serialize({
home_pos = self._home_pos,
phase    = self._phase,
z_min    = self._z_min,
z_max    = self._z_max,
})
end,

set_animation = function(self, anim)
local range = self._animation_ranges[anim]
if range then self.object:set_animation({x=range.x, y=range.y}, 1, 1, true) end
end,

on_step = function(self, dtime)
local tod      = core.get_timeofday()
local is_day   = tod > 0.23 and tod < 0.8

if is_day and self._mode == "hidden" then
self._mode = "visible"
self.object:set_properties({is_visible=true})
self:set_animation("walking")
elseif not is_day and self._mode == "visible" then
self._mode = "hidden"
self.object:set_properties({is_visible=false})
self.object:set_velocity({x=0, y=0, z=0})
return
end

if self._mode == "hidden" then return end

-- Movement logic
local pos    = self.object:get_pos()
local dir    = (self._phase == 1) and 1 or -1

self.object:set_yaw((dir == 1) and 0 or math.pi)


local target_z = (dir == 1) and self._z_max or self._z_min
local dist = math.abs(pos.z - target_z)

if dist < 0.2 then
self._phase = (self._phase == 1) and 2 or 1
dir = (self._phase == 1) and 1 or -1
self.object:set_yaw((dir == 1) and math.pi/2 or -math.pi/2)
end

-- Obstacle detection and jumping
local ray_start = {x = pos.x, y = pos.y + 0.1, z = pos.z}
local ray_end   = {x = pos.x, y = pos.y + 0.1, z = pos.z + dir * 0.6}
local ray       = core.raycast(ray_start, ray_end, false, true)
local hit       = ray:next()

if hit and hit.type == "node" then
local hit_pos        = hit.under
local node_above_pos = {x = hit_pos.x, y = hit_pos.y + 1, z = hit_pos.z}
local node_above     = core.get_node(node_above_pos)

if not core.registered_nodes[node_above.name].walkable then
local vel = self.object:get_velocity()
vel.y = 5
vel.z = dir * 0.5
self.object:set_velocity(vel)
else
self.object:set_velocity({x=0, y=0, z=0})
self._phase = (self._phase == 1) and 2 or 1
dir = (self._phase == 1) and 1 or -1
self.object:set_yaw((dir == 1) and math.pi/2 or -math.pi/2)
return
end
end

-- Regular movement forward
local vel = self.object:get_velocity()
self.object:set_velocity({
x = 0,
y = vel.y,
z = dir * 1.2
})

-- Sound alternation
self._sound_timer = self._sound_timer + dtime
if self._sound_timer >= 5 then
local sound = self._sound_toggle and "picoleteiro1" or "picoleteiro2"
core.sound_play(sound, {object=self.object, gain=1, max_hear_distance=20})
self._sound_toggle = not self._sound_toggle
self._sound_timer = 0
end
end,

on_punch = function(self)
self.object:remove()
end,
})

core.register_craftitem("terras_capixabas:pe_picoleteiro", {
description              = "Picoleteiro Spawn Egg",
inventory_image          = "picoleteiro_inv.png",
on_place                 = function(itemstack, placer, pointed_thing)
if pointed_thing.type == "node" then
local pos                = pointed_thing.above
pos.y                    = pos.y + 0.5
core.add_entity(pos, "terras_capixabas:picoleteiro")
if not core.is_creative_enabled(placer:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
end
})