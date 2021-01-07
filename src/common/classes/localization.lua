local App = require('src.app')
local Services = require('src.services.services')
local class = App.libs.middleclass

local LocalizationService = Services.localization

local MSG = App.constants.messages
local URL = App.constants.urls

local Localization = class('Localization')

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

function Localization:initialize(scene_url, msg_service, callbacks)
    self.url = scene_url
    self.text_nodes = URL.gui_nodes[self.url].text
    self.msg_service = msg_service
    self.list = {}

    if callbacks then
        self._init = callbacks.init
        self._final = callbacks.final
    end
end

function Localization:init()
    if self.get_vars then
        self.vars = self:get_vars()
    end

    self.subs = {}

    self:update()

    self.msg_service:on(self.url, MSG.common.localization_change, function()
        self:update()
    end)

    if self._init then
        self._init(self)
    end
end

function Localization:add_subscription(sub)
    self.subs[#self.subs + 1] = sub
end

function Localization:update()
    if self.get_vars then
        self.vars = self:get_vars()
    end

    self:update_static()
end

function Localization:update_node(id, vars)
    local data = LocalizationService:get(self.url)

    local text = replace_vars(data[id], vars)

    set_text(id, text)
end

function Localization:update_static()
    local data = LocalizationService:get(self.url)

    for id, _ in pairs(self.text_nodes) do
        local text = replace_vars(data[id], self.vars)

        set_text(id, text)
    end
end

function Localization:localize_list(nodes, text_nodes_ids, items_data)
    local item = {
        nodes = nodes,
        text_nodes_ids = text_nodes_ids,
        items_data = items_data
    }

    self.list[#self.list + 1] = item

    self:update_list(item)
end

function Localization:update_list(list)
    local data = LocalizationService:get(self.url)

    for id, _ in pairs(list.text_nodes_ids) do
        local text = replace_vars(data[id], list.items_data)

        gui.set_text(list.nodes[id], text)
    end
end

function Localization:remove(node_id)
    local i = 1
    for id, _ in pairs(self.text_nodes) do
        if id == node_id then
            gui.set_enabled(gui.get_node(node_id), false)
            table.remove(self.text_nodes, i)
            break
        end
        i = i + 1
    end
end

function Localization:final()
    for i = 1, #self.subs do
        self.subs[i]:unsubscribe()
    end

    if self._final then
        self._final()
    end
end

return Localization
