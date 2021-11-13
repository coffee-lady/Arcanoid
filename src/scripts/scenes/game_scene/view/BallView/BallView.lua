local App = require('src.app')
local GO = require('go.go')

--- @class BallView
local BallView = class('BallView')

function BallView:initialize(id)
    self.id = id
    self.container_node = GO.AnimatableNode(self.id)
    self.sprite_node = GO.SpriteNode(self.id)
    self.collision_node = GO.CollisionNode(self.id)
end

function BallView:get_size()
    return self.sprite_node:get_size()
end

function BallView:set_scale(scale_factor)
    self.container_node:set_scale(scale_factor)
end

function BallView:set_pos(pos)
    self.container_node:set_pos(pos)
end

function BallView:set_speed(speed)
    self.collision_node:set_linear_velocity(speed)
end

function BallView:get_speed()
    return self.collision_node:get_linear_velocity()
end

function BallView:delete()
    self.container_node:delete()
end

return BallView
