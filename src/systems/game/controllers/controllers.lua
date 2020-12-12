local GameControllers = {
    ball = require('src.systems.game.controllers.ball.ball_controller'),
    blocks = require('src.systems.game.controllers.blocks.blocks_controller'),
    walls = require('src.systems.game.controllers.walls.wall_controller'),
    platform = require('src.systems.game.controllers.platform.platform_controller')
}

return GameControllers
