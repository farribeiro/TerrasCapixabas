-- CÃES
local function register_dog(name)
  core.register_entity("terras_capixabas:" .. name, {
    initial_properties = {
      visual = "mesh",
      mesh = "cao.glb",
      textures = { name .. ".png" },
      visual_size = { x = 1, y = 1 },
      physical = true,
      collide_with_objects = true,
      collisionbox = { -0.3, -0.01, -0.3, 0.3, 0.84, 0.3 },
      stepheight = 1.1,
      fall_damage = 0,
      water_damage = 0,
      lava_damage = 0,
      suffocation = false,
      static_save = true,
    },
    animations = { idle = { start = 0, stop = 0.04, speed = 1 }, walk = { start = 0.25, stop = 1, speed = 1 }, sleep = { start = 1.5, stop = 1.54, speed = 1 }, },
    set_named_animation = function(self, name)
      local a = self.animations[name]
      if a then self.object:set_animation({ x = a.start, y = a.stop }, a.speed, 0, true) end
    end,
    on_activate = function(self, staticdata)
      self.state = "idle"
      self.prev_state = nil
      self.timer = 0
      self.following = false
      self.following_player = nil
      self.sidewalk_walk = false
      self.sidewalk_dir = "forward"
      self.sleeping = false
      self:set_named_animation("idle")
    end,
    on_rightclick = function(self, clicker)
    end,
    on_step = function(self, dtime, moveresult)
      self.timer = self.timer + dtime
      local obj = self.object
      local pos = obj:get_pos()
      local vel = obj:get_velocity()
      local new_vel = vector.copy(vel)
      -- Gravity (API-safe, physics-respecting)
      if moveresult and moveresult.touching_ground then new_vel.y = 0 else new_vel.y = new_vel.y - (9.8 * dtime) end
      -- Day / Night
      local tod = core.get_timeofday()
      local is_night = tod < 0.2 or tod > 0.8
      -- Sleep logic
      if not self.sleeping and is_night then
        if self.following and self.following_player and self.following_player:is_player() then
          if self.following_player:get_wielded_item():get_name() ~= "terras_capixabas:alm_sacanagem" then
            self.prev_state = self.state
            self.state = "sleep"
            self.sleeping = true
            self:set_named_animation("sleep")
            new_vel.x, new_vel.z = 0, 0
            obj:set_velocity(new_vel)
            return
          end
        else
          self.prev_state = self.state
          self.state = "sleep"
          self.sleeping = true
          self:set_named_animation("sleep")
          new_vel.x, new_vel.z = 0, 0
          obj:set_velocity(new_vel)
          return
        end
      elseif self.sleeping and not is_night then
        self.state = self.prev_state or "idle"
        self.sleeping = false
        self.timer = 1
        self:set_named_animation((self.state ~= "idle") and "walk" or "idle")
      end
      -- Stop following if item lost
      if self.following and (not self.following_player or not self.following_player:is_player() or self.following_player:get_wielded_item():get_name() ~= "terras_capixabas:alm_sacanagem") then
        self.following = false
        self.following_player = nil
        self.state = "idle"
        self:set_named_animation("idle")
      end
      -- Start follow or sidewalk
      if not self.following and not self.sidewalk_walk then
        for _, o in ipairs(core.get_objects_inside_radius(pos, 3)) do
          if o:is_player() then
            local item = o:get_wielded_item():get_name()
            if item == "terras_capixabas:alm_sacanagem" then
              self.following = true
              self.following_player = o
              self:set_named_animation("walk")
              break
            elseif item == "terras_capixabas:sidewalk" then
              self.sidewalk_walk = true
              self.sidewalk_dir = "forward"
              self:set_named_animation("walk")
              break
            end
          end
        end
      end
      -- FOLLOW PLAYER
      if self.following and self.following_player then
        local ppos = self.following_player:get_pos()
        local dist = vector.distance(pos, ppos)

        if dist > 2 then
          local dir = vector.direction(pos, ppos)
          new_vel.x, new_vel.z = dir.x * 2, dir.z * 2
          obj:set_rotation(vector.dir_to_rotation(dir))
          if self.state ~= "follow_walk" then
            self.state = "follow_walk"
            self:set_named_animation("walk")
          end
        else
          new_vel.x, new_vel.z = 0, 0
          if self.state ~= "idle" then
            self.state = "idle"
            self:set_named_animation("idle")
          end
        end

        obj:set_velocity(new_vel)
        return
      end

      -- SIDEWALK
      if self.sidewalk_walk then
        for _, o in ipairs(core.get_objects_inside_radius(pos, 3)) do
          if o:is_player() and o:get_wielded_item():get_name() == "terras_capixabas:alm_sacanagem" then
            self.sidewalk_walk = false
            self.following = true
            self.following_player = o
            self:set_named_animation("walk")
            return
          end
        end

        if self.sidewalk_dir == "forward" and pos.z <= -395 then
          self.sidewalk_dir = "backward"
        elseif self.sidewalk_dir == "backward" and pos.z >= -225 then
          self.sidewalk_dir =
          "forward"
        end
        local speed = (self.sidewalk_dir == "forward") and -2 or 2
        new_vel.x, new_vel.z = 0, speed
        obj:set_rotation({ x = 0, y = (speed < 0 and 0 or math.pi), z = 0 })
        self.state = "sidewalk"
        obj:set_velocity(new_vel)
        return
      end
      -- RANDOM WANDER
      if self.timer >= 1 then
        self.timer = 0
        if self.state == "idle" and math.random() < 0.25 then
          self.state = "walk"
          local dir = vector.random_direction()
          dir.y = 0
          dir = vector.normalize(dir)
          new_vel.x, new_vel.z = dir.x * 2, dir.z * 2
          obj:set_rotation(vector.dir_to_rotation(dir))
          self:set_named_animation("walk")
        elseif self.state == "walk" then
          self.state = "idle"
          new_vel.x, new_vel.z = 0, 0
          self:set_named_animation("idle")
        end
      end

      obj:set_velocity(new_vel)
    end,
  })

  core.register_craftitem("terras_capixabas:" .. name .. "_spawn", {
    description = "Cão " .. (name:match("cao_(.*)") or name),
    inventory_image = name .. "_inv.png",
    on_place = function(itemstack, placer, pointed_thing)
      core.add_entity(pointed_thing.above, "terras_capixabas:" .. name)
      itemstack:take_item()
      return itemstack
    end
  })
end

register_dog("cao_marley")
register_dog("cao_amarelo")
register_dog("cao_preto")
