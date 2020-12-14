local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')

local Ball = Models.ball
local BallView = Views.ball

local BallController = {}

function BallController:init()
    self.ball = Ball:new()
    self.ball_view = BallView:new(self.ball)
end

return BallController
