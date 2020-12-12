local Models = require('src.systems.game.models.models')
local Views = require('src.systems.game.views.views')

local Platform = Models.platform
local PlatformView = Views.platform

local PlatformController = {}

function PlatformController:init()
    self.platform = Platform:new()
    self.platform_view = PlatformView:new(self.platform)
end

function PlatformController:on_input(action_id, action)
    if action_id == hash('click') then
        self.platform_view:on_moving_platform(action)
    end
end

return PlatformController
