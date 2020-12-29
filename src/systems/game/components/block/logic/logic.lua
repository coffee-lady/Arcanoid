local App = require('src.app')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local Logic = class('Logic')

function Logic:initialize(data)
    self.lives = data.lives
    self.destroyable = data.destroyable

    self.lives_observer = Observable:new()
end

function Logic:decrease_lives(count)
    if not self.destroyable then
        return
    end

    if not count then
        count = 1
    end

    self.lives = self.lives - count >= 0 and self.lives - count or 0
    self.lives_observer:next(self.lives)

    if self.lives == 0 then
        self.lives_observer:complete()
    end
end

function Logic:make_fragile()
    self.lives_cache = self.lives
    self.destroyable_cache = self.destroyable

    self.lives = 1
    self.destroyable = true
end

function Logic:recover_from_fragility()
    self.lives = self.lives_cache
    self.destroyable = self.destroyable_cache
end

return Logic
