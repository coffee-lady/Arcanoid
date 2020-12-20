local class = require('src.libs.middleclass.middleclass')

local Animator = class('Animation')

function Animator:initialize(animate_func)
    self._timer = 0
    self.animate = animate_func
end

function Animator:play(anim)
    local delay = anim.delay + self._timer

    anim:play()

    self._timer = delay + anim.duration

    return Animator
end

function Animator:play_in_parallel(...)
    local anims = ...
    local max_time = 0

    for i = 1, #anims do
        local anim = anims[i]
        local time = anim.delay + anim.duration

        anim:play()

        if time > max_time then
            max_time = time
        end
    end

    self._timer = self._timer + max_time

    return Animator
end

function Animator:exec(callback)
    timer.delay(self._timer, false, callback)

    return Animator
end

return Animator
