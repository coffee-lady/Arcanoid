local Views = {
    ball = require('src.systems.game.go.views.ball.ball_view'),
    block = require('src.systems.game.go.views.blocks.block_view'),
    wall = require('src.systems.game.go.views.walls.wall_view'),
    platform = require('src.systems.game.go.views.platform.platform_view'),
    losing_zone = require('src.systems.game.go.views.losing_zone.losing_zone_view')
}

return Views
