local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')
local Items = require('src.scripts.common.platform.yandex.store.items.items')

local PaymentsUseCases = UseCases.Payments

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
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id
local STARTER_PACK_REPLACER_ID = PaymentsConfig.starter_pack_replacer_id
local DEBUG = App.config.debug_mode.StoreService

local YandexStoreService = {}

function YandexStoreService:init(services)
    --- @type PaymentsService
    self.payments_service = services.payments_service
    self.event_bus = services.event_bus
    self.services = services

    PaymentsUseCases.StoreApplyProductUseCase:update_services(services)
    PaymentsUseCases.StoreGetShownProductsUseCase:update_services(services)
    PaymentsUseCases.StorePurchaseUseCase:update_services(services)
    PaymentsUseCases.StorePurchaseUseCase:set_global_callbacks()
    PaymentsUseCases.CreateStorePackUseCase:update_services(services)

    self.debug = Debug('[Yandex] StoreService', DEBUG)

    self.shop_catalog = {}
    self.payments_catalog = self.payments_service:get_catalog()

    self:_process_payments_catalog()
    self:apply_purchased_not_consumable_items()

    self.event_bus:on(MSG.auth.auth_attempt, self.on_auth_attempt, self)
end

function YandexStoreService:subscribe()
    PaymentsUseCases.StorePurchaseUseCase.starter_pack_notifier:subscribe()
end

function YandexStoreService:unsubscribe()
    PaymentsUseCases.StorePurchaseUseCase.starter_pack_notifier:unsubscribe()
end

function YandexStoreService:apply_purchased_not_consumable_items()
    for i = 1, #self.shop_catalog do
        local product = self.shop_catalog[i]
        local product_id = product:get_id()

        if self:has_in_purchase_list(product_id) then
            PaymentsUseCases.ApplyStorePackUseCases:apply_not_consumable(product)
        end
    end
end

function YandexStoreService:_process_payments_catalog()
    for i = 1, #self.payments_catalog do
        local product_data = self.payments_catalog[i]
        self.shop_catalog[i] = PaymentsUseCases.CreateStorePackUseCase:create_pack(product_data, KEY_TO_ITEM)
    end
end

function YandexStoreService:get_products_to_show()
    return PaymentsUseCases.StoreGetShownProductsUseCase:get_products_to_show(self.shop_catalog)
end

function YandexStoreService:get_starter_pack()
    return self:find_product(STARTER_PACK_ID)
end

function YandexStoreService:get_starter_pack_replacer()
    return self:find_product(STARTER_PACK_REPLACER_ID)
end

--- @param product PurchasePackProductModel
function YandexStoreService:purchase_async(product)
    return PaymentsUseCases.StorePurchaseUseCase:purchase_async(product, self.shop_catalog)
end

function YandexStoreService:on_auth_attempt(data)
    PaymentsUseCases.StorePurchaseUseCase:retry_last_purchase_attempt(self.shop_catalog)
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

function YandexStoreService:has_starter_pack_in_purchase_list()
    return self.payments_service:has_in_purchase_list(STARTER_PACK_ID)
end

function YandexStoreService:find_product(product_id)
    return PaymentsUseCases.StoreFindProductUseCase:find_product(product_id, self.shop_catalog)
end

return YandexStoreService
