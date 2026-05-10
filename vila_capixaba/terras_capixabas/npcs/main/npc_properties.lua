-- npcs/init.lua (merged: 0_init.lua + core.lua + config)
-- Complete NPC system initialization

local modpath = core.get_modpath("terras_capixabas")

-- === LOAD DEPENDENCIES ===
local utils = dofile(modpath .. "/npcs/main/utils.lua")
local control = dofile(modpath .. "/npcs/main/formspec.lua")

-- === NPC DEFAULT PROPERTIES ===
local DEFAULT_PROPERTIES = {
    visual = "mesh", 
    visual_size = {x=1, y=1},
    use_texture_alpha = false,   
    lifetime = 0,  -- 0 means no automatic despawn
    physical = true, 
    collide_with_objects = false,
    collisionbox = {-0.3, -0.01, -0.3, 0.3, 1, 0.3}, 
    stepheight = 1.1, 
    fall_damage = 0,
    water_damage = 0, 
    lava_damage = 0, 
    suffocation = false,
    pathfinding = 1,
    floats = 1,
    animations = {
        idle = {start = 0, stop = 0, speed = 1},
        sit = {start = 0.2, stop = 0.3, speed = 1}, 
        lay = {start = 0.4, stop = 0.5, speed = 1},
        stand_balcony = {start = 0.6, stop = 0.7, speed = 1},
        lay_on_belly = {start = 0.8, stop = 0.9, speed = 1},
        dance = {start = 1, stop = 1.6, speed = 1},
        walk = {start = 1.8, stop = 2.4, speed = 1}
    }
}

-- === MAIN NPC REGISTRATION FUNCTION ===
local function register_npc(name, texture, mesh)
    local def = {
        initial_properties = {
            mesh = mesh or "npc.glb",
            visual = DEFAULT_PROPERTIES.visual,
            textures = {texture},
            backface_culling = name ~= "terras_capixabas:carroca",
            -- Add all physical/visual properties here:
            visual_size = DEFAULT_PROPERTIES.visual_size,
            use_texture_alpha = DEFAULT_PROPERTIES.use_texture_alpha,
            physical = DEFAULT_PROPERTIES.physical,
            collide_with_objects = DEFAULT_PROPERTIES.collide_with_objects,
            collisionbox = DEFAULT_PROPERTIES.collisionbox,
            stepheight = DEFAULT_PROPERTIES.stepheight,
            lifetime = DEFAULT_PROPERTIES.lifetime
        },

        name = name:match(":(.+)$") or name,

        on_activate = function(self, staticdata)
            local behavior = dofile(modpath .. "/npcs/behaviors/movement_behavior.lua")
            for k,v in pairs(behavior) do
                if type(v) == "function" then
                    self[k] = v
                end
            end
            self.animations = DEFAULT_PROPERTIES.animations
            self.set_animation = behavior.set_animation
            behavior.on_activate(self, staticdata)
        end,

        on_rightclick = function(self, clicker)
            control.on_rightclick(self, clicker)
        end,

        on_step = function(self, dtime)
            local behavior = dofile(modpath .. "/npcs/behaviors/movement_behavior.lua")
            behavior.on_step(self, dtime)
        end,

        get_staticdata = function(self)
            return utils.serialize_state(self)
        end
    }

    -- Add remaining properties that should be in initial_properties
    def.initial_properties.fall_damage = DEFAULT_PROPERTIES.fall_damage
    def.initial_properties.water_damage = DEFAULT_PROPERTIES.water_damage
    def.initial_properties.lava_damage = DEFAULT_PROPERTIES.lava_damage
    def.initial_properties.suffocation = DEFAULT_PROPERTIES.suffocation
    def.initial_properties.pathfinding = DEFAULT_PROPERTIES.pathfinding
    def.initial_properties.floats = DEFAULT_PROPERTIES.floats

    -- Register the entity
    core.register_entity(name, def)

    -- Register spawn egg
    core.register_craftitem(name .. "_spawn", {
        description = name:match(":(.+)$") .. " Spawn Egg",
        inventory_image = texture:gsub(".png", "_inv.png"),
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above then
                local new_ent = core.add_entity(pointed_thing.above, name)
                if new_ent then
                    local new_luaent = new_ent:get_luaentity()
                    if new_luaent then
                        new_luaent.id = utils.generate_unique_id()
                        new_luaent.spawn_pos = vector.round(pointed_thing.above)
                        new_luaent.state = "walk"
                        new_luaent.current_animation = "walk"
                    end
                end
            end
            itemstack:take_item()
            return itemstack
        end
    })

    core.log("action", "[Terra's Capixabas] " .. name .. " NPC loaded!")
end

-- === PUBLIC API ===
local npc_behavior = {}

npc_behavior.DEFAULT_PROPERTIES = DEFAULT_PROPERTIES
npc_behavior.register_npc = register_npc

npc_behavior.set_animation = function(self, anim)
    local behavior = dofile(modpath .. "/npcs/behaviors/movement_behavior.lua")
    behavior.set_animation(self, anim)
end

npc_behavior.generate_unique_id = function()
    return utils.generate_unique_id()
end

-- Export for other files if needed
npc_behavior.utils = utils
npc_behavior.control = control

return npc_behavior