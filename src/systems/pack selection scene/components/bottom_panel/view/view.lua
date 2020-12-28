local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.pack selection scene.services.services')

local ScenesService = Services.scenes
local SceneMsgService = SceneServices.gui_msg
local LevelService = Services.level

local GUIService = Services.gui

local class = App.libs.middleclass
local URL = App.constants.urls
local SceneGuiURLs = URL.gui_nodes.pack_selection_scene

local View = class('View')

function View:initialize()
    local current_pack = LevelService:get_current_pack()
    self.root_node = gui.get_node(SceneGuiURLs.bottom_panel)
    local btn = gui.get_node(SceneGuiURLs.pack_icon)

    GUIService.images:set({
        node = btn,
        animation = current_pack.icon
    })

    GUIService.buttons:set(SceneMsgService, {
        node = btn,
        callback = function()
            ScenesService:switch_to_scene(URL.scenes.game_scene.main, {
                continue = true
            })
        end
    })
end

return View
