local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')

local SceneURLs = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.gui_msg
local SceneMSG = App.constants.messages.game

local Logic = require('src.systems.game.factories.life.logic.logic')
local View = require('src.systems.game.factories.life.view.view')

local function increase_lives(self)
    self.logic:increase_lives(function(count)
        self.nodes[count]:activate()
    end)
end

local function decrease_lives(self)
    self.logic:decrease_lives(function(count)
        self.nodes[count + 1]:deactivate()
    end)
end

local Factory = {}

function Factory:init()
    self.nodes = {}

    View:new(self.nodes)
    self.logic = Logic:new(self.nodes)

    SceneMsgService:on(SceneURLs.gui, SceneMSG.increase_lives, function()
        increase_lives(self)
    end)

    SceneMsgService:on(SceneURLs.gui, SceneMSG.decrease_lives, function()
        decrease_lives(self)
    end)
end

return Factory
