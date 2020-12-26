local App = require('src.app')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local Logic = class('Logic')

function Logic:initialize(data)
    self.lives = data.lives
    self.destroyable = data.destroyable

    self.lives_observer = Observable:new()
end

function Logic:decrease_lives()
    if not self.destroyable then
        return
    end

    self.lives = self.lives - 1
    self.lives_observer:next(self.lives)

    if self.lives == 0 then
        self.lives_observer:complete()
    end
end

return Logic
