local Controllers = require('src.systems.pack selection scene.controllers.controllers')
local SceneServices = require('src.systems.pack selection scene.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.pack selection scene.factories.factories')
local PacksListFactory = Factories.packs_list
local BottomPanelFactory = Factories.bottom_panel

local SceneGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        PacksListFactory:init()
        BottomPanelFactory:init()
    end
})

return SceneGUISystem
