local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local Services = require('src.services.services')

local GameGuiMsgService = GameServices.gui_msg
local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages
local URL = App.constants.urls
local GameGuiURL = URL.gui_nodes.game_scene

local SUBSCRIPTION = 'localization_ctrl'

local LocalizationController = {}

function LocalizationController:init()
    self:update()

    GameGuiMsgService:on(SUBSCRIPTION, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(URL.scenes.game_scene.main)
    LocalizationLib:update_gui({{
        node = gui.get_node(GameGuiURL.text.pause_text),
        text = TEXT_DATA.pause_text
    }})
end

return LocalizationController
