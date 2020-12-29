local App = require('src.app')
local SceneServices = require('src.systems.game.services.services')
local Components = require('src.systems.game.components.components')

local SceneUrls = App.constants.urls.scenes.game_scene
local SceneMsgService = SceneServices.msg
local MSG = App.constants.messages
local SceneMSG = MSG.game

local Ball = Components.ball

local Factory = {}

function Factory:init()
    local balls_count = 1

    local id = factory.create(SceneUrls.ball_factory)
    Ball:new(id)

    SceneMsgService:on(SceneUrls.main, SceneMSG.add_balls, function(message)
        for _ = 1, message.count do
            local new_id = factory.create(SceneUrls.ball_factory)
            Ball:new(new_id, message.pos)
        end

        balls_count = balls_count + message.count
    end)

    SceneMsgService:on(SceneUrls.main, SceneMSG.lost_ball, function(message)
        local message_id
        balls_count = balls_count - 1

        if balls_count >= 1 then
            message_id = SceneMSG.delete_ball
        else
            message_id = SceneMSG.reset_ball
            balls_count = 1

            SceneMsgService:post(SceneUrls.gui, nil, SceneMSG.decrease_lives)
        end

        SceneMsgService:send(message.ball_id, message_id)
    end)
end

return Factory
