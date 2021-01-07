local Components = require('src.systems.game losing popup.components.components')

local MainComponent = Components.main

local Factory = {}

function Factory:init()
    MainComponent:new()
end

return Factory
