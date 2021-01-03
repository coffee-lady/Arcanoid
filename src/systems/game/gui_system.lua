local Controllers = require('src.systems.game.controllers.controllers')
local SceneServices = require('src.systems.game.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.game.factories.factories')
local LivesFactory = Factories.life
local MainGUIFactory = Factories.main_gui

local Services = require('src.services.services')
local EnergyService = Services.energy

local SceneGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        EnergyService:add_listener(msg.url())
        LivesFactory:init()
        MainGUIFactory:init()
    end,
    final = function()
        EnergyService:remove_listener(msg.url())
    end
})

return SceneGUISystem
