local App = require('src.app')
local Controllers = require('src.systems.game.gui.controllers.controllers')
local GameServices = require('src.systems.game.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = GameServices.gui_msg
local ScenesTransitions = App.libs.scenes_transitions
local LocalizationService = Services.localization

local URL = App.constants.urls
local MSG = App.constants.messages
local TransitionSettings = App.config.transitions.game_scene
local SceneGuiURLs = URL.gui_nodes.game_scene

local LivesController = Controllers.lives
local OverallController = Controllers.overall
local LocalizationController = Controllers.localization
local EffectsController = Controllers.effects

local GameGUISystem = {}

function GameGUISystem:init()
    LivesController:init()
    OverallController:init()

    LocalizationController:init()

    self.local_subs = LocalizationService.changes:subscribe(function()
        SceneGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    EffectsController:init()

    self.transition = ScenesTransitions:new(SceneGuiURLs.root)
    self.transition:auto_set(TransitionSettings)
end

function GameGUISystem:on_message(message_id, message, sender)
    SceneGuiMsgService:send(message.receiver, message_id, message.data)

    self.transition:on_message(message_id, message, sender)
end

function GameGUISystem:on_input(action_id, action)
    SceneGuiMsgService:send(nil, action_id, action)
end

function GameGUISystem:final()
    OverallController:final()

    self.local_subs:unsubscribe()

    SceneGuiMsgService:reset()
    self.transition:final()
end

return GameGUISystem
