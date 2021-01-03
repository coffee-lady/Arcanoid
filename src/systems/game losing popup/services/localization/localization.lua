local App = require('src.app')
local Localization = require('src.common.classes.localization')
local MsgService = require('src.systems.game losing popup.services.msg.gui_msg')

local Services = require('src.services.services')
local MSG = App.constants.messages
local EnergyService = Services.energy

local SCENE_URL = App.constants.urls.scenes.game_losing_popup.main

local MINUTE = 60
local thandler, subs

local LocalizationService = Localization:new(SCENE_URL, MsgService, {
    init = function(self)
        subs = MsgService:on(SCENE_URL, MSG.common.energy_updated, function()
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
        energy_recovery_left_time = EnergyService:get_minutes_left(),
        life_cost = EnergyService:get_life_cost()
    }
end

return LocalizationService

