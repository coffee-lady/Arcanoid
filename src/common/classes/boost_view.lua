local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local class = App.libs.middleclass

local SceneMsgService = SceneServices.msg

local MSG = App.constants.messages
local URL = App.constants.urls
local GameSceneURLs = URL.scenes.game_scene
local BOOST_FACTORY = GameSceneURLs.boost_factory
local PROP = App.constants.go_props

local Boost = class('Boost')

function Boost:initialize(pos, config, boost)
    if not config.falling then
        if boost then
            boost()
        end
        return
    end

    self.id = factory.create(BOOST_FACTORY, pos)

    msg.post(msg.url(nil, self.id, PROP.sprite), PROP.play_animation, {
        id = hash(config.icon)
    })

    SceneMsgService:on(self.id, MSG.game.boost_collision, function(message)
        if message.other_id == hash(GameSceneURLs.platform) then
            if boost then
                boost()
            end
            go.delete(self.id)
        end
    end)
end

return Boost
