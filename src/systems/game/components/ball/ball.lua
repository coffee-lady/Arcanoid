local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local SceneMsgService = SceneServices.msg
local MSG = App.constants.messages
local SceneMSG = App.constants.messages.game
local SceneUrls = App.constants.urls.scenes.game_scene
local BallConfig = App.config.game.go.ball

local Transform = require('src.systems.game.components.ball.transform.transform')
local Animations = require('src.systems.game.components.ball.animations.animations')
local Physics = require('src.systems.game.components.ball.physics.physics')
local View = require('src.systems.game.components.ball.view.view')

local BallComponent = class('Component')

function BallComponent:initialize(id)
    local HASH_ID = hash(id)
    local transform = Transform:new(id)
    local animations = Animations:new(id)
    local physics = Physics:new(id)
    local view = View:new(id)

    transform:reset_pos()
    transform:reset_scale()

    physics:set_speed(BallConfig.speed.start)

    animations.rotation.play()

    SceneMsgService:on(HASH_ID, MSG.common.collision_response, function()
        physics:normalize_speed()
    end)

    SceneMsgService:on(HASH_ID, SceneMSG.lost_ball, function()
        transform:reset_pos()
        transform:reset_scale()
        physics:reset_speed()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_ball, function(message)
        physics:accelerate(message.delta_speed)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_ball, function(message)
        physics:accelerate(-message.delta_speed)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.block_destructed, function()
        physics:accelerate(BallConfig.delta_speed)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.pause, function()
        physics:stop_ball()
        animations.rotation.cancel()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.winning, function()
        physics:stop_ball()
        animations.rotation.cancel()
        view:delete()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.continue, function()
        physics:resume_moving()
    end)
end

return BallComponent
