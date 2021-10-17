local App = require('src.app')
local GO = require('go.go')

local ID = App.constants.gui.screens.game_scene
local BlockID = ID.block

--- @class BlockView
local BlockView = class('BlockView')

function BlockView:initialize(id, data)
    self.id = id
    self.container_node = GO.AnimatableNode(self.id)
    self.sprite_node = GO.SpriteNode(self.id)
    self.cracks_sprite_node = GO.SpriteNode(self.id, BlockID.cracks)
    self.kinematic_collision_node = GO.CollisionNode(self.id, BlockID.co_kinematic)
    self.trigger_collision_node = GO.CollisionNode(self.id, BlockID.co_trigger)
end

function BlockView:get_size()
    return self.sprite_node:get_size()
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

function BlockView:delete()
    self.container_node:delete()
end

return BlockView
