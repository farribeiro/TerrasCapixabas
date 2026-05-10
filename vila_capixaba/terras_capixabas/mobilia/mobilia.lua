local lay_behavior = dofile(core.get_modpath("terras_capixabas") .. "/npcs/behaviors/lay_behavior.lua")
local sit_behavior = dofile(core.get_modpath("terras_capixabas") .. "/npcs/behaviors/sit_behavior.lua")

if lay_behavior and lay_behavior.globalstep then
    core.register_globalstep(lay_behavior.globalstep)
end
if sit_behavior and sit_behavior.globalstep then
    core.register_globalstep(sit_behavior.globalstep)
end



-- MOBILIA -----------------------------------------------------------------

core.register_node("terras_capixabas:camera_seguranca_parede", {
    description = "Câmera de Segurança Parede",
    tiles = {"camera_seguranca.png"},
    drawtype = "mesh",
    mesh = "camera_seguranca_parede.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:camera_seguranca_teto", {
    description = "Câmera de Segurança Teto",
    tiles = {"camera_seguranca.png"},
    drawtype = "mesh",
    mesh = "camera_seguranca_teto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:ac_esteira_eletrica", {
    description = "Esteira Elétrica",
    tiles = {"ac_esteira_eletrica.png"},
    drawtype = "mesh",
    mesh = "ac_esteira_eletrica.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:ac_petchuga", {
    description = "Petchuga",
    tiles = {"ac_petchuga.png"},
    drawtype = "mesh",
    mesh = "ac_petchuga.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:ac_peso_livre", {
    description = "Peso Livre",
    tiles = {"ac_peso_livre.png"},
    drawtype = "mesh",
    mesh = "ac_peso_livre.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:ac_supino", {
    description = "Supino",
    tiles = {"ac_supino.png"},
    drawtype = "mesh",
    mesh = "ac_supino.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:ac_triceps", {
    description = "Triceps",
    tiles = {"ac_triceps.png"},
    drawtype = "mesh",
    mesh = "ac_triceps.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- --------------------------------------------
core.register_node("terras_capixabas:antena", {
    description = "Antena",
    tiles = {"antena.png"},
    drawtype = "mesh",
    mesh = "antena.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:antena_parabolica", {
    description = "Antena Parabolica",
    tiles = {"antena_parabolica.png"},
    drawtype = "mesh",
    mesh = "antena_parabolica.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- Carrinho de Hot Dog

core.register_node("terras_capixabas:carrinho_hotdog", {
    description = "Carrinho de Hot Dog",
    tiles = {"carrinho_hotdog.png"},
    drawtype = "mesh",
    mesh = "carrinho_hotdog.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local dir = core.facedir_to_dir(node.param2)
        local drop_pos = {
            x = pos.x - dir.x * 0.9,
            y = pos.y + 0.2,
            z = pos.z - dir.z * 0.9
        }

        core.add_item(drop_pos, "terras_capixabas:alm_cachorro_quente")

        core.sound_play("plop", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0
        })
    end
})



-- Carrinho de Milho

core.register_node("terras_capixabas:carrinho_milho", {
    description = "Carrinho de Milho",
    tiles = {"carrinho_milho.png"},
    drawtype = "mesh",
    mesh = "carrinho_milho.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local dir = core.facedir_to_dir(node.param2)
        local drop_pos = {
            x = pos.x - dir.x * 0.9,
            y = pos.y + 0.2,
            z = pos.z - dir.z * 0.9
        }

        core.add_item(drop_pos, "terras_capixabas:alm_milho")

        core.sound_play("plop", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0
        })
    end
})



-- Pula Pula trampoline (reliable mesh bounce)

local bounce_strength = 12
local last_bounce = {}

core.register_node("terras_capixabas:pula_pula", {
    description = "Pula Pula",
    tiles = {"pula_pula.png"},
    drawtype = "mesh",
    mesh = "pula_pula.obj",
    paramtype = "light",
    paramtype2 = "facedir",

    groups = {cracky = 3, oddly_breakable_by_hand = 2},

    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = true,

    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.1, 0.5}
    },

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- Bounce logic
core.register_globalstep(function(dtime)
    for _, player in ipairs(core.get_connected_players()) do
        local vel = player:get_velocity()
        
        -- Only trigger if falling
        if vel.y >= 0 then goto continue end

        local pos = player:get_pos()
        local name = player:get_player_name()
        
        -- WIDENED COLLISION SCAN
        local found_node = false
        local bounce_pos = nil
        local radius = 1 

        for dx = -radius, radius do
            for dz = -radius, radius do
                local check_pos = {
                    x = math.floor(pos.x + dx + 0.5), 
                    y = math.floor(pos.y - 0.5), 
                    z = math.floor(pos.z + dz + 0.5)
                }
                
                local node = core.get_node(check_pos)
                if node.name == "terras_capixabas:pula_pula" then
                    found_node = true
                    bounce_pos = check_pos
                    break
                end
            end
            if found_node then break end
        end

        if not found_node then goto continue end

        -- COOLDOWN
        local t = core.get_us_time()
        if last_bounce[name] and t - last_bounce[name] < 200000 then goto continue end
        last_bounce[name] = t

        -- CONSISTENT IMPULSE
        player:add_velocity({x = 0, y = -vel.y + bounce_strength, z = 0})

        -- PLAY BOUNCE SOUND
        -- Luanti looks for "bounce.ogg" in your mod's /sounds folder
        core.sound_play("bounce", {
            pos = bounce_pos,
            gain = 0.8,
            max_hear_distance = 15,
            ephemeral = true, -- Sound stops if the player/object is removed
        })

        -- PARTICLES
        core.add_particlespawner({
            amount = 15,
            time = 0.05,
            minpos = {x = bounce_pos.x-0.7, y = bounce_pos.y+0.5, z = bounce_pos.z-0.7},
            maxpos = {x = bounce_pos.x+0.7, y = bounce_pos.y+0.5, z = bounce_pos.z+0.7},
            minvel = {x = -0.8, y = 2, z = -0.8},
            maxvel = {x = 0.8, y = 4, z = 0.8},
            minexptime = 0.4,
            maxexptime = 0.7,
            minsize = 0.5,
            maxsize = 1.0,
            collisiondetection = false,
            texture = "pula_pula_particle.png"
        })

        ::continue::
    end
end)





-- Enxada
core.register_node("terras_capixabas:enxada", {
    description = "Enxada",
    tiles = {"enxada.png"},
    drawtype = "mesh",
    mesh = "enxada.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5} }
})

-- Pá
core.register_node("terras_capixabas:pa", {
    description = "Pá",
    tiles = {"pa.png"},
    drawtype = "mesh",
    mesh = "pa.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5} }
})

-- Rastelo
core.register_node("terras_capixabas:rastelo", {
    description = "Rastelo",
    tiles = {"rastelo.png"},
    drawtype = "mesh",
    mesh = "rastelo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5} }
})

-- Carrinho de mão
core.register_node("terras_capixabas:carrinho_mao", {
    description = "Carrinho de Mão",
    tiles = {"carrinho_mao.png"},
    drawtype = "mesh",
    mesh = "carrinho_mao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5} }
})

-- Galinheiro
core.register_node("terras_capixabas:galinheiro", {
    description = "Galinheiro",
    tiles = {"galinheiro.png"},
    drawtype = "mesh",
    mesh = "galinheiro.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = { type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5} }
})


core.register_node("terras_capixabas:tapete_antigo", {
    description = "tapete_antigo",
    tiles = {"tapete_antigo.png"},
    drawtype = "mesh",
    mesh = "tapete_grande.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
    }
})

core.register_node("terras_capixabas:tapete_colorido", {
    description = "tapete_colorido",
    tiles = {"tapete_colorido.png"},
    drawtype = "mesh",
    mesh = "tapete_grande.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.3, 0.5}
    }
})

-- --------------------------------------------------------

core.register_entity("terras_capixabas:clube_globo2",{
visual="mesh",
mesh="clube_globo2.glb",
visual_size={x=1,y=1},
textures={"clube_globo2.png"},
physical=true,
collide_with_objects=true,
collisionbox={-0.4,-0.4,-0.4,0.4,0.4,0.4},
pointable=true,
static_save=true,

hits=0,
animating=false,
check_timer=0,

on_activate=function(self)
self.hits=0
self.animating=false
self.check_timer=0
end,

on_step=function(self,dtime)
self.check_timer=self.check_timer+dtime
if self.check_timer<0.5 then return end
self.check_timer=0

local pos=self.object:get_pos()
if not pos then return end
local active=false
local r2=100

for _,player in ipairs(core.get_connected_players()) do
local ppos=player:get_pos()
if ppos then
local dx=pos.x-ppos.x
local dy=pos.y-ppos.y
local dz=pos.z-ppos.z
if (dx*dx+dy*dy+dz*dz)<=r2 then
active=true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x=0,y=90},1,0,true)
self.animating=true
elseif not active and self.animating then
self.object:set_animation({x=0,y=0},0,0,false)
self.animating=false
end
end,

on_punch=function(self,puncher)
self.hits=self.hits+1
if self.hits>=2 then
self.object:remove()
end
end
})


-- Spawn egg
core.register_craftitem("terras_capixabas:clube_globo2_egg",{
description="Clube Globo 2",
inventory_image="clube_globo2_inv.png",
on_place=function(itemstack,user,pointed_thing)
if pointed_thing.type~="node" then return itemstack end
local pos=pointed_thing.above
core.add_entity(pos,"terras_capixabas:clube_globo2")
if not core.is_creative_enabled(user:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})

-- ---------------------------------------------------------

core.register_entity("terras_capixabas:clube_holofote2",{
visual="mesh",
mesh="clube_holofote2.glb",
visual_size={x=1,y=1},
textures={"clube_holofote2.png"},
use_texture_alpha=true,
backface_culling=false,
physical=true,
collide_with_objects=true,
collisionbox={-0.4,-0.4,-0.4,0.4,0.4,0.4},
pointable=true,
static_save=true,

hits=0,
animating=false,
check_timer=0,

on_activate=function(self)
self.hits=0
self.animating=false
self.check_timer=0
end,

on_step=function(self,dtime)
self.check_timer=self.check_timer+dtime
if self.check_timer<0.5 then return end
self.check_timer=0

local pos=self.object:get_pos()
if not pos then return end
local active=false
local r2=100

for _,player in ipairs(core.get_connected_players()) do
local ppos=player:get_pos()
if ppos then
local dx=pos.x-ppos.x
local dy=pos.y-ppos.y
local dz=pos.z-ppos.z
if (dx*dx+dy*dy+dz*dz)<=r2 then
active=true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x=0,y=60},1,0,true)
self.animating=true
elseif not active and self.animating then
self.object:set_animation({x=0,y=0},0,0,false)
self.animating=false
end
end,

on_punch=function(self,puncher)
self.hits=self.hits+1
if self.hits>=2 then
self.object:remove()
end
end
})

-- Spawn egg
core.register_craftitem("terras_capixabas:clube_holofote2_egg",{
description="Clube Holofote 2",
inventory_image="clube_holofote2_inv.png",
on_place=function(itemstack,user,pointed_thing)
if pointed_thing.type~="node" then return itemstack end
local pos=pointed_thing.above
core.add_entity(pos,"terras_capixabas:clube_holofote2")
if not core.is_creative_enabled(user:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})

-- ---------------------------------------------

core.register_entity("terras_capixabas:clube_laser2",{
visual="mesh",
mesh="clube_laser2.glb",
visual_size={x=1,y=1},
textures={"clube_laser2.png"},
use_texture_alpha=true,
backface_culling=false,
physical=true,
collide_with_objects=true,
collisionbox={-0.4,-0.4,-0.4,0.4,0.4,0.4},
pointable=true,
static_save=true,

hits=0,
animating=false,
check_timer=0,

on_activate=function(self)
self.hits=0
self.animating=false
self.check_timer=0
end,

on_step=function(self,dtime)
self.check_timer=self.check_timer+dtime
if self.check_timer<0.5 then return end
self.check_timer=0

local pos=self.object:get_pos()
if not pos then return end
local active=false
local r2=100

for _,player in ipairs(core.get_connected_players()) do
local ppos=player:get_pos()
if ppos then
local dx=pos.x-ppos.x
local dy=pos.y-ppos.y
local dz=pos.z-ppos.z
if (dx*dx+dy*dy+dz*dz)<=r2 then
active=true
break
end
end
end

if active and not self.animating then
self.object:set_animation({x=0,y=60},1,0,true)
self.animating=true
elseif not active and self.animating then
self.object:set_animation({x=0,y=0},0,0,false)
self.animating=false
end
end,

on_punch=function(self,puncher)
self.hits=self.hits+1
if self.hits>=2 then
self.object:remove()
end
end
})


-- Spawn egg
core.register_craftitem("terras_capixabas:clube_laser2_egg",{
description="Clube laser 2",
inventory_image="clube_laser2_inv.png",
on_place=function(itemstack,user,pointed_thing)
if pointed_thing.type~="node" then return itemstack end
local pos=pointed_thing.above
core.add_entity(pos,"terras_capixabas:clube_laser2")
if not core.is_creative_enabled(user:get_player_name()) then
itemstack:take_item()
end
return itemstack
end
})

-- --------------------------------------------------

core.register_node("terras_capixabas:clube_jukebox", {
description = "clube_jukebox",
drawtype = "mesh",
mesh = "clube_jukebox.obj",
tiles = {"clube_jukebox.png"},
paramtype = "light",
paramtype2 = "facedir",
backface_culling = true,
groups = {dig_immediate = 3},
selection_box = {type = "fixed",fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},
collision_box = {type = "fixed",fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}},

on_construct = function(pos)
local meta = core.get_meta(pos)
meta:set_int("step",0)
meta:set_int("sound_handle",0)
end,

on_rightclick = function(pos,node,clicker,itemstack,pointed_thing)
local meta = core.get_meta(pos)
local step = meta:get_int("step")
local handle = meta:get_int("sound_handle")

if handle ~= 0 then core.sound_stop(handle) end

step = step + 1
if step > 4 then step = 0 end
meta:set_int("step",step)

local sound = nil
if step == 1 then sound = "aerosol_of_my_love" end
if step == 2 then sound = "92bpm" end
if step == 3 then sound = "95bpm" end
if step == 4 then sound = "100bpm" end

if sound then
handle = core.sound_play(sound,{pos = pos,gain = 1.0,max_hear_distance = 15,loop = true})
meta:set_int("sound_handle",handle or 0)
else
meta:set_int("sound_handle",0)
end
end
})


core.register_node("terras_capixabas:cortina_vedante", {
    description = "cortina_vedante",
    tiles = {"cano_laje.png"},
    drawtype = "mesh",
    mesh = "cortina_vedante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- Fogão (Off)
core.register_node("terras_capixabas:fogao", {
    description = "Fogão",
    tiles = {"fogao.png"},
    drawtype = "mesh",
    mesh = "fogao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "blend",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.set_node(pos, {name = "terras_capixabas:fogao_on", param2 = node.param2})
        core.sound_play("abrir_aco", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})

-- FOGÃO on

local cooking_sessions = {}

local recipes = {
{inpt={"arroz","feijao"},out="arroz_com_feijao"},
{inpt={"batata"},out="batata_frita"},
{inpt={"camarao"},out="churrasquim_camarao"},
{inpt={"feijao","farinha","ovo"},out="feijao_tropeiro"},
{inpt={"feijao","carne_porco"},out="feijoada"},
{inpt={"pao","salsicha"},out="cachorro_quente"},
{inpt={"peixe","oleo","tempero_verde"},out="moqueca_capixaba"},
{inpt={"peixe","oleo","tomate"},out="peroa_frito"},
{inpt={"ovo"},out="ovo_frito"},
{inpt={"caranguejo_vivo"},out="pua_de_caranguejo"},
{inpt={"peixe","oleo","batata"},out="torta_de_bacalhau"},
{inpt={"macarrao","agua","tomate"},out="macarronada"},
}

-- strips "terras_capixabas:alm_" → "arroz"
local function normalize(name)
if name=="" then return "" end
name=name:match(":(.+)$") or name
return name:gsub("^alm_","")
end

local function same_items(a,b)
if #a~=#b then return false end
local t={}
for _,i in ipairs(a) do t[i]=(t[i] or 0)+1 end
for _,i in ipairs(b) do
if not t[i] then return false end
t[i]=t[i]-1
if t[i]<0 then return false end
end
return true
end

local function get_recipe(list)
local items={}
for _,s in ipairs(list) do
local n=normalize(s)
if n~="" then items[#items+1]=n end
end
for _,r in ipairs(recipes) do
if same_items(items,r.inpt) then return r.out end
end
end

local function formspec(sec)
local esc=sec and "false" or "true"
local label=sec and "Cozinhando: "..sec or "Comida"
return "formspec_version[4]size[8,8]"
.."list[current_player;main;0,4.5;8,3;]"
.."list[detached:cook;ing;2.5,0.6;3,1;]"
.."button[2.5,1.9;3,0.8;cozinhar;Cozinhar]"
.."label[3.2,2.9;"..label.."]"
.."list[detached:cook;out;3.5,3.3;1,1;]"
.."set_escape["..esc.."]"
end

core.register_node("terras_capixabas:fogao_on",{
description="Fogão (On)",
tiles={"fogao_on.png"},
drawtype="mesh",
mesh="fogao_on.obj",
paramtype="light",
paramtype2="facedir",
groups={snappy=3,flammable=2,not_in_creative_inventory=1},
walkable=true,
use_texture_alpha="blend",
backface_culling=true,

on_rightclick=function(pos,node,clicker)
local name=clicker:get_player_name()
if not core.get_inventory({type="detached",name="cook"}) then
local inv=core.create_detached_inventory("cook",{
allow_put=function(_,_,_,stack) return stack:get_count() end,
allow_take=function(_,_,_,stack) return stack:get_count() end,
allow_move=function(_,_,_,_,_,count) return count end,
})
inv:set_size("ing",3)
inv:set_size("out",1)
end
cooking_sessions[name]={pos=pos,active=true}
core.show_formspec(name,"terras_capixabas:cook",formspec(nil))
end,
})

core.register_on_player_receive_fields(function(player,form,fields)
if form~="terras_capixabas:cook" then return end
local name=player:get_player_name()
local session=cooking_sessions[name]
if not session then return end

if fields.quit then
local pos=session.pos
if pos and core.get_node(pos).name=="terras_capixabas:fogao_on" then
core.swap_node(pos,{name="terras_capixabas:fogao",param2=core.get_node(pos).param2})
end
cooking_sessions[name]=nil
return
end

if not fields.cozinhar or not session.active then return end
session.active=false

local inv=core.get_inventory({type="detached",name="cook"})
local list={}
for i=1,3 do list[i]=inv:get_stack("ing",i):get_name() end

local result=get_recipe(list)
if not result then session.active=true return end

inv:set_list("out",{})

local function tick(t)
if t>0 then
core.show_formspec(name,"terras_capixabas:cook",formspec(t))
core.after(1,function() tick(t-1) end)
else
inv:set_list("ing",{})
inv:set_stack("out",1,ItemStack("terras_capixabas:alm_"..result))
core.show_formspec(name,"terras_capixabas:cook",formspec(nil))
end
end

tick(3)
end)

core.register_node("terras_capixabas:fogao_opened",{
description="fogao (Opened)",
drawtype="mesh",
mesh="fogao_opened.obj",
tiles={"fogao.png"},
use_texture_alpha="blend",
backface_culling=false,
paramtype="light",
paramtype2="facedir",
groups={dig_immediate=3,not_in_creative_inventory=1},
on_rightclick=function(pos,node)
core.sound_play("abrir_aco",{pos=pos,gain=1.0,max_hear_distance=10})
core.swap_node(pos,{name="terras_capixabas:fogao_closed",param2=node.param2})
end,
})




-- --------------------------------------

-- Fogão à Lenha (Off)
core.register_node("terras_capixabas:fogao_lenha", {
description="Fogão à Lenha",
tiles={"fogao_lenha.png"},
drawtype="mesh",
mesh="fogao_lenha.obj",
paramtype="light",
paramtype2="facedir",
groups={snappy=3,flammable=2},
walkable=true,
use_texture_alpha="blend",
backface_culling=true,

selection_box={type="fixed",fixed={-0.5,-0.5,-0.5,0.5,0.5,0.5}},
collision_box={type="fixed",fixed={-0.5,-0.5,-0.5,0.5,0.5,0.5}},

on_rightclick=function(pos,node)
core.sound_play("acende",{pos=pos,gain=1.0,max_hear_distance=10})

core.swap_node(pos,{name="terras_capixabas:fogao_lenha_on",param2=node.param2})

local meta=core.get_meta(pos)
local handle=core.sound_play("fogo",{
pos=pos,
gain=1.0,
loop=true,
max_hear_distance=12
})
meta:set_int("fogo_handle",handle or 0)
end,
})

-- ===================================================================

local cooking_sessions={}

local recipes={
{inpt={"arroz","feijao"},out="arroz_com_feijao"},
{inpt={"batata"},out="batata_frita"},
{inpt={"camarao"},out="churrasquim_camarao"},
{inpt={"feijao","farinha","ovo"},out="feijao_tropeiro"},
{inpt={"feijao","carne_porco"},out="feijoada"},
{inpt={"pao","salsicha"},out="cachorro_quente"},
{inpt={"peixe","oleo","tempero_verde"},out="moqueca_capixaba"},
{inpt={"peixe","oleo","tomate"},out="peroa_frito"},
{inpt={"ovo"},out="ovo_frito"},
{inpt={"caranguejo_vivo"},out="pua_de_caranguejo"},
{inpt={"peixe","oleo","batata"},out="torta_de_bacalhau"},
{inpt={"macarrao","agua","tomate"},out="macarronada"},
}

local function normalize(name)
if name=="" then return "" end
name=name:match(":(.+)$") or name
return name:gsub("^alm_","")
end

local function same_items(a,b)
if #a~=#b then return false end
local t={}
for _,i in ipairs(a) do t[i]=(t[i] or 0)+1 end
for _,i in ipairs(b) do
if not t[i] then return false end
t[i]=t[i]-1
if t[i]<0 then return false end
end
return true
end

local function get_recipe(list)
local items={}
for _,s in ipairs(list) do
local n=normalize(s)
if n~="" then items[#items+1]=n end
end
for _,r in ipairs(recipes) do
if same_items(items,r.inpt) then return r.out end
end
end

local function formspec(sec)
local esc=sec and "false" or "true"
local label=sec and "Cozinhando: "..sec or "Comida"
return "formspec_version[4]size[8,8]"
.."list[current_player;main;0,4.5;8,3;]"
.."list[detached:cook;ing;2.5,0.6;3,1;]"
.."button[2.5,1.9;3,0.8;cozinhar;Cozinhar]"
.."label[3.2,2.9;"..label.."]"
.."list[detached:cook;out;3.5,3.3;1,1;]"
.."set_escape["..esc.."]"
end

core.register_node("terras_capixabas:fogao_lenha_on",{
description="Fogão à Lenha (On)",
tiles={"fogao_lenha_on.png"},
drawtype="mesh",
mesh="fogao_lenha_on.obj",
paramtype="light",
paramtype2="facedir",
groups={snappy=3,flammable=2,not_in_creative_inventory=1},
walkable=true,
use_texture_alpha="blend",
backface_culling=true,

on_rightclick=function(pos,node,clicker)
local name=clicker:get_player_name()

if not core.get_inventory({type="detached",name="cook"}) then
local inv=core.create_detached_inventory("cook",{
allow_put=function(_,_,_,stack) return stack:get_count() end,
allow_take=function(_,_,_,stack) return stack:get_count() end,
allow_move=function(_,_,_,_,_,count) return count end,
})
inv:set_size("ing",3)
inv:set_size("out",1)
end

local cook_sound=core.sound_play("cozinhar_lenha",{
pos=pos,
gain=1.0,
loop=true,
max_hear_distance=12
})

cooking_sessions[name]={pos=pos,active=true,sound=cook_sound}
core.show_formspec(name,"terras_capixabas:cook",formspec(nil))
end,
})

core.register_on_player_receive_fields(function(player,form,fields)
if form~="terras_capixabas:cook" then return end
local name=player:get_player_name()
local session=cooking_sessions[name]
if not session then return end

local pos=session.pos
local meta=core.get_meta(pos)

if fields.quit then
if session.sound then core.sound_stop(session.sound) end

local h=meta:get_int("fogo_handle")
if h~=0 then
core.sound_stop(h)
meta:set_int("fogo_handle",0)
end

core.swap_node(pos,{
name="terras_capixabas:fogao_lenha",
param2=core.get_node(pos).param2
})

cooking_sessions[name]=nil
return
end

if not fields.cozinhar or not session.active then return end
session.active=false

local inv=core.get_inventory({type="detached",name="cook"})
local list={}
for i=1,3 do list[i]=inv:get_stack("ing",i):get_name() end

local result=get_recipe(list)
if not result then session.active=true return end

inv:set_list("out",{})

local function tick(t)
if t>0 then
core.show_formspec(name,"terras_capixabas:cook",formspec(t))
core.after(1,function() tick(t-1) end)
else
if session.sound then core.sound_stop(session.sound) end

local h=meta:get_int("fogo_handle")
if h~=0 then
core.sound_stop(h)
meta:set_int("fogo_handle",0)
end

inv:set_list("ing",{})
inv:set_stack("out",1,ItemStack("terras_capixabas:alm_"..result))
core.show_formspec(name,"terras_capixabas:cook",formspec(nil))
end
end

tick(3)
end)

-- --------------------------------------------

-- Register the closed freezer node
core.register_node("terras_capixabas:freezer_closed", {
    description = "Freezer (Closed)",
    drawtype = "mesh",
    mesh = "freezer_closed.obj",
    tiles = {"freezer.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}
    },
    
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Open freezer and play sound
        core.sound_play("abrir_aco", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:freezer_opened", param2 = node.param2})
        
        -- Initialize inventory if not exists
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        if inv:get_size("freezer") == 0 then
            inv:set_size("freezer", 8) -- 8 storage slots
        end

        -- Show GUI
        core.show_formspec(clicker:get_player_name(), "terras_capixabas:freezer",
            "size[8,9]" ..
            "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";freezer;0,0.5;8,1;]" ..
            "list[current_player;main;0,2;8,4;]" ..
            "listring[]"
        )
    end,
})

-- Register the opened freezer node
core.register_node("terras_capixabas:freezer_opened", {
    description = "Freezer (Opened)",
    drawtype = "mesh",
    mesh = "freezer_opened.obj",
    tiles = {"freezer.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 1.5, 0.5, 0.5}
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Close freezer and play sound
        core.sound_play("abrir_aco", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:freezer_closed", param2 = node.param2})
        core.close_formspec(clicker:get_player_name(), "terras_capixabas:freezer")
    end,
})

-- Register the closed geladeira node
core.register_node("terras_capixabas:geladeira_closed", {
    description = "Geladeira",
    drawtype = "mesh",
    mesh = "geladeira_closed.obj",
    tiles = {"geladeira.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local player_name = clicker:get_player_name()

        -- 1. Open visually
        core.swap_node(pos, {name = "terras_capixabas:geladeira_opened", param2 = node.param2})
        
        -- 2. Sound
        core.sound_play("abrir_aco", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        
        -- 3. Inventory setup
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        if inv:get_size("geladeira_inv") == 0 then
            inv:set_size("geladeira_inv", 4) 
        end

        -- 4. Show GUI
        core.show_formspec(player_name, "terras_capixabas:geladeira_gui",
            "size[8,7]" ..
            "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";geladeira_inv;2,0.5;4,1;]" ..
            "list[current_player;main;0,2;8,4;]" ..
            "listring[]"
        )
    end,
})

-- Register the opened geladeira node
core.register_node("terras_capixabas:geladeira_opened", {
    description = "Geladeira (Opened)",
    drawtype = "mesh",
    mesh = "geladeira_opened.obj",
    tiles = {"geladeira.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Close door and play sound
        core.sound_play("abrir_aco", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:geladeira_closed", param2 = node.param2})
        
        -- Close the specific GUI
        core.close_formspec(clicker:get_player_name(), "terras_capixabas:geladeira_gui")
    end,
})

-- Register the closed janela node
core.register_node("terras_capixabas:janela_closed", {
    description = "janela (Closed)",
    drawtype = "mesh",
    mesh = "janela_closed.obj",
    tiles = {"janela.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("janela", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:janela_opened", param2 = node.param2})
    end,
})

-- Register the opened janela node
core.register_node("terras_capixabas:janela_opened", {
    description = "janela (Opened)",
    drawtype = "mesh",
    mesh = "janela_opened.obj",
    tiles = {"janela.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("janela", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:janela_closed", param2 = node.param2})
    end,
})

-- ------------------------------------------

-- Register the closed janela_branca node
core.register_node("terras_capixabas:janela_branca_closed", {
    description = "janela_branca (Closed)",
    drawtype = "mesh",
    mesh = "janela_closed.obj",
    tiles = {"janela_branca.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("janela", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:janela_branca_opened", param2 = node.param2})
    end,
})

-- Register the opened janela_branca node
core.register_node("terras_capixabas:janela_branca_opened", {
    description = "janela_branca (Opened)",
    drawtype = "mesh",
    mesh = "janela_opened.obj",
    tiles = {"janela_branca.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("janela", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:janela_branca_closed", param2 = node.param2})
    end,
})

-- -------------------------------------------

-- Register the closed janela_colonial node
core.register_node("terras_capixabas:janela_colonial_closed", {
    description = "janela_colonial (Closed)",
    drawtype = "mesh",
    mesh = "janela_closed.obj",
    tiles = {"janela_colonial.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("janela", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:janela_colonial_opened", param2 = node.param2})
    end,
})

-- Register the opened janela_colonial node
core.register_node("terras_capixabas:janela_colonial_opened", {
    description = "janela_colonial (Opened)",
    drawtype = "mesh",
    mesh = "janela_opened.obj",
    tiles = {"janela_colonial.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.125, 1.0, 0.5, 0.125},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("janela", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:janela_colonial_closed", param2 = node.param2})
    end,
})

-- ------------------------------------------

core.register_node("terras_capixabas:janela_colonial_1x2", {
    description = "Arcade 1",
    tiles = {"janela_colonial_1x2.png"},
    drawtype = "mesh",
    mesh = "janela_colonial_1x2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "blend",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- -------------------------------------------

-- Register the closed armario node
core.register_node("terras_capixabas:armario_closed", {
    description = "Armario",
    drawtype = "mesh",
    mesh = "armario_closed.obj",
    tiles = {"armario.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.0625, 1.25, 1.9375, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.0625, 1.25, 1.9375, 0.5}
    },
    
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local player_name = clicker:get_player_name()

        -- 1. Open door visually
        core.swap_node(pos, {name = "terras_capixabas:armario_opened", param2 = node.param2})
        
        -- 2. Play Sound
        core.sound_play("door_open", {pos = pos, gain = 1.0, max_hear_distance = 10})
        
        -- 3. Setup Inventory
        local meta = core.get_meta(pos)
        local inv = meta:get_inventory()
        if inv:get_size("storage") == 0 then
            inv:set_size("storage", 8) 
        end

        -- 4. Show GUI (Formname must match the close call)
        core.show_formspec(player_name, "terras_capixabas:armario_gui",
            "size[8,9]" ..
            "list[nodemeta:"..pos.x..","..pos.y..","..pos.z..";storage;0,0.5;8,1;]" ..
            "list[current_player;main;0,2;8,4;]" ..
            "listring[]"
        )
    end,
})

-- Register the opened armario node
core.register_node("terras_capixabas:armario_opened", {
    description = "Armario (Opened)",
    drawtype = "mesh",
    mesh = "armario_opened.obj",
    tiles = {"armario.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.0625, 1.25, 1.9375, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.25, -0.5, -0.0625, 1.25, 1.9375, 0.5}
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- 1. Close door visually
        core.swap_node(pos, {name = "terras_capixabas:armario_closed", param2 = node.param2})
        
        -- 2. Play Sound
        core.sound_play("door_open", {pos = pos, gain = 1.0, max_hear_distance = 10})
        
        -- 3. Force close the specific GUI if it's still open
        core.close_formspec(clicker:get_player_name(), "terras_capixabas:armario_gui")
    end,
})

-- --------------

core.register_node("terras_capixabas:vidro_ext3x1", {
    description = "vidro_ext3x1",
    tiles = {"vidro_ext3x1.png"},
    drawtype = "mesh",
    mesh = "vidro_ext3x1.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

core.register_node("terras_capixabas:vidro_ext3x2", {
    description = "vidro_ext3x2",
    tiles = {"vidro_ext3x2.png"},
    drawtype = "mesh",
    mesh = "vidro_ext3x2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

core.register_node("terras_capixabas:vidro_ext5x1", {
    description = "vidro_ext5x1",
    tiles = {"vidro_ext5x1.png"},
    drawtype = "mesh",
    mesh = "vidro_ext5x1.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

core.register_node("terras_capixabas:vidro2x2_porta", {
    description = "vidro2x2_porta",
    tiles = {"vidro2x2_porta.png"},
    drawtype = "mesh",
    mesh = "vidro2x2_porta.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

core.register_node("terras_capixabas:vidro2x3_porta", {
    description = "vidro2x3_porta",
    tiles = {"vidro2x3_porta.png"},
    drawtype = "mesh",
    mesh = "vidro2x3_porta.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

-- AR CONDICIONADO COM TEXTURA ANIMADA:
core.register_node("terras_capixabas:ar_condicionado", {
    description = "Ar Condicionado",
    drawtype = "mesh",
    mesh = "ar_condicionado.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {{
        name = "ar_condicionado.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,  -- Width of each frame in pixels
            aspect_h = 16,  -- Height of each frame in pixels
            length = 0.25    -- Total time to cycle through both frames
        }
    }},
    groups = {cracky = 3, oddly_breakable_by_hand = 2, ar_condicionado = 1},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },
})

-- ---------------------------------------------------------

-- MÁQUINA DE LAVAR (OFF)
core.register_node("terras_capixabas:maquina_lavar", {
    description = "Máquina de Lavar",
    drawtype = "mesh",
    mesh = "maquina_lavar.obj",
    tiles = {"maquina_lavar.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    walkable = true,

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    on_rightclick = function(pos, node, clicker)
        -- 1. Swap to the ON state
        core.swap_node(pos, {name = "terras_capixabas:maquina_lavar_on", param2 = node.param2})
        
        -- 2. Play Looping Sound and store the handle in Metadata
        local handle = core.sound_play("maquina_lavar", {
            pos = pos,
            max_hear_distance = 10,
            gain = 1.0,
            loop = true
        })
        
        local meta = core.get_meta(pos)
        meta:set_int("sound_handle", handle or 0)
    end
})

-- MÁQUINA DE LAVAR (ON / ANIMATED)
core.register_node("terras_capixabas:maquina_lavar_on", {
    description = "Máquina de Lavar (On)",
    drawtype = "mesh",
    mesh = "maquina_lavar.obj", -- Using the same mesh

    tiles = {{
        name = "maquina_lavar_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 64,
            aspect_h = 64,
            length = 0.6 -- Adjust time for full cycle
        }
    }},

    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
    walkable = true,
    drop = "terras_capixabas:maquina_lavar",

    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    on_rightclick = function(pos, node, clicker)
        -- 1. Get the sound handle from metadata and stop it
        local meta = core.get_meta(pos)
        local handle = meta:get_int("sound_handle")
        if handle and handle ~= 0 then
            core.sound_stop(handle)
            meta:set_int("sound_handle", 0)
        end

        -- 2. Swap back to OFF state
        core.swap_node(pos, {name = "terras_capixabas:maquina_lavar", param2 = node.param2})
    end,

    -- Safety: Stop sound if the machine is dug while running
    on_destruct = function(pos)
        local meta = core.get_meta(pos)
        local handle = meta:get_int("sound_handle")
        if handle and handle ~= 0 then
            core.sound_stop(handle)
        end
    end
})

-- --------------------------------------------------------

-- TV FLAT (OFF)
core.register_node("terras_capixabas:tvflat", {
description = "TV Flat",
drawtype = "mesh",
mesh = "tvflat.obj",
tiles = {"tvflat.png"},
paramtype = "light",
paramtype2 = "facedir",
groups = {cracky = 3, oddly_breakable_by_hand = 1},
walkable = false,

selection_box = {
type = "fixed",
fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
},

on_rightclick = function(pos,node,clicker,itemstack,pointed_thing)
core.swap_node(pos,{name="terras_capixabas:tvflat_on",param2=node.param2})
core.sound_play("toggle",{pos=pos,max_hear_distance=8,gain=1.0})
end
})

-- TV FLAT (ON / ANIMATED)
core.register_node("terras_capixabas:tvflat_on", {
description = "TV Flat (On)",
drawtype = "mesh",
mesh = "tvflat2.obj",

tiles = {{
name = "tvflat2.png",
animation = {
type = "vertical_frames",
aspect_w = 64,
aspect_h = 32,
length = 2
}
}},

paramtype = "light",
paramtype2 = "facedir",
groups = {cracky = 3, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
walkable = false,
drop = "terras_capixabas:tvflat",

selection_box = {
type = "fixed",
fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
},

on_rightclick = function(pos,node,clicker,itemstack,pointed_thing)
core.swap_node(pos,{name="terras_capixabas:tvflat",param2=node.param2})
core.sound_play("toggle",{pos=pos,max_hear_distance=8,gain=1.0})
end
})

-- ---------------------------------------------------------

-- TV Parede (Static)
core.register_node("terras_capixabas:tv_parede", {
    description = "TV Parede",
    drawtype = "mesh",
    mesh = "tv_parede.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {"tv_parede.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 2, tv = 1},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.set_node(pos, {name = "terras_capixabas:tv_parede2", param2 = node.param2})
        core.sound_play("toggle", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})

-- TV Parede2 (Animated)
core.register_node("terras_capixabas:tv_parede2", {
    description = "TV Parede (Animada)",
    drawtype = "mesh",
    mesh = "tv_parede2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    tiles = {{
        name = "tv_parede2.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 32,  -- Width of each frame in pixels
            aspect_h = 14,  -- Height of each frame in pixels
            length = 0.5    -- Total time to cycle through both frames
        }
    }},
    groups = {cracky = 3, oddly_breakable_by_hand = 2, tv = 1, not_in_creative_inventory = 1},
    walkable = false,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    },

    drop = "terras_capixabas:tv_parede", -- Always drop the static version
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.set_node(pos, {name = "terras_capixabas:tv_parede", param2 = node.param2})
        core.sound_play("toggle", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})

-- ---------------------------------------------------------


core.register_node("terras_capixabas:arcade1", {
    description = "Arcade 1",
    tiles = {"arcade1.png"},
    drawtype = "mesh",
    mesh = "arcade1.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
	backface_culling = true,
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- Vidro de Igreja
core.register_node("terras_capixabas:vidro_igreja", {
    description = "Vidro de Igreja",
    tiles = {"vidro_igreja.png"},
    drawtype = "mesh",
    mesh = "vidro_igreja.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "blend",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

-- Vidro de Igreja com santa
core.register_node("terras_capixabas:vidro_igreja2", {
    description = "Vidro de Igreja c Santa",
    tiles = {"vidro_igreja2.png"},
    drawtype = "mesh",
    mesh = "vidro_igreja.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "blend",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.125, 0.5, 0.5, 0.125}
    }
})

core.register_node("terras_capixabas:atari", {
    description = "Atari 2600",
    tiles = {"atari.png"},
    drawtype = "mesh",
    mesh = "atari.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:box3x2", {
    description = "Box 3x2",
    tiles = {"box3x2.png"},
    drawtype = "mesh",
    mesh = "box3x2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
	use_texture_alpha = "blend",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- pia banheiro (OFF)
core.register_node("terras_capixabas:pia_banheiro", {
    description = "Pia de Banheiro",
    drawtype = "mesh",
    mesh = "pia_banheiro.obj",
    tiles = {"pia_banheiro.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:pia_banheiro_on", param2 = node.param2})

        local sh = core.sound_play("filtro", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        if sh then
            core.get_meta(pos):set_string("sound_handle", tostring(sh))
        end
    end
})


-- pia banheiro (ON)
core.register_node("terras_capixabas:pia_banheiro_on", {
    description = "Pia de Banheiro (On)",
    drawtype = "mesh",
    mesh = "pia_banheiro.obj",
    tiles = {{
        name = "pia_banheiro_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 64,
            aspect_h = 32,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    use_texture_alpha = "blend",
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:pia_banheiro",
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        meta:set_string("sound_handle", "")

        core.swap_node(pos, {name = "terras_capixabas:pia_banheiro", param2 = node.param2})
    end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})



-- ------------------------------------------------

core.register_node("terras_capixabas:cooler", {
    description = "Cooler",
    tiles = {"cooler.png"},
    drawtype = "mesh",
    mesh = "cooler.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "blend",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:pl_orelha_de_elefante", {
    description = "Orelha de Elefante",
    tiles = {"orelha_de_elefante.png"},
    drawtype = "mesh",
    mesh = "orelha_de_elefante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:privada_antiga", {
    description = "Privada Antiga",
    tiles = {"privada_antiga.png"},
    drawtype = "mesh",
    mesh = "privada_antiga.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:privada_hidraulica", {
    description = "Privada Hidráulica",
    tiles = {"privada_hidraulica.png"},
    drawtype = "mesh",
    mesh = "privada_hidraulica.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:toalha", {
    description = "Toalha",
    tiles = {"toalha.png"},
    drawtype = "mesh",
    mesh = "toalha.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:papel_higienico", {
    description = "Papel Higiênico",
    tiles = {"papel_higienico.png"},
    drawtype = "mesh",
    mesh = "papel_higienico.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- -----------------------------------

-- Register the opened armario node
core.register_node("terras_capixabas:armario_opened", {
    description = "armario (Opened)",
    drawtype = "mesh",
    mesh = "armario_opened.obj",
    tiles = {"armario.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
selection_box = {
    type = "fixed",
    fixed = {-0.25, -0.5, -0.0625, 1.25, 1.9375, 0.5}
},

collision_box = {
    type = "fixed",
    fixed = {-0.25, -0.5, -0.0625, 1.25, 1.9375, 0.5}
},
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Close armario and play sound
        core.sound_play("door_close", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })
        core.swap_node(pos, {name = "terras_capixabas:armario_closed", param2 = node.param2})
        core.close_formspec(clicker:get_player_name(), "terras_capixabas:armario")
    end,
})

-- Ensure armario closes when GUI closed (ESC key)
core.register_on_player_receive_fields(function(player, formname, fields)
    if formname == "terras_capixabas:armario" and fields.quit then
        local pos = vector.round(player:get_pos())
        local radius = 3
        local nodes = core.find_nodes_in_area(
            vector.subtract(pos, radius),
            vector.add(pos, radius),
            {"terras_capixabas:armario_opened"}
        )
        
        for _, p in ipairs(nodes) do
            local node = core.get_node(p)
            core.swap_node(p, {name = "terras_capixabas:armario_closed", param2 = node.param2})
            core.sound_play("door_close", {pos = p})
        end
    end
end)

-- ------------------------------

local clothes_list = {
"roupa0",
"roupa1",
"bear",
"bikinigirl",
"bolsonaro",
"cebolinha",
"dude",
"old",
"pewee",
"tiririca"
}

local function show_wardrobe_formspec(player,selected)
selected = selected or 1
core.show_formspec(player:get_player_name(),"terras_capixabas:wardrobe",
"formspec_version[4]"..
"size[6,4.5]"..
"label[0.3,0.3;Select clothing:]"..
"textlist[0.3,0.7;5.4,2.5;clothes;"..table.concat(clothes_list,",")..";"..selected.."]"..
"button[1.5,3.5;3,0.8;apply;Trocar]"
)
end

core.register_on_player_receive_fields(function(player,formname,fields)
if formname~="terras_capixabas:wardrobe" then return end
local meta = player:get_meta()
local selected = tonumber(meta:get_string("wardrobe_sel")) or 1

if fields.clothes then
local event = core.explode_textlist_event(fields.clothes)
if event.type=="CHG" then
meta:set_string("wardrobe_sel",event.index)
show_wardrobe_formspec(player,event.index)
return
end
end

if not fields.apply then return end
local skin = clothes_list[selected]..".png"
player:set_properties({textures={skin}})
meta:set_string("skin",skin)
end)

core.register_on_joinplayer(function(player)
local skin = player:get_meta():get_string("skin")
if skin~="" then player:set_properties({textures={skin}}) end
end)


-- CLOSED wardrobe (default)
core.register_node("terras_capixabas:gdroupa", {
    description = "gdroupa (Closed)",
    drawtype = "mesh",
    mesh = "gdroupa.obj",
    tiles = {"gdroupa.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},

    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.4375, 1.5, 2.0, 0.375 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.4375, 1.5, 2.0, 0.375 }
    },

    on_rightclick = function(pos, node, clicker)
        core.sound_play("door_open", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })

        core.swap_node(pos, {
            name = "terras_capixabas:gdroupa_opened",
            param2 = node.param2
        })

        show_wardrobe_formspec(clicker)
    end,
})

-- OPENED wardrobe
core.register_node("terras_capixabas:gdroupa_opened", {
    description = "gdroupa (Opened)",
    drawtype = "mesh",
    mesh = "gdroupa_opened.obj",
    tiles = {"gdroupa.png"},
    use_texture_alpha = "clip",
    backface_culling = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},

    selection_box = {
        type = "fixed",
        fixed = { -1.0, -0.5, -0.4375, 1.0, 2.0, 0.375 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -1.0, -0.5, -0.4375, 1.0, 2.0, 0.375 }
    },

    on_rightclick = function(pos, node)
        core.sound_play("door_close", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 10,
        })

        core.swap_node(pos, {
            name = "terras_capixabas:gdroupa",
            param2 = node.param2
        })
    end,
})


-- ------------------------------------------------------

-- pia cozinha (OFF)
core.register_node("terras_capixabas:pia_cozinha", {
    description = "Tanque de cozinha",
    drawtype = "mesh",
    mesh = "pia_cozinha.obj",
    tiles = {"pia_cozinha.png"},
    use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,

selection_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

collision_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:pia_cozinha_on", param2 = node.param2})

        local sh = core.sound_play("agua_saindo", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        if sh then
            core.get_meta(pos):set_string("sound_handle", tostring(sh))
        end
    end
})

-- pia cozinha (ON)
core.register_node("terras_capixabas:pia_cozinha_on", {
    description = "Tanque da Vovó (On)",
    drawtype = "mesh",
    mesh = "pia_cozinha.obj",
    use_texture_alpha = "blend",
    tiles = {{
        name = "pia_cozinha_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 128,
            aspect_h = 128,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    walkable = true,
    drop = "terras_capixabas:pia_cozinha",

selection_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

collision_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        meta:set_string("sound_handle", "")

        core.swap_node(pos, {name = "terras_capixabas:pia_cozinha", param2 = node.param2})
    end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})



-- ---------------------------------------------

-- pia vovo (OFF)
core.register_node("terras_capixabas:pia_vovo", {
    description = "Pia da Vovó",
    drawtype = "mesh",
    mesh = "pia_vovo.obj",
    tiles = {"pia_vovo.png"},
    use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,

selection_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

collision_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:pia_vovo_on", param2 = node.param2})

        local sh = core.sound_play("agua_saindo", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        if sh then
            core.get_meta(pos):set_string("sound_handle", tostring(sh))
        end
    end
})

-- pia vovo (ON)
core.register_node("terras_capixabas:pia_vovo_on", {
    description = "Tanque da Vovó (On)",
    drawtype = "mesh",
    mesh = "pia_vovo.obj",
    use_texture_alpha = "blend",
    tiles = {{
        name = "pia_vovo_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 128,
            aspect_h = 128,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    walkable = true,
    drop = "terras_capixabas:pia_vovo",

selection_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

collision_box = {
    type = "fixed",
    fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        meta:set_string("sound_handle", "")

        core.swap_node(pos, {name = "terras_capixabas:pia_vovo", param2 = node.param2})
    end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})

-- ----------------------------------------------------

-- tanque extrerno (OFF)
core.register_node("terras_capixabas:tanque_externo", {
    description = "Tanque da Vovó",
    drawtype = "mesh",
    mesh = "tanque_externo.obj",
    tiles = {"tanque_externo.png"},
    use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,

    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.5,  1.0,  0.5,  0.5}
    },

    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.5,  1.0,  0.5,  0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:tanque_externo_on", param2 = node.param2})

        local sh = core.sound_play("agua_saindo", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        if sh then
            core.get_meta(pos):set_string("sound_handle", tostring(sh))
        end
    end
})

-- tanque extrerno (ON)
core.register_node("terras_capixabas:tanque_externo_on", {
    description = "Tanque da Vovó (On)",
    drawtype = "mesh",
    mesh = "tanque_externo.obj",
    use_texture_alpha = "blend",
    tiles = {{
        name = "tanque_externo_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 128,
            aspect_h = 128,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    walkable = true,
    drop = "terras_capixabas:tanque_externo",

    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.5,  1.0,  0.5,  0.5}
    },

    collision_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.5,  1.0,  0.5,  0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        meta:set_string("sound_handle", "")

        core.swap_node(pos, {name = "terras_capixabas:tanque_externo", param2 = node.param2})
    end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})

-- -------------------------------------------------------

-- tanque vovo (OFF)
core.register_node("terras_capixabas:tanque_vovo", {
    description = "Tanque da Vovó",
    drawtype = "mesh",
    mesh = "tanque_vovo.obj",
    tiles = {"tanque_vovo.png"},
    use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,

    selection_box = {
        type = "fixed",
        fixed = {-1.5, -0.5, -0.5,  1.5,  0.5,  0.5}
    },

    collision_box = {
        type = "fixed",
        fixed = {-1.5, -0.5, -0.5,  1.5,  0.5,  0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:tanque_vovo_on", param2 = node.param2})

        local sh = core.sound_play("agua_saindo", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        if sh then
            core.get_meta(pos):set_string("sound_handle", tostring(sh))
        end
    end
})

-- tanque vovo (ON)
core.register_node("terras_capixabas:tanque_vovo_on", {
    description = "Tanque da Vovó (On)",
    drawtype = "mesh",
    mesh = "tanque_vovo.obj",
    use_texture_alpha = "blend",
    tiles = {{
        name = "tanque_vovo_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 128,
            aspect_h = 128,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    walkable = true,
    drop = "terras_capixabas:tanque_vovo",

    selection_box = {
        type = "fixed",
        fixed = {-1.5, -0.5, -0.5,  1.5,  0.5,  0.5}
    },

    collision_box = {
        type = "fixed",
        fixed = {-1.5, -0.5, -0.5,  1.5,  0.5,  0.5}
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        meta:set_string("sound_handle", "")

        core.swap_node(pos, {name = "terras_capixabas:tanque_vovo", param2 = node.param2})
    end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})
-- MESAS DE BAR -----------------------------------

local mesabars = {
  "mesabar",
  "mesabar_azul",
  "mesabar_amarela",
  "mesabar_branca"
}

local function register_mesabar(name)
core.register_node("terras_capixabas:"..name,{
description=name,
tiles={name..".png"},
drawtype="mesh",mesh="mesabar.obj",
paramtype="light",paramtype2="facedir",
backface_culling=true,walkable=true,
groups={cracky=3,oddly_breakable_by_hand=2},
selection_box={type="fixed",fixed={-0.5,-0.5,-0.5,0.5,0.5,0.5}}
})
end

for _,name in ipairs(mesabars) do register_mesabar(name) end

-- CADEIRAS DAS MESAS DE BAR -----------------------------------

local cadeiras = {
  "mesabar_cadeira",
  "mesabar_cadeira_azul",
  "mesabar_cadeira_amarela",
  "mesabar_cadeira_branca"
}

local function register_cadeira(name)
core.register_node("terras_capixabas:"..name,{
description=name,
tiles={name:gsub("_cadeira","")..".png"},
drawtype="mesh",mesh="mesabar_cadeira.obj",
paramtype="light",paramtype2="facedir",
backface_culling=true,walkable=true,
groups={choppy=2,oddly_breakable_by_hand=2},
selection_box={type="fixed",fixed={-0.5,-0.5,-0.5,0.5,0,0.5}},
collision_box={type="fixed",fixed={-0.5,-0.5,-0.5,0.5,0,0.5}},
on_rightclick=sit_behavior.on_rightclick,
on_destruct=sit_behavior.on_destruct
})
end

for _,name in ipairs(cadeiras) do register_cadeira(name) end

core.register_node("terras_capixabas:cortina_colorida", {
    description = "Cortina Colorida",
    tiles = {"cortina_colorida.png"},
    drawtype = "mesh",
    mesh = "cortina_colorida.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "blend",
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -1.5, -0.125, 0.5, 0.5, 0.125}
        }
    }
})

core.register_node("terras_capixabas:mesinha", {
    description = "mesinha",
    tiles = {"mesinha.png"},
    drawtype = "mesh",
    mesh = "mesinha.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:mesinha_marmore", {
    description = "mesinha_marmore",
    tiles = {"mesinha_marmore.png"},
    drawtype = "mesh",
    mesh = "mesinha_marmore.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

core.register_node("terras_capixabas:vassoura", {
    description = "vassoura",
    tiles = {"vassoura.png"},
    drawtype = "mesh",
    mesh = "vassoura.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.3, -0.5, 0.2, 0.3, 1.5, 0.4}
    }
})


-- TV Antiga (Off)
core.register_node("terras_capixabas:tv_antiga", {
    description = "TV Antiga",
    tiles = {"tv_antiga.png"},
    drawtype = "mesh",
    mesh = "tv_antiga.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.3125, 0.5, 0.5, 0.3125 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.3125, 0.5, 0.5, 0.3125 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.set_node(pos, {name = "terras_capixabas:tv_antiga_on", param2 = node.param2})
        core.sound_play("toggle", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})

-- TV Antiga (On)
core.register_node("terras_capixabas:tv_antiga_on", {
    description = "TV Antiga (On)",
    tiles = {"tv_antiga_on.png"},
    drawtype = "mesh",
    mesh = "tv_antiga_on.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.3125, 0.5, 0.5, 0.3125 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.3125, 0.5, 0.5, 0.3125 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.set_node(pos, {name = "terras_capixabas:tv_antiga", param2 = node.param2})
        core.sound_play("toggle", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})


core.register_node("terras_capixabas:grade_barriga", {
    description = "grade_barriga",
    tiles = {"grade_barriga.png"},
    drawtype = "mesh",
    mesh = "grade_barriga.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-1.5, -0.5, 0.3, 1.5, 0.5, 0.7}
    }
})

core.register_node("terras_capixabas:escada_piscina", {
    description = "escada_piscina",
    tiles = {"escada_piscina.png"},
    drawtype = "mesh",
    mesh = "escada_piscina.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
selection_box = {
    type = "fixed",
    fixed = { -0.3125, -1.0, -0.78125, 0.3125, 0.25, -0.28125 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.3125, -1.0, -0.78125, -0.25, 0.25, -0.28125 }, -- Left side
        { 0.25, -1.0, -0.78125, 0.3125, 0.25, -0.28125 }, -- Right side
        { -0.25, -0.53125, -0.78125, 0.25, -0.46875, -0.59375 }, -- Step 1
        { -0.25, -1.0, -0.78125, 0.25, -0.9375, -0.59375 } -- Step 2
    }
}
})

-- guarda-roupão (CLOSED)
core.register_node("terras_capixabas:guardaroupao", {
    description = "guardaroupao",
    tiles = {"guardaroupao.png"},
    drawtype = "mesh",
    mesh = "guardaroupao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,

    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.25,  0.5,  1.5,  0.25 }
    },

    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.25,  0.5,  1.5,  0.25 }
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {
            name = "terras_capixabas:guardaroupao_aberto",
            param2 = node.param2
        })

        core.sound_play("door_open", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 8
        })
    end
})

-- guarda-roupão (OPEN)
core.register_node("terras_capixabas:guardaroupao_aberto", {
    description = "guardaroupao (Open)",
    tiles = {"guardaroupao.png"},
    drawtype = "mesh",
    mesh = "guardaroupao_aberto.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    walkable = true,
    drop = "terras_capixabas:guardaroupao",

    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.25,  0.5,  1.5,  0.25 }
    },

    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.25,  0.5,  1.5,  0.25 }
    },

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {
            name = "terras_capixabas:guardaroupao",
            param2 = node.param2
        })

        core.sound_play("door_close", {
            pos = pos,
            gain = 1.0,
            max_hear_distance = 8
        })
    end
})




core.register_node("terras_capixabas:bide", {
    description = "bide",
    tiles = {"bide.png"},
    drawtype = "mesh",
    mesh = "bide.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- Chuveiro (OFF)
core.register_node("terras_capixabas:chuveiro", {
    description = "Chuveiro",
    drawtype = "mesh",
    mesh = "chuveiro.obj",
    use_texture_alpha = "blend",
    tiles = {"chuveiro.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Turn ON the shower
        core.swap_node(pos, {name = "terras_capixabas:chuveiro_on", param2 = node.param2})
        
        -- Start looping water sound
        local sound_handle = core.sound_play("agua_chuveiro", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true  -- Make the sound loop
        })
        
        -- Store the sound handle in node metadata for later stopping
        local meta = core.get_meta(pos)
        if sound_handle then
            meta:set_string("sound_handle", tostring(sound_handle))
        end
    end
})

-- Chuveiro (ON / ANIMATED)
core.register_node("terras_capixabas:chuveiro_on", {
    description = "Chuveiro (On)",
    drawtype = "mesh",
    use_texture_alpha = "blend",
    mesh = "chuveiro.obj",
    tiles = {{
        name = "chuveiro_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 32,
            aspect_h = 128,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:chuveiro",
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Turn OFF the shower
        core.swap_node(pos, {name = "terras_capixabas:chuveiro", param2 = node.param2})
        
        -- Stop the looping water sound
        local meta = core.get_meta(pos)
        local sound_handle_str = meta:get_string("sound_handle")
        
        if sound_handle_str and sound_handle_str ~= "" then
            -- Try to parse the sound handle and stop it
            local sound_handle = tonumber(sound_handle_str)
            if sound_handle then
                core.sound_stop(sound_handle)
            end
            -- Clear the stored sound handle
            meta:set_string("sound_handle", "")
        end
    end,
    
    -- Also stop sound when node is destroyed/dug
    on_dig = function(pos, node, digger)
        -- Stop the sound first
        local meta = core.get_meta(pos)
        local sound_handle_str = meta:get_string("sound_handle")
        
        if sound_handle_str and sound_handle_str ~= "" then
            local sound_handle = tonumber(sound_handle_str)
            if sound_handle then
                core.sound_stop(sound_handle)
            end
        end
        
        -- Then do the default digging behavior
        core.node_dig(pos, node, digger)
    end
})


-- ---------------

core.register_node("terras_capixabas:arca", {
    description = "Arca",
    tiles = {"arca.png"},
    drawtype = "mesh",
    mesh = "arca.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = true,
selection_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.1875, 1.5, 1.5, 0.4375 }
},
collision_box = {
    type = "fixed",
    fixed = { -0.5, -0.5, -0.1875, 1.5, 1.5, 0.4375 }
},

})

-- Estante (Off)
core.register_node("terras_capixabas:estante", {
    description = "Estante",
    tiles = {"estante.png"},
    drawtype = "mesh",
    mesh = "estante.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.1875, 1.5, 1.5, 0.4375 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.1875, 1.5, 1.5, 0.4375 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to On version
        core.set_node(pos, {name = "terras_capixabas:estante_on", param2 = node.param2})
        core.sound_play("toggle", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})

-- Estante (On)
core.register_node("terras_capixabas:estante_on", {
    description = "Estante (On)",
    tiles = {"estante_on.png"},
    drawtype = "mesh",
    mesh = "estante_on.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.1875, 1.5, 1.5, 0.4375 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.1875, 1.5, 1.5, 0.4375 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to Off version
        core.set_node(pos, {name = "terras_capixabas:estante", param2 = node.param2})
        core.sound_play("toggle", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})


-- -------

local cooking_sessions = {}

-- Recipe Table (Mirrored from Fogão à Lenha)
local recipes = {
    {inpt={"arroz","feijao"},out="arroz_com_feijao"},
    {inpt={"batata"},out="batata_frita"},
    {inpt={"camarao"},out="churrasquim_camarao"},
    {inpt={"feijao","farinha","ovo"},out="feijao_tropeiro"},
    {inpt={"feijao","carne_porco"},out="feijoada"},
    {inpt={"pao","salsicha"},out="cachorro_quente"},
    {inpt={"peixe","oleo","tempero_verde"},out="moqueca_capixaba"},
    {inpt={"peixe","oleo","tomate"},out="peroa_frito"},
    {inpt={"ovo"},out="ovo_frito"},
    {inpt={"caranguejo_vivo"},out="pua_de_caranguejo"},
    {inpt={"peixe","oleo","batata"},out="torta_de_bacalhau"},
    {inpt={"macarrao","agua","tomate"},out="macarronada"},
}

local function normalize(name)
    if name == "" then return "" end
    name = name:match(":(.+)$") or name
    return name:gsub("^alm_", "")
end

local function same_items(a, b)
    if #a ~= #b then return false end
    local t = {}
    for _, i in ipairs(a) do t[i] = (t[i] or 0) + 1 end
    for _, i in ipairs(b) do
        if not t[i] then return false end
        t[i] = t[i] - 1
        if t[i] < 0 then return false end
    end
    return true
end

local function get_recipe(list)
    local items = {}
    for _, s in ipairs(list) do
        local n = normalize(s)
        if n ~= "" then items[#items+1] = n end
    end
    for _, r in ipairs(recipes) do
        if same_items(items, r.inpt) then return r.out end
    end
end

local function cook_formspec(sec)
    local esc = sec and "false" or "true"
    local label = sec and "Grelhando: " .. sec or "Churrasco"
    return "formspec_version[4]size[8,8]"
        .. "list[current_player;main;0,4.5;8,3;]"
        .. "list[detached:cook;ing;2.5,0.6;3,1;]"
        .. "button[2.5,1.9;3,0.8;cozinhar;Grelhar]"
        .. "label[3.2,2.9;" .. label .. "]"
        .. "list[detached:cook;out;3.5,3.3;1,1;]"
        .. "set_escape[" .. esc .. "]"
end

-- Register Smoke Entity
if not core.registered_entities["terras_capixabas:smoke"] then
    core.register_entity("terras_capixabas:smoke", {
        physical = false,
        collisionbox = {0, 0, 0, 0, 0, 0},
        visual = "sprite",
        use_texture_alpha = true,
        textures = {"churrasqueira_smoke.png^[verticalframe:12:0"},
        visual_size = {x = 1, y = 1},
        glow = 14,
        on_activate = function(self)
            self.object:set_armor_groups({immortal = 1})
            self.timer = 0
            self.frame = 0
        end,
        on_step = function(self, dtime)
            self.timer = self.timer + dtime
            self.frame = math.floor((self.timer / 3) * 12) % 12
            self.object:set_properties({
                textures = {"churrasqueira_smoke.png^[verticalframe:12:" .. self.frame},
            })
            local pos = self.object:get_pos()
            self.object:set_pos({x = pos.x, y = pos.y + 0.015, z = pos.z})
            if self.timer > 2.5 then
                local alpha = math.floor(255 * (1 - ((self.timer - 2.5) / 0.5)))
                self.object:set_properties({
                    textures = {"churrasqueira_smoke.png^[verticalframe:12:" .. self.frame .. "^[opacity:" .. alpha},
                })
            end
            if self.timer > 3 then self.object:remove() end
        end,
    })
end

local function register_churrasqueira(name, mesh, next_node)
    core.register_node("terras_capixabas:" .. name, {
        description = name == "churrasqueira" and "Churrasqueira" or "",
        tiles = {"churrasqueira.png"},
        drawtype = "mesh",
        mesh = mesh,
        paramtype = "light",
        paramtype2 = "facedir",
        groups = {
            snappy = 3, flammable = 2,
            not_in_creative_inventory = (name ~= "churrasqueira") and 1 or 0
        },
        walkable = true,
        use_texture_alpha = "clip",
        backface_culling = true,
        
        on_rightclick = function(pos, node, clicker)
            local meta = core.get_meta(pos)
            local p_name = clicker:get_player_name()

            if name == "churrasqueira" then
                -- Turn ON
                core.sound_play("abrir_aco", {pos = pos, gain = 1})
                core.swap_node(pos, {name = "terras_capixabas:" .. next_node, param2 = node.param2})
                local handle = core.sound_play("fritando", {pos = pos, gain = 1.0, loop = true})
                meta:set_int("sizzle_handle", handle or 0)
            else
                -- Interact with OPENED grill (Open Menu)
                if not core.get_inventory({type="detached", name="cook"}) then
                    local inv = core.create_detached_inventory("cook", {
                        allow_put = function(_,_,_,stack) return stack:get_count() end,
                        allow_take = function(_,_,_,stack) return stack:get_count() end,
                        allow_move = function(_,_,_,_,_,count) return count end,
                    })
                    inv:set_size("ing", 3)
                    inv:set_size("out", 1)
                end

                cooking_sessions[p_name] = {pos = pos, active = true}
                core.show_formspec(p_name, "terras_capixabas:cook", cook_formspec(nil))
            end
        end,
    })
end

-- Receive Fields Logic
core.register_on_player_receive_fields(function(player, form, fields)
    if form ~= "terras_capixabas:cook" then return end
    local name = player:get_player_name()
    local session = cooking_sessions[name]
    if not session then return end

    local pos = session.pos
    local meta = core.get_meta(pos)

    -- If player hits Quit/ESC, close the grill
    if fields.quit then
        local h = meta:get_int("sizzle_handle")
        if h > 0 then core.sound_stop(h) meta:set_int("sizzle_handle", 0) end
        
        core.swap_node(pos, {
            name = "terras_capixabas:churrasqueira",
            param2 = core.get_node(pos).param2
        })
        cooking_sessions[name] = nil
        return
    end

    if not fields.cozinhar or not session.active then return end
    session.active = false

    local inv = core.get_inventory({type="detached", name="cook"})
    local list = {}
    for i=1,3 do list[i] = inv:get_stack("ing", i):get_name() end

    local result = get_recipe(list)
    if not result then session.active = true return end

    inv:set_list("out", {})

    local function tick(t)
        if t > 0 then
            core.show_formspec(name, "terras_capixabas:cook", cook_formspec(t))
            core.after(1, function() tick(t-1) end)
        else
            inv:set_list("ing", {})
            inv:set_stack("out", 1, ItemStack("terras_capixabas:alm_" .. result))
            core.show_formspec(name, "terras_capixabas:cook", cook_formspec(nil))
            session.active = true
        end
    end
    tick(3)
end)

-- Smoke ABM
core.register_abm({
    nodenames = {"terras_capixabas:churrasqueira_opened"},
    interval = 0.5,
    chance = 1,
    action = function(pos)
        core.add_entity({
            x = pos.x + (math.random(-10, 10) * 0.01),
            y = pos.y + 0.4,
            z = pos.z + (math.random(-10, 10) * 0.01)
        }, "terras_capixabas:smoke")
    end
})

register_churrasqueira("churrasqueira", "churrasqueira.obj", "churrasqueira_opened")
register_churrasqueira("churrasqueira_opened", "churrasqueira_opened.obj", "churrasqueira")

-- -----------------------------------------------

-- filtro (OFF)
core.register_node("terras_capixabas:filtro", {
    description = "filtro",
    drawtype = "mesh",
    mesh = "filtro.obj",
    use_texture_alpha = "blend",
    tiles = {"filtro.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:filtro_on", param2 = node.param2})

        local sound_handle = core.sound_play("filtro", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        local meta = core.get_meta(pos)
        if sound_handle then
            meta:set_string("sound_handle", tostring(sound_handle))
        end

        core.after(2, function()
            local current = core.get_node(pos)
            if current.name ~= "terras_capixabas:filtro_on" then return end

            local meta2 = core.get_meta(pos)
            local sh = tonumber(meta2:get_string("sound_handle") or "")
            if sh then core.sound_stop(sh) end
            meta2:set_string("sound_handle", "")

            core.swap_node(pos, {name = "terras_capixabas:filtro", param2 = current.param2})

            local dir = core.facedir_to_dir(current.param2)
            local drop_pos = {
                x = pos.x - dir.x * 0.9,
                y = pos.y + 0.2,
                z = pos.z - dir.z * 0.9
            }

            core.add_item(drop_pos, "terras_capixabas:alm_copo_agua")

            core.sound_play("plop", {
                pos = pos,
                max_hear_distance = 8,
                gain = 1.0
            })
        end)
    end
})

-- filtro (ON / ANIMATED)
core.register_node("terras_capixabas:filtro_on", {
    description = "filtro (On)",
    drawtype = "mesh",
    use_texture_alpha = "blend",
    mesh = "filtro.obj",
    tiles = {{
        name = "filtro_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 64,
            aspect_h = 64,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:filtro",
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },
    on_rightclick = function() end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})






-- -----------------------------------------------

-- filtro_moderno (OFF)
core.register_node("terras_capixabas:filtro_moderno", {
    description = "filtro_moderno",
    drawtype = "mesh",
    mesh = "filtro_moderno.obj",
    use_texture_alpha = "blend",
    tiles = {"filtro_moderno.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.swap_node(pos, {name = "terras_capixabas:filtro_moderno_on", param2 = node.param2})

        local sound_handle = core.sound_play("filtro", {
            pos = pos,
            max_hear_distance = 8,
            gain = 1.0,
            loop = true
        })

        local meta = core.get_meta(pos)
        if sound_handle then
            meta:set_string("sound_handle", tostring(sound_handle))
        end

        core.after(2, function()
            local current = core.get_node(pos)
            if current.name ~= "terras_capixabas:filtro_moderno_on" then return end

            local meta2 = core.get_meta(pos)
            local sh = tonumber(meta2:get_string("sound_handle") or "")
            if sh then core.sound_stop(sh) end
            meta2:set_string("sound_handle", "")

            core.swap_node(pos, {name = "terras_capixabas:filtro_moderno", param2 = current.param2})

            local dir = core.facedir_to_dir(current.param2)
            local drop_pos = {
                x = pos.x - dir.x * 0.9,
                y = pos.y + 0.2,
                z = pos.z - dir.z * 0.9
            }

            core.add_item(drop_pos, "terras_capixabas:alm_copo_agua")

            core.sound_play("plop", {
                pos = pos,
                max_hear_distance = 8,
                gain = 1.0
            })
        end)
    end
})

-- filtro_moderno (ON / ANIMATED)
core.register_node("terras_capixabas:filtro_moderno_on", {
    description = "filtro_moderno (On)",
    drawtype = "mesh",
    use_texture_alpha = "blend",
    mesh = "filtro_moderno.obj",
    tiles = {{
        name = "filtro_moderno_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 64,
            aspect_h = 64,
            length = 0.5
        }
    }},
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {cracky = 3, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:filtro_moderno",
    selection_box = {
        type = "fixed",
        fixed = {-0.5,-0.5,-0.5,0.5,0.5,0.5}
    },
    on_rightclick = function() end,

    on_dig = function(pos, node, digger)
        local meta = core.get_meta(pos)
        local sh = tonumber(meta:get_string("sound_handle") or "")
        if sh then core.sound_stop(sh) end
        core.node_dig(pos, node, digger)
    end
})





-- -----------------

core.register_node("terras_capixabas:banco_praca", {
 description = "Banco de Praça",
 tiles = {"banco_praca.png"},
 drawtype = "mesh",
 mesh = "banco_praca.obj",
 paramtype = "light",
 paramtype2 = "facedir",
 groups = {choppy = 2, oddly_breakable_by_hand = 2},
 walkable = true,
 use_texture_alpha = "clip",
 selection_box = {type = "fixed", fixed = {-1,-0.5,-0.5,1,0,0.5}},
 collision_box = {type = "fixed", fixed = {-1,-0.5,-0.5,1,0,0.5}},
 on_rightclick = sit_behavior.on_rightclick,
 on_destruct = sit_behavior.on_destruct
})


core.register_node("terras_capixabas:grade_ferro1x2", {
    description = "grade_ferro 1x2",
    tiles = {"grade_ferro1x2.png"},
    drawtype = "mesh",
    mesh = "grade_ferro1x2.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.1, 0.5, 1.5, 0.1}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.1, 0.5, 1.5, 0.1}
        }
    }
})


core.register_node("terras_capixabas:portao_garagem_vovo", {
    description = "Portao Garagem Vovo",
    tiles = {"portao_garagem_vovo.png"},
    drawtype = "mesh",
    mesh = "portao_garagem_vovo.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.1, 1.5, 2.5, 0.2}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.1, 1.5, 2.5, 0.2}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:portao_garagem_vovo_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:portao_garagem_vovo_opened", {
    description = "Portao Garagem Vovo Aberto",
    tiles = {"portao_garagem_vovo.png"},
    drawtype = "mesh",
    mesh = "portao_garagem_vovo_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    drop = "terras_capixabas:portao_garagem_vovo_opened",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.1, 1.5, 2.5, 0.2}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1.5, -0.5, -0.1, 1.5, 2.5, 0.2}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:portao_garagem_vovo", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:quadro_eu", {
    description = "quadro_eu",
    tiles = {"quadro_eu.png"},
    drawtype = "mesh",
    mesh = "quadro_eu.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1}
    }
})

core.register_node("terras_capixabas:quadro_barco", {
    description = "quadro_barco",
    tiles = {"quadro_barco.png"},
    drawtype = "mesh",
    mesh = "quadro_barco.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1}
    }
})

core.register_node("terras_capixabas:quadro_menina", {
    description = "quadro_menina",
    tiles = {"quadro_menina.png"},
    drawtype = "mesh",
    mesh = "quadro_menina.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1}
    }
})

core.register_node("terras_capixabas:quadro_gretchen", {
    description = "quadro_gretchen",
    tiles = {"quadro_gretchen.png"},
    drawtype = "mesh",
    mesh = "quadro_gretchen.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1}
    }
})

core.register_node("terras_capixabas:quadro_vasco", {
    description = "quadro_vasco",
    tiles = {"quadro_vasco.png"},
    drawtype = "mesh",
    mesh = "quadro_vasco.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.1, 0.5, 0.5, 0.1}
    }
})

-- -----

core.register_node("terras_capixabas:pano_de_chao", {
    description = "Pano de chao",
    drawtype = "nodebox",
    tiles = {"pano_de_chao.png"},
    paramtype = "light",
    paramtype2 = "facedir",
    sunlight_propagates = true,
    walkable = false,  -- walk through it (it's thin)
    use_texture_alpha = "clip",
    floodable = true,

    groups = {
        snappy = 3,
        dig_immediate = 3,
        -- no 'attached_node'
    },

    sounds = default.node_sound_leaves_defaults(),

    node_box = {
        type = "fixed",
        fixed = {
            {-1.0, -0.5, -0.5, 1.0, -0.49, 0.5}, -- 32px wide, 16px deep, 1px thick
        }
    },

    selection_box = {
        type = "fixed",
        fixed = {-1.0, -0.5, -0.5, 1.0, -0.49, 0.5}
    },

    collision_box = {
        type = "fixed",
        fixed = {}
    }
})



core.register_node("terras_capixabas:cerca", {
    description = "Cerca",
    tiles = {"cerca.png"},
    drawtype = "mesh",
    mesh = "cerca.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    }
})


core.register_node("terras_capixabas:cerca_esquina", {
    description = "Cerca Esquina",
    tiles = {"cerca.png"},
    drawtype = "mesh",
    mesh = "cerca_esquina.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    collision_box = {
        type = "fixed",
        fixed = {
            {0.0, -0.5, -0.125, 0.5, 1.5, 0.125},  -- X-axis arm
            {-0.125, -0.5, 0.0, 0.125, 1.5, 0.5}   -- Z-axis arm
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {0.0, -0.5, -0.125, 0.5, 1.5, 0.125},  -- X-axis arm
            {-0.125, -0.5, 0.0, 0.125, 1.5, 0.5}   -- Z-axis arm
        }
    }
})

core.register_node("terras_capixabas:cerca_portao", {
    description = "Cerca Portao",
    tiles = {"cerca_portao.png"},
    drawtype = "mesh",
    mesh = "cerca.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "clip",
    backface_culling = false,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:cerca_portao_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:cerca_portao_opened", {
    description = "Cerca Portao (Aberto)",
    tiles = {"cerca_portao.png"},
    drawtype = "mesh",
    mesh = "cerca_portao_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    drop = "terras_capixabas:cerca_portao",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:cerca_portao", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

-- --------------------------

core.register_node("terras_capixabas:porta", {
    description = "Porta",
    tiles = {"porta.png"},
    drawtype = "mesh",
    mesh = "porta.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_opened", {
    description = "Porta Aberta)",
    tiles = {"porta.png"},
    drawtype = "mesh",
    mesh = "porta_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:porta",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

-- -------------------------------------------------------------

core.register_node("terras_capixabas:porta_branca", {
    description = "Porta Branca",
    tiles = {"porta_branca.png"},
    drawtype = "mesh",
    mesh = "porta.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_branca_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:porta_branca_opened", {
    description = "Porta Branca Aberta)",
    tiles = {"porta_branca.png"},
    drawtype = "mesh",
    mesh = "porta_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    drop = "terras_capixabas:porta",
    collision_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:porta_branca", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

-- --------------------------------------------------------------

core.register_node("terras_capixabas:vidro2x2_porta", {
    description = "vidro2x2_porta",
    tiles = {"vidro2x2_porta.png"},
    drawtype = "mesh",
    mesh = "vidro2x2_porta.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "blend",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:vidro2x2_porta_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:vidro2x2_porta_opened", {
    description = "vidro2x2_porta aberto)",
    tiles = {"vidro2x2_porta.png"},
    drawtype = "mesh",
    mesh = "vidro2x2_porta_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "blend",
    drop = "terras_capixabas:vidro2x2_porta",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 1.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:vidro2x2_porta", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:vidro2x3_porta", {
    description = "vidro2x3_porta",
    tiles = {"vidro2x3_porta.png"},
    drawtype = "mesh",
    mesh = "vidro2x3_porta.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2},
    walkable = true,
    use_texture_alpha = "blend",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 2.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap to the opened gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:vidro2x3_porta_opened", param2 = node.param2})
        -- Play the door opening sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

core.register_node("terras_capixabas:vidro2x3_porta_opened", {
    description = "vidro2x3_porta aberto)",
    tiles = {"vidro2x3_porta.png"},
    drawtype = "mesh",
    mesh = "vidro2x3_porta_opened.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},
    walkable = false,
    use_texture_alpha = "blend",
    drop = "terras_capixabas:vidro2x3_porta",
    collision_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 1.5, 0.125}
        }
    },
    selection_box = {
        type = "fixed",
        fixed = {
            {-1, -0.5, -0.125, 1, 2.5, 0.125}
        }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- Swap back to the closed gate node, preserving orientation
        core.swap_node(pos, {name = "terras_capixabas:vidro2x3_porta", param2 = node.param2})
        -- Play the door closing sound
        core.sound_play("abrir_aco", {pos = pos, gain = 0.3, max_hear_distance = 8})
    end
})

-- PORTÕES --------------------------------------------------------------------------------

local function register_portao_pair(name, def)
 local mod = "terras_capixabas:"
 local id_closed = mod..name
 local id_opened = id_closed.."_opened"
 local desc_opened = def.description.." aberto"
 local sound_open = def.sound_open or "abrir_aco"
 local sound_close = def.sound_close or sound_open
 local drop = def.drop ~= false and id_closed or nil

 local common_box = {
  type = "fixed",
  fixed = def.box or {{-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}}
 }

 local base_def = {
  tiles = {def.tile},
  drawtype = "mesh",
  mesh = def.mesh or "cerca.obj",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = def.groups or {snappy = 3, flammable = 2},
  use_texture_alpha = "clip",
  backface_culling = false,
  walkable = true,
  collision_box = common_box,
  selection_box = common_box
 }

 local opened_def = table.copy(base_def)
 opened_def.description = desc_opened
 opened_def.mesh = def.mesh_opened or "cerca_portao_opened.obj"
 opened_def.walkable = false
 opened_def.groups.not_in_creative_inventory = 1
 opened_def.drop = drop
 opened_def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
  core.swap_node(pos, {name = id_closed, param2 = node.param2})
  core.sound_play(sound_close, {pos = pos, gain = 0.3, max_hear_distance = 8})
 end

 local closed_def = table.copy(base_def)
 closed_def.description = def.description
 closed_def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
  core.swap_node(pos, {name = id_opened, param2 = node.param2})
  core.sound_play(sound_open, {pos = pos, gain = 0.3, max_hear_distance = 8})
 end

 core.register_node(id_closed, closed_def)
 core.register_node(id_opened, opened_def)
end

-- Register all portões
register_portao_pair("portao_grade", {description = "portao_grade", tile = "portao_grade.png"})
register_portao_pair("portao_ferro", {description = "portao_ferro", tile = "portao_ferro.png"})
register_portao_pair("portao_chapa", {description = "portao_chapa", tile = "portao_chapa.png"})
register_portao_pair("portao_chapa_fechado", {description = "portao_chapa_fechado", tile = "portao_chapa_fechado.png"})
register_portao_pair("portao_madeira", {
 description = "portao_madeira",
 tile = "portao_madeira.png",
 sound_open = "door_open",
 sound_close = "door_close"
})
register_portao_pair("portao_losangulo", {description = "portao_losangulo", tile = "portao_losangulo.png"})
register_portao_pair("portao_antigo", {
 description = "portao_antigo",
 tile = "portao_antigo.png",
 mesh = "cerca.obj",
 mesh_opened = "cerca_portao_opened.obj",
 box = {{-0.5, -0.5, -0.125, 0.5, 1.5, 0.125}}
})


-- PORTÕES DE GARAGEM --------------------------------------------------------------

local function register_cercag_pair(name, def)
 local mod = "terras_capixabas:"
 local id_closed = mod .. name
 local id_opened = id_closed .. "_opened"
 local desc_opened = def.description .. " Aberto"
 local sound = def.sound or "abrir_aco"
 local drop = def.drop ~= false and id_opened or nil

 local base_def = {
  tiles = {def.tile},
  drawtype = "mesh",
  mesh = def.mesh or "cercag.obj",
  paramtype = "light",
  paramtype2 = "facedir",
  groups = def.groups or {snappy = 3, flammable = 2},
  use_texture_alpha = "clip",
  backface_culling = false,
  walkable = true,
  collision_box = {type = "fixed", fixed = {{-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}}},
  selection_box = {type = "fixed", fixed = {{-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}}}
 }

 local opened_def = table.copy(base_def)
 opened_def.description = desc_opened
 opened_def.mesh = def.mesh_opened or "cercag_opened.obj"
 opened_def.walkable = false
 opened_def.groups.not_in_creative_inventory = 1
 opened_def.drop = drop
 opened_def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
  core.swap_node(pos, {name = id_closed, param2 = node.param2})
  core.sound_play(sound, {pos = pos, gain = 0.3, max_hear_distance = 8})
 end

 local closed_def = table.copy(base_def)
 closed_def.description = def.description
 closed_def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
  core.swap_node(pos, {name = id_opened, param2 = node.param2})
  core.sound_play(sound, {pos = pos, gain = 0.3, max_hear_distance = 8})
 end

 core.register_node(id_closed, closed_def)
 core.register_node(id_opened, opened_def)
end

-- Register all variations
register_cercag_pair("cercag_madeira", {description = "CercaG Madeira", tile = "cercag_madeira.png", sound = "door_open"})
register_cercag_pair("cercag_antigo", {description = "CercaG Antigo", tile = "cercag_antigo.png", sound = "abrir_aco"})
register_cercag_pair("cercag_ferro", {description = "Cerca Garagem Ferro", tile = "cercag_ferro.png", sound = "abrir_aco"})
register_cercag_pair("cercag_losangulo", {description = "CercaG Madeira", tile = "cercag_losangulo.png", sound = "abrir_aco"})
register_cercag_pair("cercag_chapa", {description = "CercaG Madeira", tile = "cercag_chapa.png", sound = "abrir_aco"})
register_cercag_pair("cercag_chapa_fechado", {description = "CercaG Madeira", tile = "cercag_chapa_fechado.png", sound = "abrir_aco"})



-- ----------------------------------------------------
core.register_node("terras_capixabas:porteira", {
 description = "Porteira",
 tiles = {"porteira.png"},
 drawtype = "mesh",
 mesh = "porteira.obj",
 paramtype = "light",
 paramtype2 = "facedir",
 groups = {snappy = 3, flammable = 2},
 walkable = true,

 collision_box = {
  type = "fixed",
  fixed = {
   {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
  }
 },

 selection_box = {
  type = "fixed",
  fixed = {
   {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
  }
 },

 on_rightclick = function(pos, node)
  core.swap_node(pos, {name = "terras_capixabas:porteira_opened", param2 = node.param2})
  core.sound_play("door_open", {pos = pos, gain = 0.3, max_hear_distance = 8})
 end
})

core.register_node("terras_capixabas:porteira_opened", {
 description = "Porteira Aberta",
 tiles = {"porteira.png"},
 drawtype = "mesh",
 mesh = "porteira_opened.obj",
 paramtype = "light",
 paramtype2 = "facedir",

 groups = {snappy = 3, flammable = 2, not_in_creative_inventory = 1},

 -- 🔑 EXACT SAME COLLISION BOX AS CLOSED NODE
 collision_box = {
  type = "fixed",
  fixed = {
   {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
  }
 },

 selection_box = {
  type = "fixed",
  fixed = {
   {-1.5, -0.5, -0.125, 1.5, 1.5, 0.125}
  }
 },

 walkable = false,

 on_rightclick = function(pos, node)
  core.swap_node(pos, {name = "terras_capixabas:porteira", param2 = node.param2})
  core.sound_play("door_close", {pos = pos, gain = 0.3, max_hear_distance = 8})
 end
})





-- -------------------------------------------------

core.register_node("terras_capixabas:bola", {
    description = "Bola",
    tiles = {"bola.png"},
    drawtype = "mesh",
    mesh = "bola.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:caixadagua", {
    description = "Caixa D´água",
    tiles = {"caixadagua.png"},
    drawtype = "mesh",
    mesh = "caixadagua.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

-- ---
core.register_node("terras_capixabas:sofa1x", {
    description = "sofa1x",
    tiles = {"sofa.png"},
    drawtype = "mesh",
    mesh = "sofa1x.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2},
    walkable = true,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
    },

    on_rightclick = sit_behavior.on_rightclick,
    on_destruct = sit_behavior.on_destruct,
})


-- ------------------------------------------------------

core.register_node("terras_capixabas:sofa2x", {
    description = "sofa2x",
    tiles = {"sofa.png"},
    drawtype = "mesh",
    mesh = "sofa2x.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2},
    walkable = true,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
    },

    on_rightclick = sit_behavior.on_rightclick,
    on_destruct = sit_behavior.on_destruct,
})
   
-- ------------------------------------------------

core.register_node("terras_capixabas:sofa3x", {
    description = "sofa3x",
    tiles = {"sofa.png"},
    drawtype = "mesh",
    mesh = "sofa3x.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2},
    walkable = true,
    backface_culling = true,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
    },

    on_rightclick = sit_behavior.on_rightclick,
    on_destruct = sit_behavior.on_destruct,
})

-- -------------

core.register_node("terras_capixabas:escola_armario", {
description = "escola_armario",
tiles = {"escola_armario.png"},
drawtype = "mesh",
mesh = "escola_armario.obj",
paramtype = "light",
paramtype2 = "facedir",
groups = {choppy = 2, oddly_breakable_by_hand = 2},
walkable = true,
selection_box = {
type = "fixed",
fixed = {-0.5, -0.5, -0.5, 1.5, 1.5, 0.5}
},
collision_box = {
type = "fixed",
fixed = {-0.5, -0.5, -0.5, 1.5, 1.5, 0.5}
},
})

core.register_node("terras_capixabas:escola_quadro", {
description = "escola_quadro",
tiles = {"escola_quadro.png"},
drawtype = "mesh",
mesh = "escola_quadro.obj",
paramtype = "light",
paramtype2 = "facedir",
groups = {choppy = 2, oddly_breakable_by_hand = 2},
walkable = true,
selection_box = {
type = "fixed",
fixed = {-1.5, -0.5, -0.2, 1.5, 1.5, 0.2}
},
collision_box = {
type = "fixed",
fixed = {-1.5, -0.5, -0.2, 1.5, 1.5, 0.2}
},
})

-- ----------

core.register_node("terras_capixabas:caixadagua2", {
    description = "Caixa D´água Clara",
    tiles = {"caixadagua2.png"},
    drawtype = "mesh",
    mesh = "caixadagua.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:castelinho", {
    description = "Castelinho de Praia",
    tiles = {"castelinho.png"},
    drawtype = "mesh",
    mesh = "castelinho.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:caixa_som", {
    description = "Caixa de Som",
    tiles = {"caixa_som.png"},
    drawtype = "mesh",
    mesh = "caixa_som.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
selection_box = {
    type = "fixed",
    fixed = { -0.28125, -0.5, 0.125, 0.28125, 0.375, 0.5 }
},
collision_box = {
    type = "fixed",
    fixed = { -0.28125, -0.5, 0.125, 0.28125, 0.375, 0.5 }
}
})

core.register_node("terras_capixabas:boleba", {
    description = "Boleba",
    tiles = {"boleba.png"},
    drawtype = "mesh",
    mesh = "boleba.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:peao", {
    description = "Peao",
    tiles = {"peao.png"},
    drawtype = "mesh",
    mesh = "peao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

-- Lixeira Closed
core.register_node("terras_capixabas:lixeira", {
    description = "Lixeira",
    tiles = {"lixeira.png"},
    drawtype = "mesh",
    mesh = "lixeira.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = { -0.3125, -0.53125, -0.3125, 0.3125, 0.34375, 0.3125 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.3125, -0.53125, -0.3125, 0.3125, 0.34375, 0.3125 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- swap to open version
        core.set_node(pos, {name = "terras_capixabas:lixeira_open", param2 = node.param2})
        -- play sound
        core.sound_play("abrir_aco", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})

-- Lixeira Open
core.register_node("terras_capixabas:lixeira_open", {
    description = "Lixeira (Aberta)",
    tiles = {"lixeira.png"},
    drawtype = "mesh",
    mesh = "lixeira_open.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3, not_in_creative_inventory = 1},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = { -0.3125, -0.53125, -0.3125, 0.3125, 0.34375, 0.3125 }
    },
    collision_box = {
        type = "fixed",
        fixed = { -0.3125, -0.53125, -0.3125, 0.3125, 0.34375, 0.3125 }
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        -- swap back to closed version
        core.set_node(pos, {name = "terras_capixabas:lixeira", param2 = node.param2})
        -- optional: play sound again
        core.sound_play("abrir_aco", {pos = pos, gain = 1.0, max_hear_distance = 10})
    end,
})


core.register_node("terras_capixabas:lixeirinha", {
    description = "lixeirinha",
    tiles = {"lixeirinha.png"},
    drawtype = "mesh",
    mesh = "lixeirinha.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
selection_box = {
    type = "fixed",
    fixed = { -0.21875, -0.499375, -0.21875, 0.21875, 0.000625, 0.21875 }
},
collision_box = {
    type = "fixed",
    fixed = { -0.21875, -0.499375, -0.21875, 0.21875, 0.000625, 0.21875 }
}
})

core.register_node("terras_capixabas:varal", {
    description = "varal",
    tiles = {"varal.png"},
    drawtype = "mesh",
    mesh = "varal.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

-- ---

core.register_node("terras_capixabas:botijao", {
    description = "Botijao",
    tiles = {"botijao.png"},
    drawtype = "mesh",
    mesh = "botijao.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:botijao_capinha", {
    description = "Botijao encapado",
    tiles = {"botijao_capinha.png"},
    drawtype = "mesh",
    mesh = "botijao_capinha.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    use_texture_alpha = "clip",
    backface_culling = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:brinquedos", {
    description = "Brinquedos",
    tiles = {"brinquedos.png"},
    drawtype = "mesh",
    mesh = "brinquedos.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:earthball", {
description = "Earthball",
tiles = {"earthball.png"},
drawtype = "normal",
paramtype = "light",
groups = {snappy = 3, oddly_breakable_by_hand = 3},
walkable = true,
diggable = true,
selection_box = {
type = "fixed",
fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},
collision_box = {
type = "fixed",
fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
},

on_construct = function(pos)
local meta = core.get_meta(pos)
meta:set_string("muted", "false")
meta:set_string("current_sound", "")
meta:set_int("sound_handle", -1)
end,

on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
local meta = core.get_meta(pos)
local muted = meta:get_string("muted")
local player_name = clicker:get_player_name()

if muted == "true" then
meta:set_string("muted", "false")
core.chat_send_player(player_name, "Earthball sound: ON")
else
local handle = meta:get_int("sound_handle")
if handle ~= -1 then
core.sound_stop(handle)
meta:set_int("sound_handle", -1)
end
meta:set_string("muted", "true")
core.chat_send_player(player_name, "Earthball sound: OFF")
end
end,

on_destruct = function(pos)
local meta = core.get_meta(pos)
local handle = meta:get_int("sound_handle")
if handle ~= -1 then
core.sound_stop(handle)
end
end
})

-- Helper function to manage sound updates
local function update_earthball_sound(pos)
local meta = core.get_meta(pos)
if not meta or meta:get_string("muted") == "true" then return end

local time_of_day = core.get_timeofday()
local new_sound = (time_of_day >= 0.23 and time_of_day <= 0.75) and "day" or "night"
local current_sound = meta:get_string("current_sound")
local handle = meta:get_int("sound_handle")

if current_sound ~= new_sound or handle == -1 then
if handle ~= -1 then
core.sound_stop(handle)
end
local new_handle = core.sound_play(new_sound, {
gain = 1.0,
loop = true,
max_hear_distance = -1
})
meta:set_int("sound_handle", new_handle)
meta:set_string("current_sound", new_sound)
end
end

-- Regular sound updates via ABM
core.register_abm({
label = "Earthball sound manager",
nodenames = {"terras_capixabas:earthball"},
interval = 5,
chance = 1,
action = function(pos, node)
update_earthball_sound(pos)
end
})

-- Restart sounds on server load, with added check for your proximity to force playback
core.register_on_mods_loaded(function()
core.after(1.0, function()
local earthballs = core.find_nodes_in_area_under_air(
{x=-32768, y=-32768, z=-32768},
{x=32768, y=32768, z=32768},
{"terras_capixabas:earthball"}
)
if earthballs and #earthballs > 0 then
-- get your player object to check distance
local player = core.get_player_by_name("your_player_name_here")
for _, pos in ipairs(earthballs) do
-- Always run the regular update (existing behavior)
update_earthball_sound(pos)
-- Additionally, if you are close, enforce playback start immediately
if player then
local ppos = player:get_pos()
if vector.distance(pos, ppos) <= 100 then
update_earthball_sound(pos)
end
end
end
end
end)
end)


core.register_node("terras_capixabas:boca_rica", {
    description = "boca_rica",
    tiles = {"boca_rica.png"},
    drawtype = "mesh",
    mesh = "boca_rica.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

core.register_node("terras_capixabas:sabonete", {
    description = "sabonete",
    tiles = {"sabonete.png"},
    drawtype = "mesh",
    mesh = "sabonete.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	backface_culling = true,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = true,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

local function register_seat(name, def)
 core.register_node("terras_capixabas:"..name, {
  description = def.description,
  tiles = {def.texture},
  drawtype = "mesh",
  mesh = def.mesh,
  paramtype = "light",
  paramtype2 = "facedir",
  groups = {choppy = 2, oddly_breakable_by_hand = 2},
  walkable = true,
  use_texture_alpha = "clip",
  selection_box = {
   type = "fixed",
   fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
  },
  collision_box = {
   type = "fixed",
   fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5}
  },
  on_rightclick = sit_behavior.on_rightclick,
  on_destruct = sit_behavior.on_destruct,
 })
end

local seats = {
 {name="cadeira", description="Cadeira", texture="cadeira.png", mesh="cadeira.obj"},
 {name="cadeira_praia", description="Cadeira de Praia", texture="cadeira_praia.png", mesh="cadeira_praia.obj"},
 {name="escola_cadeira", description="Escola Cadeira", texture="escola_cadeira.png", mesh="escola_cadeira.obj"},
 {name="rua_mesa_assento", description="rua_mesa_assento", texture="rua_mesa.png", mesh="rua_mesa_assento.obj"},
}

for _, seat in ipairs(seats) do
 register_seat(seat.name, seat)
end

core.register_node("terras_capixabas:lp_zeze", {
    description = "lp_zeze",
    tiles = {"lp_zeze.png"},
    drawtype = "mesh",
    mesh = "lp_zeze.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {snappy = 3, oddly_breakable_by_hand = 3},
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, -0.4, 0.5}
    }
})

-- ---

core.register_node("terras_capixabas:cama_solteiro", {
    description = "cama_solteiro",
    tiles = {"cama.png"},
    drawtype = "mesh",
    mesh = "cama_solteiro.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -1.5, 0.5, 0, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -1.5, 0.5, 0, 0.5}
    },
	
    on_rightclick = lay_behavior.on_rightclick,
    on_destruct = lay_behavior.on_destruct,
})


core.register_node("terras_capixabas:cama_casal", {
    description = "cama_casal",
    tiles = {"cama.png"},
    drawtype = "mesh",
    mesh = "cama_casal.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -1.5, 0.5, -0.1, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -1.5, 0.5, -0.1, 0.5}
    },

    on_rightclick = lay_behavior.on_rightclick,
    on_destruct = lay_behavior.on_destruct,
})


core.register_node("terras_capixabas:cama_beliche", {
    description = "cama_beliche",
    tiles = {"cama.png"},
    drawtype = "mesh",
    mesh = "cama_beliche.obj",
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {choppy = 2, oddly_breakable_by_hand = 2},
    walkable = true,
    use_texture_alpha = "clip",
    selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -1.5, 0.5, -0.1, 0.5}
    },
    collision_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -1.5, 0.5, 0.1, 0.5}
    },

    on_rightclick = lay_behavior.on_rightclick,
    on_destruct = lay_behavior.on_destruct,
})

-- PLACA DE AVISO ----------------

core.register_node("terras_capixabas:placa_aviso", {
    description = "Placa de aviso",
    tiles = {"placa_aviso.png"},
    drawtype = "mesh",
    mesh = "placa_aviso.obj",
    paramtype = "light",
    paramtype2 = "facedir",
	use_texture_alpha = "clip",
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    walkable = false,
	selection_box = {
        type = "fixed",
        fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}
    }
})

-- -------

core.register_node("terras_capixabas:ventilador_base", {
    description = "Ventilador Base",
    drawtype = "mesh",
    mesh = "ventilador_base.obj",
    tiles = {"ventilador_base.png"},
    paramtype = "light",
    walkable = false,
    collision_box = { type = "fixed", fixed = {} },
    selection_box = {
        type = "fixed",
        fixed = {-0.5, 0.28125, -0.5, 0.5, 0.65625, 0.5}
    },
    groups = {cracky = 2},
})

-- --------------------------

local function ventilador_toggle(pos, node)
    local next_name =
        node.name == "terras_capixabas:ventilador"
        and "terras_capixabas:ventilador_on"
        or "terras_capixabas:ventilador"

    core.swap_node(pos, {name = next_name})
    core.sound_play("toggle", {pos = pos, gain = 1.0})
end

-- OFF state
core.register_node("terras_capixabas:ventilador", {
    description = "Ventilador",
    drawtype = "mesh",
    mesh = "ventilador.obj",
    tiles = {"ventilador.png"},
    paramtype = "light",
    use_texture_alpha = "clip",       -- <-- fixes transparency
    walkable = false,
    collision_box = { type = "fixed", fixed = {} },
    selection_box = {
        type = "fixed",
        fixed = {-0.5, 0.875, -0.5, 0.5, 1.25, 0.5}
    },
    groups = {cracky = 2},

    on_rightclick = function(pos, node)
        ventilador_toggle(pos, node)
    end,
})

core.register_node("terras_capixabas:ventilador_on", {
    description = nil,
    drawtype = "mesh",
    mesh = "ventilador_on.obj",
    tiles = { {
        name = "ventilador_on.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 21,
            aspect_h = 21,
            length = 0.4
        }
    } },
    paramtype = "light",
    paramtype2 = "facedir",
    use_texture_alpha = "clip",
    backface_culling = false,      -- THIS is key to stop stretching
    walkable = false,
    collision_box = { type = "fixed", fixed = {} },
    selection_box = {
        type = "fixed",
        fixed = {-0.5, 0.875, -0.5, 0.5, 1.25, 0.5}
    },
    groups = {cracky = 2, not_in_creative_inventory = 1},

    on_rightclick = function(pos, node)
        ventilador_toggle(pos, node)
    end,
})





core.register_node("terras_capixabas:radio", {
    description = "Radio",
    drawtype = "mesh",
    mesh = "radio.obj",
    tiles = {"radio.png"},
    backface_culling = false,
	use_texture_alpha = "clip",	
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
selection_box = {
    type = "fixed",
    fixed = { -0.40625, -0.46875, -0.125, 0.40625, 0.15625, 0.125 }
},
collision_box = {
    type = "fixed",
    fixed = {
        { -0.40625, -0.46875, -0.125, 0.40625, 0.03125, 0.125 }, -- Main body
        { -0.15625, 0.03125, -0.03125, 0.15625, 0.15625, 0.03125 } -- Top part
    }
},

    on_construct = function(pos)
        local meta = core.get_meta(pos)
        meta:set_string("state", "off")
    end,

    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        local meta = core.get_meta(pos)
        local state = meta:get_string("state")
        local sound_handle = meta:get_int("sound_handle")

        if state == "off" then
            -- Turn on
            meta:set_string("state", "on")
            -- Play looping sound
            local handle = core.sound_play("aerosol_of_my_love", {
                pos = pos,
                gain = 1.0,
                max_hear_distance = 15,
                loop = true,
            })
            meta:set_int("sound_handle", handle or 0)
            core.chat_send_player(clicker:get_player_name(), "Radio turned ON.")
        else
            -- Turn off
            meta:set_string("state", "off")
            if sound_handle and sound_handle ~= 0 then
                core.sound_stop(sound_handle)
            end
            core.chat_send_player(clicker:get_player_name(), "Radio turned OFF.")
        end
    end,
})


local lamps={}
local last_phase=nil

local function is_day()
local t=core.get_timeofday()
return t>0.2 and t<0.8
end

local function get_phase()
return is_day() and 1 or 2
end

local function update_all_lamps(phase_changed)
for hash,_ in pairs(lamps) do
local pos=core.get_position_from_hash(hash)
local node=core.get_node_or_nil(pos)
if node then
local meta=core.get_meta(pos)
if phase_changed then meta:set_int("forced",0) end
if meta:get_int("forced")==0 then
local target=is_day() and "terras_capixabas:lampada_off" or "terras_capixabas:lampada_on"
if node.name~=target then
core.swap_node(pos,{name=target,param2=node.param2})
end
end
end
end
end

core.register_globalstep(function(dtime)
local phase=get_phase()
if last_phase==nil then last_phase=phase return end
if phase~=last_phase then
last_phase=phase
update_all_lamps(true)
end
end)

local function register_lamp(pos)
lamps[core.hash_node_position(pos)]=true
local meta=core.get_meta(pos)
meta:set_int("forced",0)
end

local function unregister_lamp(pos)
lamps[core.hash_node_position(pos)]=nil
end

-- LAMPADA

local function is_daytime()
local t=core.get_timeofday()
return t>0.2 and t<0.8
end

local function set_auto_state(pos)
local node=core.get_node(pos)
local meta=core.get_meta(pos)
local forced=meta:get_int("forced_state")
if forced==1 then return end
local day=is_daytime()
local target=day and "terras_capixabas:lampada_off" or "terras_capixabas:lampada_on"
if node.name~=target then
core.swap_node(pos,{name=target,param2=node.param2})
end
end

local function register_abm()
core.register_abm({
label="Lampada auto",
nodenames={"terras_capixabas:lampada_off","terras_capixabas:lampada_on"},
interval=10,
chance=1,
action=function(pos,node)
local meta=core.get_meta(pos)
local last_period=meta:get_int("last_period")
local day=is_daytime() and 1 or 2
if last_period~=day then
meta:set_int("forced_state",0)
meta:set_int("last_period",day)
end
set_auto_state(pos)
end
})
end

-- Lampada OFF
core.register_node("terras_capixabas:lampada_off",{
description="Lampada (Off)",
drawtype="mesh",
mesh="lampada_off.obj",
tiles={"lampada_off.png"},
use_texture_alpha="blend",
backface_culling=false,
walkable=false,
paramtype="light",
paramtype2="facedir",
sunlight_propagates=true,
groups={oddly_breakable_by_hand=3},
selection_box={type="fixed",fixed={-0.3,-0.1,-0.3,0.3,0.5,0.3}},
collision_box={type="fixed",fixed={}},
on_construct=function(pos)
local meta=core.get_meta(pos)
meta:set_int("forced_state",0)
meta:set_int("last_period",is_daytime() and 1 or 2)
set_auto_state(pos)
end,
on_rightclick=function(pos,node)
local meta=core.get_meta(pos)
meta:set_int("forced_state",1)
core.sound_play("toggle",{pos=pos,gain=1.0,max_hear_distance=10})
core.swap_node(pos,{name="terras_capixabas:lampada_on",param2=node.param2})
end
})

-- Lampada ON
core.register_node("terras_capixabas:lampada_on",{
description="Lampada (On)",
drawtype="mesh",
mesh="lampada_on.obj",
tiles={"lampada_on.png"},
use_texture_alpha="blend",
backface_culling=false,
walkable=false,
paramtype="light",
paramtype2="facedir",
sunlight_propagates=true,
light_source=11,
groups={oddly_breakable_by_hand=3,not_in_creative_inventory=1},
selection_box={type="fixed",fixed={-0.3,-0.1,-0.3,0.3,0.5,0.3}},
collision_box={type="fixed",fixed={}},
on_construct=function(pos)
local meta=core.get_meta(pos)
meta:set_int("forced_state",0)
meta:set_int("last_period",is_daytime() and 1 or 2)
set_auto_state(pos)
end,
on_rightclick=function(pos,node)
local meta=core.get_meta(pos)
meta:set_int("forced_state",1)
core.sound_play("toggle",{pos=pos,gain=1.0,max_hear_distance=10})
core.swap_node(pos,{name="terras_capixabas:lampada_off",param2=node.param2})
end
})

register_abm()




-- Lampiao (Off)
core.register_node("terras_capixabas:lampiao", {
    description = "Lampiao",
    drawtype = "mesh",
    mesh = "lampiao.obj",
    tiles = {"lampiao.png"},
    use_texture_alpha = "blend",
    backface_culling = false,
    walkable = false,
    paramtype = "light",
    paramtype2 = "facedir",
    groups = {dig_immediate = 3},
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2},
    },
    collision_box = {
        type = "fixed",
        fixed = {},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("lighter", {pos = pos, gain = 1.0, max_hear_distance = 10})
        core.swap_node(pos, {name = "terras_capixabas:lampiao_aceso", param2 = node.param2})
    end,
})

-- Lampiao Aceso (On)
core.register_node("terras_capixabas:lampiao_aceso", {
    description = "Lampiao Aceso",
    drawtype = "mesh",
    mesh = "lampiao_aceso.obj",
    tiles = {{
        name = "lampiao_aceso.png",
        animation = {
            type = "vertical_frames",
            aspect_w = 16,
            aspect_h = 16,
            length = 0.06
        }
    }},
    use_texture_alpha = "blend",
    backface_culling = false,
    walkable = false,
    paramtype = "light",
    paramtype2 = "facedir",
    light_source = math.floor(core.LIGHT_MAX / 2),
    groups = {dig_immediate = 3, not_in_creative_inventory = 1},
    selection_box = {
        type = "fixed",
        fixed = {-0.2, -0.5, -0.2, 0.2, 0.3, 0.2},
    },
    collision_box = {
        type = "fixed",
        fixed = {},
    },
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        core.sound_play("lighter", {pos = pos, gain = 1.0, max_hear_distance = 10})
        core.swap_node(pos, {name = "terras_capixabas:lampiao", param2 = node.param2})
    end,
})