local App = require('src.app')
local GameServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local BallConfig = App.config.game.go.ball
local Observable = App.libs.event_observation.observable

local GameSceneUrls = App.constants.urls.scenes.game_scene

local GameMsgService = GameServices.msg

local MSG = App.constants.messages.game
local PROP = App.constants.go_props

local Ball = class('Ball')

function Ball:initialize()
    self.update_observer = Observable:new()
    self.id = go.get_id(GameSceneUrls.ball)

    GameMsgService:on(self.id, MSG.collision_response, function()
        self:check_velocity_and_update()
    end)

    self:update_speed(BallConfig.start_speed)
end

function Ball:update_speed(speed)
    if speed.x < BallConfig.max_speed.x and speed.y < BallConfig.max_speed.y then
        self.speed = speed
        self.update_observer:next()
    end
end

function Ball:check_velocity_and_update()
    local velocity = go.get(msg.url(nil, self.url, PROP.collisionobject), PROP.linear_velocity)

    if velocity.x == 0 or velocity.y == 0 then
        velocity = BallConfig.start_speed
        self:update_speed(velocity)
    end
end

return Ball
