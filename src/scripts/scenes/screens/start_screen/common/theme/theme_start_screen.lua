local App = require('src.app')
local GUI = require('gui.gui')
local Nodes = require('src.scripts.scenes.screens.start_screen.common.nodes.nodes_start_screen')

local ThemeMap = GUI.ThemeMap
local NodesList = GUI.NodesList

local MSG = App.constants.msg

local Theme = {}

function Theme:init(context_services)
    --- @type EventBus
    self.event_bus = context_services.event_bus
    local ui_service = context_services.ui_service

    local nodes = Nodes:get_objects()
    local buttons = nodes.buttons

    self.theme_map = ThemeMap(ui_service):init({
        root = {
            is_static = true,
            map = {
                bg = NodesList(nodes.root, nodes.fades),
                arrows = nodes.arrows,
            },
        },

        button_continue_game = {
            disable_submode = true,
            map = {
                bg = buttons.continue_game.container,
                title = buttons.continue_game.title,
            },
        },

        button_new_game = {
            is_static = true,
            map = {
                bg = buttons.new_game.container,
                title = buttons.new_game.title,
            },
        },

        secondary_buttons = {
            disable_submode = true,
            map = {
                title = NodesList(buttons.game_events.title, buttons.daily_tasks.title, buttons.rating_button.title),
                icon = NodesList(buttons.game_events.icon, buttons.daily_tasks.icon, buttons.rating_button.icon),
                icon_bg = NodesList(buttons.game_events.inner, buttons.daily_tasks.inner, buttons.rating_button.inner),
            },
        },
    })

    self:set_subscriptions()
end

function Theme:set_subscriptions()
    self.event_bus:on(MSG.themes.theme_changed, self.on_theme_changed, self)
end

function Theme:on_theme_changed()
    self.theme_map:refresh()
end

function Theme:refresh()
    self.theme_map:refresh()
end

function Theme:get_map()
    return self.theme_map:get_map()
end

return Theme
