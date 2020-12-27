local Factories = {
    ball = require('src.systems.game.factories.ball.ball'),
    block = require('src.systems.game.factories.block.block'),
    wall = require('src.systems.game.factories.wall.wall'),
    life = require('src.systems.game.factories.life.life'),
    losing_zone = require('src.systems.game.factories.losing_zone.losing_zone'),
    platform = require('src.systems.game.factories.platform.platform')
}

return Factories
