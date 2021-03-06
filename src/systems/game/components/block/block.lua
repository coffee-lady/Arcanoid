local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Services = require('src.services.services')

local class = App.libs.middleclass
local ScreenService = Services.screen
local SceneMsgService = SceneServices.msg

local MSG = App.constants.messages
local URL = App.constants.urls
local CO_GROUPS = App.constants.co_groups
local SceneURLs = URL.scenes.game_scene

local SceneMSG = App.constants.messages.game
local BlockConfig = App.config.game.go.blocks

local Transform = require('src.systems.game.components.block.transform.transform')
local Animations = require('src.systems.game.components.block.animations.animations')
local Physics = require('src.systems.game.components.block.physics.physics')
local Logic = require('src.systems.game.components.block.logic.logic')
local View = require('src.systems.game.components.block.view.view')

local function unsubscribe(self)
    for i = 1, #self.subs do
        self.subs[i]:unsubscribe()
    end
end

local BlockComponent = class('Component')

function BlockComponent:initialize(id, data)
    self.transform = Transform:new(id, data)
    self.animations = Animations:new(id, data)
    self.physics = Physics:new(id)
    self.logic = Logic:new(data)
    self.view = View:new(id, data)

    self.subs = {}
    self.id = id
    self.data = data
    self.type = data.sprite
    self.fragile = false

    self.transform:reset()

    self.subs[#self.subs + 1] = SceneMsgService:on(id, MSG.common.collision_response, function(message)
        if message.other_group == hash(CO_GROUPS.balls) then
            self.logic:decrease_lives()
            self.last_ball_id = message.other_id
        end
    end)

    self.subs[#self.subs + 1] = ScreenService.update_observer:subscribe(
                                    function()
            self.transform:reset()
        end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneURLs.main, SceneMSG.fire_balls, function()
        if not self.data.destroyable and not BlockConfig.destroy_granite then
            return
        end

        if self.fragile then
            return
        end

        self.physics:switch_co()
        self.logic:make_fragile()
        self.fragile = true
    end)

    self.subs[#self.subs + 1] = SceneMsgService:on(SceneURLs.main, SceneMSG.put_out_balls, function()
        if not self.data.destroyable and not BlockConfig.destroy_granite then
            return
        end

        if not self.fragile then
            return
        end

        self.physics:switch_co()
        self.logic:recover_from_fragility()
        self.fragile = false
    end)

    self.logic.lives_observer:subscribe(function(lives)
        if lives == BlockConfig.leftover_lives_for_cracks then
            self.animations:animate_cracks()
        end
    end, function()
        self:destroy()
    end)

    SceneMsgService:on(id, SceneMSG.damage_block, function(message)
        self.logic:decrease_lives(message.damage)
    end)

    SceneMsgService:on(id, SceneMSG.destroy_block, function()
        self:destroy()
    end)

    SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.losing, function()
        unsubscribe(self)

    end)

    SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.winning, function()
        unsubscribe(self)
    end)

    SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.restart, function()
        unsubscribe(self)
    end)
end

function BlockComponent:is_destroyable()
    return self.data.destroyable
end

function BlockComponent:destroy()
    if self.destroyed then
        return
    end

    self.destroyed = true

    if not self.data.destroyable and not BlockConfig.destroy_granite then
        return
    end

    self.animations:animate_breaking()
    self.view:delete()

    SceneMsgService:post(URL.scenes.game_scene.scene, nil, SceneMSG.block_destructed, {
        id = self.id,
        pos = self.transform.pos,
        length = self.transform.length,
        height = self.transform.height,
        ball = self.last_ball_id,
        destroyable = self.data.destroyable,
        boost = self.data.boost
    })

    unsubscribe(self)
end

return BlockComponent
