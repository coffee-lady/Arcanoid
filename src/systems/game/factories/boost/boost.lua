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
    local f = false
    SceneMsgService:on(SceneUrls.main, MSG.game.blocks_deleted, function(message)
        local boost = RandomLib.random_with_weights(Boosts)

        boost:init(message, blocks)
    end)
end

return Factory
