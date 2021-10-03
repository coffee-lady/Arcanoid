local App = require('src.app')
local GUI = require('gui.gui')

local ButtonsMenu = GUI.ButtonsMenu
local SubscriptionsMap = App.libs.SubscriptionsMap
local Async = App.libs.async

local ButtonsID = App.constants.gui.screens.start_scene.buttons
local URL = App.constants.urls
local MSG = App.constants.msg
local UIConfig = App.config.ui.start_scene

local Controls = {}

function Controls:init(context_services)
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service

    self.main_buttons = ButtonsMenu(context_services, {
        [ButtonsID.button_play] = function()
            -- self.scenes_service:switch_to_scene(URL.game_screen)
        end,
    })
end

return Controls
