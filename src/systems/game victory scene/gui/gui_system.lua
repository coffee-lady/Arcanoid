local Controllers = require('src.systems.game victory scene.gui.controllers.controllers')
local SceneServices = require('src.systems.game victory scene.services.services')
local System = require('src.common.classes.gui_system')

local MsgService = SceneServices.gui_msg

local ButtonsController = Controllers.buttons
local PackController = Controllers.pack
local LevelController = Controllers.level

local SceneGUISystem = System:new(Controllers, MsgService, {
    init = function()
        ButtonsController:init()
        PackController:init()
        LevelController:init()
    end,
    final = function()
        ButtonsController:final()
    end
})

return SceneGUISystem
