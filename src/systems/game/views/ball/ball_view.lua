local App = require('src.app')
local class = App.libs.middleclass

local Services = require('src.services.services')
local ScreenService = Services.screen

local GameServices = require('src.systems.game.services.services')
local GameMsgService = GameServices.msg

local GameSceneUrls = App.constants.urls.scenes.game_scene
local PROP = App.constants.go_props
local GameMSG = App.constants.messages.game
local BallConfig = App.config.game.go.ball

local BallView = class('BallView')

function BallView:initialize()
    self.url = GameSceneUrls.ball
    self.pos = vmath.vector3()
    self.size = go.get(msg.url(nil, self.url, PROP.sprite), PROP.size)

    self:reset()

    GameMsgService:on(hash(self.url), GameMSG.lost_ball, function()
        self:reset()
    end)
end

function BallView:update_speed(speed)
    local url = msg.url(nil, self.url, PROP.collisionobject)

    go.set(url, PROP.linear_velocity, speed)
end

function BallView:reset()
    self:reset_pos()
    self:reset_scale()
end

function BallView:reset_scale()
    local sizes = ScreenService:get_sizes()

    go.set_scale((BallConfig.scale * sizes.y) / self.size.y, self.url)
end

function BallView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + BallConfig.start_rel_pos.x * sizes.x
    self.pos.y = start_coords.y + BallConfig.start_rel_pos.y * sizes.y

    go.set_position(self.pos, self.url)
end

return BallView
