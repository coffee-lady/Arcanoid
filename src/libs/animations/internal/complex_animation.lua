local class = require('src.libs.middleclass.middleclass')

local ComplexAnimation = class('Animation')

function ComplexAnimation:initialize(node, animate_func, cancel_func, elems)
    self.node = node
    self.elems = elems
    self.animate = animate_func
    self.cancel_animation = cancel_func
end

function ComplexAnimation:set(config)
    self.duration = config.duration
    self.delay = config.delay
    self.easing = config.easing
end

function ComplexAnimation:play()
    for i = 1, #self.elems do
        local elem = self.elems[i]

        local easing = self.easing and self.easing or elem.easing
        local duration = self.duration and self.duration or elem.duration
        local delay = self.delay and self.delay or elem.delay

        self.animate(self.node, elem.property, elem.to, easing, duration, delay, elem.callback, elem.playback)
    end
end

function ComplexAnimation:cancel()
    for i = 1, #self.elems do
        local elem = self.elems[i]
        self.cancel_animation(elem.node, elem.property)
    end
end

return ComplexAnimation
