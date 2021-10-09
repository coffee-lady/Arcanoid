local App = require('src.app')

local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages

local BallAccelerationBoost = class('BallAccelerationBoost', Boost)

function BallAccelerationBoost:initialize(id, _, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
end

function BallAccelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.accelerate_ball, {
        delta_speed = BoostConfig.delta_speed,
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.decelerate_ball, {
            delta_speed = BoostConfig.delta_speed,
        })
    end)
end

return BallAccelerationBoost
