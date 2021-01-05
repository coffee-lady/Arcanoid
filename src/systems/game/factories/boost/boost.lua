local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Components = require('src.systems.game.components.components')

local MSG = App.constants.messages
local SceneURLs = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.msg
local BOOST_FACTORY = SceneURLs.boost_factory
local BoostsDataService = SceneServices.boosts_data

local Boosts = Components.boosts

local Factory = {}

function Factory:init()
    local boosts_data = BoostsDataService:get_data()

    SceneMsgService:on(SceneURLs.main, MSG.game.blocks_deleted, function(message)
        if not message.boost then
            return
        end

        local Boost = Boosts[message.boost]
        local id = factory.create(BOOST_FACTORY, message.pos)

        Boost:new(id, message, boosts_data[message.boost]):init()
    end)
end

return Factory
