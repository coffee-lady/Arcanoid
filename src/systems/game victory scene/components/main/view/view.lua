local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game victory scene.services.services')

local class = App.libs.middleclass

local URL = App.constants.urls
local SceneMsgService = SceneServices.gui_msg
local LevelService = Services.level
local ScenesService = Services.scenes
local GUIService = Services.gui

local GAME_SCENE = URL.scenes.game_scene.main
local PACK_SELECTION_SCENE = URL.scenes.game_victory_scene.main
local START_SCENE = URL.scenes.start_scene.main

local SceneURLs = URL.gui_nodes.game_victory_scene

local View = class('View')

function View:initialize()
    local prev_pack = LevelService:get_previous_pack()
    local current_pack = LevelService:get_current_pack()

    GUIService.images:set({
        node = gui.get_node(SceneURLs.pack_icon),
        animation = prev_pack.icon
    })

    GUIService.buttons:set_multiple(SceneMsgService, {{
        node = gui.get_node(SceneURLs.button_back),
        callback = function()
            ScenesService:switch_to_scene(START_SCENE)
        end
    }, {
        node = gui.get_node(SceneURLs.button_next),
        callback = function()
            local current_level = LevelService:get_current_level()
            local played_last_level = LevelService:was_last_level_played()
            local is_passed_pack = LevelService:get_progress_level() > current_pack.last_level

            if is_passed_pack and (current_level == current_pack.last_level + 1 or played_last_level) then
                ScenesService:switch_to_scene(PACK_SELECTION_SCENE)
            else
                ScenesService:switch_to_scene(GAME_SCENE)
            end
        end
    }})
end

return View
