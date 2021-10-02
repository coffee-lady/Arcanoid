local App = require('src.app')

local SubscriptionsMap = App.libs.SubscriptionsMap

local MSG = App.constants.msg
local ITEMS_KEYS = App.config.payments_items_keys

local StoreBootstrap = {}

function StoreBootstrap:init_async(event_bus, app_installer)
    app_installer:install(self)
    self.event_bus = event_bus

    local services = {
        payments_service = self.payments_service,
        event_bus = self.event_bus,
        player_data_storage = self.player_data_storage,
        ads_service = self.ads_service,
        ui_service = self.ui_service,
        auth_service = self.auth_service,
        scenes_service = self.scenes_service,
        global_gui_caller_service = self.global_gui_caller_service,
        localization = self.localization,
        store_service = self.store_service,
        hints_service = self.hints_service,
    }

    self.payments_service:init(services)
    self.store_service:init(services)
    self.store_promotions_service:init(services)

    self:_set_subscriptions()
end

function StoreBootstrap:_set_subscriptions()
    SubscriptionsMap(self, self.event_bus, {
        [MSG.actions.global_paid_hint_applied] = self.on_paid_hint,
        [MSG.actions.global_paid_canceling_error_applied] = self.on_paid_canceling_error,
    })
end

function StoreBootstrap:on_online()
    self.payments_service:on_online()
end

function StoreBootstrap:on_authorized()
    self.payments_service:fetch_data()
    self.store_service:apply_purchased_not_consumable_items()
end

function StoreBootstrap:on_paid_hint()
    if self.payments_service.on_item_spent then
        self.payments_service:on_item_spent(ITEMS_KEYS.hints)
    end
end

function StoreBootstrap:on_paid_canceling_error()
    if self.payments_service.on_item_spent then
        self.payments_service:on_item_spent(ITEMS_KEYS.canceling_errors)
    end
end

return StoreBootstrap
