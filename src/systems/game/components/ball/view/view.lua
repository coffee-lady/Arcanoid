local App = require('src.app')
local class = App.libs.middleclass

local View = class('View')

function View:initialize(id)
    self.id = id
end

function View:delete()
    go.delete(self.id)
end

return View
