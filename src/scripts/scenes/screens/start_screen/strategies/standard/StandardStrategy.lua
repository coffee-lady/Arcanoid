local Controllers = require('src.scripts.scenes.screens.start_screen.controllers.controllers')
local SceneCommon = require('src.scripts.scenes.screens.start_screen.common.common')
local Presenters = require('src.scripts.scenes.screens.start_screen.presenters.presenters')
local View = require('src.scripts.scenes.screens.start_screen.view.ViewStartScreen')

local StandardStrategy = {}

function StandardStrategy:init(context_services)
    --- @type LeaderboardsService
    self.leaderboards_service = context_services.leaderboards_service

    SceneCommon.NodesMap:init()
    SceneCommon.ThemeMap:init(context_services)
    SceneCommon.LocalizationMap:init(context_services)
    SceneCommon.ControlsMap:init(context_services)

    self.view = View(context_services, SceneCommon.NodesMap:get_objects())

    self.presenters = {
        buttons = Presenters.ButtonsPresenter(context_services, self.view),
        debug_data = Presenters.DebugDataPresenter(context_services, self.view),
    }

    self.components_ctrl = Controllers.ComponentsController(context_services)
    self.buttons_ctrl = Controllers.ButtonsController(context_services, self.presenters)
    self.debug_data_ctrl = Controllers.DebugDataController(context_services, self.presenters)

    self.leaderboards_service:show_tutorial()
end

function StandardStrategy:update(dt)
    self.components_ctrl:update(dt)
end

function StandardStrategy:on_message(message_id, message, sender)
    self.components_ctrl:on_message(message_id, message, sender)
end

function StandardStrategy:final()
    self.components_ctrl:final()
    self.buttons_ctrl:final()
end

return StandardStrategy
