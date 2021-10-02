local App = require('src.app')
local InterstitialAds = require('src.scripts.common.platform.ok.ads.OKInterstitialAdsService')
local RewardedAds = require('src.scripts.common.platform.ok.ads.OKRewardedAdsService')

local MSG = App.constants.msg

local Notifier = App.libs.notifier

local OKAdsService = {}

function OKAdsService:init(player_data_storage, global_gui_caller_service)
    InterstitialAds:init(player_data_storage, global_gui_caller_service)
    RewardedAds:init(player_data_storage)

    self.enabled = true
    self.is_online = false
    self.error_notifier = Notifier(MSG.ads.error)
end

function OKAdsService:enable_ads()
    self.enabled = true
end

function OKAdsService:disable_ads()
    self.enabled = false
    self:hide_banner()
end

function OKAdsService:subscribe()
    self.error_notifier:subscribe()
end

function OKAdsService:show_banner()

end

function OKAdsService:hide_banner()

end

function OKAdsService:show_interstitial_on_game_start(callbacks)
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return InterstitialAds:show_on_game_start(callbacks)
end

function OKAdsService:show_interstitial_on_game_end(callbacks)
    if not self.enabled then
        return false
    end

    if not self.is_online then
        return false
    end

    return InterstitialAds:show_on_game_end(callbacks)
end

function OKAdsService:get_interstitial_views_count()
    return InterstitialAds:get_views_count()
end

function OKAdsService:show_rewarded()
    if not self.is_online then
        self.error_notifier:emit()
        return false, false
    end

    return RewardedAds:show()
end

function OKAdsService:on_online()
    self.is_online = true
end

function OKAdsService:on_offline()
    self.is_online = false
end

return OKAdsService
