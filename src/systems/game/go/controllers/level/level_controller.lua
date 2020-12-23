local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Models = require('src.systems.game.go.models.models')

local SceneMsgService = SceneServices.msg
local MSG = App.constants.messages

local Level = Models.level

local SUBSCRIPTION = 'LevelController'

local LevelController = {}

function LevelController:init()
    self.level = Level:new()

    SceneMsgService:on(SUBSCRIPTION, MSG.game.winning, function()
        self.level:next()
    end)
end

function LevelController:get_data()
    return self.level:get_data()
end

return LevelController
