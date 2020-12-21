local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.start scene.gui.views.views')

local ScenesService = Services.scenes

local URL = App.constants.urls

local PlayButtonView = Views.play_button

local PlayButtonController = {}

function PlayButtonController:init()
    self.button_view = PlayButtonView:new()

    self.button_view.click_observer:subscribe(function()
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end)
end

function PlayButtonController:final()
    self.button_view:final()
end

return PlayButtonController
