local App = require('src.app')
local Services = require('src.services.services')
local GameServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local BallConfig = App.config.game.go.ball
local Observable = App.libs.event_observation.observable

local GameSceneUrls = App.constants.urls.scenes.game_scene

local GameMsgService = GameServices.msg
local ScreenService = Services.screen

local MSG = App.constants.messages.common
local PROP = App.constants.go_props

local Ball = class('Ball')

function Ball:initialize()
    self.id = go.get_id(GameSceneUrls.ball)
    self.pos = vmath.vector3()

    self.update_observer = Observable:new()
    self.reset_observer = Observable:new()

    GameMsgService:on(self.id, MSG.collision_response, function()
        self:check_velocity_and_update()
    end)

    self:update_speed(BallConfig.start_speed)
    self:reset()
end

function Ball:update_speed(speed)
    self.speed = speed
    self.update_observer:next()
end

function Ball:check_velocity_and_update()
    local velocity = go.get(msg.url(nil, self.url, PROP.collisionobject), PROP.linear_velocity)

    if velocity.x == 0 or velocity.y == 0 then
        velocity = BallConfig.start_speed
        self:update_speed(velocity)
    end
end

function Ball:reset()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + BallConfig.start_rel_pos.x * sizes.x
    self.pos.y = start_coords.y + BallConfig.start_rel_pos.y * sizes.y

    self:update_speed(BallConfig.start_speed)
    self.reset_observer:next()
end

return Ball
