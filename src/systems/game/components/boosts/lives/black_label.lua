local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.black_label
local URL = App.constants.urls
local MSG = App.constants.messages

local BlackLabelBoost = class('BlackLabelBoost', Boost)

BlackLabelBoost.weight = BoostConfig.weight

function BlackLabelBoost:initialize(message)
    self.pos = message.pos
    self.config = BoostConfig
end

function BlackLabelBoost:boost()
    SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.decrease_lives)
end

return BlackLabelBoost
