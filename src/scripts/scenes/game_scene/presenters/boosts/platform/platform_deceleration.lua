local App = require('src.app')

local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages

local PlatformDecelerationBoost = class('PlatformDecelerationBoost', Boost)

function PlatformDecelerationBoost:initialize(id, _, config)
    BoostConfig = config
    Boost.initialize(self, id, BoostConfig)
end

function PlatformDecelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.decelerate_platform, {
        delta_time = BoostConfig.delta_moving_time,
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.accelerate_platform, {
            delta_time = BoostConfig.delta_moving_time,
        })
    end)
end

return PlatformDecelerationBoost
