local Controllers = require('src.systems.game pause popup.controllers.controllers')
local SceneServices = require('src.systems.game pause popup.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.game pause popup.factories.factories')
local MainFactory = Factories.main

local PopupGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        MainFactory:init()
    end
})

return PopupGUISystem
