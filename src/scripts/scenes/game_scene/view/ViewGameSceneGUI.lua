local App = require('src.app')
local GUI = require('gui.gui')

local SceneView = App.libs.scenes.SceneView
local LandscapeLayout = GUI.layouts.LandscapeLayout
local TextNode = GUI.TextNode

--- @class ViewGameSceneGUI : SceneView
local ViewGameSceneGUI = class('ViewGameSceneGUI', SceneView)

function ViewGameSceneGUI:initialize(UIMaps)
    SceneView.initialize(self, UIMaps)
end

return ViewGameSceneGUI
