local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local GameMsgService = GameServices.msg

local class = App.libs.middleclass
local BallConfig = App.config.game.go.ball
local Observable = App.libs.event_observation.observable

local GameSceneUrls = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props
local MSG = App.constants.messages.common
local GameMSG = App.constants.messages.game

local Ball = class('Ball')

function Ball:initialize()
    self.url = GameSceneUrls.ball
    self.update_speed_observer = Observable:new()
    self.co_url = msg.url(nil, self.url, PROP.collisionobject)

    GameMsgService:on(hash(self.url), MSG.collision_response, function(message)
        self:check_speed()
    end)

    GameMsgService:on(hash(self.url), GameMSG.lost_ball, function()
        self:reset()
    end)
end

function Ball:reset()
    self:reset_speed()
end

function Ball:reset_speed()
    self.update_speed_observer:next(BallConfig.start_speed)
end

function Ball:check_speed()
    local speed = go.get(self.co_url, PROP.linear_velocity)

    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    if mod_x < BallConfig.min_mod_speed.x or mod_y < BallConfig.min_mod_speed.y then
        speed.x = speed.x / mod_x * BallConfig.start_speed.x
        speed.y = speed.y / mod_y * BallConfig.start_speed.y
        self.update_speed_observer:next(speed)
    end
end

return Ball
