local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.shorten_platform
local MSG = App.constants.messages

local ShortenPlatformBoost = class('ShortenPlatformBoost', Boost)

ShortenPlatformBoost.weight = BoostConfig.weight

function ShortenPlatformBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function ShortenPlatformBoost:boost()
    SceneMsgService:send(nil, MSG.game.shorten_platform, {
        percentage = BoostConfig.percentage
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.extend_platform, {
            percentage = BoostConfig.percentage
        })
    end)
end

return ShortenPlatformBoost
