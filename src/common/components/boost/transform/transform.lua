local App = require('src.app')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local LevelService = Services.level

local BoostConfig = App.config.game.boosts
local PROP = App.constants.go_props

local Transform = class('Transform')

function Transform:initialize(id)
    self.id = id
    self.size = go.get(msg.url(nil, self.id, PROP.sprite), PROP.size)
end

function Transform:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function Transform:reset_scale()
    local sizes = ScreenService:get_sizes()
    local grid_sizes = LevelService:get_data().sizes

    local scale_factor = (BoostConfig.scale * sizes.x / grid_sizes.x) / self.size.x

    self:set_scale(scale_factor)
end

return Transform
