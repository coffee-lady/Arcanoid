local App = require('src.app')
local ShowLeaderboardsUseCase = require('src.scripts.use_cases.leaderboards.ShowLeaderboardsUseCase')

local URL = App.constants.urls
local MSG = App.constants.msg
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local DELAY = App.config.ui.rating_help_popup_delay
local KEY_WAS_TUTORIAL_SHOWN = FilesConfig.keys.was_leaderboards_tutorial_shown

--- @class ShowLeaderboardsTutorialUseCase
local ShowLeaderboardsTutorialUseCase = {}

function ShowLeaderboardsTutorialUseCase:update_services(services)
    self.player_data_storage = services.player_data_storage
    self.scenes_service = services.scenes_service
    self.global_gui_caller_service = services.global_gui_caller_service
end

function ShowLeaderboardsTutorialUseCase:set_global_callbacks()
    self.global_gui_caller_service:set_callback(MSG.leaderboards._show_leaderboards_tutorial, function()
        self.scenes_service:switch_to_scene_delayed(DELAY, URL.rating_help_popup, {
            hide_rating_button = false,
        })
    end)
end

function ShowLeaderboardsTutorialUseCase:show_tutorial()
    if not self:is_available() then
        return false
    end

    self.player_data_storage:set(FILE, KEY_WAS_TUTORIAL_SHOWN, true)
    self.global_gui_caller_service:call(MSG.leaderboards._show_leaderboards_tutorial)
    return true
end

function ShowLeaderboardsTutorialUseCase:is_available()
    local was_tutorial_shown = self.player_data_storage:get(FILE, KEY_WAS_TUTORIAL_SHOWN)
    return ShowLeaderboardsUseCase:is_available() and not was_tutorial_shown
end

return ShowLeaderboardsTutorialUseCase
