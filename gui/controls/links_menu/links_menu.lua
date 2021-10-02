local Libs = require('src.libs.libs')
local SubscribedLink = require('gui.controls.subscribed_link.subscribed_link')
local AbstractMenu = require('gui.controls.abstract_menu.abstract_menu')

local class = Libs.middleclass

--- @class LinksMenu: AbstractMenu
local LinksMenu = class('LinksMenu', AbstractMenu)

function LinksMenu:initialize(context_services, map)
    AbstractMenu.initialize(self, context_services, SubscribedLink, map)
end

return LinksMenu
