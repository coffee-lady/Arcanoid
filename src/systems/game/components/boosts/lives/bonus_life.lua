local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.life
local URL = App.constants.urls
local MSG = App.constants.messages

local BonusLifeBoost = class('BonusLifeBoost', Boost)

BonusLifeBoost.weight = BoostConfig.weight

function BonusLifeBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function BonusLifeBoost:boost()
    SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.increase_lives)
end

return BonusLifeBoost
