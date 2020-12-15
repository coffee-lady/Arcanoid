local App = require('src.app')
local Services = require('src.services.services')
local class = App.libs.middleclass

local BallView = class('BallView')

local GameSceneUrls = App.constants.urls.scenes.game_scene

local ScreenService = Services.screen

local PROP = App.constants.go_props

local BallConfig = App.config.game.go.ball

function BallView:initialize(ball)
    self.ball = ball
    self.url = GameSceneUrls.ball
    self.size = go.get(msg.url(nil, self.url, PROP.sprite), PROP.size)

    self.ball.update_observer:subscribe(function()
        self:update_velocity()
    end)

    self.ball.reset_observer:subscribe(function()
        self:reset()
    end)

    ScreenService.update_observer:subscribe(function()
        self:update_scale()
    end)

    self:update_velocity()
    self:update_scale()
    self:reset()
end

function BallView:update_velocity()
    go.set(msg.url(nil, self.url, PROP.collisionobject), PROP.linear_velocity, self.ball.speed)
end

function BallView:update_scale()
    local sizes = ScreenService:get_sizes()

    go.set_scale((BallConfig.scale * sizes.y) / self.size.y, self.url)
end

function BallView:reset()
    self:update_velocity()
    go.set_position(self.ball.pos, self.url)
end

return BallView
