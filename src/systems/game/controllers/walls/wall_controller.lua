local App = require('src.app')
local Views = require('src.systems.game.views.views')

local WallView = Views.wall
local WallsConfig = App.config.game.go.walls
local WallsConst = App.constants.urls.scenes.game_scene.walls

local WallsController = {}

function WallsController:init()
    self.walls = {}

    for key, val in pairs(WallsConfig) do
        self.walls[#self.walls + 1] = WallView:new(WallsConst[key], val.pos)
    end
end

return WallsController
