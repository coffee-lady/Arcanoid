local App = require('src.app')
local BannerAds = require('src.scripts.services.platform.yandex.ads.YandexBannerAdsService')
local InterstitialAds = require('src.scripts.services.platform.yandex.ads.YandexInterstitialAdsService')
local RewardedAds = require('src.scripts.services.platform.yandex.ads.YandexRewardedAdsService')

local MSG = App.constants.msg

local Notifier = App.libs.notifier
local Luject = App.libs.luject

--- @class AdsService
local YandexAdsService = class('YandexAdsService')

YandexAdsService.__cparams = {'player_data_storage', 'global_gui_caller_service'}

function YandexAdsService:initialize(player_data_storage, global_gui_caller_service)
    self.interstitial = Luject:resolve_class(InterstitialAds)
    self.rewarded = Luject:resolve_class(RewardedAds)
    self.banner = Luject:resolve_class(BannerAds)

    self.enabled = true
    self.is_online = false
    self.error_notifier = Notifier(MSG.ads.error)
end

function YandexAdsService:enable_ads()
    self.enabled = true
end

function YandexAdsService:disable_ads()
    self.enabled = false
    self:hide_banner()
end

function YandexAdsService:subscribe()
    self.rewarded:subscribe()
    self.error_notifier:subscribe()
end

function YandexAdsService:show_banner()
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return self.banner:show()
end

function YandexAdsService:hide_banner()
    if not self.is_online then
        return false
    end

    return self.banner:hide()
end

function YandexAdsService:show_interstitial_on_game_start(callbacks)
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return self.interstitial:show_on_game_start(callbacks)
end

function YandexAdsService:show_interstitial_on_game_end(callbacks)
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return self.interstitial:show_on_game_end(callbacks)
end

function YandexAdsService:get_interstitial_views_count()
    return self.interstitial:get_views_count()
end

function YandexAdsService:show_rewarded()
    if not self.is_online then
        self.error_notifier:emit()
        return false, false
    end

    return self.rewarded:show_on_reward()
end

function YandexAdsService:on_online()
    self.is_online = true
end

function YandexAdsService:on_offline()
    self.is_online = false
end

return YandexAdsService
