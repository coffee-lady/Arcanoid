local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.extend_platform
local MSG = App.constants.messages

local ExtendPlatformBoost = class('ExtendPlatformBoost', Boost)

ExtendPlatformBoost.weight = BoostConfig.weight

function ExtendPlatformBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function ExtendPlatformBoost:boost()
    SceneMsgService:send(nil, MSG.game.extend_platform, {
        percentage = BoostConfig.percentage
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.shorten_platform, {
            percentage = BoostConfig.percentage
        })
    end)
end

return ExtendPlatformBoost
