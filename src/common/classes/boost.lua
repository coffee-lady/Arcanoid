local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local MSG = App.constants.messages
local URL = App.constants.urls
local SceneURLs = URL.scenes.game_scene
local BOOST_FACTORY = SceneURLs.boost_factory
local PROP = App.constants.go_props

local Boost = class('Boost')

function Boost:init()
    if not self.config.falling then
        if self.boost then
            self:boost()
        end

        return
    end

    self.id = factory.create(BOOST_FACTORY, self.pos)

    msg.post(msg.url(nil, self.id, PROP.sprite), PROP.play_animation, {
        id = hash(self.config.icon)
    })

    SceneMsgService:on(self.id, MSG.game.boost_collision, function(message)
        if message.other_id == hash(SceneURLs.platform) then
            if self.boost then
                self:boost()
            end

            self:destroy()
        end
    end)
end

function Boost:destroy()
    go.delete(self.id)
end

return Boost
