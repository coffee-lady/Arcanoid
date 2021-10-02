local Libs = require('src.libs.libs')
local SubscribedButton = require('gui.controls.subscribed_button.subscribed_button')
local AbstractMenu = require('gui.controls.abstract_menu.abstract_menu')

local class = Libs.middleclass

--- @class ButtonsMenu : AbstractMenu
local ButtonsMenu = class('ButtonsMenu', AbstractMenu)

function ButtonsMenu:initialize(context_services, map)
    AbstractMenu.initialize(self, context_services, SubscribedButton, map)
end

return ButtonsMenu
