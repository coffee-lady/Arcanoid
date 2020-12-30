local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.platform_deceleration
local MSG = App.constants.messages

local PlatformDecelerationBoost = {
    weight = BoostConfig.weight
}

local function boost()
    SceneMsgService:send(nil, MSG.game.decelerate_platform, {
        delta_time = BoostConfig.delta_moving_time
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.accelerate_platform, {
            delta_time = BoostConfig.delta_moving_time
        })
    end)
end

function PlatformDecelerationBoost:init(message)
    Boost:new(message.pos, BoostConfig, boost)
end

return PlatformDecelerationBoost
