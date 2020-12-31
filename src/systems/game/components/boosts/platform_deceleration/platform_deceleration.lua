local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.platform_deceleration
local MSG = App.constants.messages

local PlatformDecelerationBoost = class('PlatformDecelerationBoost', Boost)

PlatformDecelerationBoost.weight = BoostConfig.weight

function PlatformDecelerationBoost:initialize(id)
    Boost.initialize(self, id, BoostConfig)
end

function PlatformDecelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.decelerate_platform, {
        delta_time = BoostConfig.delta_moving_time
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.accelerate_platform, {
            delta_time = BoostConfig.delta_moving_time
        })
    end)
end

return PlatformDecelerationBoost
