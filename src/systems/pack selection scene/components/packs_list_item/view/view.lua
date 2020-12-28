local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.pack selection scene.services.services')

local class = App.libs.middleclass

local SceneMsgService = SceneServices.gui_msg
local LevelService = Services.level
local ScenesService = Services.scenes
local GUIService = Services.gui

local URL = App.constants.urls
local PacksConfig = App.config.game.packs
local SceneGuiURLs = URL.gui_nodes.pack_selection_scene

local LIST_ITEM = SceneGuiURLs.list_item
local LIST_ITEM_ICON = SceneGuiURLs.list_item_icon

local View = class('View')

local function set_bg_color(nodes, index)
    local color = index % 2 == 0 and PacksConfig.even_list_item_color or PacksConfig.odd_list_item_color
    gui.set_color(nodes[LIST_ITEM], color)
end

function View:initialize(index)
    local template = gui.get_node(SceneGuiURLs.list_item)

    local nodes = gui.clone_tree(template)
    self.root_node = nodes[LIST_ITEM]

    set_bg_color(nodes, index)

    local pack_data = PacksConfig.list[index]

    local progress_level = LevelService:get_progress_level()
    local is_closed_pack = progress_level < pack_data.first_level

    GUIService.images:set({
        node = nodes[LIST_ITEM_ICON],
        animation = is_closed_pack and PacksConfig.icon_closed or pack_data.icon
    })

    GUIService.buttons:set(SceneMsgService, {
        node = nodes[LIST_ITEM_ICON],
        disabled = is_closed_pack,
        callback = function()
            LevelService:switch_to_pack(pack_data)
            ScenesService:switch_to_scene(URL.scenes.game_scene.main)
        end
    })

    SceneServices.localization:localize_partially(nodes, SceneGuiURLs.list_item_texts, {
        item_pack_title = pack_data.title,
        item_first_level = pack_data.first_level,
        item_last_level = pack_data.last_level
    })
end

return View
