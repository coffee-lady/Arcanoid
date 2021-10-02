local Libs = require('src.libs.libs')
local Core = require('gui.core.core')
local FancyScroll = require('gui.fancy_scroll.fancy_scroll')

local class = Libs.middleclass
local GUINode = Core.Node

local ScrollController = class('ScrollController')

function ScrollController:initialize(context_services, params, slider_common)
    self.context_services = context_services

    self.slider_common = slider_common
    self.data = params.data
    self.config = params.config
    self.container_id = params.container_id
    self.item_template_id = params.item_template_id
    self.ItemView = params.ItemView
end

function ScrollController:init()
    self.scroll_container = GUINode(self.container_id)
    self.item_template = GUINode(self.item_template_id)

    self.item_template:set_enabled(false)
    self.scroll_view = self:_create_scroll(self.container_id)

    self:create_items()
end

function ScrollController:get_pos_in_horizontal_scroll(scroll_index)
    local viewport_size = self.scroll_container:get_size()
    local item_size = self.item_template:get_size()
    local pos = vmath.vector3()
    pos.x = -(item_size.x + viewport_size.x) / 2 + scroll_index * (viewport_size.x + item_size.x)
    return pos
end

function ScrollController:get_pos_in_vertical_scroll(scroll_index)
    local viewport_size = self.scroll_container:get_size()
    local item_size = self.item_template:get_size()
    local pos = vmath.vector3()
    pos.y = (item_size.y + viewport_size.y) / 2 - scroll_index * (viewport_size.y + item_size.y)
    return pos
end

function ScrollController:_create_scroll(container_id)
    local scroll_options = self.config

    local view_creator = function()
        return self:_create_view_item()
    end

    local view_scroll = FancyScroll.FancyScrollView(container_id, view_creator, scroll_options)

    return view_scroll
end

function ScrollController:create_items()
    self.scroll_view:update_items(self.data)
end

function ScrollController:on_data_updated(data)
    self.data = data
    self.scroll_view:update_items(self.data)
end

function ScrollController:_create_view_item()
    local nodes = self.item_template:clone_tree()
    return self.ItemView(nodes, self.scroll_container, self.context_services, self.slider_common)
end

function ScrollController:set_scrollbar(nodes, options)
    self.scroll_view:set_scrollbar(nodes, options)
end

function ScrollController:get_scroll_index()
    return self.scroll_view:get_scroll_index()
end

function ScrollController:switch_to(index, callack)
    self.scroll_view:switch_to(index, callack)
end

function ScrollController:scroll_to(index, callack)
    self.scroll_view:scroll_to(index, callack)
end

function ScrollController:next()
    self.scroll_view:next()
end

function ScrollController:prev()
    self.scroll_view:prev()
end

function ScrollController:on_scroll(callback)
    self.scroll_view:on_scroll(callback)
end

function ScrollController:on_item_position_updated(cb)
    self.scroll_view:add_on_item_position_updated(cb)
end

function ScrollController:on_all_items_positions_updated(cb)
    self.scroll_view:add_on_all_items_positions_updated(cb)
end

function ScrollController:update(dt)
    self.scroll_view:update(dt)
end

function ScrollController:on_input(action_id, action)
    self.scroll_view:on_input(action_id, action)
end

function ScrollController:get_item_position(first_position, scroll_index)
    return self.scroll_view:get_item_position(first_position, scroll_index)
end

return ScrollController
