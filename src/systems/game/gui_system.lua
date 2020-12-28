local Controllers = require('src.systems.game.controllers.controllers')
local SceneServices = require('src.systems.game.services.services')
local System = require('src.common.classes.gui_system')

local Factories = require('src.systems.game.factories.factories')
local LivesFactory = Factories.life
local MainGUIFactory = Factories.main_gui

local SceneGUISystem = System:new(Controllers, SceneServices, {
    init = function()
        LivesFactory:init()
        MainGUIFactory:init()
    end
})

return SceneGUISystem
