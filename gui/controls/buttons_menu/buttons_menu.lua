local SubscribedButton = require('gui.controls.subscribed_button.subscribed_button')
local AbstractMenu = require('gui.controls.abstract_menu.abstract_menu')

--- @class ButtonsMenu : AbstractMenu
local ButtonsMenu = class('ButtonsMenu', AbstractMenu)

function ButtonsMenu:initialize(scenes_service, ui_service, map)
    AbstractMenu.initialize(self, scenes_service, ui_service, SubscribedButton, map)
end

return ButtonsMenu
