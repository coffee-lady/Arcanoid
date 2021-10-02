local App = require('src.app')

local URL = App.constants.urls
local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_WAS_FEEDBACK_REQUESTED = FilesConfig.keys.was_feedback_requested

--- @class RequestFeedbackUseCase
local RequestFeedbackUseCase = {}

function RequestFeedbackUseCase:update_services(services)
    self.scenes_service = services.scenes_service
    self.player_data_storage = services.player_data_storage
end

function RequestFeedbackUseCase:request_feedback()
    self.player_data_storage:set(FILE, KEY_WAS_FEEDBACK_REQUESTED, true)
    self.scenes_service:switch_to_scene_delayed(App.config.ui.feedback_popup_delay, URL.rate_game_popup)
end

return RequestFeedbackUseCase
