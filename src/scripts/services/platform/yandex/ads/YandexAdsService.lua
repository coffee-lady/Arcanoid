local App = require('src.app')
local BannerAds = require('src.scripts.services.platform.yandex.ads.YandexBannerAdsService')
local InterstitialAds = require('src.scripts.services.platform.yandex.ads.YandexInterstitialAdsService')
local RewardedAds = require('src.scripts.services.platform.yandex.ads.YandexRewardedAdsService')

local MSG = App.constants.msg

local Luject = App.libs.luject
local Event = App.libs.Event

--- @class AdsService
local YandexAdsService = class('YandexAdsService')

YandexAdsService.__cparams = {'data_storage_use_cases'}

function YandexAdsService:initialize(data_storage_use_cases)
    self.interstitial = Luject:resolve_class(InterstitialAds)
    self.rewarded = Luject:resolve_class(RewardedAds)
    self.banner = Luject:resolve_class(BannerAds)

    self.enabled = true
    self.is_online = false
    self.event_error = Event()
end

function YandexAdsService:enable_ads()
    self.enabled = true
end

function YandexAdsService:disable_ads()
    self.enabled = false
    self:hide_banner()
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
        self.event_error:emit()
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
