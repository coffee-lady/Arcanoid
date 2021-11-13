local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local ID = App.constants.gui.screens.game_scene
local WallsConfig = App.config.game.walls

--- @class LosingZoneController : SceneController
local LosingZoneController = class('LosingZoneController', SceneController)

LosingZoneController.__cparams = {'event_bus_go'}

function LosingZoneController:initialize(event_bus, presenters, view)
    SceneController.initialize(self, event_bus)

    --- @type LosingZonePresenter
    self.losing_zone_presenter = presenters.losing_zone_presenter
    --- @type ViewGameSceneGO
    self.view = view

    self:set_subscriptions_map(
        {
            [MSG.collision_response] = self.on_collision_response
        }
    )
end

function LosingZoneController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if go_id == hash(ID.losing_zone) then
        print('losing_zone collision!')
    end
end

function LosingZoneController:init()
    self:_reset_pos()
end

function LosingZoneController:_reset_pos()
    local pos = self.losing_zone_presenter:get_zone_pos()
    self.view:set_losing_zone_pos(pos)
end

return LosingZoneController
