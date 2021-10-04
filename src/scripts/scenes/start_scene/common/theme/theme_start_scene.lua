local App = require('src.app')
local GUI = require('gui.gui')

local ThemeMap = GUI.ThemeMap
local NodesList = GUI.NodesList
local SubscriptionsMap = App.libs.SubscriptionsMap

local MSG = App.constants.msg

local Theme = class('ThemeMap')

Theme.__cparams = {'event_bus', 'ui_service'}

function Theme:initialize(event_bus, ui_service, nodes_map)
    --- @type EventBus
    self.event_bus = event_bus
    --- @type UIService
    self.ui_service = ui_service

    local nodes = nodes_map:get_table()

    self.theme_map = ThemeMap(self.ui_service):init({
        root = {
            is_static = true,
            map = {
                bg = nodes.root,
            },
        },

        button_play = {
            is_static = true,
            map = {
                inner = nodes.button_play.inner,
                text = nodes.button_play.text,
            },
        },
    })

    self:_set_subscriptions()
end

function Theme:_set_subscriptions()
    SubscriptionsMap(self, self.event_bus, {
        [MSG.themes.theme_changed] = self.on_theme_changed,
    })
end

function Theme:on_theme_changed()
    self.theme_map:refresh()
end

function Theme:get_map()
    return self.theme_map:get_map()
end

return Theme
