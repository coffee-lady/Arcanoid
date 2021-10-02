local App = require('src.app')

local SubscriptionsMap = App.libs.SubscriptionsMap

local MSG = App.constants.msg

local ButtonsController = class('ButtonsComponent')

function ButtonsController:initialize(context_services, presenters)
    self.progress_service = context_services.progress_service
    --- @type EventBus
    self.event_bus = context_services.event_bus
    --- @type LeaderboardsService
    self.leaderboards_service = context_services.leaderboards_service

    --- @type ButtonsPresenterStartScreen
    self.buttons_presenter = presenters.buttons

    self:_check_showing_buttons()
    self:_set_subscriptions()
end

function ButtonsController:_set_subscriptions()
    self.subs = SubscriptionsMap(self, self.event_bus, {
        [MSG.auth.success_auth] = self.on_authorized,
    })
end

function ButtonsController:on_authorized()
    self:_check_showing_buttons()
end

function ButtonsController:_check_showing_buttons()
    local is_there_prev_game = self.progress_service:get_previous_game_data() ~= nil

    if not is_there_prev_game then
        self.buttons_presenter:hide_button_continue()
    else
        self.buttons_presenter:show_button_continue()
    end

    self.buttons_presenter:update_main_buttons_layout()
    self:_check_secondary_buttons()
end

function ButtonsController:_check_secondary_buttons()
    self.buttons_presenter:disable_secondary_buttons_in_dev()

    if not self.leaderboards_service:is_available() then
        self.buttons_presenter:disable_rating_button()
    end
end

function ButtonsController:final()
    self.subs:unsubscribe()
end

return ButtonsController
