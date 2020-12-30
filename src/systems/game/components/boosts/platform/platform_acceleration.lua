local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.platform_acceleration
local MSG = App.constants.messages

local PlatformAccelerationBoost = class('PlatformAccelerationBoost', Boost)

PlatformAccelerationBoost.weight = BoostConfig.weight

function PlatformAccelerationBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function PlatformAccelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.accelerate_platform, {
        delta_time = BoostConfig.delta_moving_time
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.decelerate_platform, {
            delta_time = BoostConfig.delta_moving_time
        })
    end)
end

return PlatformAccelerationBoost
