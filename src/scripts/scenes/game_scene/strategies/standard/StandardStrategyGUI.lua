local App = require('src.app')
local Controllers = require('src.scripts.scenes.game_scene.controllers.controllers_gui')
local UIMaps = require('src.scripts.scenes.game_scene.view.common.common_gui')
local Presenters = require('src.scripts.scenes.game_scene.presenters.presenters_gui')
local View = require('src.scripts.scenes.game_scene.view.ViewGameSceneGUI')

local SceneStrategy = App.libs.scenes.SceneStrategy

--- @class StandardStrategy : SceneStrategy
local StandardStrategy = class('StandardStrategy', SceneStrategy)

function StandardStrategy:initialize()
    SceneStrategy.initialize(self, Controllers, Presenters, View, UIMaps)

    self:set_screen_transition()
end

return StandardStrategy
