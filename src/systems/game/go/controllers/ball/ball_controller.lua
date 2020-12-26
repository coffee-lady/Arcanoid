local App = require('src.app')
local Models = require('src.systems.game.go.models.models')
local Views = require('src.systems.game.go.views.views')
local SceneServices = require('src.systems.game.services.services')

local Services = require('src.services.services')
local ScreenService = Services.screen

local Ball = Models.ball
local BallView = Views.ball
local LosingZone = Models.losing_zone
local LosingZoneView = Views.losing_zone

local SceneMsgService = SceneServices.msg
local SceneGuiMsgService = SceneServices.gui_msg
local GameSceneUrls = App.constants.urls.scenes.game_scene

local CO_GROUPS = App.constants.co_groups
local SceneMSG = App.constants.messages.game
local SceneUrls = App.constants.urls.scenes.game_scene

local BallController = {}

function BallController:init()
    local ball_id = factory.create(GameSceneUrls.ball_factory)

    local ball = Ball:new(ball_id)
    local ball_view = BallView:new(ball_id)

    ball.update_speed_observer:subscribe(function(speed)
        ball_view:update_speed(speed)
    end)

    ball:reset()

    local losing_zone = LosingZone:new()
    local losing_zone_view = LosingZoneView:new()

    ScreenService.update_observer:subscribe(function()
        ball:reset()
        losing_zone_view:reset()
    end)

    losing_zone.triggered_observer:subscribe(function(message)
        if message.other_group == hash(CO_GROUPS.balls) then
            SceneMsgService:send(nil, SceneMSG.lost_ball)
            go.delete(ball_view.url)
            SceneGuiMsgService:post(SceneUrls.gui, nil, SceneMSG.lost_ball)
        end
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_ball, function(message)
        ball:accelerate(message.delta_speed)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.accelerate_ball, function(message)
        ball:accelerate(-message.delta_speed)
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.block_destructed, function()
        ball:speed_up()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.pause, function()
        ball_view:stop_ball()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.winning, function()
        ball_view:stop_ball()
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.continue, function()
        ball_view:resume_moving()
    end)

    SceneMsgService:on(hash(ball_view.url), SceneMSG.lost_ball, function()
        ball_view:reset()
    end)
end

return BallController
