local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')

local RewardedAdsAdapter = YandexAPI.Ads.RewardedAds
local Algorithm = YandexAPI.Ads.RewardedAdsAlgorithm

local Debug = App.libs.debug
local Notifier = App.libs.notifier

local RewardedConfig = App.config.ads.rewarded
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_TIMER = DataStorageConfig.keys.rewarded_timer
local MSG = App.constants.msg
local DEBUG = App.config.debug_mode.RewardedAdsService

--- @class YandexBannerAdsService
local YandexRewardedAdsService = class('YandexBannerAdsService')

YandexRewardedAdsService.__cparams = {'player_data_storage', 'use_case_rewarded_ad'}

function YandexRewardedAdsService:initialize(player_data_storage, use_case_rewarded_ad)
    self.use_case_rewarded_ad = use_case_rewarded_ad
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
    if not self.use_case_rewarded_ad:is_available() then
        return false, false
    end

    return RewardedAdsAdapter:show(callbacks)
end

return YandexRewardedAdsService
