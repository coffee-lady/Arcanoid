local App = require('src.app')
local GO = require('go.go')
local Animations = require('animations.animations')
local BlockUIConfig = require('src.scripts.scenes.game_scene.view.BlockView.BlockUIConfig')

local Sequence = Animations.GO.sequence
local ID = App.constants.gui.screens.game_scene
local BlockID = ID.block

--- @class BlockView
local BlockView = class('BlockView')

function BlockView:initialize(id, data)
    self.id = id
    self.container_node = GO.AnimatableNode(self.id)
    self.sprite_node = GO.SpriteNode(self.id)
    self.decoration_sprite_node = GO.SpriteNode(self.id, BlockID.decoration_sprite)
    self.cracks_sprite_node = GO.SpriteNode(self.id, BlockID.cracks)
    self.kinematic_collision_node = GO.CollisionNode(self.id, BlockID.co_kinematic)
    self.trigger_collision_node = GO.CollisionNode(self.id, BlockID.co_trigger)
    self.breaking_pfx_node = GO.ParticlefxNode(self.id, BlockID.breaking_pfx)
end

function BlockView:set_image(image)
    return self.sprite_node:set_image(image)
end

function BlockView:get_size()
    return self.decoration_sprite_node:get_size() * self:get_scale().x
end

function BlockView:show_cracks()
    self.cracks_sprite_node:set_enabled(true)
end

function BlockView:hide_cracks()
    self.cracks_sprite_node:set_enabled(false)
end

function BlockView:set_scale(scale_factor)
    self.container_node:set_scale(scale_factor)
end

function BlockView:get_scale()
    return self.container_node:get_scale()
end

function BlockView:set_pos(pos)
    self.container_node:set_pos(pos)
end

function BlockView:set_kinematic_collision()
    self.kinematic_collision_node:set_enabled(true)
    self.trigger_collision_node:set_enabled(false)
end

function BlockView:set_trigger_collision()
    self.kinematic_collision_node:set_enabled(false)
    self.trigger_collision_node:set_enabled(true)
end

function BlockView:animate_destruction()
    local delay_deleting = BlockUIConfig.destruction.delay_deleting
    local seq = Sequence()

    seq:add_callback(function()
        self.breaking_pfx_node:play()
    end)
    seq:add_delay(delay_deleting)
    seq:add_callback(function()
        self:delete()
    end)

    seq:run()
end

function BlockView:delete()
    self.container_node:delete()
end

return BlockView
