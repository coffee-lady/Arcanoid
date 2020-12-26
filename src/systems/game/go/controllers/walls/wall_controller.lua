local App = require('src.app')
local Views = require('src.systems.game.go.views.views')
local Services = require('src.services.services')

local ScreenService = Services.screen

local WallView = Views.wall
local WallsConfig = App.config.game.go.walls
local WallsConst = App.constants.urls.scenes.game_scene.walls

local WallsController = {}

function WallsController:init()
    local walls = {}

    for key, val in pairs(WallsConfig) do
        walls[#walls + 1] = WallView:new(WallsConst[key], val.pos)
    end

    ScreenService.update_observer:subscribe(function()
        for i = 1, #walls do
            walls[i]:reset()
        end
    end)
end

return WallsController
