local App = require('src.app')
local GUI = require('gui.gui')

local URL = App.constants.urls
local MSG = App.constants.msg

local Async = App.libs.async
local SubscriptionsMap = App.libs.SubscriptionsMap

local AdsBootstrap = class('AdsBootstrap')

AdsBootstrap.__cparams = {'event_bus', 'scenes_service', 'ads_service', 'use_case_common_ads', 'use_case_interstitial_ad', 'use_case_banner_ad'}

function AdsBootstrap:initialize(event_bus, scenes_service, ads_service, use_case_common_ads, use_case_interstitial_ad, use_case_banner_ad)
    self.event_bus = event_bus
    self.scenes_service = scenes_service
    self.ads_service = ads_service
    self.use_case_common_ads = use_case_common_ads
    self.use_case_interstitial_ad = use_case_interstitial_ad
    self.use_case_banner_ad = use_case_banner_ad

    SubscriptionsMap(self, self.event_bus, {
        [MSG.js.online] = self.on_online,
        [MSG.js.offline] = self.on_offline,
        [MSG.ads.error] = self.on_ads_error,
        [MSG.ads.short_ad_preview] = self.on_short_ad_preview,
        [MSG.ads.close_banner] = self.on_close_banner,
        [self.scenes_service.BEFORE_SCENE_CHANGE] = self.on_before_scene_change,
        [self.scenes_service.SCENE_CHANGE] = self.on_scene_change,
    })

    self.ads_service:subscribe()
end

function AdsBootstrap:on_game_initialized()
    self.use_case_interstitial_ad:set_interstitials_middleware()
end

function AdsBootstrap:on_close_banner()
    self.use_case_banner_ad:close_banner()
end

function AdsBootstrap:on_ads_error()
    self.use_case_common_ads:on_ads_error()
end

function AdsBootstrap:on_short_ad_preview(data)
    self.use_case_interstitial_ad:on_short_ad_preview(data)
end

function AdsBootstrap:on_before_scene_change(scenes_data)
    self.use_case_banner_ad:try_hide_banner(scenes_data)
end

function AdsBootstrap:on_scene_change(scenes_data)
    self.use_case_banner_ad:try_show_banner(scenes_data)
end

function AdsBootstrap:on_authorized()
    self.use_case_banner_ad:try_show_banner()
end

function AdsBootstrap:on_online()
    self.ads_service:on_online()
end

function AdsBootstrap:on_offline()
    self.ads_service:on_offline()
end

return AdsBootstrap
