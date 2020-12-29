local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.captive_ball
local MSG = App.constants.messages

local CaptiveBallBoost = {}

local function boost(self)
    SceneMsgService:send(nil, MSG.game.add_balls, {
        count = BoostConfig.count,
        pos = self.pos
    })
end

function CaptiveBallBoost:init(message)
    self.pos = message.pos
    Boost:new(message.pos, BoostConfig, function()
        boost(self)
    end)
end

return CaptiveBallBoost
