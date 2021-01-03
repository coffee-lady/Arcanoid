local App = require('src.app')
local Button = App.libs.gui.button
local GUIButtonConfig = App.config.common.gui.button
local ACTIONS = App.constants.actions

local ButtonsController = {}

function ButtonsController:set(scene_msg_service, data)
    local btn = Button:new(data.node, GUIButtonConfig, data.callback)
    if data.disabled then
        btn:disable()
    end

    scene_msg_service:on('ButtonsController', ACTIONS.click, function(action)
        btn:on_click(action)
    end)
end

function ButtonsController:set_multiple(scene_msg_service, data)
    for i = 1, #data do
        local item = data[i]
        local btn = Button:new(item.node, GUIButtonConfig, item.callback)

        if item.disabled then
            btn:disable()
        end

        scene_msg_service:on('ButtonsController', ACTIONS.click, function(action)
            btn:on_click(action)
        end)
    end
end

return ButtonsController
