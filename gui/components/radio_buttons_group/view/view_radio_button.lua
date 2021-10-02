local Libs = require('src.libs.libs')
local Core = require('gui.core.core')
local Widget = require('gui.widget.widget')

local BoxNode = Core.BoxNode
local TextNode = Core.TextNode

local class = Libs.middleclass

--- @class RadioButtonView : Widget
local RadioButtonView = class('RadioButtonView', Widget)

function RadioButtonView:initialize(context_services, id, gui_nodes, params)
    Widget.initialize(self, context_services)

    self.localization = context_services.localization
    self.ui_service = context_services.ui_service

    local ids = params.ID

    self.id = id
    self.params = params
    self.nodes = {
        container = BoxNode(gui_nodes[ids.container]),
        mark_container = BoxNode(gui_nodes[ids.mark_container]),
        mark = BoxNode(gui_nodes[ids.mark]),
        title = TextNode(gui_nodes[ids.title]),
    }

    self.theme_object = self:set_theme_map({
        radio_button = {
            primary_mode = 'enabled',
            disable_submode = true,
            map = {
                container = self.nodes.mark_container,
                icon = self.nodes.mark,
                title = self.nodes.title,
            },
        },
    }):get_map().radio_button

    self:init()
end

function RadioButtonView:init()
    local title_node_text = self.localization:get_localized_text(self.params.localization_key)[self.id]
    self.nodes.title:set_text(title_node_text)

    if self.params.enabled ~= self.id then
        self:deselect()
    end
end

function RadioButtonView:is_pressed(action)
    return self.nodes.container:is_pressed(action)
end

function RadioButtonView:select()
    self.theme_object:switch_to(self.theme_object.MODE.enabled)
    self.nodes.mark:set_enabled(true)
end

function RadioButtonView:deselect()
    self.theme_object:switch_to(self.theme_object.MODE.disabled)
    self.nodes.mark:set_enabled(false)
end

function RadioButtonView:get_container()
    return self.nodes.container
end

return RadioButtonView
