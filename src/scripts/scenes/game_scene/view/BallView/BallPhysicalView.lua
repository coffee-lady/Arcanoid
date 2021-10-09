local App = require('src.app')

local CoordsLib = App.libs.coords
local class = App.libs.middleclass
local PROP = App.constants.go_props
local BallConfig = App.config.game.go.ball
local ZERO_SPEED = vmath.vector3()

--- @class BallPhysicalView
local BallPhysicalView = class('BallPhysicalView')

function BallPhysicalView:initialize(id)
    self.co_url = msg.url(nil, id, PROP.collisionobject)
    self.base_speed = vmath.vector3(BallConfig.speed.start.x, BallConfig.speed.start.y, 0)
end

function BallPhysicalView:set_speed(speed)
    go.set(self.co_url, PROP.linear_velocity, speed)
end

function BallPhysicalView:stop_ball()
    self.speed_snapshot = go.get(self.co_url, PROP.linear_velocity)

    self:set_speed(ZERO_SPEED)
end

function BallPhysicalView:resume_moving()
    local speed = self.speed_snapshot

    if speed.x == 0 and speed.y == 0 then
        speed = BallConfig.speed.start
    end

    self:set_speed(speed)
end

function BallPhysicalView:reset_speed()
    self:set_speed(self.base_speed)
end

local function get_vector_length(v)
    return math.sqrt(v.x * v.x + v.y * v.y)
end

function BallPhysicalView:normalize_speed()
    local speed = go.get(self.co_url, PROP.linear_velocity)

    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    if mod_x < BallConfig.speed.min.x or mod_y < BallConfig.speed.min.y then
        speed.x = speed.x / mod_x * self.base_speed.x
        speed.y = speed.y / mod_y * self.base_speed.y

        self:set_speed(speed)
    end
end

function BallPhysicalView:accelerate(delta_speed)
    local speed = go.get(self.co_url, PROP.linear_velocity)

    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    local new_x = self.base_speed.x + delta_speed.x
    local new_y = self.base_speed.y + delta_speed.y

    local max_speed_vector = get_vector_length(BallConfig.speed.max)
    local min_speed_vector = get_vector_length(BallConfig.speed.min)
    local speed_vector = CoordsLib.hypotenuse(new_x, new_y)

    if speed_vector > min_speed_vector and speed_vector < max_speed_vector then
        self.base_speed.x = new_x
        self.base_speed.y = new_y

        speed.x = speed.x / mod_x * new_x
        speed.y = speed.y / mod_y * new_y

        self:set_speed(speed)
    end
end

return BallPhysicalView
