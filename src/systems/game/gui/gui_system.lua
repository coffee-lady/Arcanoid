local Controllers = require('src.systems.game.gui.controllers.controllers')
local SceneServices = require('src.systems.game.services.services')
local System = require('src.common.classes.system')

local SceneGuiMsgService = SceneServices.gui_msg

local LivesController = Controllers.lives
local OverallController = Controllers.overall
local EffectsController = Controllers.effects

local SceneGUISystem = System:new(Controllers, SceneGuiMsgService, {
    init = function()
        LivesController:init()
        OverallController:init()
        EffectsController:init()
    end,
    final = function()
        OverallController:final()
    end
})

return SceneGUISystem
