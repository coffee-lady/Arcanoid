local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local SceneMsgService = SceneServices.msg

local MSG = App.constants.messages
local URL = App.constants.urls
local CO_GROUPS = App.constants.co_groups

local SceneMSG = App.constants.messages.game
local BlockConfig = App.config.game.go.blocks

local Transform = require('src.systems.game.components.block.transform.transform')
local Animations = require('src.systems.game.components.block.animations.animations')
local Logic = require('src.systems.game.components.block.logic.logic')
local View = require('src.systems.game.components.block.view.view')

local BlockComponent = class('Component')

function BlockComponent:initialize(id, data)
    local transform = Transform:new(id, data)
    local animations = Animations:new(id)
    local logic = Logic:new(data)
    local view = View:new(id, data)

    transform:reset()

    SceneMsgService:on(id, MSG.common.collision_response, function(message)
        if message.other_group == hash(CO_GROUPS.balls) then
            logic:decrease_lives()
        end
    end)

    logic.lives_observer:subscribe(function(lives)
        if lives == BlockConfig.leftover_lives_for_cracks then
            animations:animate_cracks()
        end
    end, function()
        animations:animate_breaking()
        view:delete()

        SceneMsgService:post(URL.scenes.game_scene.scene, nil, SceneMSG.block_destructed, {
            id = id,
            pos = view.pos
        })
    end)

    ScreenService.update_observer:subscribe(function()
        transform:reset()
    end)
end

return BlockComponent
