local App = require('src.app')
local BannerAds = require('src.scripts.common.platform.yandex.ads.YandexBannerAdsService')
local InterstitialAds = require('src.scripts.common.platform.yandex.ads.YandexInterstitialAdsService')
local RewardedAds = require('src.scripts.common.platform.yandex.ads.YandexRewardedAdsService')

local MSG = App.constants.msg

local Notifier = App.libs.notifier

local YandexAdsService = {}

function YandexAdsService:init(player_data_storage, global_gui_caller_service)
    InterstitialAds:init(player_data_storage, global_gui_caller_service)
    RewardedAds:init(player_data_storage)
    BannerAds:init(player_data_storage)

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
    RewardedAds:subscribe()
    self.error_notifier:subscribe()
end

function YandexAdsService:show_banner()
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return BannerAds:show()
end

function YandexAdsService:hide_banner()
    if not self.is_online then
        return false
    end

    return BannerAds:hide()
end

function YandexAdsService:show_interstitial_on_game_start(callbacks)
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return InterstitialAds:show_on_game_start(callbacks)
end

function YandexAdsService:show_interstitial_on_game_end(callbacks)
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return InterstitialAds:show_on_game_end(callbacks)
end

function YandexAdsService:get_interstitial_views_count()
    return InterstitialAds:get_views_count()
end

function YandexAdsService:show_rewarded()
    if not self.is_online then
        self.error_notifier:emit()
        return false, false
    end

    return RewardedAds:show_on_reward()
end

function YandexAdsService:on_online()
    self.is_online = true
end

function YandexAdsService:on_offline()
    self.is_online = false
end

return YandexAdsService
