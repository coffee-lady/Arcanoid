local class = require('src.libs.middleclass.middleclass')

local Animation = class('Animation')

function Animation:initialize(node, animate_func, cancel_func, config)
    self.node = node
    self.property = config.property
    self.to = config.to
    self.duration = config.duration and config.duration or 0
    self.easing = config.easing and config.easing or gui.EASING_LINEAR
    self.delay = config.delay and config.delay or 0
    self.callback = config.callback
    self.playback = config.playback and config.playback or gui.PLAYBACK_ONCE_FORWARD

    self.animate = animate_func
    self.cancel_animation = cancel_func
end

function Animation:play()
    self.animate(self.node, self.property, self.to, self.easing, self.duration, self.delay, self.callback, self.playback)
end

function Animation:cancel()
    self.cancel_animation(self.node, self.property)
end

return Animation
