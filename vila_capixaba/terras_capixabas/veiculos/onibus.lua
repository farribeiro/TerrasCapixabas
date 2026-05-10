-- terras_capixabas/veiculos/onibus.lua

-- Local references for performance
local vector_add = vector.add
local math_pi = math.pi
local core_sound_play = core.sound_play
local core_sound_stop = core.sound_stop
local core_get_timeofday = core.get_timeofday
local core_get_connected_players = core.get_connected_players

local SOUND_RANGE = 64
local SOUND_RANGE2 = SOUND_RANGE * SOUND_RANGE
local BOARD_RADIUS = 4
local BOARD_RADIUS2 = BOARD_RADIUS * BOARD_RADIUS

-- Ônibus Entity
core.register_entity("terras_capixabas:onibus", {
    initial_properties = {
        physical = false,
        collide_with_objects = false,
        collisionbox = {-0.6, 0, -1.2, 0.6, 1.8, 1.2},
        visual = "mesh",
        mesh = "onibus.glb",
        textures = {"onibus.png"},
        visual_size = {x=1, y=1},
        backface_culling = false,
    },

    _animation_ranges = {
        driving = {x=0, y=1},
    },

    _mode = "hidden",
    _phase = 1,
    _sound_handle = nil,
    _player_check_timer = 0,
    driver = nil,

    on_activate = function(self, staticdata)
        self.object:set_acceleration({x=0, y=0, z=0})
        self:set_animation("driving")

        local tod = core_get_timeofday()
        local is_day = tod > 0.23 and tod < 0.8

        self._mode = is_day and "visible" or "hidden"
        self.object:set_properties({is_visible = is_day})
    end,

    get_staticdata = function(self)
        return core.serialize({phase = self._phase})
    end,

    set_animation = function(self, anim)
        local r = self._animation_ranges[anim]
        if r then
            self.object:set_animation({x=r.x, y=r.y}, 1, 1, true)
        end
    end,

    -- SAFE DETACH
    detach_driver = function(self)
        if not self.driver then return end
        self.driver:set_detach()
        self.driver:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
        self.driver:set_physics_override({speed=1, jump=1, gravity=1})
        self.driver = nil
    end,

    -- BOARDING
    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end
        if self.driver or self._mode ~= "visible" then return end

        local epos = self.object:get_pos()
        local ppos = clicker:get_pos()
        if not epos or not ppos then return end

        local dx = epos.x - ppos.x
        local dy = epos.y - ppos.y
        local dz = epos.z - ppos.z
        if (dx*dx + dy*dy + dz*dz) > BOARD_RADIUS2 then return end

        self.driver = clicker
        clicker:set_attach(self.object, "", {x=0, y=6, z=0}, {x=0, y=0, z=0})
        clicker:set_eye_offset({x=0, y=5, z=0}, {x=0, y=22, z=-15})
        clicker:set_physics_override({speed=0, jump=0, gravity=0})
    end,

    on_step = function(self, dtime)
        local tod = core_get_timeofday()
        local is_day = tod > 0.23 and tod < 0.8
        local pos = self.object:get_pos()

        -- visibility
        if is_day and self._mode == "hidden" then
            self._mode = "visible"
            self.object:set_properties({is_visible=true})
            self:set_animation("driving")

        elseif not is_day and self._mode == "visible" then
            self._mode = "hidden"
            self.object:set_properties({is_visible=false})
            self.object:set_velocity({x=0, y=0, z=0})
            self:detach_driver()
            if self._sound_handle then
                core_sound_stop(self._sound_handle)
                self._sound_handle = nil
            end
            return
        end

        if self._mode ~= "visible" then return end

        -- detach on jump
        if self.driver then
            local ctrl = self.driver:get_player_control()
            if ctrl.jump then self:detach_driver() end
        end

        -- sound
        self._player_check_timer = self._player_check_timer + dtime
        if self._player_check_timer > 0.5 then
            self._player_check_timer = 0
            local heard = false

            for _, p in ipairs(core_get_connected_players()) do
                local pp = p:get_pos()
                local dx = pos.x - pp.x
                local dy = pos.y - pp.y
                local dz = pos.z - pp.z
                if (dx*dx + dy*dy + dz*dz) <= SOUND_RANGE2 then
                    heard = true
                    break
                end
            end

            if heard then
                if not self._sound_handle then
                    self._sound_handle = core_sound_play("onibus", {
                        object=self.object,
                        loop=true,
                        gain=1.5,
                        max_hear_distance=SOUND_RANGE
                    })
                end
            elseif self._sound_handle then
                core_sound_stop(self._sound_handle)
                self._sound_handle = nil
            end
        end

        -- movement
        local vel = {x=0, y=0, z=0}

        if self._phase == 1 then
            if pos.z < -213 then 
                vel.z = 6 
                self.object:set_yaw(0) 
            else 
                self._phase = 2 
            end
        elseif self._phase == 2 then
            if pos.x > -452 then 
                vel.x = -6 
                self.object:set_yaw(math_pi/2) 
            else 
                self._phase = 3 
            end
        elseif self._phase == 3 then
            if pos.z > -407 then 
                vel.z = -6 
                self.object:set_yaw(math_pi) 
            else 
                self._phase = 4 
            end
        elseif self._phase == 4 then
            if pos.x < -402 then 
                vel.x = 6 
                self.object:set_yaw(-math_pi/2) 
            else 
                self._phase = 1 
            end
        end

        self.object:set_velocity(vel)
    end,

    on_punch = function(self, puncher)
        self:detach_driver()
        if self._sound_handle then
            core_sound_stop(self._sound_handle)
            self._sound_handle = nil
        end
        self.object:remove()
    end,

    on_deactivate = function(self)
        self:detach_driver()
        if self._sound_handle then
            core_sound_stop(self._sound_handle)
            self._sound_handle = nil
        end
    end
})

-- Spawn Egg
core.register_craftitem("terras_capixabas:pe_onibus", {
    description = "Ônibus Spawn Egg",
    inventory_image = "onibus_inv.png",
    
    on_place = function(itemstack, placer, pointed_thing)
        if pointed_thing.type ~= "node" then return itemstack end
        local pos = vector_add(pointed_thing.above, {x=0, y=0.5, z=0})
        core.add_entity(pos, "terras_capixabas:onibus")
        if not core.is_creative_enabled(placer:get_player_name()) then
            itemstack:take_item()
        end
        return itemstack
    end
})