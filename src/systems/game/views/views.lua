local GameViews = {
    ball = require('src.systems.game.views.ball.ball_view'),
    block = require('src.systems.game.views.blocks.block_view'),
    wall = require('src.systems.game.views.walls.wall_view'),
    platform = require('src.systems.game.views.platform.platform_view'),
    lives = require('src.systems.game.views.lives.lives_view')
}

return GameViews
