local App = require('src.app')
local Controllers = require('src.systems.game victory scene.gui.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization
local ScenesTransitions = App.libs.scenes_transitions

local URL = App.constants.urls
local MSG = App.constants.messages
local TransitionSettings = App.config.transitions.game_victory_scene
local SceneGuiURLs = URL.gui_nodes.game_victory_scene

local OverallController = Controllers.overall
local LocalizationController = Controllers.localization

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        SceneGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    self.transition = ScenesTransitions:new(SceneGuiURLs.root)
    self.transition:auto_set(TransitionSettings)
end

function GameSceneGUISystem:on_message(message_id, message, sender)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)

    self.transition:on_message(message_id, message, sender)
end

function GameSceneGUISystem:on_input(action_id, action)
    SceneGuiMsgService:send(nil, action_id, action)
end

function GameSceneGUISystem:final()
    OverallController:final()
    LocalizationController:final()

    self.local_subs:unsubscribe()

    SceneGuiMsgService:reset()
    self.transition:final()
end

return GameSceneGUISystem
