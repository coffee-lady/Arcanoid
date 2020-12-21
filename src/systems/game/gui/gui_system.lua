local App = require('src.app')
local Controllers = require('src.systems.game.gui.controllers.controllers')
local GameServices = require('src.systems.game.services.services')
local Services = require('src.services.services')

local GameGuiMsgService = GameServices.gui_msg

local LocalizationService = Services.localization

local MSG = App.constants.messages
local LivesController = Controllers.lives
local PauseButtonController = Controllers.pause_button
local LocalizationController = Controllers.localization
local EffectsController = Controllers.effects

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
    LivesController:init()
    PauseButtonController:init()

    LocalizationController:init()

    LocalizationService.changes:subscribe(function()
        GameGuiMsgService:send(nil, MSG.common.localization_change)
    end)

    EffectsController:init()
end

function GameSceneGUISystem:on_message(message_id, message)
    GameGuiMsgService:send(message.receiver, message_id, message.data)
end

function GameSceneGUISystem:on_input(action_id, action)
    GameGuiMsgService:send(nil, action_id, action)
end

return GameSceneGUISystem
