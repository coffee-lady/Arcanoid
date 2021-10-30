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

    self:set_subscriptions_map({
        [MSG.collision_response] = self.on_collision_response
    })
end

function BlocksController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if self.blocks[go_id] then
        print('block collision!')
    end
end

function BlocksController:init()
    local current_level = self.levels_service:get_current_level()
    local level_height, level_width, level_data = current_level.height, current_level.width, current_level.data

    self.blocks_presenter:update_blocks_metrics(level_height, level_width)

    for i = 1, level_height do
        for j = 1, level_width do
            local block_cell_id = level_data[(i - 1) * level_width + j]
            local id = self.blocks_presenter:create_block(i, j)
            self.blocks[id] = {}
        end
    end
end

return BlocksController
