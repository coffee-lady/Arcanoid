local Libs = require('src.libs.libs')
local AbstractButton = require('gui.controls.abstract_button.abstract_button')

local class = Libs.middleclass

--- @class Link : AbstractButton
local Link = class('Link', AbstractButton)

return Link
