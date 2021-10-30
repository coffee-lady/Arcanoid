local App = require('src.app')
local GO = require('go.go')

local Math = App.libs.math
local Array = App.libs.array

local BlocksConfig = App.config.game.blocks

--- @class BlocksPresenter
local BlocksPresenter = class('BlocksPresenter')

BlocksPresenter.__cparams = {'screen_service', 'levels_service', 'graphics_service'}

function BlocksPresenter:initialize(screen_service, levels_service, graphics_service, view)
    --- @type ScreenService
    self.screen_service = screen_service
    --- @type LevelsService
    self.levels_service = levels_service
    --- @type GraphicsService
    self.graphics_service = graphics_service

    --- @type ViewGameSceneGO
    self.view = view
end

function BlocksPresenter:create_block(i, j)
    local id = self.view:create_block()

    self:update_block_pos(id, i, j)
    self:update_block_scale(id)
    self:_update_block_icon(id, i, j)

    return id
end

function BlocksPresenter:get_block_size(id)
    return self.view:get_block_size(id)
end

function BlocksPresenter:update_block_pos(id, i, j)
    local pos = self:_get_block_pos(i, j)
    self.view:set_block_pos(id, pos)
end

function BlocksPresenter:update_block_scale(id)
    local scale_factor = self:_get_block_scale(id)
    self.view:set_block_scale(id, scale_factor)
end

function BlocksPresenter:update_blocks_metrics(level_height, level_width)
    local start_coords, end_coords = self.screen_service:get_coords()
    local sizes = self.screen_service:get_sizes()

    local side_margin = BlocksConfig.side_margin * sizes.x
    local top_margin = BlocksConfig.top_margin * sizes.y
    self.gap = BlocksConfig.gap * (sizes.x - side_margin * 2) / level_width
    self.block_length = (sizes.x - side_margin * 2 - self.gap * (level_width - 1)) / level_width

    self.start_pos = vmath.vector3()
    self.start_pos.x = start_coords.x + side_margin + self.block_length / 2
    self.start_pos.y = end_coords.y - top_margin - self.block_length / 2

    self.level_height, self.level_width = level_height, level_width
end

function BlocksPresenter:destruct_block(id)
    self.view:animate_block_destruction(id)
end

function BlocksPresenter:update_blocks_icons(level_icons_indexes)
    --- @type UISetConfig
    local ui_set_config = self.graphics_service:get_ui_config()
    local icons_count = ui_set_config.game.blocks.icons_count

    self.level_icons_indexes = level_icons_indexes
    self.icons_indexes = {}

    for i = 1, #level_icons_indexes do
        local level_icon_index = level_icons_indexes[i]
        if not self.icons_indexes[level_icon_index] then
            self:_set_random_icon_index(level_icon_index, icons_count)
        end
    end
end

function BlocksPresenter:_set_random_icon_index(level_icon_index, icons_count)
    local icon_index
    repeat
        icon_index = math.random(icons_count)
    until not Array.has(icon_index, self.icons_indexes)
    self.icons_indexes[level_icon_index] = icon_index
end

function BlocksPresenter:_update_block_icon(id, i, j)
    local block_index = (i - 1) * self.level_width + j
    local icon_index = self.icons_indexes[self.level_icons_indexes[block_index]]
    local icon = self.graphics_service:get_block_icon(icon_index)
    self.view:set_block_image(id, icon)
end

function BlocksPresenter:_get_block_pos(i, j)
    local pos = vmath.vector3()

    pos.x = self.start_pos.x + (j - 1) * self.block_length + (j - 1) * self.gap
    pos.y = self.start_pos.y - (i - 1) * self.block_length - (i - 1) * self.gap

    return pos
end

function BlocksPresenter:_get_block_scale(id)
    local scale = self.block_length / self:get_block_size(id).x
    return scale
end

return BlocksPresenter
