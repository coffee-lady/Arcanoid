local App = require('src.app')

local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages

local CaptiveBallBoost = class('CaptiveBallBoost', Boost)

function CaptiveBallBoost:initialize(id, message, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
    self.pos = message.pos
end

function CaptiveBallBoost:boost()
    SceneMsgService:send(nil, MSG.game.add_balls, {
        count = BoostConfig.count,
        pos = self.pos,
    })
end

return CaptiveBallBoost
