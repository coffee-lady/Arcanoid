local Controllers = require('src.systems.game pause popup.gui.controllers.controllers')
local PopupServices = require('src.systems.game pause popup.services.services')
local System = require('src.common.classes.system')

local PopupGuiMsgService = PopupServices.gui_msg

local OverallController = Controllers.overall

local PopupGUISystem = System:new(Controllers, PopupGuiMsgService, {
    init = function()
        OverallController:init()
    end,
    final = function()
        OverallController:final()
    end
})

return PopupGUISystem
