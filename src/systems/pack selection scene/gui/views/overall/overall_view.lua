local App = require('src.app')
local class = App.libs.middleclass
local SceneServices = require('src.systems.pack selection scene.services.services')

local Button = App.libs.gui.button
local Observable = App.libs.event_observation.observable

local SceneGuiMsgService = SceneServices.gui_msg

local GUIButtonConfig = App.config.common.gui.button
local Actions = App.constants.actions
local URL = App.constants.urls
local GameGuiURL = URL.gui_nodes.game_scene

local SUBSCRIPTION = 'OverallView'

local OverallView = class('OverallView')

function OverallView:initialize()
    -- self.pause_observer = Observable:new()

    -- SceneGuiMsgService:on(SUBSCRIPTION, Actions.click, function(action)
    --     self.pause_button:on_click(action)
    -- end)
end

function OverallView:final()
    -- self.pause_observer:complete()
end

return OverallView
