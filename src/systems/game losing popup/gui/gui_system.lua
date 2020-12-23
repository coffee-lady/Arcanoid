local Controllers = require('src.systems.game losing popup.gui.controllers.controllers')
local PopupServices = require('src.systems.game losing popup.services.services')
local System = require('src.common.classes.system')

local MsgService = PopupServices.gui_msg

local OverallController = Controllers.overall

local PopupGUISystem = System:new(Controllers, MsgService, {
    init = function()
        OverallController:init()
    end,
    final = function()
        OverallController:final()
    end
})

return PopupGUISystem
