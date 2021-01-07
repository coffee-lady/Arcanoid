local App = require('src.app')
local Localization = require('src.common.classes.localization')
local Services = require('src.services.services')
local MsgService = require('src.systems.pack selection scene.services.msg.gui_msg_service')
local MSG = App.constants.messages

local LevelService = Services.level
local EnergyService = Services.energy

local SCENE_URL = App.constants.urls.scenes.pack_selection_scene.main
local ENERGY_CONTAINER = App.constants.urls.gui_nodes.pack_selection_scene.text.energy_container_left

local MINUTE = 60
local thandler, subs

local LocalizationService = Localization:new(SCENE_URL, MsgService, {
    init = function(self)
        subs = MsgService:on(SCENE_URL, MSG.common.energy_updated, function()
            self:update()
        end)

        thandler = timer.delay(MINUTE, true, function()
            self:update()
            timer.cancel(thandler)
        end)
    end,
    final = function()

        subs:unsubscribe()
    end
})

function LocalizationService:get_vars()
    local min_left, sec_left = EnergyService:get_time_left()

    if min_left == 0 and sec_left == 0 then
        self:remove(ENERGY_CONTAINER)

    end

    return {
        current_level = LevelService:get_progress_level(),
        current_pack = LevelService:get_current_pack().title,
        current_energy = EnergyService:get_current_energy(),
        max_energy = EnergyService:get_max_energy(),
        min_left = min_left < 10 and '0' .. min_left or min_left,
        sec_left = sec_left < 10 and '0' .. sec_left or sec_left
    }
end

return LocalizationService
