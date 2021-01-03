local Controllers = require('src.systems.pack selection scene.controllers.controllers')
local SceneServices = require('src.systems.pack selection scene.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.pack selection scene.factories.factories')
local PacksListFactory = Factories.packs_list
local BottomPanelFactory = Factories.bottom_panel

local Services = require('src.services.services')
local EnergyService = Services.energy

local SceneGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        EnergyService:add_listener(msg.url())
        PacksListFactory:init()

        BottomPanelFactory:init()
    end,
    final = function()
        EnergyService:remove_listener(msg.url())
    end
})

return SceneGUISystem
