local App = require('src.app')
local SceneUrls = App.constants.urls.scenes.game_scene
local Components = require('src.systems.game.components.components')

local LosingZone = Components.losing_zone

local Factory = {}

function Factory:init()
    local id = SceneUrls.losing_zone

    LosingZone:new(id)
end

return Factory
