local Controllers = {
    boosts = require('src.systems.game.go.controllers.boosts.boosts_controller'),
    walls = require('src.systems.game.go.controllers.walls.wall_controller'),
    platform = require('src.systems.game.go.controllers.platform.platform_controller')
}

return Controllers
