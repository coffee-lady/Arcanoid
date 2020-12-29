local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Components = require('src.systems.game.components.components')

local MSG = App.constants.messages
local SceneUrls = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.msg

local Boosts = Components.boosts

local Factory = {}

function Factory:init(blocks)
    local flag = false

    SceneMsgService:on(SceneUrls.main, MSG.game.blocks_deleted, function(message)
        -- if not flag then
        --    Boosts.simple_bomb:init(message, blocks)
        --    flag = true
        -- end

        -- local index = math.random(1, #Boosts)
        -- Boosts[index]:init(message, blocks)
    end)
end

return Factory
