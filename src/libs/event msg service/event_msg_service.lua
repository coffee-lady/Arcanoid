local class = require('src.libs.middleclass.middleclass')

local EventObservationLib = require('src.libs.event_observation.event_observation')
local Observable = EventObservationLib.observable

local EventMSGServiceLib = class('MSGService')

function EventMSGServiceLib:initialize()
    self._subs = {}
end

local function create_subs(self, message_id)
    self._subs[message_id] = {
        observer = Observable:new(),
        subscribers = {}
    }

    return self._subs[message_id]
end

local function send_to_all_subscribers(self, message_id, message)
    local subscribers = self._subs[message_id].subscribers
    for i = 1, #subscribers do
        subscribers[i]:next(message)
    end
end

local function send_to_receiver(self, receiver, message_id, message)
    local subscribers = self._subs[message_id].subscribers

    for i = 1, #subscribers do
        if subscribers[i].subscriber == receiver then
            subscribers[i]:next(message)
        end
    end
end

local function post_to_scene(scene, receiver, message_id, message)
    local data = {
        receiver = receiver,
        data = message
    }

    msg.post(scene, message_id, data)
end

local function post_to_receiver(receiver, message_id, message)
    msg.post(receiver, message_id, message)
end

function EventMSGServiceLib:post(scene, receiver, message_id, message)
    if scene then
        post_to_scene(scene, receiver, message_id, message)
    else
        post_to_receiver(receiver, message_id, message)
    end
end

function EventMSGServiceLib:send(receiver, message_id, message)
    if not self._subs[message_id] then
        create_subs(self, message_id)
    end

    if receiver then
        send_to_receiver(self, receiver, message_id, message)
        return
    end

    send_to_all_subscribers(self, message_id, message)
end

function EventMSGServiceLib:on(subscriber, message_id, callback)
    local subs = self._subs[message_id]
    if not subs then
        subs = create_subs(self, message_id)
    end

    local new_subs = subs.observer:subscribe(callback)
    new_subs.subscriber = subscriber

    table.insert(subs.subscribers, new_subs)

    return new_subs
end

function EventMSGServiceLib:reset()
    for _, obj in pairs(self._subs) do
        local subscriptions = obj.subscribers
        for i = 1, #subscriptions do
            subscriptions[i]:unsubscribe()
        end
    end

    self._subs = {}
end

return EventMSGServiceLib
