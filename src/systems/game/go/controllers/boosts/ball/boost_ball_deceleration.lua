local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local BoostView = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.ball_deceleration
local URL = App.constants.urls
local MSG = App.constants.messages

local BallDecelerationBoostController = {}

function BallDecelerationBoostController:init(boost_pos)
    BoostView:new(boost_pos, BoostConfig, self.boost)
end

function BallDecelerationBoostController:boost()
    SceneMsgService:post(URL.scenes.game_scene.main, nil, MSG.game.decelerate_ball, {
        delta_speed = BoostConfig.delta_speed
    })

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:post(URL.scenes.game_scene.main, nil, MSG.game.accelerate_ball, {
            delta_speed = BoostConfig.delta_speed
        })
    end)
end

return BallDecelerationBoostController
