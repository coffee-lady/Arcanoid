local App = require('src.app')
local Services = require('src.services.services')
local GameServices = require('src.systems.game.services.services')

local ScreenService = Services.screen

local class = App.libs.middleclass
local LosingZoneConfig = App.config.game.go.losing_zone
local Observable = App.libs.event_observation.observable

local GameSceneUrls = App.constants.urls.scenes.game_scene

local GameMsgService = GameServices.msg

local MSG = App.constants.messages.game

local LosingZone = class('LosingZone')

function LosingZone:initialize()
    self.url = GameSceneUrls.losing_zone
    self.pos = vmath.vector3()
    self.sizes = ScreenService:get_sizes()

    self.update_observer = Observable:new()
    self.triggered_observer = Observable:new()

    GameMsgService:on(self.url, MSG.trigger_response, function(message)
        self.triggered_observer:next(message)
    end)

    ScreenService.update_observer:subscribe(function()
        self:update()
    end)

    self:update()
end

function LosingZone:update()
    self:update_pos()
    self:update_scale()
    self.update_observer:next()
end

function LosingZone:update_scale()
    local sizes = ScreenService:get_sizes()

    local scale_factor = sizes.x / self.sizes.x
    self.scale = vmath.vector3(scale_factor, scale_factor, scale_factor)
end

function LosingZone:update_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * LosingZoneConfig.bottom_padding
end

return LosingZone
