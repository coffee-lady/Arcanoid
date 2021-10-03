local App = require('src.app')
local AdsBootstrap = require('src.scripts.scenes.bootstrap.common.ads_bootstrap')
local StoreBootstrap = require('src.scripts.scenes.bootstrap.common.store_bootstrap')

local URL = App.constants.urls

local AuthBootstrap = class('AuthBootstrap')

AuthBootstrap.__cparams = {'event_bus', 'auth_service', 'localization_service', 'leaderboards_service', 'ui_service', 'progress_service'}

function AuthBootstrap:initialize(event_bus, auth_service, localization_service, leaderboards_service, ui_service, progress_service)
    self.event_bus = event_bus
    self.auth_service = auth_service
    self.localization_service = localization_service
    self.leaderboards_service = leaderboards_service
    self.ui_service = ui_service
    self.progress_service = progress_service

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
    self.ui_service:on_authorized()
    StoreBootstrap:on_authorized()
    AdsBootstrap:on_authorized()
    self.leaderboards_service:on_authorized()
    self.localization_service:on_authorized()
end

function AuthBootstrap:on_auth_error()

end

return AuthBootstrap
