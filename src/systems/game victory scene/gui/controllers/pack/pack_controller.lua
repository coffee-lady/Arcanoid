local Models = require('src.systems.game victory scene.gui.models.models')
local Views = require('src.systems.game victory scene.gui.views.views')

local Pack = Models.pack
local PackView = Views.pack

local PackController = {}

function PackController:init()
    self.pack = Pack:new()
    self.pack_view = PackView:new(self.pack.prev_pack, self.pack.next_pack)
end

return PackController
