-- folclore_npcs.lua
-- Ghost NPCs - Independent registration (doesn't need npc_behavior)

local function register_ghost_npc(name, texture, mesh)
    local def = {
        mesh = mesh or "npc.glb",
        visual = "mesh",
        textures = {texture},
        use_texture_alpha = true,
        physical = false,
        collide_with_objects = false,
        collisionbox = {-0.3, -0.01, -0.3, 0.3, 1.8, 0.3},
        name = name:match(":(.+)$") or name,
        hp_max = 1,

        on_activate = function(self, staticdata)
            self.state = "ghost_wander"
            self.timer = 0
            self.footstep_timer = 0
            self.wander_reset_timer = 0
            local pos = self.object:get_pos()
            self.spawn_pos = vector.new(pos.x, 4.5, pos.z)
            self.wander_target = nil
            self.stop_timer = 0
            self.current_animation = nil
            self.health = 1

            if staticdata and staticdata ~= "" then
                local data = core.deserialize(staticdata)
                if data then
                    for k,v in pairs(data) do self[k] = v end
                    if self.spawn_pos then self.spawn_pos.y = 4.5 end
                end
            end

            self.object:set_pos(vector.new(pos.x, 4.5, pos.z))
            self:update_visibility()
            self:set_animation("walk")
        end,

        update_visibility = function(self)
            local t = core.get_timeofday()
            local night = t < 0.2 or t > 0.8
            if night then
                self.object:set_properties({
                    visual = "mesh",
                    textures = {texture},
                    visual_size = {x=1, y=1}
                })
            else
                self.object:set_properties({
                    visual = "sprite",
                    textures = {"transparent.png"},
                    visual_size = {x=0, y=0}
                })
            end
        end,

        get_staticdata = function(self)
            return core.serialize({
                spawn_pos = self.spawn_pos,
                wander_target = self.wander_target,
                stop_timer = self.stop_timer,
                wander_reset_timer = self.wander_reset_timer,
                current_animation = self.current_animation,
                health = self.health
            })
        end,

        on_punch = function(self, puncher)
            local t = core.get_timeofday()
            if not (t < 0.2 or t > 0.8) then return true end
            local tool = puncher:get_wielded_item():get_name()
            if tool == "" or tool == "default:torch" or tool:find("sword") then
                self.health = self.health - 1
                if self.health <= 0 then
                    core.sound_play("default_dig_cracky",{pos=self.object:get_pos(),gain=0.8})
                    self.object:remove()
                else
                    core.sound_play("default_dig_crumbly",{pos=self.object:get_pos(),gain=0.5})
                end
            end
            return true
        end,

        on_step = function(self, dtime)
            self:update_visibility()
            local t = core.get_timeofday()
            if not (t < 0.2 or t > 0.8) then
                self.object:set_velocity({x=0,y=0,z=0})
                return
            end

            local pos = self.object:get_pos()
            if pos.y ~= 4.5 then
                self.object:set_pos({x=pos.x,y=4.5,z=pos.z})
                pos = self.object:get_pos()
            end

            self.timer = (self.timer or 0) + dtime
            self.wander_reset_timer = (self.wander_reset_timer or 0) + dtime

            local dist_spawn = vector.distance(pos, self.spawn_pos)

            if dist_spawn > 8 then
                local dir = vector.direction(pos, self.spawn_pos)
                local yaw = math.atan2(dir.z, dir.x) - math.pi/2
                self.object:set_yaw(yaw)
                self.object:set_velocity({x=dir.x*2,y=0,z=dir.z*2})
                self.wander_target = nil
                self.stop_timer = 0
                return self:set_animation("walk")
            end

            if self.wander_reset_timer > 5 then
                self.wander_target = nil
                self.wander_reset_timer = 0
            end

            if (self.stop_timer or 0) > 0 then
                self.stop_timer = self.stop_timer - dtime
                self.object:set_velocity({x=0,y=0,z=0})
                return self:set_animation("idle")
            end

            if not self.wander_target or vector.distance(pos, self.wander_target) < 0.5 then
                local angle = math.random() * math.pi * 2
                local dist = math.random(3,6)
                self.wander_target = {
                    x = self.spawn_pos.x + math.cos(angle)*dist,
                    y = 4.5,
                    z = self.spawn_pos.z + math.sin(angle)*dist
                }
                self.stop_timer = math.random(2,5)
                self.wander_reset_timer = 0
            end

            if self.wander_target then
                local dir = vector.direction(pos, self.wander_target)
                local yaw = math.atan2(dir.z, dir.x) - math.pi/2
                self.object:set_yaw(yaw)
                self.object:set_velocity({x=dir.x*2,y=0,z=dir.z*2})
                return self:set_animation("walk")
            end
        end,

        set_animation = function(self, anim)
            if self.current_animation ~= anim and self.animations and self.animations[anim] then
                local a = self.animations[anim]
                self.object:set_animation({x=a.start,y=a.stop},a.speed,0,0.1)
                self.current_animation = anim
            end
        end,

        animations = {
            walk = {start=1.8,stop=2.4,speed=1},
            idle = {start=0,stop=0,speed=1}
        }
    }

    core.register_entity(name, def)

    core.register_craftitem(name.."_spawn", {
        description = (name:match(":(.+)$") or name).." Spawn Egg",
        inventory_image = texture:gsub(".png","_inv.png"),
        wield_image = texture:gsub(".png","_inv.png"),
        stack_max = 99,
        groups = {spawn_egg=1},
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.type=="node" then
                local pos = pointed_thing.above
                pos.y = 4.5
                core.add_entity(pos, name)
                if not core.is_creative_enabled(placer:get_player_name()) then
                    itemstack:take_item()
                end
            end
            return itemstack
        end
    })
end

-- Register ghost NPCs
register_ghost_npc("terras_capixabas:pe_cuca","pe_cuca.png","npcf.glb")
register_ghost_npc("terras_capixabas:pe_saci","pe_saci.png","npc.glb")
register_ghost_npc("terras_capixabas:pe_curupira","pe_curupira.png","npc.glb")