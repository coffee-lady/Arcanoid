local App = require('src.app')
local Models = require('src.systems.game.go.models.models')
local Views = require('src.systems.game.go.views.views')
local Services = require('src.services.services')
local GameServices = require('src.systems.game.services.services')

local BlockModelBuilder = Models.block_builder
local BlockViewBuilder = Views.block_builder

local SceneMsgService = GameServices.msg
local ScreenService = Services.screen

local Config = App.config
local MSG = App.constants.messages.common

local BlocksConfig = Config.game.go.blocks

local BlocksController = {}

local function on_broken_block(self, block_view)
    for j = 1, #self.blocks do
        if self.blocks_views[j].id == block_view.id then
            table.remove(self.blocks, j)
            table.remove(self.blocks_views, j)
            break
        end
    end
    block_view:delete()
end

function BlocksController:build(level_data)
    self.blocks = {}
    self.blocks_views = {}

    BlockModelBuilder:build(self.blocks, level_data, BlocksConfig)
    BlockViewBuilder:build(self.blocks, self.blocks_views, level_data, BlocksConfig)

    for i = 1, #self.blocks_views do
        local block = self.blocks[i]
        local block_view = self.blocks_views[i]

        SceneMsgService:on(block_view.id, MSG.collision_response, function()
            block:decrease_lives()
        end)

        block.lives_observer:subscribe(function(lives)
            block_view:on_lives_decreasing(lives)
        end, function()
            on_broken_block(self, block_view)
        end)
    end

    ScreenService.update_observer:subscribe(function()
        BlockViewBuilder:rebuild(self.blocks_views)
    end)
end

return BlocksController
