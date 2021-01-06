local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local LifeConfig = App.config.game.go.lives
local SceneURLs = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.msg
local SceneMSG = App.constants.messages.game

local FactoryLogic = class('FactoryLogic')

function FactoryLogic:initialize()
    self.count = LifeConfig.count
end

function FactoryLogic:increase_lives(callback)
    if self.count == LifeConfig.count then
        return
    end

    self.count = self.count + 1

    if callback then
        callback(self.count)
    end
end

function FactoryLogic:decrease_lives(callback)
    if self.count == 0 then
        return
    end

    self.count = self.count - 1

    if callback then
        callback(self.count)
    end

    if self.count == 0 then
        SceneMsgService:post(SceneURLs.scene, nil, SceneMSG.losing)
    end
end

return FactoryLogic
