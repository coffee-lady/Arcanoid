local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local URL = App.constants.urls
local MSG = App.constants.messages

local BonusLifeBoost = class('BonusLifeBoost', Boost)

function BonusLifeBoost:initialize(id, _, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
end

function BonusLifeBoost:boost()
    SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.increase_lives)
end

return BonusLifeBoost
