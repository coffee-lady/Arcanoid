local App = require('src.app')
local SceneServices = require('src.systems.pack selection scene.services.services')

local class = App.libs.middleclass
local SceneGuiURLs = App.constants.urls.gui_nodes.pack_selection_scene
local SceneMsgService = SceneServices.gui_msg
local ACTION = App.constants.actions

local Transform = require('src.systems.pack selection scene.components.packs_list.transform.transform')
local Animations = require('src.systems.pack selection scene.components.packs_list.animations.animations')
local View = require('src.systems.pack selection scene.components.packs_list.view.view')

local PacksListComponent = class('Component')

function PacksListComponent:initialize(list_length)
    local view = View:new()
    local animations = Animations:new(view.node)
    local transform = Transform:new(view.node)

    local template = gui.get_node(SceneGuiURLs.list_item)

    gui.set_enabled(template, false)

    SceneMsgService:on(SceneGuiURLs.root, ACTION.click, function(action)
        transform:scroll(action, list_length)
    end)
end

return PacksListComponent
