local App = require('src.app')
local GUI = require('gui.gui')

local ButtonsMenu = GUI.ButtonsMenu
local SubscriptionsMap = App.libs.SubscriptionsMap
local Async = App.libs.async
local Luject = App.libs.luject

local ButtonsID = App.constants.gui.screens.start_scene.buttons
local URL = App.constants.urls
local MSG = App.constants.msg

local ControlsMap = class('ControlsMap')

ControlsMap.__cparams = {'scenes_service'}

function ControlsMap:initialize(scenes_service)
    --- @type ScenesService
    self.scenes_service = scenes_service

    self.main_buttons = Luject:resolve_class(ButtonsMenu, {
        [ButtonsID.button_play] = function()
            -- self.scenes_service:switch_to_scene(URL.game_screen)
        end,
    })
end

return ControlsMap
