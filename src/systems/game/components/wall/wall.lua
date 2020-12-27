local App = require('src.app')
local Services = require('src.services.services')

local ScreenService = Services.screen
local class = App.libs.middleclass

local Transform = require('src.systems.game.components.wall.transform.transform')

local WallComponent = class('WallComponent')

function WallComponent:initialize(key, id)
    local transform = Transform:new(key, id)

    transform:reset()

    ScreenService.update_observer:subscribe(function()
        transform:reset()
    end)
end

return WallComponent
