local App = require('src.app')

local class = App.libs.middleclass
local PROP = App.constants.go_props
local BallConfig = App.config.game.go.ball
local ZERO_SPEED = vmath.vector3()

local Physics = class('Physics')

function Physics:initialize(id)
    self.co_url = msg.url(nil, id, PROP.collisionobject)
    self.base_speed = vmath.vector3(BallConfig.speed.start.x, BallConfig.speed.start.y, 0)
end

function Physics:set_speed(speed)
    go.set(self.co_url, PROP.linear_velocity, speed)
end

function Physics:stop_ball()
    self.speed_snapshot = go.get(self.co_url, PROP.linear_velocity)

    self:set_speed(ZERO_SPEED)
end

function Physics:resume_moving()
    local speed = self.speed_snapshot

    if speed.x == 0 and speed.y == 0 then
        speed = BallConfig.speed.start
    end

    self:set_speed(speed)
end

function Physics:reset_speed()
    self:set_speed(self.base_speed)
end

local function get_vector_length(v)
    return math.sqrt(v.x * v.x + v.y * v.y)
end

function Physics:normalize_speed()
    local speed = go.get(self.co_url, PROP.linear_velocity)

    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    if mod_x < BallConfig.speed.min.x or mod_y < BallConfig.speed.min.y then
        speed.x = speed.x / mod_x * self.base_speed.x
        speed.y = speed.y / mod_y * self.base_speed.y

        self:set_speed(speed)
    end
end

function Physics:accelerate(delta_speed)
    local speed = go.get(self.co_url, PROP.linear_velocity)
    speed.x = speed.x + delta_speed.x
    speed.y = speed.y + delta_speed.y

    local max_speed_vector = get_vector_length(BallConfig.speed.max)
    local min_speed_vector = get_vector_length(BallConfig.speed.min)
    local speed_vector = get_vector_length(speed)

    if speed_vector > min_speed_vector and speed_vector < max_speed_vector then
        self.base_speed.x = math.abs(speed.x)
        self.base_speed.y = math.abs(speed.y)

        self:set_speed(speed)
    end
end

return Physics
