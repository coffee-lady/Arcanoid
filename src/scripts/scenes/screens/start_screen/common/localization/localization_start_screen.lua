local App = require('src.app')
local Nodes = require('src.scripts.scenes.screens.start_screen.common.nodes.nodes_start_screen')

local TextKeys = App.config.localization.keys
local MSG = App.constants.msg

local DateLib = App.libs.date
local GUI = require('gui.gui')
local LocalizationMap = GUI.LocalizationMap
local SubscriptionsMap = App.libs.SubscriptionsMap

local Localization = {}

function Localization:init(context_services)
    self.progress_service = context_services.progress_service
    self.localization = context_services.localization
    --- @type EventBus
    self.event_bus = context_services.event_bus

    local nodes = Nodes:get_objects()

    self.object = LocalizationMap(context_services, TextKeys.start_screen, {{
        key = 'button_continue',
        object = nodes.buttons.continue_game.title,
    }, {
        key = 'button_new_game',
        object = nodes.buttons.new_game.title,
    }, {
        key = 'button_game_events',
        object = nodes.buttons.game_events.title,
    }, {
        key = 'button_daily_tasks',
        object = nodes.buttons.daily_tasks.title,
    }, {
        key = 'button_rating',
        object = nodes.buttons.rating_button.title,
    }})

    self:set_previous_game_data()
    self:set_subscriptions()
end

function Localization:add(data)
    self.object:add(data)
end

function Localization:set_subscriptions()
    SubscriptionsMap(self, self.event_bus, {
        [MSG.auth.success_auth] = self.set_previous_game_data,
        [MSG.localization.language_changed] = self.on_language_changed,
    })
end

function Localization:set_previous_game_data()
    local btn_continue = Nodes:get_objects().buttons.continue_game
    local game_data = self.progress_service:get_previous_game_data()

    if not game_data then
        return
    end

    local difficulty_index = game_data.game_config.difficulty_index
    local difficulty_text = self.localization:get_localized_text(TextKeys.common.difficulty)

    local data = self.localization:get_localized_text(TextKeys.start_screen, {
        time = DateLib.format_ms(game_data.timer.minutes, game_data.timer.seconds),
        difficulty = difficulty_text[difficulty_index],
    })

    local prev_game_text = data.prev_game_data
    btn_continue.subtext_text:set_text(prev_game_text)
end

function Localization:on_language_changed()
    self.object:refresh()
    self:set_previous_game_data()
end

return Localization
