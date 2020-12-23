local Controllers = require('src.systems.start scene.gui.controllers.controllers')
local SceneServices = require('src.systems.start scene.services.services')
local System = require('src.common.classes.system')

local SceneGuiMsgService = SceneServices.gui_msg

local EffectsController = Controllers.effects
local OverallController = Controllers.overall

local SceneGUISystem = System:new(Controllers, SceneGuiMsgService, {
    init = function()
        OverallController:init()
        EffectsController:init()
    end,
    final = function()
        OverallController:final()
    end
})

return SceneGUISystem

