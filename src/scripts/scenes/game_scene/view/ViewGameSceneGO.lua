local App = require('src.app')
local GUI = require('gui.gui')

local SceneView = App.libs.scenes.SceneView
local LandscapeLayout = GUI.layouts.LandscapeLayout
local TextNode = GUI.TextNode

--- @class ViewGameSceneGO : SceneView
local ViewGameSceneGO = class('ViewGameSceneGO', SceneView)

function ViewGameSceneGO:initialize(UIMaps)
    SceneView.initialize(self, UIMaps)
end

return ViewGameSceneGO
