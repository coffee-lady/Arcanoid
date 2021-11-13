local Luject = require('src.libs.luject.luject')
local SubscriptionsMap = require('src.libs.event_bus.subscriptions_map')
local ScriptWrapper = require('src.libs.script_wrapper.ScriptWrapper')

--- @class MessagesSceneWrapper
local MessagesSceneWrapper = class('MessagesSceneWrapper', ScriptWrapper)

MessagesSceneWrapper.__cparams = {'event_bus_gui'}

function MessagesSceneWrapper:initialize(event_bus)
    self.event_bus = event_bus
    self.subscribed_services = {}

    self:register()
end

function MessagesSceneWrapper:on_input(action_id, action)
    if not action_id then
        return
    end

    self.event_bus:emit(action_id, action)
end

function MessagesSceneWrapper:on_message(message_id, message, sender)
    self.event_bus:emit(message_id, message)
end

function MessagesSceneWrapper:set_subscriptions_map(map)
    self.subs_map = SubscriptionsMap(self, self.event_bus, map)
end

function MessagesSceneWrapper:set_services_subscriptions(...)
    local services = {...}

    for i = 1, #services do
        services[i]:subscribe()
        self.subscribed_services[i] = services[i]
    end
end

function MessagesSceneWrapper:remove_services_subscriptions()
    for i = 1, #self.subscribed_services do
        self.subscribed_services[i]:unsubscribe()
    end

    self.subscribed_services = {}
end

function MessagesSceneWrapper:final()
    self:remove_services_subscriptions()

    if self.subs_map then
        self.subs_map:unsubscribe()
    end
end

return MessagesSceneWrapper
