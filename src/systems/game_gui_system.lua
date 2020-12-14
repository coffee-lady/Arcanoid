local Controllers = require('src.systems.game.controllers.controllers')

local LivesController = Controllers.lives

local GameSceneGUISystem = {}

function GameSceneGUISystem:init()
    LivesController:init()
end

return GameSceneGUISystem
