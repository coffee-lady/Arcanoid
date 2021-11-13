local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

local BallsConfig = App.config.game.balls

--- @class BallsPresenter
local BallsPresenter = class('BallPresenter')

BallsPresenter.__cparams = {'screen_service'}

function BallsPresenter:initialize(screen_service)
    --- @type ScreenService
    self.screen_service = screen_service
end

function BallsPresenter:get_normalized_ball_speed(speed, base_speed)
    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    if mod_x >= BallsConfig.speed.min.x and mod_y >= BallsConfig.speed.min.y then
        return nil
    end

    local new_speed = vmath.vector3()

    new_speed.x = speed.x / mod_x * base_speed.x
    new_speed.y = speed.y / mod_y * base_speed.y

    return new_speed
end

function BallsPresenter:accelerate_ball(id, delta_speed)
    return self:_update_ball_speed(id, delta_speed)
end

function BallsPresenter:decelerate_ball(id, delta_speed)
    return self:_update_ball_speed(id, -delta_speed)
end

function BallsPresenter:get_ball_scale(ball_size)
    local screen_sizes = self.screen_service:get_sizes()
    local scale_factor = (BallsConfig.rel_size * screen_sizes.x) / ball_size.x
    scale_factor = math.max(scale_factor, BallsConfig.min_scale)
    return scale_factor
end

function BallsPresenter:get_ball_initial_pos()
    local pos = vmath.vector3()
    local sizes = self.screen_service:get_sizes()
    local start_coords = self.screen_service:get_coords()

    pos.x = start_coords.x + BallsConfig.start_rel_pos.x * sizes.x
    pos.y = start_coords.y + BallsConfig.start_rel_pos.y * sizes.y

    return pos
end

function BallsPresenter:get_ball_speeds(current_speed, base_velocity, change_delta_speed)
    local new_speed_x = base_velocity.x + change_delta_speed.x
    local new_speed_y = base_velocity.y + change_delta_speed.y

    local max_speed_h = Math.v3_hypotenuse(BallsConfig.speed.max)
    local min_speed_h = Math.v3_hypotenuse(BallsConfig.speed.min)
    local speed_h = Math.hypotenuse(new_speed_x, new_speed_y)

    if speed_h < min_speed_h or speed_h > max_speed_h then
        return base_velocity, base_velocity
    end

    base_velocity.x = new_speed_x
    base_velocity.y = new_speed_y

    local speed = vmath.vector3()

    speed.x = current_speed.x / math.abs(current_speed.x) * new_speed_x
    speed.y = current_speed.y / math.abs(current_speed.y) * new_speed_y

    return speed, base_velocity
end

return BallsPresenter
