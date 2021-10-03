local SubscribedLink = require('gui.controls.subscribed_link.subscribed_link')
local AbstractMenu = require('gui.controls.abstract_menu.abstract_menu')

--- @class LinksMenu: AbstractMenu
local LinksMenu = class('LinksMenu', AbstractMenu)

function LinksMenu:initialize(scenes_service, ui_service, map)
    AbstractMenu.initialize(self, scenes_service, ui_service, SubscribedLink, map)
end

return LinksMenu
