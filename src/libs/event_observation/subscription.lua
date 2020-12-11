local class = require('src.libs.middleclass.middleclass')

local Subscription = class('Subscription')

function Subscription:initialize(_unsubscribe_behavior)
    self._unsubscribe_behavior = _unsubscribe_behavior
end

function Subscription:unsubscribe()
    self._unsubscribe_behavior(self)
end

return Subscription
