-- MORCEGO
core.register_entity("terras_capixabas:morcego", {
  initial_properties = { physical = false, collide_with_objects = false, collisionbox = { -0.25, -0.51, -0.25, 0.25, 0.0, 0.25 }, visual = "mesh", mesh = "morcego.glb", textures = { "morcego.png" }, visual_size = { x = 1, y = 1 }, },
  _animation_ranges = { fly = { x = 0.5, y = 1 }, stand = { x = 0, y = 0.25 }, },
  chirp_interval = 7,
  speed = 6,
  flight_ceiling = 15,
  _mode = "sleeping",
  _home_pos = nil,
  _flight_center = nil,
  _direction = nil,
  _last_chirp = 0,
  _height_progress = 0,
  on_activate = function(self, staticdata)
    local pos = self.object:get_pos()
    if staticdata and staticdata ~= "" then
      local data = core.deserialize(staticdata) or {}
      self._home_pos = data._home_pos or vector.round(pos)
      self._mode = data._mode or "sleeping"
      self._direction = data._direction or { x = 0, y = 0, z = 0 }
      self._height_progress = data._height_progress or 0
    else
      self._home_pos = vector.round(pos)
      self._mode = "sleeping"
      self._direction = { x = 0, y = 0, z = 0 }
      self._height_progress = 0
    end
    self._last_chirp = 0
    self:set_animation((self._mode == "sleeping") and "stand" or "fly")
  end,
  get_staticdata = function(self)
    return core.serialize({
      _home_pos = self._home_pos,
      _mode = self._mode,
      _direction = self._direction,
      _height_progress = self._height_progress,
    })
  end,
  set_animation = function(self, anim)
    local range = self._animation_ranges[anim]
    if range then self.object:set_animation({ x = range.x, y = range.y }, 1, 1, true) end
  end,
  play_chirp = function(self) core.sound_play("morcego", { object = self.object, gain = 1, max_hear_distance = 16 }) end,
  on_step = function(self, dtime)
    local pos = self.object:get_pos()
    local tod = core.get_timeofday()
    local is_night = tod < 0.23 or tod > 0.8
    if self._mode ~= "sleeping" then
      self._last_chirp = self._last_chirp + dtime
      if self._last_chirp >= self.chirp_interval then
        self:play_chirp()
        self._last_chirp = 0
      end
    end
    if self._mode == "sleeping" and is_night then
      self._mode = "ascending"
      self:set_animation("fly")
      local angle_rad = math.rad(33)
      local yaw = math.random() * 2 * math.pi
      self._direction = {
        x = math.cos(yaw) * math.cos(angle_rad),
        y = math.sin(angle_rad),
        z = math.sin(yaw) * math.cos(angle_rad)
      }
    elseif (self._mode == "ascending" or self._mode == "flying") and not is_night then
      self._mode = "returning"
      self:set_animation("fly")
    elseif self._mode == "returning" and vector.distance(pos, self._home_pos) < 0.3 then
      self.object:set_pos(self._home_pos)
      self._mode = "sleeping"
      self:set_animation("stand")
      return
    end
    if self._mode == "ascending" then
      local move_vec = vector.multiply(self._direction, self.speed * dtime)
      local new_pos = vector.add(pos, move_vec)
      if new_pos.y >= self.flight_ceiling then
        new_pos.y = self.flight_ceiling
        self._mode = "flying"
        local yaw = math.random() * 2 * math.pi
        self._direction = vector.normalize({ x = math.cos(yaw), y = 0, z = math.sin(yaw) })
      end
      self.object:set_pos(new_pos)
      self.object:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi / 2)
    elseif self._mode == "flying" then
      local move_vec = vector.multiply(self._direction, self.speed * dtime)
      local new_pos = vector.add(pos, move_vec)
      local bounced = false
      if new_pos.x < -491 then
        new_pos.x = -491
        bounced = true
      end
      if new_pos.x > -340 then
        new_pos.x = -340
        bounced = true
      end
      if new_pos.z < -432 then
        new_pos.z = -432
        bounced = true
      end
      if new_pos.z > -180 then
        new_pos.z = -180
        bounced = true
      end
      if bounced then
        local yaw = math.random() * 2 * math.pi
        self._direction = vector.normalize({ x = math.cos(yaw), y = 0, z = math.sin(yaw) })
      end
      if new_pos.y >= self.flight_ceiling then self._direction.y = -math.abs(self._direction.y) end
      if new_pos.y <= 2 then self._direction.y = math.abs(self._direction.y) end
      move_vec = vector.multiply(self._direction, self.speed * dtime)
      new_pos = vector.add(pos, move_vec)
      new_pos.y = math.min(new_pos.y, self.flight_ceiling)
      self.object:set_pos(new_pos)
      self.object:set_yaw(math.atan2(self._direction.z, self._direction.x) - math.pi / 2)
    elseif self._mode == "returning" then
      local dir_vec = vector.direction(pos, self._home_pos)
      local move_vec = vector.multiply(dir_vec, self.speed * dtime)
      local new_pos = vector.add(pos, move_vec)
      if vector.distance(new_pos, self._home_pos) < 0.3 then new_pos = self._home_pos end
      self.object:set_pos(new_pos)
      self.object:set_yaw(math.atan2(dir_vec.z, dir_vec.x) - math.pi / 2)
    end
  end,
})
core.register_craftitem("terras_capixabas:an_morcego_spawn_egg", {
  description = "Morcego Spawn Egg",
  inventory_image = "morcego_inv.png",
  on_place = function(itemstack, placer, pointed_thing)
    if pointed_thing.type == "node" then
      local pos = pointed_thing.above
      pos.y = pos.y + 0.5
      core.add_entity(pos, "terras_capixabas:morcego")
      if not core.is_creative_enabled(placer:get_player_name()) then itemstack:take_item() end
      return itemstack
    end
  end
})
