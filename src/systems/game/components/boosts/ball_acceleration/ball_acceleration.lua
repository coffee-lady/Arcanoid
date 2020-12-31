local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.ball_acceleration
local MSG = App.constants.messages

local BallAccelerationBoost = class('BallAccelerationBoost', Boost)

BallAccelerationBoost.weight = BoostConfig.weight

function BallAccelerationBoost:initialize(id)
    Boost.initialize(self, id, BoostConfig)
end

function BallAccelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.accelerate_ball, {
        delta_speed = BoostConfig.delta_speed
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.decelerate_ball, {
            delta_speed = BoostConfig.delta_speed
        })
    end)
end

return BallAccelerationBoost
