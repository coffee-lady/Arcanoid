local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.start scene.services.services')

local class = App.libs.middleclass

local SceneMsgService = SceneServices.gui_msg
local ScenesService = Services.scenes
local GUIService = Services.gui
local URL = App.constants.urls
local SceneURLs = URL.gui_nodes.start_scene

local View = class('View')

function View:initialize()
    local btn = gui.get_node(SceneURLs.button_play)

    GUIService.buttons:set(SceneMsgService, {
        node = btn,
        callback = function()
            ScenesService:switch_to_scene(URL.scenes.pack_selection_scene.main)
        end
    })
end

return View
