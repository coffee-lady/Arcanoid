local Components = require('src.systems.start scene.components.components')

local Main = Components.main

local Factory = {}

function Factory:init()
    Main:new()
end

return Factory
