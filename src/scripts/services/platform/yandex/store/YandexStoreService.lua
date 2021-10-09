local App = require('src.app')
local Items = require('src.scripts.services.platform.yandex.store.items.items')

local KEY_TO_ITEM = {
    hints = Items.ItemAddHints,
    canceling_errors = Items.ItemAddCancelingErrors,
    all_themes = Items.ItemUnlockThemes,
    no_ads = Items.ItemDisableAds,
}

local Debug = App.libs.debug
local Async = App.libs.async

local MSG = App.constants.msg
local PaymentsConfig = App.config.payments
local DEBUG = App.config.debug_mode.StoreService

--- @class StoreService
local YandexStoreService = class('YandexStoreService')

YandexStoreService.__cparams = {'payments_service', 'event_bus_gui', 'use_case_get_shown_products', 'use_case_finish_special_offer', 'use_case_find_product'}

function YandexStoreService:initialize(payments_service, event_bus, use_case_get_shown_products, use_case_finish_special_offer, use_case_find_product)
    --- @type PaymentsService
    self.payments_service = payments_service
    self.event_bus = event_bus
    self.use_case_get_shown_products = use_case_get_shown_products
    self.use_case_finish_special_offer = use_case_finish_special_offer
    self.use_case_find_product = use_case_find_product

    self.debug = Debug('[Yandex] StoreService', DEBUG)

    self.shop_catalog = {}
    self.payments_catalog = self.payments_service:get_catalog()

    self:_process_payments_catalog()
    self:apply_purchased_not_consumable_items()
end

function YandexStoreService:subscribe()

end

function YandexStoreService:unsubscribe()

end

function YandexStoreService:apply_purchased_not_consumable_items()
    for i = 1, #self.shop_catalog do
        local product = self.shop_catalog[i]
        local product_id = product:get_id()

        if self:has_in_purchase_list(product_id) then

        end
    end
end

function YandexStoreService:_process_payments_catalog()
    for i = 1, #self.payments_catalog do
        local product_data = self.payments_catalog[i]
        self.shop_catalog[i] = product_data
    end
end

function YandexStoreService:get_products_to_show()
    return self.use_case_get_shown_products:get_products_to_show(self.shop_catalog)
end

--- @param product PurchasePackProductModel
function YandexStoreService:purchase_async(product)
    if not self.auth_service:is_authorized() then
        return nil, 'Error: not authorized'
    end

    local is_on_special_offer = product:is_on_special_offer()
    local id = is_on_special_offer and product:get_offer_id() or product:get_id()
    local token, err = self.payments_service:purchase_async(id)

    if not token then
        return token, err
    end

    if is_on_special_offer then
        self.use_case_finish_special_offer:finish_special_offer(product)
    end

    if product:is_consumable() then
        self.payments_service:consume_purchase_async(token)
    end

    return token, err
end

function YandexStoreService:get_catalog()
    return self.shop_catalog
end

function YandexStoreService:consume_purchase_async(purchase_token)
    self.payments_service:consume_purchase_async(purchase_token)
end

function YandexStoreService:has_in_purchase_list(product_id)
    return self.payments_service:has_in_purchase_list(product_id)
end

function YandexStoreService:find_product(product_id)
    return self.use_case_find_product:find_product(product_id, self.shop_catalog)
end

return YandexStoreService
