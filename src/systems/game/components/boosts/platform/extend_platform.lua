local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.extend_platform
local MSG = App.constants.messages

local ExtendPlatformBoost = {
    weight = BoostConfig.weight
}

local function boost()
    SceneMsgService:send(nil, MSG.game.extend_platform, {
        percentage = BoostConfig.percentage
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.shorten_platform, {
            percentage = BoostConfig.percentage
        })
    end)
end

function ExtendPlatformBoost:init(message)
    Boost:new(message.pos, BoostConfig, boost)
end

return ExtendPlatformBoost
