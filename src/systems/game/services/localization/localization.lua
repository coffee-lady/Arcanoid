local App = require('src.app')
local Localization = require('src.common.classes.localization')
local MsgService = require('src.systems.game.services.msg.gui_msg')

local Services = require('src.services.services')
local EnergyService = Services.energy
local MSG = App.constants.messages

local SCENE_URL = App.constants.urls.scenes.game_scene.main

local SECOND = 1
local subs

local LocalizationService = Localization:new(SCENE_URL, MsgService, {
    init = function(self)
        subs = MsgService:on(SCENE_URL, MSG.common.energy_updated, function()
            self:update()
        end)

        timer.delay(SECOND, true, function()
            self:update()
        end)
    end,
    final = function()
        subs:unsubscribe()
    end
})

function LocalizationService:get_vars()
    return {
        current_energy = EnergyService:get_current_energy(),
        max_energy = EnergyService:get_max_energy()
    }
end

return LocalizationService
