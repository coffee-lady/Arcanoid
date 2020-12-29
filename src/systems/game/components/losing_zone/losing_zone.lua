local App = require('src.app')
local Services = require('src.services.services')
local SceneServices = require('src.systems.game.services.services')

local class = App.libs.middleclass
local MSG = App.constants.messages
local CO_GROUPS = App.constants.co_groups

local SceneMsgService = SceneServices.msg
local ScreenService = Services.screen

local SceneMSG = App.constants.messages.game
local SceneUrls = App.constants.urls.scenes.game_scene

local Transform = require('src.systems.game.components.losing_zone.transform.transform')

local LosingZoneComponent = class('Component')

function LosingZoneComponent:initialize(id)
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
                ball_id = message.other_id
            })
            SceneMsgService:post(SceneUrls.gui, nil, SceneMSG.lost_ball)
        end
    end)
end

return LosingZoneComponent
