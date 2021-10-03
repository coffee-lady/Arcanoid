local App = require('src.app')
local StoreBootstrap = require('src.scripts.scenes.bootstrap.common.store_bootstrap')

local URL = App.constants.urls
local MSG = App.constants.msg

local SubscriptionsMap = App.libs.SubscriptionsMap

local JSEventsBootstrap = {}

function JSEventsBootstrap:init(event_bus, app_installer)
    app_installer:install(self)
    self.event_bus = event_bus

    SubscriptionsMap(self, self.event_bus, {
        [MSG.js.save_data] = self.on_save_data,
        [MSG.js.resize] = self.on_window_resize,
        [MSG.js.online] = self.on_online,
        [MSG.js.offline] = self.on_offline,
        [MSG.js.several_tabs_warning] = self.on_tabs_warning,
    })
end

function JSEventsBootstrap:on_save_data()
    self.progress_service:save()
end

function JSEventsBootstrap:on_window_resize()
    self.platform_service:on_resize()
end

function JSEventsBootstrap:on_online()
    self.player_data_storage:on_online()
    self.leaderboards_service:on_online()
    self.platform_service:on_online()
    StoreBootstrap:on_online()
    self.feedback_service:on_online()
end

function JSEventsBootstrap:on_offline()
    self.player_data_storage:on_offline()
    self.platform_service:on_offline()
    self.leaderboards_service:on_offline()
    self.feedback_service:on_offline()
end

function JSEventsBootstrap:on_tabs_warning()
end

return JSEventsBootstrap
