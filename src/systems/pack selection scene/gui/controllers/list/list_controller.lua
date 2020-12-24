local Views = require('src.systems.pack selection scene.gui.views.views')

local ListView = Views.list

local ListController = {}

function ListController:init()
    self.list_view = ListView:new()
end

return ListController
