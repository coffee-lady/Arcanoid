local App = require('src.app')
local Controllers = require('src.scripts.scenes.start_scene.controllers.controllers')
local UIMaps = require('src.scripts.scenes.start_scene.common.common')
local Presenters = require('src.scripts.scenes.start_scene.presenters.presenters')
local View = require('src.scripts.scenes.start_scene.view.ViewStartScreen')

local SceneStrategy = App.libs.scenes.SceneStrategy

--- @class StandardStrategy : SceneStrategy
local StandardStrategy = class('StandardStrategy', SceneStrategy)

function StandardStrategy:initialize()
    SceneStrategy.initialize(self, Controllers, Presenters, View, UIMaps)

    self:set_screen_transition()
end

return StandardStrategy
