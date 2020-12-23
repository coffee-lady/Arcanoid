local Controllers = require('src.systems.game victory scene.gui.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local System = require('src.common.classes.gui_system')

local MsgService = SceneServices.gui_msg

local OverallController = Controllers.overall

local SceneGUISystem = System:new(Controllers, MsgService, {
    init = function()
        OverallController:init()
    end,
    final = function()
        OverallController:final()
    end
})

return SceneGUISystem
