local App = require('src.app')
local PopupServices = require('src.systems.game pause popup.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = PopupServices.gui_msg
local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages
local URL = App.constants.urls

local SceneGuiURLs = URL.gui_nodes.game_victory_scene
local SCENE_URL = URL.scenes.game_victory_scene.main

local SUBSCRIPTION = 'LocalizationController'

local LocalizationController = {}

function LocalizationController:init()
    self:update()

    self.msg_subs = SceneGuiMsgService:on(SUBSCRIPTION, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(SCENE_URL)

    LocalizationLib:update_gui({{
        node = gui.get_node(SceneGuiURLs.text.title),
        text = TEXT_DATA.title
    }, {
        node = gui.get_node(SceneGuiURLs.text.congrats_text),
        text = TEXT_DATA.congrats_text
    }, {
        node = gui.get_node(SceneGuiURLs.text.level_title),
        text = TEXT_DATA.level_title
    }, {
        node = gui.get_node(SceneGuiURLs.text.pack_title),
        text = TEXT_DATA.pack_title
    }, {
        node = gui.get_node(SceneGuiURLs.text.button_next_text),
        text = TEXT_DATA.button_next_text
    }, {
        node = gui.get_node(SceneGuiURLs.text.button_back_text),
        text = TEXT_DATA.button_back_text
    }})
end

function LocalizationController:final()
    self.msg_subs:unsubscribe()
end

return LocalizationController
