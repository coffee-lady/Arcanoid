local class = require('src.libs.middleclass.middleclass')

local Observer = class('Observer')

function Observer:initialize(next, complete)
    self._next = next
    self._complete = complete
end

function Observer:next(value)
    if self._next then
        self._next(value)
    end
end

function Observer:complete()
    if self._complete then
        self._complete()
    end
end

return Observer
