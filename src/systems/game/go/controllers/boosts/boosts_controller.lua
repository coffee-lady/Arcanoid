local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local SceneMsgService = SceneServices.msg

local LifeBoostCtrl = require('src.systems.game.go.controllers.boosts.lives.boost_life')

local BoostsConfig = App.config.game.boosts
local MSG = App.constants.messages

local SUBSCRIPTION = 'BoostsController'

local BoostsController = {}

function BoostsController:init()
    local boosts_controllers = {}

    SceneMsgService:on(SUBSCRIPTION, MSG.game.block_destructed, function(message)
        LifeBoostCtrl:init(message.pos)
    end)
end

return BoostsController
