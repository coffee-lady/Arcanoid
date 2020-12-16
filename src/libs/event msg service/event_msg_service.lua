local class = require('src.libs.middleclass.middleclass')

local EventObservationLib = require('src.libs.event_observation.event_observation')
local Observable = EventObservationLib.observable

local EventMSGServiceLib = class('MSGService')

function EventMSGServiceLib:initialize()
    self._subs = {}
end

local function _create_subs(self, message_id)
    self._subs[message_id] = {
        observer = Observable:new(),
        subscribers = {}
    }

    return self._subs[message_id]
end

local function _send_to_all_subscribers(self, message_id, message)
    local subscribers = self._subs[message_id].subscribers
    for i = 1, #subscribers do
        subscribers[i]:next(message)
    end
end

local function _send_to_reciever(self, receiver, message_id, message)
    local subscribers = self._subs[message_id].subscribers

    for i = 1, #subscribers do
        if subscribers[i].subscriber == receiver then
            subscribers[i]:next(message)
        end
    end
end

function EventMSGServiceLib:send(receiver, message_id, message)
    if not self._subs[message_id] then
        _create_subs(self, message_id)
    end

    if receiver then
        _send_to_reciever(self, receiver, message_id, message)
        return
    end

    _send_to_all_subscribers(self, message_id, message)
end

function EventMSGServiceLib:on(subscriber, message_id, callback)
    local subs = self._subs[message_id]
    if not subs then
        subs = _create_subs(self, message_id)
    end

    local new_subs = subs.observer:subscribe(callback)
    new_subs.subscriber = subscriber

    table.insert(subs.subscribers, new_subs)

    return new_subs
end

return EventMSGServiceLib
