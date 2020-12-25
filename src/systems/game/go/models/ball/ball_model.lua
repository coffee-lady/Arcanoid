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
    self.base_speed = vmath.vector3(BallConfig.start_speed.x, BallConfig.start_speed.y, 0)

    GameMsgService:on(hash(self.url), MSG.collision_response, function()
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

    if mod_x < BallConfig.min_speed.x or mod_y < BallConfig.min_speed.y then
        speed.x = speed.x / mod_x * self.base_speed.x
        speed.y = speed.y / mod_y * self.base_speed.y

        self.update_speed_observer:next(speed)
    end
end

function Ball:speed_up()
    local speed = go.get(self.co_url, PROP.linear_velocity)

    local direction_x = speed.x / math.abs(speed.x)
    local direction_y = speed.y / math.abs(speed.y)

    speed.x = speed.x + BallConfig.delta_speed.x * direction_x
    speed.y = speed.y + BallConfig.delta_speed.y * direction_y

    local max_speed_vector = math.sqrt(math.pow(BallConfig.max_speed.x, 2) + math.pow(BallConfig.max_speed.y, 2))
    local speed_vector = math.sqrt(speed.x * speed.x + speed.y * speed.y)

    if speed_vector < max_speed_vector then
        self.base_speed = speed
        self.update_speed_observer:next(speed)
    end
end

return Ball
