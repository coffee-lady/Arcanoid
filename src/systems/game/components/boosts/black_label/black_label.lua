local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local Common = require('src.common.common')
local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg
local BoostsDataService = SceneServices.boosts_data

local BoostConfig

local URL = App.constants.urls
local MSG = App.constants.messages

local BlackLabelBoost = class('BlackLabelBoost', Boost)

function BlackLabelBoost:initialize(id)
    BoostConfig = BoostsDataService:get_data().black_label

    Boost.initialize(self, id, BoostConfig)
end

function BlackLabelBoost:boost()
    SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.decrease_lives)
end

return BlackLabelBoost
