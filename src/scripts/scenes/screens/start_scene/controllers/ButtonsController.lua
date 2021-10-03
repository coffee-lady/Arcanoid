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

    self:_set_subscriptions()
end

function ButtonsController:_set_subscriptions()
    self.subs = SubscriptionsMap(self, self.event_bus, {
        [MSG.auth.success_auth] = self.on_authorized,
    })
end

function ButtonsController:on_authorized()

end

function ButtonsController:final()
    self.subs:unsubscribe()
end

return ButtonsController
