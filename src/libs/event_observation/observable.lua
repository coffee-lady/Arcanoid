local class = require('src.libs.middleclass.middleclass')
local Subscriber = require('src.libs.event_observation.subscriber')

local Observable = class('Observable')

function Observable:initialize()
    self.subscribers = {}
    self.completed = false
end

function Observable:next(value)
    if self.completed then
        return
    end

    for i = 1, #self.subscribers do
        self.subscribers[i]:next(value)
    end
end

function Observable:subscribe(next, complete)
    local subscription = Subscriber:new(next, complete, function(subscriber)
        self:remove(subscriber)
    end)

    table.insert(self.subscribers, subscription)
    return subscription
end

function Observable:remove(subscriber)
    for i = 1, #self.subscribers do
        if self.subscribers[i].subs == subscriber then
            table.remove(self.subscribers, i)
            break
        end
    end
end

function Observable:complete()
    for i = 1, #self.subscribers do
        self.subscribers[i]:complete()
        self.subscribers[i]:unsubscribe()
        self.completed = true
    end

    self.subscribers = nil
end

return Observable
