local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.fireball
local MSG = App.constants.messages

local BallDecelerationBoost = {}

local function boost()
    SceneMsgService:send(nil, MSG.game.fire_balls)

    timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.put_out_balls)
    end)
end

function BallDecelerationBoost:init(message)
    Boost:new(message.pos, BoostConfig, function()
        boost()
    end)
end

return BallDecelerationBoost
