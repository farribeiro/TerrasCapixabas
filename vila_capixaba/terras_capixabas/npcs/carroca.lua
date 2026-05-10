local behavior = dofile(core.get_modpath("terras_capixabas") .. "/npcs/behaviors/movement_behavior.lua")

-- Carroca NPC definition
local carroca_def = {
    initial_properties = {
        visual = "mesh",
        mesh = "terras_capixabas_carroca.b3d",
        textures = {"terras_capixabas_carroca.png"},
        visual_size = {x = 1, y = 1, z = 1},
        collisionbox = {-0.5, 0, -0.5, 0.5, 1, 0.5},
        physical = true,
        stepheight = 0.6,
        pointable = true,
        static_save = true
    },
    
    name = "terras_capixabas:carroca",
    npc_id = "carroca",
    
    -- Override on_activate to add custom animations
    on_activate = function(self, staticdata)
        behavior.on_activate(self, staticdata)
        -- Add custom animation for carroca
        self.animations.walk = {start = 0.0, stop = 2.0, speed = 1}
    end,
    
    get_staticdata = function(self)
        return behavior.get_staticdata(self)
    end,
    
    on_step = function(self, dtime)
        behavior.on_step(self, dtime)
    end,
    
    on_rightclick = function(self, clicker)
        if not clicker or not clicker:is_player() then return end
        
        local item = clicker:get_wielded_item()
        local item_name = item:get_name()
        
        -- Check for following items
        local follow_items = {
            "default:stick", "default:wood", "farming:wheat", "farming:bread"
        }
        
        for _, follow_item in ipairs(follow_items) do
            if item_name == follow_item then
                if not self.following or self.following_player_name ~= clicker:get_player_name() then
                    self.following = true
                    self.following_player = clicker
                    self.following_player_name = clicker:get_player_name()
                    self.state = "follow"
                    
                    -- Consume one item
                    if not minetest.is_creative_enabled(clicker:get_player_name()) then
                        item:take_item()
                        clicker:set_wielded_item(item)
                    end
                    
                    minetest.chat_send_player(clicker:get_player_name(), "Carroca is now following you!")
                else
                    self.following = false
                    self.following_player = nil
                    self.following_player_name = nil
                    self.state = "walk"
                    minetest.chat_send_player(clicker:get_player_name(), "Carroca stopped following you.")
                end
                return
            end
        end
        
        -- Check for state change items
        if item_name == "default:dirt" then
            self.state = "sit"
            self.frozen = true
            behavior.set_animation(self, "sit")
        elseif item_name == "default:cobble" then
            self.state = "lay"
            self.frozen = true
            behavior.set_animation(self, "lay")
        elseif item_name == "default:stone" then
            self.state = "dance"
            self.frozen = true
            behavior.set_animation(self, "dance")
        elseif item_name == "default:steel_ingot" then
            self.state = "walk"
            self.frozen = false
            behavior.set_animation(self, "walk")
        elseif item_name == "default:gold_ingot" then
            self.state = "sidewalk"
            self.frozen = false
            self.sidewalk_direction = 1
            self.sidewalk_start_z = nil
            behavior.set_animation(self, "walk")
        end
    end
}

return carroca_def