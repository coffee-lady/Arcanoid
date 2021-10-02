local App = require('src.app')
local GUI = require('gui.gui')

local ID = App.constants.gui.screens.start_screen

local TextNode = GUI.TextNode

--- @class DebugDataPresenter
local DebugDataPresenter = class('DebugDataPresenter')

function DebugDataPresenter:initialize(context_services, view)
    --- @type ViewStartScreen
    self.view = view
end

function DebugDataPresenter:set_version_label(version)
    self.view:set_version_label('Version: ' .. version)
end

function DebugDataPresenter:hide_version_label()
    self.view:hide_version_label()
end

return DebugDataPresenter
