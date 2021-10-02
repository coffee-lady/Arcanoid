local App = require('src.app')
local Items = require('src.scripts.common.platform.ok.store.items.items')
local UseCases = require('src.scripts.use_cases.use_cases')

local PaymentsUseCases = UseCases.Payments

local Debug = App.libs.debug
local Async = App.libs.async

local MSG = App.constants.msg
local PaymentsConfig = App.config.payments
local NOT_CONSUMABLE_ITEMS = App.config.payments_not_consumable_items_keys
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id
local STARTER_PACK_REPLACER_ID = PaymentsConfig.starter_pack_replacer_id
local DEBUG = App.config.debug_mode.StoreService

local KEY_TO_ITEM = {
    hints = Items.ItemAddHints,
    canceling_errors = Items.ItemAddCancelingErrors,
    all_themes = Items.ItemUnlockThemes,
    no_ads = Items.ItemDisableAds,
}

local OKStoreService = {}

function OKStoreService:init(services)
    --- @type PaymentsService
    self.payments_service = services.payments_service
    self.event_bus = services.event_bus
    self.services = services

    PaymentsUseCases.StoreApplyProductUseCase:update_services(services)
    PaymentsUseCases.StoreGetShownProductsUseCase:update_services(services)
    PaymentsUseCases.StorePurchaseUseCase:update_services(services)
    PaymentsUseCases.StorePurchaseUseCase:set_global_callbacks()
    PaymentsUseCases.CreateStorePackUseCase:update_services(services)

    self.debug = Debug('[OK] StoreService', DEBUG)

    self.shop_catalog = {}
    self.payments_catalog = self.payments_service:get_catalog()

    self:_process_payments_catalog()
    self:apply_purchased_not_consumable_items()

    self.event_bus:on(MSG.auth.auth_attempt, self.on_auth_attempt, self)
end

function OKStoreService:subscribe()
    PaymentsUseCases.StorePurchaseUseCase.starter_pack_notifier:subscribe()
end

function OKStoreService:apply_purchased_not_consumable_items()
    local wallet = self.payments_service:get_wallet()

    for key, value in pairs(NOT_CONSUMABLE_ITEMS) do
        if wallet[key] then
            KEY_TO_ITEM[key](self.services, key):apply()
        end
    end
end

function OKStoreService:_process_payments_catalog()
    for i = 1, #self.payments_catalog do
        local purchase_product = self.payments_catalog[i]
        self.shop_catalog[i] = PaymentsUseCases.CreateStorePackUseCase:create_pack(purchase_product, KEY_TO_ITEM)
    end
end

function OKStoreService:get_products_to_show()
    return PaymentsUseCases.StoreGetShownProductsUseCase:get_products_to_show(self.shop_catalog)
end

function OKStoreService:get_starter_pack()
    return self:_find_product(STARTER_PACK_ID)
end

function OKStoreService:get_starter_pack_replacer()
    return self:_find_product(STARTER_PACK_REPLACER_ID)
end

function OKStoreService:get_catalog()
    return self.shop_catalog
end

function OKStoreService:has_starter_pack_in_purchase_list()
    return self.payments_service:has_in_wallet('all_themes') and self.payments_service:has_in_wallet('no_ads')
end

--- @param product PurchasePackProductModel
function OKStoreService:purchase_async(product)
    return PaymentsUseCases.StorePurchaseUseCase:purchase_async(product, self.shop_catalog)
end

function OKStoreService:on_auth_attempt(data)
    PaymentsUseCases.StorePurchaseUseCase:retry_last_purchase_attempt(self.shop_catalog)
end

function OKStoreService:_find_product(product_id)
    return PaymentsUseCases.StoreFindProductUseCase:find_product(product_id, self.shop_catalog)
end

return OKStoreService
