local App = require('src.app')

local URL = App.constants.urls
local IntConfig = App.config.ads.interstitial
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_INTERSTITIAL_VIEW_COUNT = DataStorageConfig.keys.interstitial_view_count

--- @class InterstitialAdsUseCases
local InterstitialAdsUseCases = class('InterstitialAdsUseCases')

InterstitialAdsUseCases.__cparams = {'scenes_service', 'store_promotions_service', 'player_data_storage'}

function InterstitialAdsUseCases:initialize(scenes_service, store_promotions_service, player_data_storage)
    --- @type ScenesService
    self.scenes_service = scenes_service
    --- @type StorePromotionsService
    self.store_promotions_service = store_promotions_service
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage
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
end

function InterstitialAdsUseCases:on_short_ad_preview(data)
end

function InterstitialAdsUseCases:on_interstitial_view()
    local count = self.player_data_storage:get(FILE, KEY_INTERSTITIAL_VIEW_COUNT) or 0
    self.player_data_storage:set(FILE, KEY_INTERSTITIAL_VIEW_COUNT, count + 1)
end

function InterstitialAdsUseCases:is_available()
    return true
end

return InterstitialAdsUseCases
