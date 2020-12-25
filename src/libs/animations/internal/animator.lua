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

    return self
end

function Animator:play_in_parallel(anims)
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

    return self
end

function Animator:suspend(time)
    timer.delay(self._timer, false, function()
        self._timer = self._timer + time
    end)

    return self
end

function Animator:finish()
    timer.delay(self._timer, false, function()
        self._timer = 0
    end)

    return self
end

return Animator
