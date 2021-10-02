local Libs = require('src.libs.libs')
local Core = require('gui.core.core')
local Widget = require('gui.widget.widget')

local BoxNode = Core.BoxNode
local TextNode = Core.TextNode

local class = Libs.middleclass

--- @class CheckboxView : Widget
local CheckboxView = class('CheckboxView', Widget)

function CheckboxView:initialize(context_services, ids, gap)
    Widget.initialize(self, context_services, true)

    self.localization = context_services.localization
    self.ui_service = context_services.ui_service

    self.nodes = {
        container = BoxNode(ids.container),
        text = TextNode(ids.text),
        checkmark = BoxNode(ids.checkmark),
        checkmark_stroke = BoxNode(ids.checkmark_stroke),
    }

    self:set_theme_map({
        checkbox = {
            is_static = true,
            map = {
                text = self.nodes.text,
                icon = self.nodes.checkmark,
                stroke = self.nodes.checkmark_stroke,
            },
        },
    })

    self.gap = gap
    self:align_nodes_horizontally({self.nodes.checkmark_stroke, self.nodes.text}, self.gap)
end

function CheckboxView:is_pressed(action)
    return self.nodes.checkmark_stroke:is_pressed(action)
end

function CheckboxView:check()
    self.nodes.checkmark:set_enabled(true)
end

function CheckboxView:uncheck()
    self.nodes.checkmark:set_enabled(false)
end

function CheckboxView:localize(key, vars)
    local text = self.localization:get_localized_text(key, vars)
    self:set_text(text)
end

function CheckboxView:set_text(text)
    self.nodes.text:set_text(text)
    self:align_nodes_horizontally({self.nodes.checkmark_stroke, self.nodes.text}, self.gap)
end

function CheckboxView:get_container()
    return self.nodes.container
end

return CheckboxView
