local App = require('src.app')
local GUI = require('gui.gui')
local Nodes = require('src.scripts.scenes.screens.start_scene.common.nodes.nodes_start_scene')

local ThemeMap = GUI.ThemeMap
local NodesList = GUI.NodesList
local SubscriptionsMap = App.libs.SubscriptionsMap

local MSG = App.constants.msg

local Theme = {}

function Theme:init(context_services)
    --- @type EventBus
    self.event_bus = context_services.event_bus
    local ui_service = context_services.ui_service

    local nodes = Nodes:get_table()

    self.theme_map = ThemeMap(ui_service):init({
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
