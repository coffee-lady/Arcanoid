local App = require('src.app')
local Models = require('src.systems.game.go.models.models')
local Views = require('src.systems.game.go.views.views')
local GameServices = require('src.systems.game.services.services')

local Services = require('src.services.services')
local ScreenService = Services.screen

local Ball = Models.ball
local BallView = Views.ball
local LosingZone = Models.losing_zone
local LosingZoneView = Views.losing_zone

local SceneMsgService = GameServices.msg
local SceneGuiMsgService = GameServices.gui_msg

local SceneMSG = App.constants.messages.game
local SceneUrls = App.constants.urls.scenes.game_scene

local BallController = {}

function BallController:init()
    self.ball = Ball:new()
    self.ball_view = BallView:new(self.ball)

    self.ball.update_speed_observer:subscribe(function(speed)
        self.ball_view:update_speed(speed)
    end)

    self.ball:reset()

    self.losing_zone = LosingZone:new()
    self.losing_zone_view = LosingZoneView:new()

    ScreenService.update_observer:subscribe(function()
        self.ball:reset()
        self.losing_zone_view:reset()
    end)

    self.losing_zone.triggered_observer:subscribe(function(message)
        if message.other_id == hash(SceneUrls.ball) then
            SceneMsgService:send(nil, SceneMSG.lost_ball)
            SceneGuiMsgService:post(SceneUrls.gui, nil, SceneMSG.lost_ball)
        end
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.pause, function()
        self.ball_view:stop_ball()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.winning, function()
        self.ball_view:stop_ball()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.losing, function()
        self.ball_view:stop_ball()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.continue, function()
        self.ball_view:resume_moving()
    end)
end

return BallController
