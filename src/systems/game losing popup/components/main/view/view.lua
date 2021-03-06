local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game losing popup.services.services')

local class = App.libs.middleclass

local SceneMsgService = SceneServices.gui_msg
local ScenesService = Services.scenes
local GUIService = Services.gui
local EnergyService = Services.energy

local URL = App.constants.urls
local SceneURLs = URL.gui_nodes.game_losing_popup
local GameMSG = App.constants.messages.game
local GAME_SCENE = URL.scenes.game_scene.main
local START_SCENE = URL.scenes.start_scene.main

local View = class('View')

function View:initialize()
    GUIService.buttons:set_multiple(SceneMsgService, {{
        node = gui.get_node(SceneURLs.button_restart),
        disabled = not EnergyService:is_enough_to_restart(),
        callback = function()
            ScenesService:post(GAME_SCENE, GameMSG.restart)
            ScenesService:back_to_prev_scene()
        end
    }, {
        node = gui.get_node(SceneURLs.button_back),
        callback = function()
            ScenesService:switch_to_scene(START_SCENE)
        end
    }, {
        node = gui.get_node(SceneURLs.button_buy),
        disabled = not EnergyService:is_enough_to_buy_life(),
        callback = function()
            ScenesService:post(GAME_SCENE, GameMSG.increase_lives)
            ScenesService:post(GAME_SCENE, GameMSG.continue)
            EnergyService:buy_life()
            ScenesService:back_to_prev_scene()
        end
    }})
end

return View
