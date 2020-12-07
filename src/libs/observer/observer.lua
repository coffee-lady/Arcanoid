local Observer = {}

function Observer:new()
    local obj = {
        subscriptions = {}
    }

    self.__index = self
    return setmetatable(obj, self)
end

function Observer:observe(message_id)
    self.subscriptions[message_id] = {}
end

function Observer:stop_observing(message_id)
    self.subscriptions[message_id] = nil
end

function Observer:next(message_id, message)
    if not self.subscriptions[message_id] then return end

    local subs = self.subscriptions[message_id]
    for i =  1, #subs do
        subs[i].callback(message)
    end
end

function Observer:subscribe(subscriber, message_id, callback)
    if not self.subscriptions[message_id] then return end

    local size = #self.subscriptions[message_id]
    self.subscriptions[message_id][size + 1] = {
        subscriber = subscriber,
        callback = callback
    }
end

function Observer:unsubscribe(message_id, subscriber)
    if not self.subscriptions[message_id] then return end

    local subs = self.subscriptions[message_id]
    for i =  1, #subs do
        if subs[i].subscriber == subscriber then
            table.remove(subs, i)
            break
        end
    end
end

return Observer
