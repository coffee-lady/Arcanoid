local App = require('src.app')
local Components = require('src.systems.game victory scene.components.components')

local MainComponent = Components.main

local Factory = {}

function Factory:init()
    MainComponent:new()
end

return Factory
