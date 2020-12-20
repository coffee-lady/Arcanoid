local Models = require('src.systems.game.gui.models.models')
local Views = require('src.systems.game.gui.views.views')

local PauseButtonView = Views.pause_button

local PauseButtonController = {}

function PauseButtonController:init()
    self.button_view = PauseButtonView:new()
end

return PauseButtonController
