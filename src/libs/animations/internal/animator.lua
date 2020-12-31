local class = require('src.libs.middleclass.middleclass')

local Animator = class('Animation')

function Animator:initialize(animate_func)
    self._timer = 0
    self.animate = animate_func
    self.timers = {}
end

function Animator:play(anim)
    local delay = anim.delay + self._timer

    self.timers[#self.timers + 1] = timer.delay(self._timer, false, function()
        anim:play()
    end)

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

function Animator:exec(callback)
    self.timers[#self.timers + 1] = timer.delay(self._timer, false, function()
        callback()
    end)

    return self
end

function Animator:suspend(time)
    self.timers[#self.timers + 1] = timer.delay(self._timer, false, function()
        self._timer = self._timer + time
    end)

    return self
end

function Animator:finish()
    self.timers[#self.timers + 1] = timer.delay(self._timer, false, function()
        self._timer = 0
    end)

    return self
end

function Animator:force_stop()
    for i = 1, #self.timers do
        timer.cancel(self.timers[i])
    end

    self._timer = 0
end

return Animator
