local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local BoostView = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.platform_acceleration
local URL = App.constants.urls
local MSG = App.constants.messages

local PlatformAccelerationBoostController = {}

function PlatformAccelerationBoostController:init(boost_pos)
    BoostView:new(boost_pos, BoostConfig, self.boost)
end

function PlatformAccelerationBoostController:boost()
    SceneMsgService:post(URL.scenes.game_scene.main, nil, MSG.game.accelerate_platform, {
        delta_time = BoostConfig.delta_moving_time
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:post(URL.scenes.game_scene.main, nil, MSG.game.decelerate_platform, {
            delta_time = BoostConfig.delta_moving_time
        })
    end)
end

return PlatformAccelerationBoostController
