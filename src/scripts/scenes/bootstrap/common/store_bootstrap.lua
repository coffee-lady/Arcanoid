local App = require('src.app')

local SubscriptionsMap = App.libs.SubscriptionsMap

local StoreBootstrap = class('StoreBootstrap')

StoreBootstrap.__cparams = {'event_bus'}

function StoreBootstrap:initialize(event_bus)
    self.event_bus = event_bus
end

function StoreBootstrap:on_online()
    self.payments_service:on_online()
end

function StoreBootstrap:on_authorized()
    self.payments_service:fetch_data()
    self.store_service:apply_purchased_not_consumable_items()
end

return StoreBootstrap
