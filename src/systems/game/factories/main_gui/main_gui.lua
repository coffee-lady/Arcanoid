local App = require('src.app')
local Components = require('src.systems.game.components.components')

local MainGUI = Components.main_gui

local Factory = {}

function Factory:init()
    MainGUI:new()
end

return Factory
