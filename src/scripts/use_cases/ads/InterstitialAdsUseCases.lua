local App = require('src.app')
local OfferOnInterstitialViewUseCase = require('src.scripts.use_cases.payments.special_offer.OfferOnInterstitialViewUseCase')

local URL = App.constants.urls
local IntConfig = App.config.ads.interstitial
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_INTERSTITIAL_VIEW_COUNT = FilesConfig.keys.interstitial_view_count

--- @class InterstitialAdsUseCases
local InterstitialAdsUseCases = {}

function InterstitialAdsUseCases:update_services(context_services)
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
    self.ads_service = context_services.ads_service
    self.store_promotions_service = context_services.store_promotions_service
    self.player_data_storage = context_services.player_data_storage
    self.stats_service = context_services.stats_service
end

function InterstitialAdsUseCases:set_interstitials_middleware()
    local was_inter_shown = false

    local callbacks = {
        close = function(was_shown)
            was_inter_shown = was_shown
        end,
    }

    local on_interstitial_end = function()
        if was_inter_shown then
            local views_count = self.player_data_storage:get(FILE, KEY_INTERSTITIAL_VIEW_COUNT) or 0
            self.store_promotions_service:on_interstitial_view(views_count)
        end

        was_inter_shown = false
    end

    self.scenes_service:prepend_middleware(URL.game_screen, function()
        self.ads_service:show_interstitial_on_game_start(callbacks)
    end)

    self.scenes_service:prepend_middleware(URL.victory_screen, function()
        self.ads_service:show_interstitial_on_game_end(callbacks)
    end)

    self.scenes_service:append_middleware(URL.game_screen, on_interstitial_end)
    self.scenes_service:append_middleware(URL.victory_screen, on_interstitial_end)
end

function InterstitialAdsUseCases:on_short_ad_preview(data)
    self.scenes_service:switch_to_scene(URL.short_ad_preview_popup, data)
end

function InterstitialAdsUseCases:on_interstitial_view()
    local count = self.player_data_storage:get(FILE, KEY_INTERSTITIAL_VIEW_COUNT) or 0
    self.player_data_storage:set(FILE, KEY_INTERSTITIAL_VIEW_COUNT, count + 1)
end

function InterstitialAdsUseCases:is_available()
    local passed_levels = self.stats_service:get_passed_levels_count()
    return passed_levels >= IntConfig.start_level - 1
end

return InterstitialAdsUseCases
