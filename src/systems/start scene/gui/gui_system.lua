local App = require('src.app')
local Controllers = require('src.systems.start scene.gui.controllers.controllers')
local Services = require('src.services.services')
local SceneServices = require('src.systems.start scene.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization

local MSG = App.constants.messages

local LocalizationController = Controllers.localization
local EffectsController = Controllers.effects
local PlayButtonController = Controllers.play_button

local StartSceneGUISystem = {}

function StartSceneGUISystem:init()
    PlayButtonController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        SceneGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    EffectsController:init()
end

function StartSceneGUISystem:on_input(action_id, action)
    SceneGuiMsgService:send(nil, action_id, action)
end

function StartSceneGUISystem:final()
    PlayButtonController:final()

    self.local_subs:unsubscribe()

    SceneGuiMsgService:reset()
end

return StartSceneGUISystem
