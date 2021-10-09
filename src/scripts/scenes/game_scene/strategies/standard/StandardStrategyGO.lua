local App = require('src.app')
local Controllers = require('src.scripts.scenes.game_scene.controllers.controllers')
local UIMaps = require('src.scripts.scenes.game_scene.common.common_go')
local Presenters = require('src.scripts.scenes.game_scene.presenters.presenters')
local View = require('src.scripts.scenes.game_scene.view.ViewGameSceneGO')

local SceneStrategy = App.libs.scenes.SceneStrategy

--- @class StandardStrategy : SceneStrategy
local StandardStrategy = class('StandardStrategy', SceneStrategy)

function StandardStrategy:initialize()
    SceneStrategy.initialize(self, Controllers, Presenters, View, UIMaps)
end

return StandardStrategy
