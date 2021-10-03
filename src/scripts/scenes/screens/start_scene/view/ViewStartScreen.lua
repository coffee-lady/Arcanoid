local App = require('src.app')
local GUI = require('gui.gui')

local LandscapeLayout = GUI.layouts.LandscapeLayout
local TextNode = GUI.TextNode

local UIConfig = App.config.ui.start_scene
local ID = App.constants.gui.screens.start_scene

--- @class ViewStartScene
local ViewStartScreen = class('ViewStartScreen')

function ViewStartScreen:initialize(context_services, nodes)
    self.ui_service = context_services.ui_service
    self.nodes = nodes
end

function ViewStartScreen:set_button_play(version_text)
    self.nodes.button_play:set_text(version_text)
end

return ViewStartScreen
