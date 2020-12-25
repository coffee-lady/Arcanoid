local App = require('src.app')
local class = App.libs.middleclass
local Services = require('src.services.services')
local SceneServices = require('src.systems.pack selection scene.services.services')

local LevelService = Services.level
local ScenesService = Services.scenes
local SceneMsgService = SceneServices.gui_msg
local Button = App.libs.gui.button
local GUIButtonConfig = App.config.common.gui.button

local PacksConfig = App.config.game.packs
local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene
local ACTIONS = App.constants.actions
local URL = App.constants.urls

local SUBSCRIPTION = 'ListItemPackView'

local ListItemPackView = class('ListItemPackView')

function ListItemPackView:initialize(nodes, data)
    local progress_level = LevelService:get_progress_level()
    local is_closed_pack = progress_level < data.first_level

    local icon = is_closed_pack and PacksConfig.icon_closed or data.icon

    gui.play_flipbook(nodes[SceneGuiURLs.list_item_icon], icon)
    gui.set_text(nodes[SceneGuiURLs.list_item_pack_title], data.title)

    local btn_node = nodes[SceneGuiURLs.list_item_icon]

    local icon_btn = Button:new(btn_node, GUIButtonConfig, function()
        LevelService:switch_to_pack(data)
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end)

    SceneMsgService:on(SUBSCRIPTION, ACTIONS.click, function(action)
        if action.dx ~= 0 or action.dy ~= 0 or is_closed_pack then
            return
        end

        icon_btn:on_click(action)
    end)
end

return ListItemPackView
