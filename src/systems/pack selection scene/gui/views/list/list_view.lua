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

function ListView:initialize()
    local list_node = gui.get_node(SceneGuiURLs.list)
    local start_list_pos = gui.get_position(list_node)

    local template = gui.get_node(SceneGuiURLs.list_item)
    self.items = {}

    local A = Animator:new()
    local anim_config = {
        property = PROP.position_y,
        duration = ScrollConfig.duration,
        easing = gui.EASING_LINEAR,
        delay = 0,
        playback = gui.PLAYBACK_ONCE_FORWARD
    }

    for i = 1, #PacksConfig.list do
        self.items[#self.items + 1] = ListItemView:new(template, i)
    end

    SceneMsgService:on(SUBSCRIPTION, ACTIONS.click, function(action)
        local pos = gui.get_position(list_node)
        pos.y = pos.y + action.dy

        anim_config.to = pos.y
        local anim = Animation:new(list_node, gui.animate, gui.cancel_animation, anim_config)

        if action.dy > 0 then
            if pos.y <= start_list_pos.y then
                A:play(anim)
            end
        end

        if action.dy < 0 then
            local list_length = #self.items * PacksConfig.gui_item_height

            if pos.y + list_length >= 0 then
                A:play(anim)
            end
        end
    end)
end

return ListView
