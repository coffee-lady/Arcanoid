local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')

local PaymentsUseCases = UseCases.Payments

local PaymentsConfig = App.config.payments
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id
local DEBUG = App.config.debug_mode.StoreService

local Debug = App.libs.debug

local StorePromotionsService = {}

function StorePromotionsService:init(services)
    self.store_service = services.store_service

    PaymentsUseCases.OfferOnInterstitialViewUseCase:update_services(services)
    PaymentsUseCases.ShowOfferUseCase:update_services(services)
    PaymentsUseCases.FinishOfferUseCase:update_services(services)
    PaymentsUseCases.FinishOfferUseCase:set_global_callbacks()
    PaymentsUseCases.StartOfferUseCase:update_services(services)
    PaymentsUseCases.StartOfferUseCase:set_global_callbacks()

    self.debug = Debug('StorePromotionsService', DEBUG)

    self.shop_catalog = self.store_service:get_catalog()
end

function StorePromotionsService:subscribe()
    PaymentsUseCases.StartOfferUseCase.promotion_notifier:subscribe()
    PaymentsUseCases.FinishOfferUseCase.offer_finished_notifier:subscribe()
end

function StorePromotionsService:unsubscribe()
    PaymentsUseCases.StartOfferUseCase.promotion_notifier:unsubscribe()
    PaymentsUseCases.FinishOfferUseCase.offer_finished_notifier:unsubscribe()
end

function StorePromotionsService:on_interstitial_view(count)
    PaymentsUseCases.OfferOnInterstitialViewUseCase:on_interstitial_view(count, self.shop_catalog)
end

function StorePromotionsService:show_starter_pack_offer()
    PaymentsUseCases.ShowOfferUseCase:show_special_offer()
end

function StorePromotionsService:begin_starter_pack_promotion()
    self:start_special_offer(STARTER_PACK_ID)
end

function StorePromotionsService:start_special_offer(product_id)
    local product = self:_find_product(product_id)
    PaymentsUseCases.StartOfferUseCase:start_special_offer(product)
end

function StorePromotionsService:is_special_offer_in_store()
    for i = 1, #self.shop_catalog do
        local product = self.shop_catalog[i]

        if product:is_on_special_offer() then
            return true
        end
    end

    return false
end

function StorePromotionsService:_find_product(product_id)
    return PaymentsUseCases.StoreFindProductUseCase:find_product(product_id, self.shop_catalog)
end

return StorePromotionsService
