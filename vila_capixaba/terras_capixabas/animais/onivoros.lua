local function register_chicken(name, def)

mobs:register_mob("terras_capixabas:"..name, {

type = "animal",
passive = true,

hp_min = def.hp,
hp_max = def.hp,
armor = 200,

collisionbox = def.collisionbox,
visual = "mesh",
mesh = def.mesh,
textures = {{def.texture}},

automatic_face_movement_dir = true,
makes_footstep_sound = true,

sounds = {
random = "galinha",
replace = "default_dig_crumbly",
},

walk_velocity = 1,
run_velocity = 3,
stepheight = 0.6,

stay_near = {"terras_capixabas:galinheiro", 5, 1},

drops = {},

water_damage = 1,
lava_damage = 5,
light_damage = 0,

fall_damage = 0,
fall_speed = -4,
fear_height = 5,

follow = {"farming:seed_wheat"},
view_range = 5,

animation = {
stand_start = 0,
stand_end   = 2,
stand_speed = def.anim_speed,

stand1_start = 4,
stand1_end   = 10,
stand1_speed = def.anim_speed,

walk_start = 0.42,
walk_end   = 1.13,
walk_speed = def.anim_speed,

run_start = 10,
run_end   = 36,
run_speed = def.anim_run,
},

-- 🔒 HARD CONTAINMENT WITHOUT BREAKING MOBS AI
do_custom = function(self)

local obj = self.object
local pos = obj:get_pos()
if not pos then return end

-- cache home once (safe + cheap)
if not self._home then
self._home = core.find_node_near(pos, 5, {"terras_capixabas:galinheiro"})
end
if not self._home then return end

-- horizontal distance squared (NO sqrt = faster)
local dx = pos.x - self._home.x
local dz = pos.z - self._home.z
local dist2 = dx*dx + dz*dz

-- outside allowed radius
if dist2 > (5.2 * 5.2) then
local dir = vector.direction(pos, self._home)
local vel = obj:get_velocity()

obj:set_velocity({
x = dir.x * self.walk_velocity * 1.5,
y = vel.y, -- preserve gravity / jumps
z = dir.z * self.walk_velocity * 1.5,
})
end

end,
})

mobs:register_egg(
"terras_capixabas:"..name,
def.egg_name,
def.egg_tex,
0
)

end

register_chicken("galinha", {
hp = 5,
mesh = "galinha.glb",
texture = "galinha.png",
collisionbox = {-0.3,-0.75,-0.3,0.3,0.1,0.3},
anim_speed = 1,
anim_run = 1,
egg_name = "Galinha",
egg_tex = "galinha_inv.png"
})

register_chicken("galo", {
hp = 5,
mesh = "galo.glb",
texture = "galo.png",
collisionbox = {-0.3,-0.75,-0.3,0.3,0.1,0.3},
anim_speed = 1,
anim_run = 1,
egg_name = "Galo",
egg_tex = "galo_inv.png"
})

register_chicken("pintinho", {
hp = 3,
mesh = "pintinho.glb",
texture = "pintinho.png",
collisionbox = {-0.15,-0.4,-0.15,0.15,0.1,0.15},
anim_speed = 1,
anim_run = 1,
egg_name = "Pintinho",
egg_tex = "pintinho_inv.png"
})
