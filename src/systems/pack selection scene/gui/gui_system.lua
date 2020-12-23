local Controllers = require('src.systems.pack selection scene.gui.controllers.controllers')
local GameServices = require('src.systems.pack selection scene.services.services')
local System = require('src.common.classes.gui_system')

local MsgService = GameServices.gui_msg

local SceneGUISystem = System:new(Controllers, MsgService, {})

return SceneGUISystem
