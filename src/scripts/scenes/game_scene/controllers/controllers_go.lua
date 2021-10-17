local BallsController = require('src.scripts.scenes.game_scene.controllers.BallsController.BallsController')
local WallsController = require('src.scripts.scenes.game_scene.controllers.WallsController.WallsController')
local LosingZoneController = require('src.scripts.scenes.game_scene.controllers.LosingZoneController.LosingZoneController')

local ControllersGO = {BallsController, WallsController, LosingZoneController}

return ControllersGO
