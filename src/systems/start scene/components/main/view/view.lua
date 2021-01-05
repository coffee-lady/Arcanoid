local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.start scene.services.services')

local class = App.libs.middleclass

local SceneMsgService = SceneServices.gui_msg
local ScenesService = Services.scenes
local GUIService = Services.gui
local URL = App.constants.urls
local SceneURLs = URL.gui_nodes.start_scene
local ScenesUrls = App.constants.urls.scenes

local LevelService = Services.level

local View = class('View')

function View:initialize()
    local btn = gui.get_node(SceneURLs.button_play)

    GUIService.buttons:set(SceneMsgService, {
        node = btn,
        callback = function()
            local screen_id

            if LevelService:get_current_level() == 1 then
                screen_id = ScenesUrls.game_scene.main
            else
                screen_id = ScenesUrls.pack_selection_scene.main
            end

            ScenesService:switch_to_scene(screen_id)
        end
    })
end

return View
