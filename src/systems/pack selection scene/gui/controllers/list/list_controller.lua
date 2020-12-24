local App = require('src.app')
local Services = require('src.services.services')
local Views = require('src.systems.pack selection scene.gui.views.views')
local SceneServices = require('src.systems.pack selection scene.services.services')

local ScenesService = Services.scenes
local SceneMsgService = SceneServices.msg

local URL = App.constants.urls
local GAME_SCENE_URL = URL.scenes.game_scene.scene

local GameMSG = App.constants.messages.game
local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene

local ListView = Views.list

local ListController = {}

function ListController:init()
    self.list_view = ListView:new()
end

function ListController:final()

end

return ListController
