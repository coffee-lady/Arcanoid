local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')

local Platform = Models.platform
local PlatformView = Views.platform

local PlatformController = {}

function PlatformController:init()
    self.platform = Platform:new()
    self.platform_view = PlatformView:new(self.platform)
end

return PlatformController
