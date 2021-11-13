local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local BallsConfig = App.config.game.balls

--- @class BallsController : SceneController
local BallsController = class('BallsController', SceneController)

BallsController.__cparams = {'event_bus_go'}

function BallsController:initialize(event_bus, presenters, view)
    SceneController.initialize(self, event_bus)

    --- @type BallsPresenter
    self.balls_presenter = presenters.balls_presenter
    --- @type ViewGameSceneGO
    self.view = view
    self.balls = {}

    self:set_subscriptions_map(
        {
            [MSG.collision_response] = self.on_collision_response
        }
    )
end

function BallsController:init()
    self:_create_initial_ball()
end

function BallsController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if self.balls[go_id] then
        self:_normalize_ball_speed(go_id)
    end
end

function BallsController:_create_initial_ball()
    local id = self.view:create_ball()

    self.balls[id] = {
        base_speed = BallsConfig.speed.start
    }

    self:_reset_ball(id)
end

function BallsController:create_ball()
    return self.view:create_ball()
end

function BallsController:_normalize_ball_speed(id)
    local speed = self.view:get_ball_speed(id)
    local base_speed = self.balls[id].base_speed
    local new_speed = self.balls_presenter:get_normalized_ball_speed(speed, base_speed)

    if new_speed then
        self.view:set_ball_speed(id, new_speed)
    end
end

function BallsController:_accelerate_ball(id, delta_speed)
    return self:_update_ball_speed(id, delta_speed)
end

function BallsController:_decelerate_ball(id, delta_speed)
    return self:_update_ball_speed(id, -delta_speed)
end

function BallsController:_stop_ball(id)
    self.view:set_ball_speed(id, vmath.vector3())
end

function BallsController:_resume_ball_moving(id, last_velocity)
    self.view:set_ball_speed(id, last_velocity)
end

function BallsController:_reset_ball(id)
    self:_reset_ball_pos(id)
    self:_reset_ball_scale(id)
    self.view:set_ball_speed(id, BallsConfig.speed.start)
end

function BallsController:_reset_ball_scale(id)
    local ball_size = self.view:get_ball_size(id)
    local scale_factor = self.balls_presenter:get_ball_scale(ball_size)
    self.view:set_ball_scale(id, scale_factor)
end

function BallsController:_reset_ball_pos(id)
    local pos = self.balls_presenter:get_ball_initial_pos()
    self.view:set_ball_pos(id, pos)
end

function BallsController:_change_ball_speed(id, change_delta_speed)
    local base_speed = self.balls[id].base_speed
    local current_speed = self.view:get_ball_speed(id)
    local speed, new_base_speed = self.balls_presenter:get_ball_speeds(current_speed, base_speed, change_delta_speed)

    self.balls[id].base_speed = new_base_speed
    self.view:set_ball_speed(id, current_speed)
end

function BallsController:_delete_ball(id)
    self.view:delete_ball(id)
end

return BallsController
