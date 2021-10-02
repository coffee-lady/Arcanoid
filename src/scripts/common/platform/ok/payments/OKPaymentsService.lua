local App = require('src.app')
local OkAdapter = require('src.scripts.include.ok.ok')
local Models = require('src.scripts.common.platform.ok.payments.models.models')
local LocalStorage = require('src.scripts.common.services.core.local_storage.local_storage')

local PurchaseProductModel = Models.PurchaseProductModel
local PaymentsAdapter = OkAdapter.Payments

local Array = App.libs.array
local Debug = App.libs.debug
local Notifier = App.libs.notifier
local Async = App.libs.async

local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_WALLET_TO_SYNC = FilesConfig.keys.wallet_to_sync
local KEY_THEME = FilesConfig.keys.wallet_to_sync
local KEY_NO_ADS = FilesConfig.keys.no_ads
local KEY_CANCELING_ERRORS = FilesConfig.keys.paid_canceling_errors_count
local KEY_PAID_HINTS = FilesConfig.keys.paid_hints_count
local PaymentsConfig = App.config.payments
local DEBUG = App.config.debug_mode.PaymentsService
local MSG = App.constants.msg

local WALLET_KEY_TO_FILE_KEY = {
    canceling_errors = KEY_CANCELING_ERRORS,
    hints = KEY_PAID_HINTS,
}

local OKPaymentsService = {}

function OKPaymentsService:init(services)
    self.player_data_storage = services.player_data_storage
    self.global_gui_caller_service = services.global_gui_caller_service
    self.services = services
    self.auth_service = services.auth_service
    self.debug = Debug('[OK] PaymentsService', DEBUG)

    self.catalog = {}

    self:fetch_data()
    self:_check_wallet_events()
end

function OKPaymentsService:on_online()
    Async.bootstrap(function()
        self:_check_wallet_events()
    end)
end

function OKPaymentsService:on_item_spent(item_key)
    Async.bootstrap(function()
        local wallet_events_to_sync = LocalStorage:get(FILE, KEY_WALLET_TO_SYNC)

        if not wallet_events_to_sync then
            wallet_events_to_sync = {}
        end

        if not wallet_events_to_sync[item_key] then
            wallet_events_to_sync[item_key] = 1
        else
            wallet_events_to_sync[item_key] = wallet_events_to_sync[item_key] + 1
        end

        self.debug:log('item spent', item_key, 'wallet events to sync', self.debug:inspect(wallet_events_to_sync))

        LocalStorage:set(FILE, KEY_WALLET_TO_SYNC, wallet_events_to_sync)
        self:_check_wallet_events()
    end)
end

function OKPaymentsService:_check_wallet_events()
    if self.is_syncing then
        return
    end

    self.is_syncing = true

    local wallet_events_to_sync = LocalStorage:get(FILE, KEY_WALLET_TO_SYNC)

    if not wallet_events_to_sync then
        self.debug:log('_check_wallet_events: no events to sync')
        self.is_syncing = false
        return
    end

    LocalStorage:set(FILE, KEY_WALLET_TO_SYNC, nil)

    local result = PaymentsAdapter:sync_wallet_events_async(wallet_events_to_sync)

    if not result then
        self.debug:log('_check_wallet_events: no response')
        self.is_syncing = false
        self:_merge_wallet_events_to_sync(wallet_events_to_sync)
        return
    end

    self:_sync_wallet()

    self.debug:log('_check_wallet_events: synced. got wallet', self.debug:inspect(self.wallet))
    self.is_syncing = false

    wallet_events_to_sync = LocalStorage:get(FILE, KEY_WALLET_TO_SYNC)

    if wallet_events_to_sync then
        self:_check_wallet_events()
    end
end

function OKPaymentsService:_merge_wallet_events_to_sync(events)
    local wallet_events_to_sync = LocalStorage:get(FILE, KEY_WALLET_TO_SYNC)

    if not wallet_events_to_sync then
        wallet_events_to_sync = events
        LocalStorage:set(FILE, KEY_WALLET_TO_SYNC, wallet_events_to_sync)
        return
    end

    for key, _ in pairs(wallet_events_to_sync) do
        if events[key] then
            wallet_events_to_sync[key] = wallet_events_to_sync[key] + events[key]
        end
    end

    for key, _ in pairs(self.events) do
        if wallet_events_to_sync[key] then
            wallet_events_to_sync[key] = wallet_events_to_sync[key] + events[key]
        end
    end

    LocalStorage:set(FILE, KEY_WALLET_TO_SYNC, wallet_events_to_sync)
end

function OKPaymentsService:fetch_data()
    PaymentsAdapter:init()
    self:_load_catalog()
    self:_sync_wallet()
    self.debug:log('loaded wallet', self.debug:inspect(self.wallet))
end

function OKPaymentsService:_load_catalog()
    self.server_catalog_list = PaymentsAdapter:get_catalog_async()

    for i = 1, #self.server_catalog_list do
        self:_check_catalog_item(i, self.server_catalog_list[i])
    end

    for product_id, offer_id in pairs(PaymentsConfig.offers_ids) do
        local product, offer_product = self:_find_product(product_id), self:_find_product_in_server_catalog(offer_id)
        product:set_offer_product(offer_product)
    end
end

function OKPaymentsService:_check_catalog_item(index, new_item_data)
    if Array.has(new_item_data.id, PaymentsConfig.offers_ids) then
        return
    end

    if not self:_find_product(new_item_data.id) then
        self.catalog[#self.catalog + 1] = PurchaseProductModel(self.services, new_item_data)
    else
        self.catalog[index]:update(new_item_data)
    end
end

function OKPaymentsService:purchase_async(id)
    if not self.auth_service:is_authorized() then
        return nil, 'Error: not authorized'
    end

    local product = self:_find_product_in_server_catalog(id)
    local title = product:get_title()
    local price = product:get_price()
    local token, err = PaymentsAdapter:purchase_async(id, title, price)

    if token then
        self:_sync_wallet()
    end

    return token, err
end

function OKPaymentsService:consume_purchase_async()

end

function OKPaymentsService:get_catalog()
    return self.catalog
end

function OKPaymentsService:get_wallet()
    return self.wallet
end

function OKPaymentsService:_sync_wallet()
    self.wallet = PaymentsAdapter:get_wallet_async()

    self.debug:log('synced wallet', self.debug:inspect(self.wallet))

    for key, value in pairs(self.wallet) do
        if WALLET_KEY_TO_FILE_KEY[key] then
            self.debug:log('synced wallet: update', WALLET_KEY_TO_FILE_KEY[key], value)
            self.player_data_storage:set(FILE, WALLET_KEY_TO_FILE_KEY[key], value)
        end
    end
end

function OKPaymentsService:has_in_wallet(item_key)
    return self.wallet[item_key] ~= nil and self.wallet[item_key] ~= 0
end

function OKPaymentsService:_find_product(product_id)
    for i = 1, #self.catalog do
        local product = self.catalog[i]
        local item_id = product:get_id()

        if item_id == product_id then
            return product
        end
    end
end

function OKPaymentsService:_find_product_concrete(product_id)
    for i = 1, #self.catalog do
        local product = self.catalog[i]
        local item_id = product:get_id()

        if item_id == product_id then
            return product
        end
    end
end

function OKPaymentsService:_find_product_in_server_catalog(product_id)
    for i = 1, #self.server_catalog_list do
        local product = self.server_catalog_list[i]
        local item_id = product.id

        if item_id == product_id then
            return PurchaseProductModel(self.services, product, function()
                self.global_gui_caller_service:call(MSG.store._end_offer_timer)
            end)
        end
    end
end

return OKPaymentsService
