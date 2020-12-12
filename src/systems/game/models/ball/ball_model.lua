local App = require('src.app')

local class = App.libs.middleclass
local BallConfig = App.config.game.ball
local Observable = App.libs.event_observation.observable

local Ball = class('Ball')

function Ball:initialize()
    self.update_observer = Observable:new()

    self:update_speed(BallConfig.start_speed)
end

function Ball:update_speed(speed)
    if speed.x < BallConfig.max_speed.x and speed.y < BallConfig.max_speed.y then
        self.speed = speed
        self.update_observer:next()
    end
end

return Ball
