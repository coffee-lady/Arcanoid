local App = require('src.app')

local class = App.libs.middleclass

local GameSceneUrls = App.constants.urls.scenes.game_scene

local LosingZoneView = class('LosingZoneView')

function LosingZoneView:initialize(zone)
    self.url = GameSceneUrls.losing_zone
    self.zone = zone

    self.zone.update_observer:subscribe(function()
        self:update_pos()
        self:update_scale()
    end)

    self:update_pos()
end

function LosingZoneView:update_pos()
    go.set_position(self.zone.pos, self.url)
end

function LosingZoneView:update_scale()
    go.set_scale(self.zone.scale, self.url)
end

return LosingZoneView
