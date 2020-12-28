local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local URL = App.constants.urls
local SceneMSG = App.constants.messages.game
local SceneURLs = App.constants.urls.gui_nodes.game_scene

local SceneMsgService = SceneServices.gui_msg
local ScenesService = Services.scenes
local GUIService = Services.gui

local View = class('View')

function View:initialize()
    local btn = gui.get_node(SceneURLs.pause_button)

    GUIService.buttons:set(SceneMsgService, {
        node = btn,
        callback = function()
            SceneMsgService:post(URL.scenes.game_scene.scene, nil, SceneMSG.pause)
            ScenesService:open_popup(URL.scenes.game_pause_popup.main)
        end
    })

    local snow_pfx_node = gui.get_node(SceneURLs.snow_particlefx)

    gui.play_particlefx(snow_pfx_node)
end

return View
