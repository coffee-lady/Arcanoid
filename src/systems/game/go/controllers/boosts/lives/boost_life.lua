local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local BoostView = require('src.common.classes.boost_view')

local SceneMsgService = SceneServices.msg

local BoostConfig = App.config.game.boosts.life
local URL = App.constants.urls
local MSG = App.constants.messages

local LifeBoostController = {}

function LifeBoostController:init(boost_pos)
    BoostView:new(boost_pos, BoostConfig, self.boost)
end

function LifeBoostController:boost()
    SceneMsgService:post(URL.scenes.game_scene.gui, nil, MSG.game.increase_lives)
end

return LifeBoostController
