local class = require('src.libs.middleclass.middleclass')
local Subscription = require('src.libs.event_observation.subscription')
local Observer = require('src.libs.event_observation.observer')

local Subscriber = class('Subscriber', Subscription)

function Subscriber:initialize(next, complete, _unsubs_behavior)
    self.subs = Subscription:new(_unsubs_behavior)
    self.observer = Observer:new(next, complete)
    self.completed = false
end

function Subscriber:next(value)
    if self.completed then
        return
    end

    self.observer:next(value)
end

function Subscriber:complete()
    if self.completed then
        return
    end

    self.observer:complete()
    self.completed = true
end

function Subscriber:unsubscribe()
    if self.completed then
        return
    end

    self.subs:unsubscribe()
    self.completed = true
end

return Subscriber
