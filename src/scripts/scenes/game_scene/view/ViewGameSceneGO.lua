local App = require('src.app')
local GO = require('go.go')
local BallView = require('src.scripts.scenes.game_scene.view.BallView.BallView')
local BlockView = require('src.scripts.scenes.game_scene.view.BlockView.BlockView')
local PlatformView = require('src.scripts.scenes.game_scene.view.PlatformView.PlatformView')

local SceneView = App.libs.scenes.SceneView

local ID = App.constants.gui.screens.game_scene

--- @class ViewGameSceneGO : SceneView
local ViewGameSceneGO = class('ViewGameSceneGO', SceneView)

function ViewGameSceneGO:initialize(UIMaps)
    SceneView.initialize(self, UIMaps)

    self.platform_view = PlatformView()
    self.balls_views = {}
    self.blocks_views = {}
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

function ViewGameSceneGO:set_wall_pos(key, pos)
    self.nodes.walls[key]:set_pos(pos)
end

function ViewGameSceneGO:set_losing_zone_pos(pos)
    self.nodes.losing_zone:set_pos(pos)
end

function ViewGameSceneGO:get_platform_size()
    return self.platform_view:get_size()
end

function ViewGameSceneGO:set_platform_scale(scale_factor)
    self.platform_view:set_scale(scale_factor)
end

function ViewGameSceneGO:get_platform_scale()
    return self.platform_view:get_scale()
end

function ViewGameSceneGO:set_platform_pos(pos)
    self.platform_view:set_pos(pos)
end

function ViewGameSceneGO:get_platform_pos()
    return self.platform_view:get_pos()
end

function ViewGameSceneGO:animate_platform_pos(pos)
    self.platform_view:animate_pos(pos)
end

function ViewGameSceneGO:delete_platform()
    self.platform_view:delete()
end

function ViewGameSceneGO:create_block(settings)
    local id = self.nodes.blocks_factory:create(settings)
    local view = BlockView(id)

    self.blocks_views[id] = view

    view:hide_cracks()
    view:set_kinematic_collision()

    return id
end

function BlockView:show_block_cracks(id)
    self.blocks_views[id]:show_block_cracks()
end

function BlockView:hide_block_cracks(id)
    self.blocks_views[id]:hide_block_cracks()
end

function BlockView:set_block_kinematic_collision(id)
    self.blocks_views[id]:set_block_kinematic_collision()
end

function BlockView:set_block_trigger_collision(id)
    self.blocks_views[id]:set_block_trigger_collision()
end

function ViewGameSceneGO:get_block_size(id)
    return self.blocks_views[id]:get_size()
end

function ViewGameSceneGO:set_block_scale(id, scale_factor)
    self.blocks_views[id]:set_scale(scale_factor)
end

function ViewGameSceneGO:set_block_pos(id, pos)
    self.blocks_views[id]:set_pos(pos)
end

function ViewGameSceneGO:delete_block(id)
    self.blocks_views[id]:delete()
end

return ViewGameSceneGO
