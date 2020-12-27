local App = require('src.app')
local Components = require('src.systems.game.components.components')

local Wall = Components.wall

local WallsURLs = App.constants.urls.scenes.game_scene.walls

local Factory = {}

function Factory:init()
    for key, id in pairs(WallsURLs) do
        Wall:new(key, id)
    end
end

return Factory
