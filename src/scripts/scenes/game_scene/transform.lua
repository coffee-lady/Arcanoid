local App = require('src.app')

local LevelService = Services.level
local class = App.libs.middleclass
local ScreenService = Services.screen
local BlocksConfig = App.config.game.go.blocks

local Transform = class('Transform')

function Transform:initialize(id, data)
    self.id = id
    self.pos = vmath.vector3()
    self.data = data
end

function Transform:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function Transform:set_pos(pos)
    go.set_position(pos, self.id)
end

function Transform:reset()
    self:set_length()
    self:reset_scale()
    self:reset_pos()
end

function Transform:set_length()
    local level_data = LevelService:get_data()
    local sizes = ScreenService:get_sizes()
    local width = level_data.width

    self.indent = BlocksConfig.indent_between * sizes.x / width
    self.sides_padding = BlocksConfig.sides_padding * sizes.x / width
    local indents_length = 2 * self.sides_padding + (width - 1) * self.indent

    self.length = (sizes.x - indents_length) / width
end

function Transform:get_start_pos()
    local start_coords, end_coords = ScreenService:get_coords()
    local sizes = ScreenService:get_sizes()

    local start = {}

    start.x = start_coords.x + self.sides_padding + self.length / 2
    start.y = end_coords.y - BlocksConfig.top_padding * sizes.y

    return start
end

function Transform:reset_scale()
    local scale_factor = self.length / self.data.default_width
    self.scale = scale_factor

    self.height = self.data.default_height * self.scale

    self:set_scale(scale_factor)
end

function Transform:reset_pos()
    local grid_pos = self.data.grid_pos
    local default_height = self.data.default_height
    local start_pos = self:get_start_pos()

    self.pos.x = start_pos.x + grid_pos.x * self.length + grid_pos.x * self.indent

    local indent_top = default_height * self.scale / 2 + grid_pos.y * default_height * self.scale
    self.pos.y = start_pos.y - indent_top - grid_pos.y * self.indent

    self:set_pos(self.pos)
end

return Transform
