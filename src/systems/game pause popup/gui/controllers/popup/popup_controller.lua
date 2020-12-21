local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.game pause popup.gui.views.views')

local ScenesService = Services.scenes

local URL = App.constants.urls
local GameMSG = App.constants.messages.game

local PopupView = Views.popup

local PopupController = {}

function PopupController:init()
    self.popup_view = PopupView:new()

    self.popup_view.continue_observer:subscribe(function()
        ScenesService:post(URL.scenes.game_scene.main, GameMSG.continue)
        ScenesService:back_to_prev_scene()
    end)

    self.popup_view.restart_observer:subscribe(function()
        ScenesService:post(URL.scenes.game_scene.main, GameMSG.restart)
        ScenesService:back_to_prev_scene()
    end)

    self.popup_view.back_observer:subscribe(function()
        ScenesService:switch_to_scene(URL.scenes.start_scene.main)
    end)
end

function PopupController:final()
    self.popup_view:final()
end

return PopupController
