local App = require('src.app')
local GO = require('go.go')
local BallView = require('src.scripts.scenes.game_scene.view.BallView.BallView')

local SceneView = App.libs.scenes.SceneView

local ID = App.constants.gui.screens.game_scene

--- @class ViewGameSceneGO : SceneView
local ViewGameSceneGO = class('ViewGameSceneGO', SceneView)

function ViewGameSceneGO:initialize(UIMaps)
    SceneView.initialize(self, UIMaps)

    self.balls_views = {}
end

function ViewGameSceneGO:create_ball(settings)
    local id = self.nodes.balls_factory:create(settings)
    local view = BallView(id)

    self.balls_views[id] = view

    return id
end

function ViewGameSceneGO:get_ball_size(id)
    return self.balls_views[id]:get_size()
end

function ViewGameSceneGO:set_ball_scale(id, scale_factor)
    self.balls_views[id]:set_scale(scale_factor)
end

function ViewGameSceneGO:set_ball_pos(id, pos)
    self.balls_views[id]:set_pos(pos)
end

function ViewGameSceneGO:set_ball_speed(id, speed)
    self.balls_views[id]:set_speed(speed)
end

function ViewGameSceneGO:delete_ball(id)
    self.balls_views[id]:delete()
end

return ViewGameSceneGO
