local Controllers = require('src.systems.game victory scene.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.game victory scene.factories.factories')
local MainFactory = Factories.main

local SceneGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        MainFactory:init()
    end
})

return SceneGUISystem
