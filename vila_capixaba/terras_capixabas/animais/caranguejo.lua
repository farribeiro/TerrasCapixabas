-- CARANGUEJO

core.register_entity("terras_capixabas:caranguejo", {
  initial_properties = { physical = true, collide_with_objects = true, collisionbox = { -0.25, -0.25, -0.25, 0.25, 0.25, 0.25 }, visual = "mesh", mesh = "caranguejo.glb", textures = { "caranguejo.png" }, visual_size = { x = 1, y = 1 }, backface_culling = false, stepheight = 1.1, },
  _animation_ranges  = { walk = { x = 0, y = 0.58 }, },
  _mode              = "hidden",
  _home_pos          = nil,
  _phase             = 1,
  _target_z          = nil,
  on_activate        = function(self, staticdata)
    local pos = self.object:get_pos()
    if staticdata and staticdata ~= "" then
      local data     = core.deserialize(staticdata) or {}
      self._home_pos = data.home_pos or vector.round(pos)
      self._phase    = data.phase or 1
      self._target_z = data.target_z or (self._home_pos.z - 4)
    else
      self._home_pos = vector.round(pos)
      self._phase    = 1
      self._target_z = self._home_pos.z - 4
    end
    self._mode = "hidden"
    self.object:set_acceleration({ x = 0, y = -10, z = 0 })
    self.object:set_properties({ is_visible = false })
    self:set_animation("walk")
  end,
  get_staticdata     = function(self)
    return core.serialize({ home_pos = self._home_pos, phase = self._phase, target_z = self._target_z, })
  end,
  set_animation      = function(self, anim)
    local range = self._animation_ranges[anim]
    if range then self.object:set_animation({ x = range.x, y = range.y }, 1, 1, true) end
  end,
  on_step            = function(self, dtime)
    local tod    = core.get_timeofday()
    local is_day = tod > 0.23 and tod < 0.8

    if is_day and self._mode == "hidden" then
      self._mode = "visible"
      self.object:set_properties({ is_visible = true })
      self:set_animation("walk")
    elseif not is_day and self._mode == "visible" then
      self._mode = "hidden"
      self.object:set_properties({ is_visible = false })
      self.object:set_velocity({ x = 0, y = 0, z = 0 })
      return
    end
    if self._mode == "hidden" then return end
    local pos   = self.object:get_pos()
    local dir_z = (self._phase == 1) and -1 or 1
    -- Face direction
    self.object:set_yaw((self._phase == 1) and 0 or math.pi)
    -- Obstacle detection
    local ray_start = { x = pos.x, y = pos.y + 0.1, z = pos.z }
    local ray_end   = { x = pos.x, y = pos.y + 0.1, z = pos.z + dir_z * 0.6 }
    local ray       = core.raycast(ray_start, ray_end, false, true)
    local hit       = ray:next()
    if hit and hit.type == "node" then
      local hit_pos = hit.under
      local node_above = { x = hit_pos.x, y = hit_pos.y + 1, z = hit_pos.z }
      local node_above_def = core.get_node(node_above)
      if not core.registered_nodes[node_above_def.name].walkable then
        local vel = self.object:get_velocity()
        vel.y = 5
        vel.z = dir_z * 0.5
        self.object:set_velocity(vel)
        return
      else
        self.object:set_velocity({ x = 0, y = 0, z = 0 })
        self._phase = (self._phase == 1) and 2 or 1
        self._target_z = self._home_pos.z + (self._phase == 1 and -4 or 4)
        return
      end
    end
    -- Distance check
    local dist = math.abs(pos.z - self._target_z)
    if dist < 0.2 then
      self._phase = (self._phase == 1) and 2 or 1
      self._target_z = self._home_pos.z + (self._phase == 1 and -4 or 4)
      self.object:set_velocity({ x = 0, y = 0, z = 0 })
      return
    end
    -- Normal movement
    local vel = {
      x = 0,
      y = self.object:get_velocity().y,
      z = dir_z * 1.2
    }
    self.object:set_velocity(vel)
  end,
  on_punch           = function(self) self.object:remove() end,
})

core.register_craftitem("terras_capixabas:an_caranguejo_inv", {
  description     = "Caranguejo Spawn Egg",
  inventory_image = "caranguejo_inv.png",
  on_place        = function(itemstack, placer, pointed_thing)
    if pointed_thing.type == "node" then
      local pos = pointed_thing.above
      pos.y     = pos.y + 0.5
      core.add_entity(pos, "terras_capixabas:caranguejo")
      if not core.is_creative_enabled(placer:get_player_name()) then itemstack:take_item() end
      return itemstack
    end
  end
})
