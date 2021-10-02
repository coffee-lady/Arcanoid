local App = require('src.app')

local MSG = App.constants.msg
local SubscriptionsMap = App.libs.SubscriptionsMap

local AnalyticsBootstrap = {}

function AnalyticsBootstrap:init_async(event_bus, app_installer)
    app_installer:install(self)
    self.event_bus = event_bus

    self.analytics_service:init(self.ui_service)

    SubscriptionsMap(self, self.event_bus, {
        [MSG.js.get_loading_time] = self.on_get_loading_time,
        [MSG.themes.theme_changed] = self.on_theme_changed,
        [MSG.actions.global_paid_hint_applied] = self.on_hint_applied,
    })
end

function AnalyticsBootstrap:on_get_loading_time(data)
    self.analytics_service.design:on_loading_screen_closed(data)
end

function AnalyticsBootstrap:on_theme_changed()
    self.analytics_service.custom:on_theme_changed()
end

return AnalyticsBootstrap
