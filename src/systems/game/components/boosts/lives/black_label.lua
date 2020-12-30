local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Boost = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.black_label
local URL = App.constants.urls
local MSG = App.constants.messages

local BlackLabelBoost = {
    weight = BoostConfig.weight
}

function BlackLabelBoost:init(message)
    Boost:new(message.pos, BoostConfig, function()
        SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.decrease_lives)
    end)
end

return BlackLabelBoost
