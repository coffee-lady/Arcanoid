local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages

local ShortenPlatformBoost = class('ShortenPlatformBoost', Boost)

function ShortenPlatformBoost:initialize(id, _, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
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
