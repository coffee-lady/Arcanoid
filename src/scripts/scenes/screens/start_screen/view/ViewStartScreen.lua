local App = require('src.app')
local GUI = require('gui.gui')

local LandscapeLayout = GUI.layouts.LandscapeLayout
local TextNode = GUI.TextNode

local UIConfig = App.config.ui.start_screen
local ID = App.constants.gui.screens.start_screen

--- @class ViewStartScreen
local ViewStartScreen = class('ViewStartScreen')

function ViewStartScreen:initialize(context_services, nodes)
    self.ui_service = context_services.ui_service
    self.nodes = nodes
end

function ViewStartScreen:update_button_continue_layout()
    local text_object = self.nodes.buttons.continue_game.subtext_text
    local icon_object = self.nodes.buttons.continue_game.subtext_icon

    LandscapeLayout({icon_object, text_object}, UIConfig.continue_button_subtext.gap):apply()
end

function ViewStartScreen:set_version_label(version_text)
    self.nodes.version_label:set_text(version_text)

    local colors = self.ui_service:get_common_colors()
    self.nodes.version_label:set_color(colors.version_label)
end

function ViewStartScreen:hide_version_label()
    self.nodes.version_label:set_enabled(false)
end

return ViewStartScreen
