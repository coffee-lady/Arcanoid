local App = require('src.app')
local YandexAdapter = require('src.scripts.include.yandex.yandex')

local BannerAdsAdapter = YandexAdapter.Ads.BannerAds
local Debug = App.libs.debug

local BannerConfig = App.config.ads.banner
local DEBUG = App.config.debug_mode.BannerAdsService

--- @class YandexBannerAdsService
local YandexBannerAdsService = class('YandexBannerAdsService')

YandexBannerAdsService.__cparams = {'player_data_storage', 'use_case_banner_ad'}

function YandexBannerAdsService:initialize(player_data_storage, use_case_banner_ad)
    self.debug = Debug('[Yandex] BannerAdsService', DEBUG)
    self.player_data_storage = player_data_storage
    self.use_case_banner_ad = use_case_banner_ad
end

function YandexBannerAdsService:_load()
    BannerAdsAdapter:init_async(BannerConfig.height)
    BannerAdsAdapter:load_async(BannerConfig)

    if BannerConfig.visible then
        self:_init_timer()
    end
end

function YandexBannerAdsService:_init_timer()
    self.timer = timer.delay(BannerConfig.reload_time, true, function()
        BannerAdsAdapter:refresh(BannerConfig.block_id)
    end)
end

function YandexBannerAdsService:show()
    if not self.use_case_banner_ad:is_available() then
        self.debug:log('trying show banner: passed_levels < BannerConfig.start_level - 1')
        return
    end

    if not BannerAdsAdapter.initted then
        self:_load()
    end

    BannerAdsAdapter:show(BannerConfig.block_id)
end

function YandexBannerAdsService:hide()
    if not BannerAdsAdapter.initted then
        self:_load()
    end

    BannerAdsAdapter:hide(BannerConfig.block_id)
end

return YandexBannerAdsService
