local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local MSG = App.constants.messages
local URL = App.constants.urls
local SceneURLs = URL.scenes.game_scene

local Animations = require('src.common.components.boost.animations.animations')
local Transform = require('src.common.components.boost.transform.transform')
local View = require('src.common.components.boost.view.view')

local Component = class('Component')

function Component:initialize(id, config)
    self.animations = Animations:new(id)
    self.view = View:new(id, config)
    self.transform = Transform:new(id, config)

    self.id = id
    self.config = config

    self.transform:reset_scale()
end

function Component:init()
    if not self.config.falling then
        if self.boost then
            self:boost()
        end

        self:destroy()
        return
    end

    self.animations:play():exec(function()
        self:destroy()
    end)

    SceneMsgService:on(self.id, MSG.game.boost_collision, function(message)
        if message.other_id == hash(SceneURLs.platform) then
            if self.boost then
                self:boost()
            end

            self.animations:cancel()
            self:destroy()
        end
    end)
end

function Component:destroy()
    self.view:destroy()
end

return Component
