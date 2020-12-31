local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Components = require('src.systems.game.components.components')

local RandomLib = App.libs.random
local MSG = App.constants.messages
local SceneURLs = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.msg
local BOOST_FACTORY = SceneURLs.boost_factory

local Boosts = Components.boosts

local Factory = {}

function Factory:init()
    SceneMsgService:on(SceneURLs.main, MSG.game.blocks_deleted, function(message)
        local Boost = RandomLib.random_with_weights(Boosts)
        local id = factory.create(BOOST_FACTORY, message.pos)

        Boost:new(id, message):init()
    end)
end

return Factory
