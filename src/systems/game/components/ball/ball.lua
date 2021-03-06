local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local BallData = SceneServices.shared_data.balls

local class = App.libs.middleclass
local SceneMsgService = SceneServices.msg
local ScreenService = Services.screen
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

    self.animations = Animations:new(id)
    self.view = View:new(id)

    if BallData:is_fired() then
        self.view:fire_ball()
    end

    self.subs = {}

    if not pos then
        self.transform:reset_pos()
    else
        self.transform:set_pos(pos)
    end

    self.transform:reset_scale()
    self.physics:reset_speed()

    self.animations.rotation.play()

    self.subs[#self.subs + 1] = ScreenService.update_observer:subscribe(
                                    function()
            self.transform:reset_scale()
            self.transform:reset_pos()
        end)

    SceneMsgService:on(HASH_ID, MSG.common.collision_response, function()
        self.physics:normalize_speed()
    end)

    SceneMsgService:on(HASH_ID, SceneMSG.reset_ball, function()
        self.transform:reset_pos()
        self.transform:reset_scale()
        self.physics:reset_speed()
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_ball, function(message)
        self.physics:accelerate(message.delta_speed)
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.decelerate_ball, function(message)
        local delta_speed = -vmath.vector3(message.delta_speed.x, message.delta_speed.y, message.delta_speed.z)
        self.physics:accelerate(delta_speed)
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.block_destructed, function()
        self.physics:accelerate(BallConfig.delta_speed)
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.pause, function()
        self.physics:stop_ball()
        self.animations.rotation.cancel()
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.fire_balls, function()
        self.view:fire_ball()
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.put_out_balls, function()
        self.view:put_out_ball()
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.winning, function()
        self:delete()
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.losing, function()
        self.physics:stop_ball()
        self.animations.rotation.cancel()
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneUrls.main, SceneMSG.continue, function()
        self.physics:resume_moving()
    end)

    SceneMsgService:on(HASH_ID, SceneMSG.delete_ball, function()
        self:delete()
    end)
end

function BallComponent:delete()
    self.physics:stop_ball()
    self.animations.rotation.cancel()

    self.view:delete()

    for i = 1, #self.subs do
        self.subs[i]:unsubscribe()
    end
end

return BallComponent
