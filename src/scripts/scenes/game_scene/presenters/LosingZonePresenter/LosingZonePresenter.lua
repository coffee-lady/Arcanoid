local App = require('src.app')

local LosingZoneConfig = App.config.game.losing_zone

--- @class LosingZonePresenter
local LosingZonePresenter = class('LosingZonePresenter')

LosingZonePresenter.__cparams = {'screen_service'}

function LosingZonePresenter:initialize(screen_service)
    --- @type ScreenService
    self.screen_service = screen_service
end

function LosingZonePresenter:get_zone_pos()
    local pos = vmath.vector3()
    local sizes = self.screen_service:get_sizes()
    local start_coords = self.screen_service:get_coords()

    pos.x = start_coords.x + sizes.x / 2
    pos.y = start_coords.y + sizes.y * LosingZoneConfig.bottom_margin

    return pos
end

return LosingZonePresenter
