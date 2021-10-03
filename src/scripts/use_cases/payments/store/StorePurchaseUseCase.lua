local App = require('src.app')
local ApplyProductUseCase = require('src.scripts.use_cases.payments.store.StoreApplyProductUseCase')
local StoreFindProductUseCase = require('src.scripts.use_cases.payments.store.StoreFindProductUseCase')
local FinishOfferUseCase = require('src.scripts.use_cases.payments.special_offer.FinishOfferUseCase')

local Async = App.libs.async
local Notifier = App.libs.notifier

local MSG = App.constants.msg
local URL = App.constants.urls
local PaymentsConfig = App.config.payments
local STARTER_PACK_ID = PaymentsConfig.starter_pack_id
local STARTER_PACK_REPLACER_ID = PaymentsConfig.starter_pack_replacer_id

--- @class StorePurchaseUseCase
local StorePurchaseUseCase = {}

function StorePurchaseUseCase:update_services(context_services)
    --- @type PaymentsService
    self.payments_service = context_services.payments_service
    self.auth_service = context_services.auth_service
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
    self.global_gui_caller_service = context_services.global_gui_caller_service
end

function StorePurchaseUseCase:set_global_callbacks()
    self.starter_pack_notifier = Notifier(MSG.store.starter_pack_bought)

    self.global_gui_caller_service:set_callback(MSG.store._emit_starter_pack_bought, function()
        self.starter_pack_notifier:emit()
    end)
end

--- @param product StorePackEntity
function StorePurchaseUseCase:purchase_async(product, shop_catalog)
    if not self.auth_service:is_authorized() then
        self.scenes_service:switch_to_scene(URL.purchase_auth_popup)
        self.last_product_tried_to_buy = self:_find_product(product:get_id(), shop_catalog)
        return nil, 'Error: not authorized'
    end

    local is_on_special_offer = product:is_on_special_offer()
    local id = is_on_special_offer and product:get_offer_id() or product:get_id()
    local token, err = self.payments_service:purchase_async(id)

    if not token then
        return token, err
    end

    if is_on_special_offer then
        FinishOfferUseCase:finish_special_offer(product)
    end

    ApplyProductUseCase:apply_product(product, token)

    self.scenes_service:switch_to_scene(URL.post_purchase_popup, {
        product_config = product:get_config(),
    })

    if product:get_id() == STARTER_PACK_ID then
        self.global_gui_caller_service:call(MSG.store._emit_starter_pack_bought)
    end

    return token, err
end

function StorePurchaseUseCase:retry_last_purchase_attempt(shop_catalog)
    local starter_pack = self:_find_product(STARTER_PACK_ID, shop_catalog)
    local is_starter_pack_bought = self.payments_service:has_in_purchase_list(STARTER_PACK_ID)

    if self.last_product_tried_to_buy == starter_pack and is_starter_pack_bought then
        return
    end

    Async.bootstrap(function()
        if self.auth_service:is_authorized() and self.last_product_tried_to_buy then
            self:purchase_async(self.last_product_tried_to_buy)
        end

        self.last_product_tried_to_buy = nil
    end)
end

function StorePurchaseUseCase:_find_product(product_id, shop_catalog)
    return StoreFindProductUseCase:find_product(product_id, shop_catalog)
end

return StorePurchaseUseCase
