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

local GameMsgService = GameServices.msg
local GameGuiMsgService = GameServices.gui_msg

local GameMSG = App.constants.messages.game
local GameSceneUrls = App.constants.urls.scenes.game_scene

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
        if message.other_id == hash(GameSceneUrls.ball) then
            GameMsgService:send(nil, GameMSG.lost_ball)
            GameGuiMsgService:post(GameSceneUrls.gui, nil, GameMSG.lost_ball)
        end
    end)

    GameMsgService:on(GameSceneUrls.main, GameMSG.pause, function()
        self.ball_view:stop_ball()
    end)
end

return BallController
