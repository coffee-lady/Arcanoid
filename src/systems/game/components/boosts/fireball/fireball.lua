local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg
local BoostsDataService = SceneServices.boosts_data

local BoostConfig

local MSG = App.constants.messages

local BallDecelerationBoost = class('BallDecelerationBoost', Boost)

function BallDecelerationBoost:initialize(id)
    BoostConfig = BoostsDataService:get_data().fireball

    Boost.initialize(self, id, BoostConfig)
end

function BallDecelerationBoost:boost()
    SceneMsgService:send(nil, MSG.game.fire_balls)

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.put_out_balls)
    end)
end

return BallDecelerationBoost
