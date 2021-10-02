local App = require('src.app')
local GUI = require('gui.gui')

local UIConfig = App.config.ui.common.templates.simple_popup

local VerticalLayout = GUI.layouts.VerticalLayout

local CHECKBOX_POS = 3

local SimplePopupView = class('SimplePopupView')

function SimplePopupView:initialize(context_services, nodes)
    self.nodes = nodes
end

function SimplePopupView:add_checkbox(checkbox_node)
    self.checkbox_node = checkbox_node
end

function SimplePopupView:update_layout()
    if not self.nodes.icon_bg.target then
        VerticalLayout({self.nodes.header, self.nodes.text, self.nodes.button_next}, UIConfig.gaps_without_icon):apply():adjust_container_height(self.nodes.root)
        return
    end

    local nodes = {self.nodes.header, self.nodes.text, self.nodes.icon_bg, self.nodes.button_next}
    VerticalLayout(nodes, UIConfig.gaps):apply():adjust_container_height(self.nodes.root)
end

function SimplePopupView:update_layout_with_checkbox()
    if not self.nodes.icon_bg.target then
        VerticalLayout({self.nodes.header, self.nodes.text, self.nodes.button_next}, UIConfig.gaps_without_icon):apply():adjust_container_height(self.nodes.root)
        return
    end

    local nodes = {self.nodes.header, self.nodes.text, self.nodes.icon_bg, self.nodes.button_next}
    local layout = VerticalLayout(nodes, UIConfig.gaps_with_checkbox)
    layout:set_node(self.checkbox_node, CHECKBOX_POS)
    layout:apply():adjust_container_height(self.nodes.root)
end

return SimplePopupView
