local App = require('src.app')
local class = App.libs.middleclass
local Subviews = require('src.systems.pack selection scene.gui.views.list.subviews.subviews')
local SceneServices = require('src.systems.pack selection scene.services.services')

local SceneMsgService = SceneServices.gui_msg

local ACTIONS = App.constants.actions

local Animation = App.libs.animations.animation
local Animator = App.libs.animations.animator

local ScrollConfig = App.config.common.scroll
local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene
local PacksConfig = App.config.game.packs
local PROP = App.constants.go_props

local SUBSCRIPTION = 'ListView'

local ListItemView = Subviews.list_item

local ListView = class('ListView')

local ANIM_CONFIG = {
    property = PROP.position_y,
    duration = ScrollConfig.duration,
    easing = gui.EASING_LINEAR,
    delay = 0,
    playback = gui.PLAYBACK_ONCE_FORWARD
}

local A = Animator:new()

local function scroll(action, node, start_pos, height)
    local pos = gui.get_position(node)
    pos.y = pos.y + action.dy

    ANIM_CONFIG.to = pos.y
    local anim = Animation:new(node, gui.animate, gui.cancel_animation, ANIM_CONFIG)

    if action.dy > 0 then
        if pos.y <= start_pos.y then
            A:play(anim)
        end
    end

    if action.dy < 0 then
        if pos.y + height >= 0 then
            A:play(anim)
        end
    end
end

function ListView:initialize()
    local list_node = gui.get_node(SceneGuiURLs.list)
    local start_list_pos = gui.get_position(list_node)
    local template = gui.get_node(SceneGuiURLs.list_item)

    self.items = {}

    for i = 1, #PacksConfig.list do
        self.items[#self.items + 1] = ListItemView:new(template, i)
    end

    local list_height = #self.items * PacksConfig.gui_item_height

    gui.set_enabled(template, false)

    SceneMsgService:on(SUBSCRIPTION, ACTIONS.click, function(action)
        scroll(action, list_node, start_list_pos, list_height)
    end)
end

return ListView
