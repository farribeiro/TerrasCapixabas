-- terras_capixabas/veiculos/trem_rffsa.lua

-- Local references for performance
local vector_distance = vector.distance
local core_sound_play = core.sound_play
local core_sound_stop = core.sound_stop
local core_get_connected_players = core.get_connected_players

local SOUND_RANGE = 64

-- Trem RFFSA Entity
core.register_entity("terras_capixabas:trem_rffsa", {
    initial_properties = {
        physical = false,
        collide_with_objects = false,
        collisionbox = {-1, 0, -1, 1, 2, 1},
        visual = "mesh",
        mesh = "trem_rffsa.glb",
        textures = {"trem_rffsa.png"},
        visual_size = {x=1, y=1},
        backface_culling = false,
        is_visible = true,
        makes_footstep_sound = false,
        static_save = true
    },

    on_activate = function(self)
        local pos = self.object:get_pos()
        pos.x = -489
        self.object:set_pos(pos)
        self.speed = 2
        self.sound_handle_locomotiva = nil
        self.sound_handle_vagao = nil
        self._sound_cooldown = 0
        self._player_check_timer = 0
    end,

    on_step = function(self, dtime)
        local pos = self.object:get_pos()
        if not pos then return end

        local new_z = pos.z - (self.speed * dtime)
        if new_z <= -502 then
            new_z = -200
            self.object:set_pos({x = -489, y = pos.y, z = new_z})
            if self.sound_handle_locomotiva then 
                core_sound_stop(self.sound_handle_locomotiva)
                self.sound_handle_locomotiva = nil 
            end
            if self.sound_handle_vagao then 
                core_sound_stop(self.sound_handle_vagao)
                self.sound_handle_vagao = nil 
            end
            self._sound_cooldown = 1
            return
        end
        self.object:set_pos({x = -489, y = pos.y, z = new_z})

        if self._sound_cooldown > 0 then
            self._sound_cooldown = self._sound_cooldown - dtime
            return
        end

        -- Check player proximity with timer
        self._player_check_timer = self._player_check_timer + dtime
        if self._player_check_timer > 0.5 then -- Check every 0.5 seconds
            self._player_check_timer = 0
            
            local players_nearby = false
            for _, player in ipairs(core_get_connected_players()) do
                local ppos = player:get_pos()
                if vector_distance(pos, ppos) <= SOUND_RANGE then
                    players_nearby = true
                    break
                end
            end

            if players_nearby then
                -- Start or restart sounds
                if not self.sound_handle_locomotiva then
                    self.sound_handle_locomotiva = core_sound_play("locomotiva", {
                        object = self.object,
                        loop = true,
                        gain = 1.0,
                        max_hear_distance = SOUND_RANGE
                    })
                end

                if not self.sound_handle_vagao then
                    local vagao_pos = {x = pos.x, y = pos.y, z = pos.z + 20}
                    self.sound_handle_vagao = core_sound_play("vagao", {
                        pos = vagao_pos,
                        loop = true,
                        gain = 1.0,
                        max_hear_distance = SOUND_RANGE
                    })
                end
            else
                -- Stop sounds if no one is nearby
                if self.sound_handle_locomotiva then
                    core_sound_stop(self.sound_handle_locomotiva)
                    self.sound_handle_locomotiva = nil
                end
                if self.sound_handle_vagao then
                    core_sound_stop(self.sound_handle_vagao)
                    self.sound_handle_vagao = nil
                end
            end
        end
    end,

    on_punch = function(self, puncher)
        if self.sound_handle_locomotiva then 
            core_sound_stop(self.sound_handle_locomotiva)
            self.sound_handle_locomotiva = nil 
        end
        if self.sound_handle_vagao then 
            core_sound_stop(self.sound_handle_vagao)
            self.sound_handle_vagao = nil 
        end
        self.object:remove()
    end,

    on_deactivate = function(self)
        if self.sound_handle_locomotiva then 
            core_sound_stop(self.sound_handle_locomotiva)
            self.sound_handle_locomotiva = nil 
        end
        if self.sound_handle_vagao then 
            core_sound_stop(self.sound_handle_vagao)
            self.sound_handle_vagao = nil 
        end
    end
})

core.register_craftitem("terras_capixabas:trem_rffsa", {
    description = "Locomotive Spawn Egg",
    inventory_image = "trem_rffsa_inv.png",
    
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type == "node" then
            local pos = pointed_thing.above
            pos.x = -489
            pos.y = pos.y + 0.5
            local node_below = core.get_node({x=pos.x, y=pos.y-1, z=pos.z})
            if node_below.name == "air" then pos.y = pos.y - 0.5 end
            core.add_entity(pos, "terras_capixabas:trem_rffsa")
            if not core.is_creative_enabled(placer:get_player_name()) then 
                itemstack:take_item() 
            end
            return itemstack
        end
    end
})