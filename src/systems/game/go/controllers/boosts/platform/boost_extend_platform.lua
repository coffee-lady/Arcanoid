local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local BoostView = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.extend_platform
local URL = App.constants.urls
local MSG = App.constants.messages

local ExtendPlatformBoostController = {}

function ExtendPlatformBoostController:init(boost_pos)
    BoostView:new(boost_pos, BoostConfig, self.boost)
end

function ExtendPlatformBoostController:boost()
    SceneMsgService:post(URL.scenes.game_scene.main, nil, MSG.game.extend_platform, {
        percentage = BoostConfig.percentage
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:post(URL.scenes.game_scene.main, nil, MSG.game.shorten_platform, {
            percentage = BoostConfig.percentage
        })
    end)
end

return ExtendPlatformBoostController
