local App = require('src.app')
local Controllers = require('src.scripts.scenes.game_scene.controllers.controllers_go')
local UIMaps = require('src.scripts.scenes.game_scene.view.common.common_go')
local Presenters = require('src.scripts.scenes.game_scene.presenters.presenters_go')
local View = require('src.scripts.scenes.game_scene.view.ViewGameSceneGO')

local SceneStrategy = App.libs.scenes.SceneStrategy

--- @class StandardStrategy : SceneStrategy
local StandardStrategy = class('StandardStrategy', SceneStrategy)

function StandardStrategy:initialize()
    SceneStrategy.initialize(self, Controllers, Presenters, View, UIMaps)
end

return StandardStrategy
