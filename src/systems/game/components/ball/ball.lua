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

function BallComponent:initialize(id, pos)
    local HASH_ID = hash(id)

    self.transform = Transform:new(id)
    self.physics = Physics:new(id)

    local animations = Animations:new(id)
    local view = View:new(id)

    local subs = {}

    if not pos then
        self.transform:reset_pos()
    else
        self.transform:set_pos(pos)
    end

    self.transform:reset_scale()
    self.physics:reset_speed()

    animations.rotation.play()

    SceneMsgService:on(HASH_ID, MSG.common.collision_response, function()
        self.physics:normalize_speed()
    end)

    SceneMsgService:on(HASH_ID, SceneMSG.reset_ball, function()
        self.transform:reset_pos()
        self.transform:reset_scale()
        self.physics:reset_speed()
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_ball, function(message)
        self.physics:accelerate(message.delta_speed)
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.decelerate_ball, function(message)
        self.physics:accelerate(-message.delta_speed)
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.block_destructed, function()
        self.physics:accelerate(BallConfig.delta_speed)
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.pause, function()
        self.physics:stop_ball()
        animations.rotation.cancel()
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.winning, function()
        self.physics:stop_ball()
        animations.rotation.cancel()
        view:delete()
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.losing, function()
        self.physics:stop_ball()
        animations.rotation.cancel()
    end)

    subs[#subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.continue, function()
        self.physics:resume_moving()
    end)

    SceneMsgService:on(HASH_ID, SceneMSG.delete_ball, function()
        view:delete()

        for i = 1, #subs do
            subs[i]:unsubscribe()
        end
    end)
end

return BallComponent
