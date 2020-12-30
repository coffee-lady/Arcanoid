local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Components = require('src.systems.game.components.components')

local RandomLib = App.libs.random
local MSG = App.constants.messages
local SceneUrls = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.msg

local Boosts = Components.boosts

local Factory = {}

function Factory:init(blocks)
    SceneMsgService:on(SceneUrls.main, MSG.game.blocks_deleted, function(message)
        local Boost = RandomLib.random_with_weights(Boosts)

        Boost:new(message, blocks):init()
    end)
end

return Factory
