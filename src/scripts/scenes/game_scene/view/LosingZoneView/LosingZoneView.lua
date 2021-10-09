local App = require('src.app')

local class = App.libs.middleclass
local MSG = App.constants.messages
local CO_GROUPS = App.constants.co_groups

local SceneMsgService = SceneServices.msg
local ScreenService = Services.screen

local SceneMSG = App.constants.messages.game
local SceneUrls = App.constants.urls.scenes.game_scene

local LosingZoneView = class('LosingZoneView')

function LosingZoneView:initialize(id)
    local transform = Transform:new(id)

    transform:reset_pos()
    transform:reset_scale()

    ScreenService.update_observer:subscribe(function()
        transform:reset_pos()
        transform:reset_scale()
    end)

    SceneMsgService:on(id, MSG.common.collision_response, function(message)
        if message.other_group == hash(CO_GROUPS.balls) then
            SceneMsgService:send(nil, SceneMSG.lost_ball, {
                ball_id = message.other_id,
            })
            SceneMsgService:post(SceneUrls.gui, nil, SceneMSG.lost_ball)
        end
    end)
    self.pos = vmath.vector3()
    self.init_screen_sizes = ScreenService:get_sizes()
end

function LosingZoneView:set_scale(scale_factor)
    go.set_scale(scale_factor, self.id)
end

function LosingZoneView:set_pos(pos)
    go.set_position(pos, self.id)
end

function LosingZoneView:reset_pos()
    local sizes = ScreenService:get_sizes()
    local start_coords = ScreenService:get_coords()

    self.pos.x = start_coords.x + sizes.x / 2
    self.pos.y = start_coords.y + sizes.y * LosingZoneConfig.bottom_padding

    self:set_pos(self.pos)
end

function LosingZoneView:reset_scale()
    local sizes = ScreenService:get_sizes()
    local scale_factor = sizes.x / self.init_screen_sizes.x

    self:set_scale(scale_factor)
end

return LosingZoneView
