local App = require('src.app')
local Controllers = require('src.systems.start scene.gui.controllers.controllers')
local Services = require('src.services.services')
local SceneServices = require('src.systems.start scene.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization
local ScenesTransitions = App.libs.scenes_transitions

local URL = App.constants.urls
local MSG = App.constants.messages
local TransitionSettings = App.config.transitions.start_scene
local SceneGuiURLs = URL.gui_nodes.start_scene

local LocalizationController = Controllers.localization
local EffectsController = Controllers.effects
local OverallController = Controllers.overall

local StartSceneGUISystem = {}

function StartSceneGUISystem:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        SceneGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    EffectsController:init()

    self.transition = ScenesTransitions:new(SceneGuiURLs.root)
    self.transition:auto_set(TransitionSettings)
end

function StartSceneGUISystem:on_input(action_id, action)
    SceneGuiMsgService:send(nil, action_id, action)
end

function StartSceneGUISystem:on_message(message_id, message, sender)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)

    self.transition:on_message(message_id, message, sender)
end

function StartSceneGUISystem:final()
    OverallController:final()

    self.local_subs:unsubscribe()

    SceneGuiMsgService:reset()
    self.transition:final()
end

return StartSceneGUISystem
