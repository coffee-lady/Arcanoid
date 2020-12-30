local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.captive_ball
local MSG = App.constants.messages

local CaptiveBallBoost = class('CaptiveBallBoost', Boost)

CaptiveBallBoost.weight = BoostConfig.weight

function CaptiveBallBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function CaptiveBallBoost:boost()
    SceneMsgService:send(nil, MSG.game.add_balls, {
        count = BoostConfig.count,
        pos = self.pos
    })
end

return CaptiveBallBoost
