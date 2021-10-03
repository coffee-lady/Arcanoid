local Tween = require('animations.tween.tween')

--- @class TweenGO : Tween
local TweenGO = class('AnimationTweenGO', Tween)

function TweenGO:initialize(object, to, duration, anim_property)
    self.object = object
    self.to = to
    self.anim_property = anim_property
    self.anim_playback = gui.PLAYBACK_ONCE_FORWARD
    self.anim_delay = 0
    self.anim_easing = gui.EASING_LINEAR
    self.anim_duration = duration
    self.callbacks = {}

    self.is_running = false
end

function TweenGO:on_run(callback)
    go.animate(self.object.target, self.anim_property, self.anim_playback, self.to, self.anim_easing, self.anim_duration, self.anim_delay, function()
        callback(self)
    end)
end

function TweenGO:on_cancel()
    go.cancel_animations(self.object.target, self.anim_property)
end

return TweenGO
