local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')
local YandexAdapter = require('src.scripts.include.yandex.yandex')

local InterstitialAdsAdapter = YandexAdapter.Ads.InterstitialAds

local AdsUseCases = UseCases.Ads

local Debug = App.libs.debug

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_TIMER = DataStorageConfig.keys.interstitial_timer
local MSG = App.constants.msg
local IntConfig = App.config.ads.interstitial
local DEBUG = App.config.debug_mode.InterstitialAdsService

local function exec(func, ...)
    if func then
        func(...)
    end
end

local YandexInterstitialAdsService = {}

function YandexInterstitialAdsService:init(player_data_storage, global_gui_caller_service)
    self.debug = Debug('[Yandex] InterstitialAdsService', DEBUG)
    self.player_data_storage = player_data_storage
    self.global_gui_caller_service = global_gui_caller_service

    InterstitialAdsAdapter:init_timer(IntConfig.delay, FILE, KEY_TIMER, self.player_data_storage)

    self.global_gui_caller_service:set_callback(MSG.ads._resume_interstitial_timer, function()
        InterstitialAdsAdapter:resume_timer()
    end)
end

function YandexInterstitialAdsService:show(callbacks)
    InterstitialAdsAdapter:show(self:_get_callbacks(callbacks))
end

function YandexInterstitialAdsService:show_on_game_start(callbacks)
    self.debug:log('show_on_game_start')
    self:show_with_probability(IntConfig.prob_start_game, callbacks)
end

function YandexInterstitialAdsService:show_on_game_end(callbacks)
    self.debug:log('show_on_game_end')
    self:show_with_probability(IntConfig.prob_end_game, callbacks)
end

function YandexInterstitialAdsService:show_with_probability(probability, callbacks)
    if not AdsUseCases.InterstitialAdsUseCases:is_available() then
        self.debug:log('passed_levels < start_level - 1')
        return
    end

    InterstitialAdsAdapter:show_with_probability(probability, self:_get_callbacks(callbacks))
end

function YandexInterstitialAdsService:_get_callbacks(callbacks)
    callbacks = callbacks or {}

    return {
        open = callbacks.open,
        offline = callbacks.offline,
        error = callbacks.error,
        close = function(was_shown)
            if was_shown then
                self:_on_was_shown()
            end

            exec(callbacks.close, was_shown)
        end,
    }
end

function YandexInterstitialAdsService:_on_was_shown()
    self.global_gui_caller_service:call(MSG.ads._resume_interstitial_timer)
    AdsUseCases.InterstitialAdsUseCases:on_interstitial_view()
end

return YandexInterstitialAdsService
