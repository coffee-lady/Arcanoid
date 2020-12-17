local App = require('src.app')
local GameServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local Observable = App.libs.event_observation.observable

local GameMsgService = GameServices.msg
local GameSceneUrls = App.constants.urls.scenes.game_scene

local MSG = App.constants.messages.common

local LosingZone = class('LosingZone')

function LosingZone:initialize()
    self.url = GameSceneUrls.losing_zone
    self.triggered_observer = Observable:new()

    GameMsgService:on(self.url, MSG.collision_response, function(message)
        self.triggered_observer:next(message)
    end)
end

return LosingZone
