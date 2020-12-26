local App = require('src.app')
local Animation = require('src.systems.game.go.views.ball.animation.animation')
local class = App.libs.middleclass

local Services = require('src.services.services')
local ScreenService = Services.screen

local PROP = App.constants.go_props
local BallConfig = App.config.game.go.ball

local ZERO_SPEED = vmath.vector3()

local BallView = class('BallView')

function BallView:initialize(url)
    self.url = url
    self.co_url = msg.url(nil, self.url, PROP.collisionobject)
    self.pos = vmath.vector3()
    self.size = go.get(msg.url(nil, self.url, PROP.sprite), PROP.size)

    self:reset()

    Animation:init(self.url)
    Animation:animate_rotation()
end

function BallView:copy(ball)
    local new_ball = BallView:new()

    local pos = go.get_position(ball.url)
    go.set_position(pos, new_ball)
end

function BallView:update_speed(speed)
    go.set(self.co_url, PROP.linear_velocity, speed)
end

function BallView:stop_ball()
    self.speed_snapshot = go.get(self.co_url, PROP.linear_velocity)

    go.set(self.co_url, PROP.linear_velocity, ZERO_SPEED)
    Animation:cancel()
end

function BallView:resume_moving()
    local speed = self.speed_snapshot

    if speed.x == 0 and speed.y == 0 then
        speed = BallConfig.speed.start
    end

    go.set(self.co_url, PROP.linear_velocity, speed)

    Animation:animate_rotation()
end

function BallView:reset()
    self:reset_pos()
    self:reset_scale()
end

function BallView:reset_scale()
    local sizes = ScreenService:get_sizes()

    go.set_scale((BallConfig.scale * sizes.y) / self.size.y, self.url)
end

function BallView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + BallConfig.start_rel_pos.x * sizes.x
    self.pos.y = start_coords.y + BallConfig.start_rel_pos.y * sizes.y

    go.set_position(self.pos, self.url)
end

return BallView
