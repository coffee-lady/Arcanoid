local App = require('src.app')
local Localization = require('src.common.classes.localization')
local MsgService = require('src.systems.start scene.services.msg.gui_msg_service')

local Services = require('src.services.services')
local EnergyService = Services.energy
local MSG = App.constants.messages
local URL = App.constants.urls

local MINUTE = 60

local SCENE_URL = App.constants.urls.scenes.start_scene.main

local thandler, subs

local LocalizationService = Localization:new(SCENE_URL, MsgService, {
    init = function(self)
        subs = MsgService:on(URL.scenes.start_scene.main, MSG.common.energy_updated, function()
            self:update()
        end)

        thandler = timer.delay(MINUTE, true, function()
            self:update()
        end)
    end,
    final = function()
        timer.cancel(thandler)
        subs:unsubscribe()
    end
})

function LocalizationService:get_vars()
    return {
        current_energy = EnergyService:get_current_energy(),
        max_energy = EnergyService:get_max_energy(),
        energy_recovery_left_time = EnergyService:get_minutes_left()
    }
end

return LocalizationService
