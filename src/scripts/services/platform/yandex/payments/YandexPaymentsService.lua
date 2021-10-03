local App = require('src.app')
local YandexAPI = require('src.scripts.include.yandex.yandex')
local Models = require('src.scripts.services.platform.yandex.payments.models.models')

local PurchaseProductModel = Models.PurchaseProductModel
local PaymentsAdapter = YandexAPI.Payments

local Array = App.libs.array
local Debug = App.libs.debug
local Notifier = App.libs.notifier
local Luject = App.libs.luject

local PaymentsConfig = App.config.payments
local OFFER_ID = PaymentsConfig.offers_ids
local DEBUG = App.config.debug_mode.PaymentsService
local MSG = App.constants.msg

--- @class PaymentsService
local YandexPaymentsService = class('YandexPaymentsService')

YandexPaymentsService.__cparams = {'auth_service'}

function YandexPaymentsService:initialize(auth_service)
    self.auth_service = auth_service
    self.debug = Debug('[Yandex] PaymentsService', DEBUG)

    self.catalog = {}
    self.user_purchases = {}

    self:fetch_data()
end

function YandexPaymentsService:on_online()

end

function YandexPaymentsService:fetch_data()
    if self.auth_service:is_authorized() then
        PaymentsAdapter:init()
        self:_load_catalog()
        self:_update_purchases_list()
    else
        self:_make_catalog_from_config()
    end
end

function YandexPaymentsService:_load_catalog()
    local catalog_list = PaymentsAdapter:get_catalog_async()

    for i = 1, #catalog_list do
        self:_check_catalog_item(i, catalog_list[i])
    end
end

function YandexPaymentsService:_make_catalog_from_config()
    local catalog_list = PaymentsConfig.products

    for i = 1, #catalog_list do
        self:_check_catalog_item(i, catalog_list[i])
    end
end

function YandexPaymentsService:_check_catalog_item(index, new_item_data)
    if Array.has(new_item_data.id, PaymentsConfig.offers_ids) then
        return
    end

    if not self:_find_product(new_item_data.id) then
        self.catalog[#self.catalog + 1] = PurchaseProductModel(new_item_data)
    else
        self.catalog[index]:update(new_item_data)
    end
end

function YandexPaymentsService:purchase_async(id)
    if not self.auth_service:is_authorized() then
        return nil, 'Error: not authorized'
    end
    local token, err = PaymentsAdapter:purchase_async(id)

    if token then
        self:_update_purchases_list()
    end

    return token, err
end

function YandexPaymentsService:get_purchases()
    return self.user_purchases
end

function YandexPaymentsService:get_catalog()
    return self.catalog
end

function YandexPaymentsService:consume_purchase_async(purchase_token)
    if not self.auth_service:is_authorized() then
        return
    end

    PaymentsAdapter:consume_purchase_async(purchase_token)

    self:_update_purchases_list()
end

function YandexPaymentsService:has_in_purchase_list(product_id)
    if not self.auth_service:is_authorized() then
        return false
    end

    for i = 1, #self.user_purchases do
        local purch_product_id = self.user_purchases[i].product_id

        if purch_product_id == product_id or purch_product_id == OFFER_ID[product_id] then
            return true
        end
    end

    return false
end

function YandexPaymentsService:_update_purchases_list()
    self.user_purchases = PaymentsAdapter:get_purchases_async()
end

function YandexPaymentsService:_find_product(product_id)
    for i = 1, #self.catalog do
        local product = self.catalog[i]
        local item_id = product:get_id()
        local item_offer_id = product:get_offer_id()

        if item_id == product_id or item_offer_id == product_id then
            return product
        end
    end
end

return YandexPaymentsService
