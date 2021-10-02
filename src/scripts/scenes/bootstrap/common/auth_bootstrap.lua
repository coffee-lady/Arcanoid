local App = require('src.app')
local AdsBootstrap = require('src.scripts.scenes.bootstrap.common.ads_bootstrap')
local StoreBootstrap = require('src.scripts.scenes.bootstrap.common.store_bootstrap')

local URL = App.constants.urls

local AuthBootstrap = {}

function AuthBootstrap:init_async(event_bus, app_installer)
    app_installer:install(self)
    self.event_bus = event_bus

    self.auth_service:init(self.event_bus, self.global_gui_caller_service)

    self.auth_service:on_authenticate(function()
        self:on_authorized()
    end)

    self.auth_service:on_auth_error(function()
        self:on_auth_error()
    end)
end

function AuthBootstrap:on_authorized()
    self.player_data_storage:load_data_from_server()
    self.player_data_storage:compare_data()

    self.progress_service:on_authorized()
    self.ranks_service:on_authorized()
    self.stats_service:on_authorized()
    self.ui_service:on_authorized()
    StoreBootstrap:on_authorized()
    AdsBootstrap:on_authorized()
    self.leaderboards_service:on_authorized()
    self.localization:on_authorized()
end

function AuthBootstrap:on_auth_error()
    if not self.scenes_service:is_visible(URL.auth_error_popup) then
        self.scenes_service:switch_to_scene(URL.auth_error_popup)
    end
end

return AuthBootstrap
