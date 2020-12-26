local App = require('src.app')
local SceneUrls = App.constants.urls.scenes.game_scene
local Components = require('src.systems.game.components.components')

local Ball = Components.ball

local Factory = {}

function Factory:init()
    local id = factory.create(SceneUrls.ball_factory)
    Ball:new(id)
end

return Factory
