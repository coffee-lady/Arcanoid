local App = require('src.app')
local Models = require('src.systems.game.go.models.models')
local Views = require('src.systems.game.go.views.views')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local BlockModelBuilder = Models.block_builder
local BlockViewBuilder = Views.block_builder

local SceneMsgService = SceneServices.msg
local ScreenService = Services.screen
local LevelService = Services.level

local Config = App.config
local URL = App.constants.urls
local CO_GROUPS = App.constants.co_groups
local GameMSG = App.constants.messages.game
local CommonMSG = App.constants.messages.common

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

    SceneMsgService:post(URL.scenes.game_scene.scene, nil, GameMSG.block_destructed, {
        pos = block_view.pos
    })

    self.destroyable_count = self.destroyable_count - 1

    if self.destroyable_count == 0 then
        LevelService:go_to_next_level()
        SceneMsgService:send(nil, GameMSG.winning)
    end
end

function BlocksController:init()
    local level_data = LevelService:get_data()

    self.blocks = {}
    self.blocks_views = {}
    self.destroyable_count = 0

    BlockModelBuilder:build(self.blocks, level_data, BlocksConfig)
    BlockViewBuilder:build(self.blocks, self.blocks_views, level_data, BlocksConfig)

    for i = 1, #self.blocks_views do
        local block = self.blocks[i]
        local block_view = self.blocks_views[i]

        if block.destroyable then
            self.destroyable_count = self.destroyable_count + 1
        end

        SceneMsgService:on(block_view.id, CommonMSG.collision_response, function(message)
            if message.other_group == hash(CO_GROUPS.balls) then
                block:decrease_lives()
            end
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
