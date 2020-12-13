local App = require('src.app')

local Observable = App.libs.event_observation.observable

local GameMsgService = {}

function GameMsgService:init()
    self._subs = {}
end

function GameMsgService:_create_subs(message_id)
    self._subs[message_id] = {
        observer = Observable:new(),
        subscribers = {}
    }

    return self._subs[message_id]
end

function GameMsgService:send(receiver, message_id, message)
    if not self._subs[message_id] then
        self:_create_subs(message_id)
    end

    if receiver then
        self:_send_to_reciever(receiver, message_id, message)
        return
    end

    self:_send_to_all_subscribers(message_id, message)
end

function GameMsgService:_send_to_all_subscribers(message_id, message)
    self._subs[message_id]:next(message)
end

function GameMsgService:_send_to_reciever(receiver, message_id, message)
    local subscribers = self._subs[message_id].subscribers

    for i = 1, #subscribers do
        if subscribers[i].subscriber == receiver then
            subscribers[i]:next(message)
        end
    end
end

function GameMsgService:on(subscriber, message_id, callback)
    local subs = self._subs[message_id]
    if not subs then
        subs = self:_create_subs(message_id)
    end

    local new_subs = subs.observer:subscribe(callback)
    new_subs.subscriber = subscriber

    table.insert(subs.subscribers, new_subs)

    return new_subs
end

return GameMsgService
