local App = require('src.app')
local SceneMsgService = require('src.systems.game.services.msg.msg')

local URL = App.constants.urls
local MSG = App.constants.messages

local BallsData = {}

function BallsData:init()
    self.fired = false

    SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.fire_balls, function()
        self.fired = true
        print('true')
    end)

    SceneMsgService:on(URL.scenes.game_scene.main, MSG.game.put_out_balls, function()
        self.fired = false
        print('false')
    end)
end

function BallsData:is_fired()
    return self.fired
end

return BallsData
