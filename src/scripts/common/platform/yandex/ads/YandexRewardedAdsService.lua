local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')
local YandexAPI = require('src.scripts.include.yandex.yandex')

local RewardedAdsAdapter = YandexAPI.Ads.RewardedAds
local Algorithm = YandexAPI.Ads.RewardedAdsAlgorithm

local AdsUseCases = UseCases.Ads

local Debug = App.libs.debug
local Notifier = App.libs.notifier

local RewardedConfig = App.config.ads.rewarded
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_TIMER = FilesConfig.keys.rewarded_timer
local MSG = App.constants.msg
local DEBUG = App.config.debug_mode.RewardedAdsService

local YandexRewardedAdsService = {}

function YandexRewardedAdsService:init(player_data_storage)
    self.debug = Debug('[Yandex] RewardedAdsService', DEBUG)

    RewardedAdsAdapter:init(RewardedConfig.delay, FILE, KEY_TIMER, player_data_storage)
    Algorithm:init(RewardedConfig.min_time, player_data_storage)

    self.short_ad_notifier = Notifier(MSG.ads.short_ad_preview)
end

function YandexRewardedAdsService:subscribe()
    self.short_ad_notifier:subscribe()
end

function YandexRewardedAdsService:show(callbacks)
    return RewardedAdsAdapter:show(callbacks)
end

function YandexRewardedAdsService:show_on_reward(callbacks)
    if not AdsUseCases.RewardedAdsUseCases:is_available() then
        return false, false
    end

    return RewardedAdsAdapter:show(callbacks)
end

return YandexRewardedAdsService
