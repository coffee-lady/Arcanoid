local Services = {
    msg = require('src.systems.game.services.msg.msg'),
    gui_msg = require('src.systems.game.services.msg.gui_msg'),
    localization = require('src.systems.game.services.localization.localization'),
    blocks_data = require('src.systems.game.services.blocks_data.blocks_data'),
    boosts_data = require('src.systems.game.services.boosts_data.boosts_data'),
    shared_data = require('src.systems.game.services.shared_data.shared_data')
}

return Services
