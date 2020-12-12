local App = require('src.app')
local class = App.libs.middleclass

local BallView = class('BallView')

local Services = require('src.services.services')
local ScreenService = Services.screen

local BallConfig = App.config.game.ball

function BallView:initialize(ball)
    self.ball = ball
    self.url = 'ball'
    self.size = go.get(msg.url(nil, self.url, 'sprite'), 'size')

    self.ball.update_observer:subscribe(function()
        self:update_velocity()
    end)

    ScreenService.observer:subscribe(function()
        self:update_scale()
    end)

    self:update_velocity()
    self:update_scale()
end

function BallView:update_velocity()
    go.set(msg.url(nil, self.url, 'collisionobject'), 'linear_velocity', self.ball.speed)
end

function BallView:update_scale()
    local sizes = ScreenService:get_sizes()

    go.set_scale((BallConfig.scale * sizes.y) / self.size.y, self.url)
end

return BallView
