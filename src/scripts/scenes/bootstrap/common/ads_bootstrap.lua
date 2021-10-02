local App = require('src.app')
local GUI = require('gui.gui')
local UseCases = require('src.scripts.use_cases.use_cases')

local AdsUseCases = UseCases.Ads

local URL = App.constants.urls
local MSG = App.constants.msg

local Async = App.libs.async
local SubscriptionsMap = App.libs.SubscriptionsMap

local AdsBootstrap = {}

function AdsBootstrap:init_async(event_bus, app_installer)
    local context_services = {}

    app_installer:install(self)
    app_installer:install(context_services)

    self.event_bus = event_bus
    context_services.event_bus = event_bus

    AdsUseCases.CommonAdsUseCases:update_services(context_services)
    AdsUseCases.InterstitialAdsUseCases:update_services(context_services)
    AdsUseCases.BannerAdsUseCases:update_services(context_services)

    self.ads_service:init(self.player_data_storage, self.global_gui_caller_service)
    self.ads_service:subscribe()

    SubscriptionsMap(self, self.event_bus, {
        [MSG.js.online] = self.on_online,
        [MSG.js.offline] = self.on_offline,
        [MSG.ads.error] = self.on_ads_error,
        [MSG.ads.short_ad_preview] = self.on_short_ad_preview,
        [MSG.ads.close_banner] = self.on_close_banner,
        [self.scenes_service.BEFORE_SCENE_CHANGE] = self.on_before_scene_change,
        [self.scenes_service.SCENE_CHANGE] = self.on_scene_change,
    })
end

function AdsBootstrap:on_game_initialized()
    AdsUseCases.InterstitialAdsUseCases:set_interstitials_middleware()
end

function AdsBootstrap:on_close_banner()
    AdsUseCases.BannerAdsUseCases:close_banner()
end

function AdsBootstrap:on_ads_error()
    AdsUseCases.CommonAdsUseCases:on_ads_error()
end

function AdsBootstrap:on_short_ad_preview(data)
    AdsUseCases.InterstitialAdsUseCases:on_short_ad_preview(data)
end

function AdsBootstrap:on_before_scene_change(scenes_data)
    AdsUseCases.BannerAdsUseCases:try_hide_banner(scenes_data)
end

function AdsBootstrap:on_scene_change(scenes_data)
    AdsUseCases.BannerAdsUseCases:try_show_banner(scenes_data)
end

function AdsBootstrap:on_authorized()
    AdsUseCases.BannerAdsUseCases:try_show_banner()
end

function AdsBootstrap:on_online()
    self.ads_service:on_online()
end

function AdsBootstrap:on_offline()
    self.ads_service:on_offline()
end

return AdsBootstrap
