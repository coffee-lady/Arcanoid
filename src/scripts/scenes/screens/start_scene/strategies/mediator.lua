local App = require('src.app')
local Strategies = require('src.scripts.scenes.screens.start_scene.strategies.strategies')

local GameMSG = App.constants.msg.game_screen

local SubscriptionsMap = App.libs.SubscriptionsMap

local StrategiesMediator = class('StrategiesMediator')

function StrategiesMediator:initialize(context_services)
    self.auth_service = context_services.auth_service
    self.ui_service = context_services.ui_service
    --- @type LeaderboardsService
    self.leaderboards_service = context_services.leaderboards_service
    self.store_promotions_service = context_services.store_promotions_service
    self.localization = context_services.localization
    self.context_services = context_services

    self:init_scene()
end

function StrategiesMediator:init_scene()
    self.strategy = Strategies.StandardStrategy
    self.strategy:init(self.context_services)
    self:_set_subscriptions()
end

function StrategiesMediator:_set_subscriptions()
    self.auth_service:subscribe()
    self.ui_service:subscribe()
    self.leaderboards_service:subscribe()
    self.store_promotions_service:subscribe()
    self.localization:subscribe()
end

function StrategiesMediator:_remove_subscriptions()
    self.auth_service:unsubscribe()
    self.ui_service:unsubscribe()
    self.localization:unsubscribe()
    self.leaderboards_service:unsubscribe()
    self.store_promotions_service:unsubscribe()
end

function StrategiesMediator:update(dt)
    self.strategy:update(dt)
end

function StrategiesMediator:on_message(message_id, message, sender)
    self.strategy:on_message(message_id, message, sender)
end

function StrategiesMediator:final()
    self:_remove_subscriptions()
    self.strategy:final()
end

return StrategiesMediator
