local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local MSG = App.constants.messages
local URL = App.constants.urls

local handle

local FireballBoost = class('FireballBoost', Boost)

function FireballBoost:initialize(id, _, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
end

function FireballBoost:boost()
    SceneMsgService:send(nil, MSG.game.fire_balls)

    local subs = SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.fire_balls, function()
        timer.cancel(handle)
    end)

    handle = timer.delay(BoostConfig.time, false, function()
        SceneMsgService:send(nil, MSG.game.put_out_balls)
        subs:unsubscribe()
    end)
end

return FireballBoost
