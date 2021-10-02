local App = require('src.app')
local GUI = require('gui.gui')

local ID = App.constants.gui.common.templates.simple_popup

local TextNode = GUI.TextNode
local BoxNode = GUI.BoxNode
local ButtonsMenu = GUI.ButtonsMenu

local MSG = App.constants.msg

local Nodes = class('Nodes')

function Nodes:initialize(context_services, map)
    --- @type EventBus
    self.event_bus = context_services.event_bus
    self.context_services = context_services

    self.nodes = {
        root = BoxNode(ID.root),
        header = BoxNode(ID.header),
        title = TextNode(ID.title),
        text = TextNode(ID.text),

        button_close = BoxNode(ID.button_close.container),
        button_close_inner = BoxNode(ID.button_close.inner),

        button_next = BoxNode(ID.button_next.container),
        button_next_text = TextNode(ID.button_next.text),
        button_next_inner = BoxNode(ID.button_next.inner),

        icon = BoxNode(ID.icon),
        icon_bg = BoxNode(ID.icon_bg),
    }

    self:set_buttons_menu(map)
end

function Nodes:set_buttons_menu(map)
    ButtonsMenu(self.context_services, {
        [ID.button_close] = map.button_close,
        [ID.button_next] = map.button_next,
    }):set_button_type_id(ID.button_close, GUI.BUTTON_CLOSE)
end

function Nodes:add_checkbox(checkbox)
    self.nodes.checkbox = checkbox
end

function Nodes:get_objects()
    return self.nodes
end

return Nodes
