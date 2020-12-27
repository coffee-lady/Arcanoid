local App = require('src.app')
local SceneUrls = App.constants.urls.scenes.game_scene
local Components = require('src.systems.game.components.components')

local URL = App.constants.urls

local Platform = Components.platform

local Factory = {}

function Factory:init()
    local id = URL.scenes.game_scene.platform

    Platform:new(id)
end

return Factory
