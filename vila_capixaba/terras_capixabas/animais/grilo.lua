-- GRILO
core.register_entity("terras_capixabas:grilo", {
  initial_properties = { physical = false, collide_with_objects = false, collisionbox = { -0.25, -0.25, -0.25, 0.25, 0.25, 0.25 }, visual = "mesh", mesh = "grilo.glb", textures = { "grilo.png" }, visual_size = { x = 1, y = 1 }, backface_culling = false, static_save = true },
  _mode = "hidden",
  _home_pos = nil,
  _move_timer = 0,
  _sound_handle = nil,
  on_activate = function(self, staticdata)
    local pos = self.object:get_pos()
    if staticdata and staticdata ~= "" then
      local data = core.deserialize(staticdata)
      if data then
        -- Adjust home_pos.y by subtracting 1 to lower model in world
        self._home_pos = data._home_pos or vector.round(pos)
        self._home_pos.y = self._home_pos.y - 1.5
        self._mode = data._mode or "hidden"
        self._move_timer = data._move_timer or 0
      else
        self._home_pos = vector.round(pos)
        self._home_pos.y = self._home_pos.y - 1.5
        self._mode = "hidden"
        self._move_timer = 0
      end
    else
      self._home_pos = vector.round(pos)
      self._home_pos.y = self._home_pos.y - 1.5
      self._mode = "hidden"
      self._move_timer = 0
    end
    self._sound_handle = nil
    self.object:set_properties({ is_visible = (self._mode == "visible") })
    local tod = core.get_timeofday()
    if self._mode == "visible" and (tod < 0.23 or tod > 0.8) then
      self._sound_handle = core.sound_play("grilo", {
        object = self.object,
        gain = 0.1,
        max_hear_distance = 16,
        loop = true
      })
    end
  end,
  get_staticdata = function(self)
    return core.serialize({ _home_pos = self._home_pos, _mode = self._mode, _move_timer = self._move_timer })
  end,
  on_step = function(self, dtime)
    local tod = core.get_timeofday()
    local is_night = tod < 0.23 or tod > 0.8
    self._move_timer = self._move_timer + dtime
    if is_night and self._mode == "hidden" then
      self._mode = "visible"
      self.object:set_properties({ is_visible = true })
      self._sound_handle = core.sound_play("grilo", {
        object = self.object,
        gain = 0.1,
        max_hear_distance = 16,
        loop = true
      })
    elseif not is_night and self._mode == "visible" then
      self._mode = "hidden"
      self.object:set_properties({ is_visible = false })
      self.object:set_pos(self._home_pos)
      if self._sound_handle then
        core.sound_stop(self._sound_handle)
        self._sound_handle = nil
      end
    end
    if self._mode == "visible" and self._move_timer >= 20 then
      self._move_timer = 0
      local offset_x = math.random(-8, 8)
      local offset_z = math.random(-8, 8)
      local target_pos = {
        x = self._home_pos.x + offset_x,
        y = self._home_pos.y, -- Keep Y fixed (already adjusted by -1)
        z = self._home_pos.z + offset_z
      }
      self.object:set_pos(target_pos)
    end
    -- Force Y position to home Y every step to prevent vertical movement
    local pos = self.object:get_pos()
    if pos and pos.y ~= self._home_pos.y then
      self.object:set_pos({ x = pos.x, y = self._home_pos.y, z = pos.z })
    end
  end,
  on_punch = function(self)
    if self._sound_handle then
      core.sound_stop(self._sound_handle)
      self._sound_handle = nil
    end
    self.object:remove()
  end,
  on_deactivate = function(self)
    if self._sound_handle then
      core.sound_stop(self._sound_handle)
      self._sound_handle = nil
    end
  end
})
core.register_craftitem("terras_capixabas:an_grilo", {
  description = "Grilo Spawn Egg",
  inventory_image = "grilo_inv.png",
  on_place = function(itemstack, placer, pointed_thing)
    if pointed_thing.type == "node" then
      local pos = pointed_thing.above
      pos.y     = pos.y + 0.5
      core.add_entity(pos, "terras_capixabas:grilo")
      if not core.is_creative_enabled(placer:get_player_name()) then itemstack:take_item() end
      return itemstack
    end
  end
})
