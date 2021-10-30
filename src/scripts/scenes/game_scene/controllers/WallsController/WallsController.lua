local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ID = App.constants.gui.screens.game_scene
local WallsConfig = App.config.game.walls

--- @class WallsController : SceneController
local WallsController = class('WallsController', SceneController)

WallsController.__cparams = {'event_bus_go'}

function WallsController:initialize(event_bus, presenters)
    SceneController.initialize(self, event_bus)

    --- @type WallsPresenter
    self.walls_presenter = presenters.walls_presenter

    self:set_subscriptions_map({})
end

function WallsController:init()
    for key, id in pairs(ID.walls) do
        self.walls_presenter:reset_wall(key, WallsConfig[key].rel_pos)
    end
end

return WallsController
