local App = require('src.app')
local Controllers = require('src.scripts.common.controllers.controllers')

local MSG = App.constants.msg

local BootstrapGO = {}

function BootstrapGO:init(app_installer)
    app_installer:init()
    app_installer:install(self)

    self.event_bus:on(MSG.game_loaded, self.on_game_loaded, self)
end

function BootstrapGO:update(dt)
    if not self.is_initted then
        return
    end

    self.sound_service:update(dt)
end

function BootstrapGO:on_message(message_id, message)
    self.global_go_caller_service:_bootstrap_on(message_id, message)
    self.event_bus:emit(message_id, message)
end

function BootstrapGO:on_game_loaded()
    self.is_initted = true

    self.scenes_service:subscribe()
    self.scenes_service:add_listener(msg.url())

    self.global_go_caller_service:init(self.scenes_service)
    self.sound_service:init(self.global_go_caller_service, self.player_data_storage)

    Controllers.SoundsController(self)
end

return BootstrapGO
