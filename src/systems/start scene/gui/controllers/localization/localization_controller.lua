local App = require('src.app')
local SceneServices = require('src.systems.start scene.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages
local URL = App.constants.urls
local SceneGuiURL = URL.gui_nodes.start_scene
local SCENE_URL = URL.scenes.start_scene.main

local SUBSCRIPTION = 'LocalizationController'

local LocalizationController = {}

function LocalizationController:init()
    self:update()

    SceneGuiMsgService:on(SUBSCRIPTION, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(SCENE_URL)
    LocalizationLib:update_gui({{
        node = gui.get_node(SceneGuiURL.text.button_play_text),
        text = TEXT_DATA.button_play_text
    }})
end

return LocalizationController
