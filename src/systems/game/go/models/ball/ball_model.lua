local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local GameMsgService = GameServices.msg

local class = App.libs.middleclass
local BallConfig = App.config.game.go.ball
local Observable = App.libs.event_observation.observable

local PROP = App.constants.go_props
local MSG = App.constants.messages.common
local GameMSG = App.constants.messages.game

local Ball = class('Ball')

function Ball:initialize(url)
    self.url = url
    self.update_speed_observer = Observable:new()
    self.co_url = msg.url(nil, self.url, PROP.collisionobject)
    self.base_speed = vmath.vector3(BallConfig.speed.start.x, BallConfig.speed.start.y, 0)

    GameMsgService:on(hash(self.url), MSG.collision_response, function()
        self:check_speed()
    end)

    GameMsgService:on(hash(self.url), GameMSG.lost_ball, function()
        self:reset()
    end)
end

function Ball:copy(ball)
    local new_ball = Ball:new()

    new_ball.update_speed_observer:next(ball.speed)
end

function Ball:reset()
    self:reset_speed()
end

function Ball:reset_speed()
    self.update_speed_observer:next(BallConfig.speed.start)
end

local function get_vector_length(v)
    return math.sqrt(v.x * v.x + v.y * v.y)
end

function Ball:check_speed()
    local speed = go.get(self.co_url, PROP.linear_velocity)

    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    if mod_x < BallConfig.speed.min.x or mod_y < BallConfig.speed.min.y then
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

    local max_speed_vector = get_vector_length(BallConfig.speed.max)
    local speed_vector = get_vector_length(speed)

    if speed_vector < max_speed_vector then
        self.base_speed = speed
        self.update_speed_observer:next(speed)
    end
end

function Ball:accelerate(delta_speed)
    local speed = go.get(self.co_url, PROP.linear_velocity)
    speed.x = speed.x + delta_speed.x
    speed.y = speed.y + delta_speed.y

    local max_speed_vector = get_vector_length(BallConfig.speed.max)
    local min_speed_vector = get_vector_length(BallConfig.speed.min)
    local speed_vector = get_vector_length(speed)

    if speed_vector > min_speed_vector and speed_vector < max_speed_vector then
        self.update_speed_observer:next(speed)
    end
end

return Ball
