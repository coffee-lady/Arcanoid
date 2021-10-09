local Luject = require('src.libs.luject.luject')
local SubscriptionsMap = require('src.libs.event_bus.subscriptions_map')

--- @class SceneStrategiesMediator
local SceneStrategiesMediator = class('SceneStrategiesMediator')

SceneStrategiesMediator.__cparams = {'event_bus_gui'}

function SceneStrategiesMediator:initialize(event_bus)
    self.event_bus = event_bus
    self.subscribed_services = {}
end

--- @param Strategy SceneStrategy
function SceneStrategiesMediator:set_strategy(Strategy, ...)
    self.current_strategy = Luject:resolve_class(Strategy, ...)
end

function SceneStrategiesMediator:update(dt)
    assert(self.current_strategy)
    self.current_strategy:update(dt)
end

function SceneStrategiesMediator:on_input(action_id, action)
    assert(self.current_strategy)

    if not action_id then
        return
    end

    self.event_bus:emit(action_id, action)
    self.current_strategy:on_input(action_id, action)
end

function SceneStrategiesMediator:on_message(message_id, message, sender)
    assert(self.current_strategy)
    self.event_bus:emit(message_id, message)
    self.current_strategy:on_message(message_id, message, sender)
end

function SceneStrategiesMediator:set_subscriptions_map(map)
    self.subs_map = SubscriptionsMap(self, self.event_bus, map)
end

function SceneStrategiesMediator:set_services_subscriptions(...)
    local services = {...}

    for i = 1, #services do
        services[i]:subscribe()
        self.subscribed_services[i] = services[i]
    end
end

function SceneStrategiesMediator:remove_services_subscriptions()
    for i = 1, #self.subscribed_services do
        self.subscribed_services[i]:unsubscribe()
    end

    self.subscribed_services = {}
end

function SceneStrategiesMediator:final()
    assert(self.current_strategy)
    self.current_strategy:final()
    self:remove_services_subscriptions()

    if self.subs_map then
        self.subs_map:unsubscribe()
    end
end

return SceneStrategiesMediator
