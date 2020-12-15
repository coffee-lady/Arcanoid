local App = require('src.app')
local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')

local Ball = Models.ball
local BallView = Views.ball
local LosingZone = Models.losing_zone
local LosingZoneView = Views.losing_zone

local GameSceneUrls = App.constants.urls.scenes.game_scene

local BallController = {}

function BallController:init()
    self.ball = Ball:new()
    self.ball_view = BallView:new(self.ball)

    self.losing_zone = LosingZone:new()
    self.losing_zone_view = LosingZoneView:new(self.losing_zone)

    self.losing_zone.triggered_observer:subscribe(function(message)
        if message.other_id == hash(GameSceneUrls.ball) then
            self.ball:reset()
        end
    end)
end

return BallController
