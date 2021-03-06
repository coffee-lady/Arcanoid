local App = require('src.app')

local ScenesTransitions = App.libs.scenes_transitions

local URL = App.constants.urls
local TransitionSettings = App.config.transitions.game_victory_scene
local SceneGuiURLs = URL.gui_nodes.game_victory_scene

local TransitionsController = {}

function TransitionsController:init()
    self.transition = ScenesTransitions:new()

    self.transition:auto_set(SceneGuiURLs.root, TransitionSettings.popup)
    self.transition:auto_set(SceneGuiURLs.transition, TransitionSettings.fade)
end

function TransitionsController:on_message(message_id, message, sender)
    self.transition:on_message(message_id, message, sender)
end

function TransitionsController:final()
    self.transition:final()
end

return TransitionsController
