local App = require('src.app')

local PaymentsConfig = App.config.payments
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id
local DEBUG = App.config.debug_mode.StoreService

local Debug = App.libs.debug

--- @class StorePromotionsService
local StorePromotionsService = class('StorePromotionsService')

StorePromotionsService.__cparams = {'store_service', 'use_case_start_special_offer', 'use_case_finish_special_offer', 'use_case_find_product'}

function StorePromotionsService:initialize(store_service, use_case_start_special_offer, use_case_finish_special_offer, use_case_find_product)
    self.store_service = store_service
    self.use_case_start_special_offer = use_case_start_special_offer
    self.use_case_finish_special_offer = use_case_finish_special_offer
    self.use_case_find_product = use_case_find_product

    self.debug = Debug('StorePromotionsService', DEBUG)

    self.shop_catalog = self.store_service:get_catalog()
end

function StorePromotionsService:subscribe()
    self.use_case_start_special_offer.promotion_notifier:subscribe()
    self.use_case_finish_special_offer.offer_finished_notifier:subscribe()
end

function StorePromotionsService:unsubscribe()
    self.use_case_start_special_offer.promotion_notifier:unsubscribe()
    self.use_case_finish_special_offer.offer_finished_notifier:unsubscribe()
end

function StorePromotionsService:show_starter_pack_offer()

end

function StorePromotionsService:begin_starter_pack_promotion()
    self:start_special_offer(STARTER_PACK_ID)
end

function StorePromotionsService:start_special_offer(product_id)
    local product = self:_find_product(product_id)
    self.use_case_start_special_offer:start_special_offer(product)
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
    return self.use_case_find_product:find_product(product_id, self.shop_catalog)
end

return StorePromotionsService
