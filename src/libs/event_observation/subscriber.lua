local class = require('src.libs.middleclass.middleclass')
local Subscription = require('src.libs.event_observation.subscription')
local Observer = require('src.libs.event_observation.observer')

local Subscriber = class('Subscriber', Subscription)

function Subscriber:initialize(next, complete, _unsubs_behavior)
    Subscription.initialize(self, _unsubs_behavior)
    self.observer = Observer:new(next, complete)
    self.completed = false
end

function Subscriber:next(value)
    self.observer:next(value)
end

function Subscriber:complete()
    self.observer:complete()
end

function Subscriber:unsubscribe()
    Subscription.unsubscribe(self)
    self.completed = true
end

return Subscriber
