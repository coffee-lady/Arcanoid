local losing_zone = require "src.systems.game.components.losing_zone.losing_zone"
local Components = {
    ball = require('src.systems.game.components.ball.ball'),
    block = require('src.systems.game.components.block.block'),
    losing_zone = require('src.systems.game.components.losing_zone.losing_zone')
}

return Components
