local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local BallsConfig = App.config.game.balls

--- @class BallsController : SceneController
local BallsController = class('BallsController', SceneController)

BallsController.__cparams = {'event_bus_go'}

function BallsController:initialize(event_bus, presenters)
    SceneController.initialize(self, event_bus)

    --- @type BallsPresenter
    self.balls_presenter = presenters.balls_presenter
    self.balls = {}

    self:set_subscriptions_map({
        [MSG.collision_response] = self.on_collision_response
    })
end

function BallsController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if self.balls[go_id] then
        print('ball collision!')
    end
end

function BallsController:init()
    self:_create_initial_ball()
end

function BallsController:_create_initial_ball()
    local id = self.balls_presenter:create_ball()
    self.balls[id] = {
        base_speed = BallsConfig.speed.start
    }

    self.balls_presenter:reset_ball(id)
end

return BallsController
