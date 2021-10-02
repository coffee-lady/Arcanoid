local Libs = require('src.libs.libs')
local Button = require('gui.controls.button.button')
local AbstractMenu = require('gui.controls.abstract_menu.abstract_menu')

local class = Libs.middleclass

--- @class FlowButtonsMenu : AbstractMenu
local FlowButtonsMenu = class('FlowButtonsMenu', AbstractMenu)

function FlowButtonsMenu:initialize(context_services, map)
    AbstractMenu.initialize(self, context_services, Button, map)
end

function FlowButtonsMenu:on_click(action)
    for _, button in pairs(self.buttons) do
        button:click(action)
    end
end

return FlowButtonsMenu
