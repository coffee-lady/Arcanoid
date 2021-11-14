local App = require('src.app')

local URL = App.constants.urls
local MSG = App.constants.msg
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_WAS_TUTORIAL_SHOWN = DataStorageConfig.keys.was_leaderboards_tutorial_shown

--- @class LeaderboardsTutorialUseCases
local LeaderboardsTutorialUseCases = class('LeaderboardsTutorialUseCases')

LeaderboardsTutorialUseCases.__cparams = {'scenes_service', 'player_data_storage', 'global_gui_caller_service'}

function LeaderboardsTutorialUseCases:initialize(scenes_service, player_data_storage, global_gui_caller_service)
    --- @type ScenesService
    self.scenes_service = scenes_service
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage
    --- @type GlobalGUICallerService
    self.global_gui_caller_service = global_gui_caller_service

    self.global_gui_caller_service:set_callback(
        MSG.leaderboards._show_leaderboards_tutorial,
        function()
        end
    )
end

function LeaderboardsTutorialUseCases:show_tutorial()
    if not self:is_available() then
        return false
    end

    self.player_data_storage:set(FILE, KEY_WAS_TUTORIAL_SHOWN, true)
    self.global_gui_caller_service:call(MSG.leaderboards._show_leaderboards_tutorial)

    return true
end

function LeaderboardsTutorialUseCases:is_available()
    local was_tutorial_shown = self.player_data_storage:get(FILE, KEY_WAS_TUTORIAL_SHOWN)
    return not was_tutorial_shown
end

return LeaderboardsTutorialUseCases
