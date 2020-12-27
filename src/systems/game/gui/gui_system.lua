local Controllers = require('src.systems.game.gui.controllers.controllers')
local SceneServices = require('src.systems.game.services.services')
local System = require('src.common.classes.gui_system')

local SceneMsgService = SceneServices.gui_msg

local Factories = require('src.systems.game.factories.factories')
local LivesFactory = Factories.life

local OverallController = Controllers.overall
local EffectsController = Controllers.effects

local SceneGUISystem = System:new(Controllers, SceneMsgService, {
    init = function()
        LivesFactory:init()
        OverallController:init()
        EffectsController:init()
    end,
    final = function()
        OverallController:final()
    end
})

return SceneGUISystem
