local App = require('src.app')

local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg
local BlocksConfig = App.config.game.blocks

--- @class BlocksController : SceneController
local BlocksController = class('BlocksController', SceneController)

BlocksController.__cparams = {'event_bus_go', 'levels_service', 'screen_service'}

function BlocksController:initialize(event_bus, levels_service, screen_service, presenters, view)
    SceneController.initialize(self, event_bus)

    --- @type LevelsService
    self.levels_service = levels_service
    --- @type ScreenService
    self.screen_service = screen_service

    --- @type BlocksPresenter
    self.blocks_presenter = presenters.blocks_presenter
    --- @type ViewGameSceneGO
    self.view = view
    self.blocks = {}

    self:set_subscriptions_map(
        {
            [MSG.collision_response] = self.on_collision_response
        }
    )
end

function BlocksController:on_collision_response(data)
    local go_id, other_go_id = data.go_id, data.other_id

    if self.blocks[go_id] then
        self:_destruct_block(go_id)
        self.blocks[go_id] = nil
    end
end

function BlocksController:init()
    local current_level = self.levels_service:get_current_level()
    local level_height, level_width, icons_indexes = current_level.height, current_level.width, current_level.data

    self.blocks_presenter:update_blocks_metrics(level_height, level_width)
    self.blocks_presenter:update_blocks_icons(icons_indexes)

    for i = 1, level_height do
        for j = 1, level_width do
            local id = self:_create_block(i, j)
            self.blocks[id] = {}
        end
    end
end

function BlocksController:_create_block(i, j)
    local id = self.view:create_block()

    self:_update_block_pos(id, i, j)
    self:_update_block_scale(id)
    self:_update_block_icon(id, i, j)

    return id
end

function BlocksController:_update_block_pos(id, i, j)
    local pos = self.blocks_presenter:get_block_pos(i, j)
    self.view:set_block_pos(id, pos)
end

function BlocksController:_update_block_scale(id)
    local block_size = self.view:get_block_size(id)
    local scale_factor = self.blocks_presenter:get_block_scale(block_size)
    self.view:set_block_scale(id, scale_factor)
end

function BlocksController:_update_block_icon(id, i, j)
    local icon = self.blocks_presenter:get_block_icon(i, j)
    self.view:set_block_image(id, icon)
end

function BlocksController:_destruct_block(id)
    self.view:animate_block_destruction(id)
end

return BlocksController
