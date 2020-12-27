local App = require('src.app')

local class = App.libs.middleclass
local PROP = App.constants.go_props

local View = class('View')

function View:initialize(id)
    self.id = id
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
end

return View
