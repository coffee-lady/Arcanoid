local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local BlocksConfig = App.config.game.blocks

--- @class BlocksController : SceneController
local BlocksController = class('BlocksController', SceneController)

BlocksController.__cparams = {'event_bus_go', 'levels_service', 'screen_service'}

function BlocksController:initialize(event_bus, levels_service, screen_service, presenters)
    SceneController.initialize(self, event_bus)

    --- @type LevelsService
    self.levels_service = levels_service
    --- @type ScreenService
    self.screen_service = screen_service

    --- @type BlocksPresenter
    self.blocks_presenter = presenters.blocks_presenter
    self.blocks = {}

    self:set_subscriptions_map({})
end

function BlocksController:init()
    local current_level = self.levels_service:get_current_level()
    local level_height, level_width, level_data = current_level.height, current_level.width, current_level.data

    print(inspect(current_level))

    local start_coords, end_coords = self.screen_service:get_coords()
    local sizes = self.screen_service:get_sizes()

    local side_margin = BlocksConfig.side_margin * sizes.x
    local top_margin = BlocksConfig.top_margin * sizes.y
    local gap = BlocksConfig.gap * (sizes.x - side_margin * 2) / level_width
    local block_length = (sizes.x - side_margin * 2 - gap * (level_width - 1)) / level_width
    local start_pos = vmath.vector3()
    start_pos.x = start_coords.x + side_margin + block_length / 2
    start_pos.y = end_coords.y - top_margin - block_length / 2

    for i = 1, level_height do
        for j = 1, level_width do
            local block_cell_id = level_data[(i - 1) * level_width + j]
            local id = self.blocks_presenter:create_block()
            self.blocks[id] = {}

            local pos = vmath.vector3()
            pos.x = start_pos.x + (j - 1) * block_length + (j - 1) * gap
            pos.y = start_pos.y - (i - 1) * block_length - (i - 1) * gap

            local scale = block_length / self.blocks_presenter:get_block_size(id).x

            self.blocks_presenter:set_block_pos(id, pos)
            self.blocks_presenter:set_block_scale(id, scale)
        end
    end
end

return BlocksController
