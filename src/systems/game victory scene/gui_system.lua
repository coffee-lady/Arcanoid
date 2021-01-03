local Controllers = require('src.systems.game victory scene.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.game victory scene.factories.factories')
local MainFactory = Factories.main

local Services = require('src.services.services')
local EnergyService = Services.energy

local SceneGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        EnergyService:add_listener(msg.url())
        MainFactory:init()

    end,
    final = function()
        EnergyService:remove_listener(msg.url())
    end
})

return SceneGUISystem
