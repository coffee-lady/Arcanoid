local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local class = App.libs.middleclass
local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.ball_deceleration
local MSG = App.constants.messages

local BallDecelerationBoost = class('BallDecelerationBoost', Boost)

BallDecelerationBoost.weight = BoostConfig.weight

function BallDecelerationBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function BallDecelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.decelerate_ball, {
        delta_speed = BoostConfig.delta_speed
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.accelerate_ball, {
            delta_speed = BoostConfig.delta_speed
        })
    end)
end

return BallDecelerationBoost
