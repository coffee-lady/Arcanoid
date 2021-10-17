local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ID = App.constants.gui.screens.game_scene
local WallsConfig = App.config.game.walls

--- @class LosingZoneController : SceneController
local LosingZoneController = class('LosingZoneController', SceneController)

function LosingZoneController:initialize(event_bus, presenters)
    SceneController.initialize(self, event_bus)

    --- @type LosingZonePresenter
    self.losing_zone_presenter = presenters.losing_zone_presenter

    self:set_subscriptions_map({})
end

function LosingZoneController:init()
    self.losing_zone_presenter:reset_pos()
end

return LosingZoneController
