local App = require('src.app')
local GameServices = require('src.systems.game.services.services')
local class = App.libs.middleclass

local Config = App.config
local Observable = App.libs.event_observation.observable

local GameMsgService = GameServices.msg

local LivesConfig = Config.game.player.lives
local GameMSG = App.constants.messages.game

local SUBSCRIPTION_URL = 'LivesModel'

local Lives = class('LivesModel')

function Lives:initialize()
    self.count = LivesConfig.count
    self.increase_observer = Observable:new()
    self.decrease_observer = Observable:new()

    GameMsgService:on(SUBSCRIPTION_URL, GameMSG.lost_ball, function()
        self:decrease()
    end)
end

function Lives:increase()
    if self.count == LivesConfig.count then
        return
    end
    self.count = self.count + 1
    self.increase_observer:next(self.count)
end

function Lives:decrease()
    if self.count == 0 then
        return
    end
    self.count = self.count - 1
    self.decrease_observer:next(self.count)
end

return Lives
