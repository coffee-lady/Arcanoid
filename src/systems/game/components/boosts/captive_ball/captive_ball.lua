local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg
local BoostsDataService = SceneServices.boosts_data

local BoostConfig

local MSG = App.constants.messages

local CaptiveBallBoost = class('CaptiveBallBoost', Boost)

function CaptiveBallBoost:initialize(id, message)
    BoostConfig = BoostsDataService:get_data().captive_ball

    Boost.initialize(self, id, BoostConfig)
    self.pos = message.pos
end

function CaptiveBallBoost:boost()
    SceneMsgService:send(nil, MSG.game.add_balls, {
        count = BoostConfig.count,
        pos = self.pos
    })
end

return CaptiveBallBoost
