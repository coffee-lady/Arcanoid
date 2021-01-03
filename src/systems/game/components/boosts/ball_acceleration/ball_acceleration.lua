local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg
local BoostsDataService = SceneServices.boosts_data

local BoostConfig

local MSG = App.constants.messages

local BallAccelerationBoost = class('BallAccelerationBoost', Boost)

function BallAccelerationBoost:initialize(id)
    BoostConfig = BoostsDataService:get_data().ball_acceleration

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
