local App = require('src.app')
local GO = require('go.go')

local ID = App.constants.gui.screens.game_scene

local Animations = {
    moving = {
        duration = 0.1
    }
}

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

function PlatformView:get_scale()
    return self.container_node:get_scale()
end

function PlatformView:set_pos(pos)
    self.container_node:set_pos(pos)
end

function PlatformView:get_pos()
    return self.sprite_node:get_pos()
end

function PlatformView:animate_pos(pos)
    self.container_node:animate_move_to(pos, Animations.moving.duration):run()
end

function PlatformView:delete()
    self.container_node:delete()
end

return PlatformView
