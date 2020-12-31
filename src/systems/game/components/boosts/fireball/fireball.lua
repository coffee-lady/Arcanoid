local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.fireball
local MSG = App.constants.messages

local BallDecelerationBoost = class('BallDecelerationBoost', Boost)

BallDecelerationBoost.weight = BoostConfig.weight

function BallDecelerationBoost:initialize(id)
    Boost.initialize(self, id, BoostConfig)
end

function BallDecelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.fire_balls)

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.put_out_balls)
    end)
end

return BallDecelerationBoost
