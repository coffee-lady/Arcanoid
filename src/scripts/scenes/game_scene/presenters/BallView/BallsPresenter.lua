local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math

local BallsConfig = App.config.game.balls

--- @class BallsPresenter
local BallsPresenter = class('BallPresenter')

BallsPresenter.__cparams = {'screen_service'}

function BallsPresenter:initialize(screen_service, view)
    --- @type ScreenService
    self.screen_service = screen_service

    --- @type ViewGameSceneGO
    self.view = view
end

function BallsPresenter:create_ball(settings)
    return self.view:create_ball(settings)
end

function BallsPresenter:normalize_ball_speed(id, base_velocity)
    local speed = self.view:get_ball_speed(id)
    local mod_x = math.abs(speed.x)
    local mod_y = math.abs(speed.y)

    if mod_x > BallsConfig.speed.min.x and mod_y > BallsConfig.speed.min.y then
        return base_velocity
    end

    speed.x = speed.x / mod_x * base_velocity.x
    speed.y = speed.y / mod_y * base_velocity.y

    self.view:set_ball_speed(id, speed)

    return speed
end

function BallsPresenter:accelerate_ball(id, delta_speed)
    return self:_update_ball_speed(id, delta_speed)
end

function BallsPresenter:decelerate_ball(id, delta_speed)
    return self:_update_ball_speed(id, -delta_speed)
end

function BallsPresenter:stop_ball(id)
    self.view:set_ball_speed(id, vmath.vector3())
end

function BallsPresenter:resume_ball_moving(id, last_velocity)
    self.view:set_ball_speed(id, last_velocity)
end

function BallsPresenter:reset_ball(id)
    self:reset_ball_pos(id)
    self:reset_ball_scale(id)
    self.view:set_ball_speed(id, BallsConfig.speed.start)
end

function BallsPresenter:reset_ball_scale(id)
    local ball_size = self.view:get_ball_size(id)
    local screen_sizes = self.screen_service:get_sizes()
    local scale_factor = (BallsConfig.rel_size * screen_sizes.x) / ball_size.x
    scale_factor = math.max(scale_factor, BallsConfig.min_scale)
    self.view:set_ball_scale(id, scale_factor)
end

function BallsPresenter:reset_ball_pos(id)
    local pos = vmath.vector3()
    local sizes = self.screen_service:get_sizes()
    local start_coords = self.screen_service:get_coords()

    pos.x = start_coords.x + BallsConfig.start_rel_pos.x * sizes.x
    pos.y = start_coords.y + BallsConfig.start_rel_pos.y * sizes.y

    self.view:set_ball_pos(id, pos)
end

function BallsPresenter:delete_ball(id)
    self.view:delete_ball(id)
end

function BallsPresenter:_update_ball_speed(id, base_velocity, change_delta_speed)
    local new_speed_x = base_velocity.x + change_delta_speed.x
    local new_speed_y = base_velocity.y + change_delta_speed.y

    local max_speed_h = Math.v3_hypotenuse(BallsConfig.speed.max)
    local min_speed_h = Math.v3_hypotenuse(BallsConfig.speed.min)
    local speed_h = Math.hypotenuse(new_speed_x, new_speed_y)

    if speed_h < min_speed_h or speed_h > max_speed_h then
        return base_velocity
    end

    base_velocity.x = new_speed_x
    base_velocity.y = new_speed_y

    local speed = self.view:get_ball_speed(id)
    speed.x = speed.x / math.abs(speed.x) * new_speed_x
    speed.y = speed.y / math.abs(speed.y) * new_speed_y

    self.view:set_ball_speed(id, speed)

    return speed
end

return BallsPresenter
