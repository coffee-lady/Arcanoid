local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Services = require('src.services.services')

local SceneGuiMsgService = SceneServices.gui_msg
local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages
local URL = App.constants.urls
local SceneGuiURL = URL.gui_nodes.pack_selection_scene

local SUBSCRIPTION = 'LocalizationController'

local LocalizationController = {}

function LocalizationController:init()
    self:update()

    SceneGuiMsgService:on(SUBSCRIPTION, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(SceneGuiURL.main)
    LocalizationLib:update_gui({{
        node = gui.get_node(SceneGuiURL.text.level_title),
        text = TEXT_DATA.level_title
    }, {
        node = gui.get_node(SceneGuiURL.text.continue_text),
        text = TEXT_DATA.continue_text
    }, {
        node = gui.get_node(SceneGuiURL.text.pack_title),
        text = TEXT_DATA.pack_title
    }})
end

return LocalizationController
