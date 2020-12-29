local App = require('src.app')
local class = App.libs.middleclass
local Services = require('src.services.services')

local LocalizationService = Services.localization

local MSG = App.constants.messages
local URL = App.constants.urls

local LocalizationController = class('LocalizationController')

local function replace_vars(str, vars)
    if not vars then
        vars = str
    end
    return (string.gsub(str, '({([^}]+)})', function(whole, i)
        return vars[i] or whole
    end))
end

local function set_text(id, text)
    local node = gui.get_node(id)
    gui.set_text(node, text)
end

function LocalizationController:initialize(scene_url, msg_service)
    self.url = scene_url
    self.text_nodes = URL.gui_nodes[self.url].text
    self.msg_service = msg_service
    self.list = {}
end

function LocalizationController:init()
    if self.get_vars then
        self.vars = self:get_vars()
    end

    self:update()

    self.msg_service:on(self.url, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local data = LocalizationService:get(self.url)

    for id, _ in pairs(self.text_nodes) do
        local text = replace_vars(data[id], self.vars)

        set_text(id, text)
    end
end

function LocalizationController:localize_partially(nodes, text_nodes_ids, items_data)
    local item = {
        nodes = nodes,
        text_nodes_ids = text_nodes_ids,
        items_data = items_data
    }

    self.list[#self.list + 1] = item

    self:update_list(item)
end

function LocalizationController:update_list(list)
    local data = LocalizationService:get(self.url)

    for id, _ in pairs(list.text_nodes_ids) do
        local text = replace_vars(data[id], list.items_data)

        gui.set_text(list.nodes[id], text)
    end
end

return LocalizationController
