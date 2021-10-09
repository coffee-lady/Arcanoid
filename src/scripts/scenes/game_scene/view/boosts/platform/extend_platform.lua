local App = require('src.app')

local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages

local ExtendPlatformBoost = class('ExtendPlatformBoost', Boost)

function ExtendPlatformBoost:initialize(id, _, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
end

function ExtendPlatformBoost:boost()
    SceneMsgService:send(nil, MSG.game.extend_platform, {
        percentage = BoostConfig.percentage,
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.shorten_platform, {
            percentage = BoostConfig.percentage,
        })
    end)
end

return ExtendPlatformBoost