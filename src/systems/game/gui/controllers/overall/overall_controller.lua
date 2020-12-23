local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.game.gui.views.views')
local SceneServices = require('src.systems.game.services.services')

local ScenesService = Services.scenes
local SceneMsgService = SceneServices.msg

local URL = App.constants.urls
local GAME_SCENE_URL = URL.scenes.game_scene.scene

local GameMSG = App.constants.messages.game

local OverallView = Views.overall

local OverallController = {}

function OverallController:init()
    self.overall_view = OverallView:new()

    self.overall_view.pause_observer:subscribe(function()
        SceneMsgService:post(GAME_SCENE_URL, nil, GameMSG.pause)
        ScenesService:open_popup(URL.scenes.game_pause_popup.main)
    end)
end

function OverallController:final()
    self.overall_view:final()
end

return OverallController
