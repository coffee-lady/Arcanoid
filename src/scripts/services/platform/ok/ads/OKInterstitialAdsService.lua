local App = require('src.app')
local OkAdapter = require('src.scripts.include.ok.ok')

local InterstitialAdsAdapter = OkAdapter.Ads.InterstitialAds
local Debug = App.libs.debug

local AppConfig = App.config.app
local FILE = AppConfig.file
local KEY_INTERSTITIAL_VIEW_COUNT = AppConfig.keys.interstitial_view_count
local MSG = App.constants.msg
local IntConfig = App.config.ads.interstitial
local DEBUG = App.config.debug_mode.InterstitialAdsService

local function exec(func, ...)
    if func then
        func(...)
    end
end

--- @class OKInterstitialAdsService
local OKInterstitialAdsService = class('OKInterstitialAdsService')

OKInterstitialAdsService.__cparams = {'player_data_storage', 'global_gui_caller_service', 'use_case_interstitial_ad'}

function OKInterstitialAdsService:initialize(player_data_storage, global_gui_caller_service, use_case_interstitial_ad)
    self.debug = Debug('[OK] InterstitialAdsService', DEBUG)
    self.player_data_storage = player_data_storage
    self.global_gui_caller_service = global_gui_caller_service
    self.use_case_interstitial_ad = use_case_interstitial_ad

    InterstitialAdsAdapter:init_timer(IntConfig.delay, self.player_data_storage)

    self.global_gui_caller_service:set_callback(MSG.ads._resume_interstitial_timer, function()
        InterstitialAdsAdapter:resume_timer()
    end)
end

function OKInterstitialAdsService:show(callbacks)
    InterstitialAdsAdapter:show(self:_get_callbacks(callbacks))
end

function OKInterstitialAdsService:show_on_game_start(callbacks)
    self.debug:log('show_on_game_start')
    self:show_with_probability(IntConfig.prob_start_game, callbacks)
end

function OKInterstitialAdsService:show_on_game_end(callbacks)
    self.debug:log('show_on_game_end')
    self:show_with_probability(IntConfig.prob_end_game, callbacks)
end

function OKInterstitialAdsService:show_with_probability(probability, callbacks)
    if not self.use_case_interstitial_ad:is_available() then
        self.debug:log('passed_levels < start_level - 1')
        return
    end

    InterstitialAdsAdapter:show_with_probability(probability, self:_get_callbacks(callbacks))
end

function OKInterstitialAdsService:_get_callbacks(callbacks)
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

function OKInterstitialAdsService:_on_was_shown()
    self.global_gui_caller_service:call(MSG.ads._resume_interstitial_timer)
    self.use_case_interstitial_ad:on_interstitial_view()
end

return OKInterstitialAdsService
