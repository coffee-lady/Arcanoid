local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.game.gui.views.views')
local GameServices = require('src.systems.game.services.services')

local ScenesService = Services.scenes
local GameMsgService = GameServices.msg

local URL = App.constants.urls
local GameSceneUrls = URL.scenes.game_scene

local GameMSG = App.constants.messages.game

local PauseButtonView = Views.pause_button

local PauseButtonController = {}

function PauseButtonController:init()
    self.button_view = PauseButtonView:new()

    self.button_view.click_observer:subscribe(function()
        GameMsgService:post(GameSceneUrls.main, nil, GameMSG.pause)
        ScenesService:open_popup(URL.popups.game_pause)
    end)
end

return PauseButtonController
