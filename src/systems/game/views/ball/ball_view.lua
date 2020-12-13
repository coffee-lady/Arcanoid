local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local class = App.libs.middleclass

local BallView = class('BallView')

local GameSceneUrls = App.constants.urls.scenes.game_scene

local Services = require('src.services.services')
local ScreenService = Services.screen

local GameMsgService = GameServices.msg
local MSG = App.constants.messages.game

local PROP = App.constants.go_props

local BallConfig = App.config.game.ball

function BallView:initialize(ball)
    self.ball = ball
    self.id = go.get_id(GameSceneUrls.ball)
    self.url = GameSceneUrls.ball
    self.size = go.get(msg.url(nil, self.url, PROP.sprite), PROP.size)

    self.ball.update_observer:subscribe(function()
        self:update_velocity()
    end)

    ScreenService.update_observer:subscribe(function()
        self:update_scale()
    end)

    self:update_velocity()
    self:update_scale()
end

function BallView:update()
    local velocity = go.get(msg.url(nil, self.url, PROP.collisionobject), PROP.linear_velocity)

    if velocity.x == 0 or velocity.y == 0 then
        self:update_velocity()
    end
end

function BallView:update_velocity()
    go.set(msg.url(nil, self.url, PROP.collisionobject), PROP.linear_velocity, self.ball.speed)
end

function BallView:update_scale()
    local sizes = ScreenService:get_sizes()

    go.set_scale((BallConfig.scale * sizes.y) / self.size.y, self.url)
end

function BallView:subscribe_to_collision()
    GameMsgService:on(self.id, MSG.collision_response, function()
        self:update()
    end)
end

return BallView
