local App = require('src.app')

local Boost = Common.components.boost

local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local BoostConfig

local URL = App.constants.urls
local MSG = App.constants.messages

local BlackLabelBoost = class('BlackLabelBoost', Boost)

function BlackLabelBoost:initialize(id, _, config)
    BoostConfig = config

    Boost.initialize(self, id, BoostConfig)
end

function BlackLabelBoost:boost()
    SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.decrease_lives)
end

return BlackLabelBoost
