local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ID = App.constants.gui.screens.game_scene
local WallsConfig = App.config.game.walls

--- @class WallsController : SceneController
local WallsController = class('WallsController', SceneController)

WallsController.__cparams = {'event_bus_go'}

function WallsController:initialize(event_bus, presenters, view)
    SceneController.initialize(self, event_bus)

    --- @type WallsPresenter
    self.walls_presenter = presenters.walls_presenter
    --- @type ViewGameSceneGO
    self.view = view

    self:set_subscriptions_map({})
end

function WallsController:init()
    for key, id in pairs(ID.walls) do
        self:_reset_wall(key, WallsConfig[key].rel_pos)
    end
end

function WallsController:_reset_wall(id, rel_pos)
    self:_reset_wall_pos(id, rel_pos)
end

function WallsController:_reset_wall_pos(id, rel_pos)
    local pos = self.walls_presenter:get_wall_pos(rel_pos)
    self.view:set_wall_pos(id, pos)
end

return WallsController
