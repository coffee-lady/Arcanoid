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

local SUBSCRIPTION = 'ListItemView'

local ListItemView = class('ListItemView')

local function set_pos(nodes, index)
    local pos_y = (index - 1) * PacksConfig.gui_item_height + PacksConfig.gui_item_height / 2
    gui.set_position(nodes[SceneGuiURLs.list_item], vmath.vector3(0, pos_y, 0))
end

local function is_closed(pack)
    local progress_level = LevelService:get_progress_level()

    return progress_level < pack.first_level
end

local function set_icon(nodes, data, is_closed)
    local icon = is_closed and PacksConfig.icon_closed or data.icon

    gui.play_flipbook(nodes[SceneGuiURLs.list_item_icon], icon)
    gui.set_text(nodes[SceneGuiURLs.list_item_pack_title], data.title)
end

local function set_level_title(nodes, data)
    local template_level_title = gui.get_node(SceneGuiURLs.list_item_level_title)
    local level_text = gui.get_text(template_level_title)

    local level_title_node = nodes[SceneGuiURLs.list_item_level_title]
    gui.set_text(level_title_node, level_text .. data.first_level .. '-' .. data.last_level)
end

local function set_color(nodes, index)
    local color = index % 2 == 0 and PacksConfig.even_list_item_color or PacksConfig.odd_list_item_color
    gui.set_color(nodes[SceneGuiURLs.list_item], color)
end

function ListItemView:initialize(template, index)
    local pack_data = PacksConfig.list[index]
    local nodes = gui.clone_tree(template)

    self.is_closed = is_closed(pack_data)

    set_pos(nodes, index)

    set_level_title(nodes, pack_data)
    set_icon(nodes, pack_data, self.is_closed)

    set_color(nodes, index)

    local btn_node = nodes[SceneGuiURLs.list_item_icon]
    self.icon_btn = Button:new(btn_node, GUIButtonConfig, function()
        LevelService:switch_to_pack(pack_data)
        ScenesService:switch_to_scene(URL.scenes.game_scene.main)
    end)

    SceneMsgService:on(SUBSCRIPTION, ACTIONS.click, function(action)
        if action.dx ~= 0 or action.dy ~= 0 or self.is_closed then
            return
        end

        self.icon_btn:on_click(action)
    end)
end

return ListItemView
