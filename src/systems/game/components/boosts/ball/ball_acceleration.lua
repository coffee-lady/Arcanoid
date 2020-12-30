local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.ball_acceleration
local MSG = App.constants.messages

local BallAccelerationBoost = {
    weight = BoostConfig.weight
}

local function boost()
    SceneMsgService:send(nil, MSG.game.accelerate_ball, {
        delta_speed = BoostConfig.delta_speed
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.decelerate_ball, {
            delta_speed = BoostConfig.delta_speed
        })
    end)
end

function BallAccelerationBoost:init(message)
    Boost:new(message.pos, BoostConfig, boost)
end

return BallAccelerationBoost