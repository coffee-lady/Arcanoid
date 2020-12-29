local Components = {
    ball = require('src.systems.game.components.ball.ball'),
    block = require('src.systems.game.components.block.block'),
    wall = require('src.systems.game.components.wall.wall'),
    life = require('src.systems.game.components.life.life'),
    platform = require('src.systems.game.components.platform.platform'),
    losing_zone = require('src.systems.game.components.losing_zone.losing_zone'),
    main_gui = require('src.systems.game.components.main_gui.main_gui'),
    boosts = require('src.systems.game.components.boosts.boosts')
}

return Components
