local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg
local BoostsDataService = SceneServices.boosts_data

local BoostConfig

local MSG = App.constants.messages

local PlatformDecelerationBoost = class('PlatformDecelerationBoost', Boost)

function PlatformDecelerationBoost:initialize(id)
    BoostConfig = BoostsDataService:get_data().platform_deceleration

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
