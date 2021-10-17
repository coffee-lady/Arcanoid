local App = require('src.app')
local GO = require('go.go')

local ID = App.constants.gui.screens.game_scene

--- @class PlatformView
local PlatformView = class('PlatformView')

function PlatformView:initialize()
    self.id = ID.platform
    self.container_node = GO.AnimatableNode(self.id)
    self.sprite_node = GO.SpriteNode(self.id)
    self.collision_node = GO.CollisionNode(self.id)
end

function PlatformView:get_size()
    return self.sprite_node:get_size()
end

function PlatformView:set_scale(scale_factor)
    self.container_node:set_scale(scale_factor)
end

function PlatformView:set_pos(pos)
    self.container_node:set_pos(pos)
end

function PlatformView:delete()
    self.container_node:delete()
end

return PlatformView
