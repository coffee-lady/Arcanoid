local App = require('src.app')
local StartOfferUseCase = require('src.scripts.use_cases.payments.special_offer.StartOfferUseCase')
local ShowOfferUseCase = require('src.scripts.use_cases.payments.special_offer.ShowOfferUseCase')
local StoreFindProductUseCase = require('src.scripts.use_cases.payments.store.StoreFindProductUseCase')

local PaymentsConfig = App.config.payments
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id

--- @class OfferOnInterstitialViewUseCase
local OfferOnInterstitialViewUseCase = {}

function OfferOnInterstitialViewUseCase:update_services(context_services)
    self.payments_service = context_services.payments_service
end

function OfferOnInterstitialViewUseCase:on_interstitial_view(interstitials_count, shop_catalog)
    local starter_pack = StoreFindProductUseCase:find_product(STARTER_PACK_ID, shop_catalog)
    local is_starter_pack_bought = self.payments_service:has_in_purchase_list(STARTER_PACK_ID)

    if is_starter_pack_bought then
        return
    end

    if interstitials_count == starter_pack:get_interstitial_till_offer() then
        StartOfferUseCase:start_special_offer(starter_pack)
        ShowOfferUseCase:show_special_offer()
    end
end

return OfferOnInterstitialViewUseCase
