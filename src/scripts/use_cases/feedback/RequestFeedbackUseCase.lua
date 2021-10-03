local App = require('src.app')

local URL = App.constants.urls
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_WAS_FEEDBACK_REQUESTED = DataStorageConfig.keys.was_feedback_requested

--- @class RequestFeedbackUseCase
local RequestFeedbackUseCase = {}

function RequestFeedbackUseCase:update_services(services)
    self.scenes_service = services.scenes_service
    self.player_data_storage = services.player_data_storage
end

function RequestFeedbackUseCase:request_feedback()
    self.player_data_storage:set(FILE, KEY_WAS_FEEDBACK_REQUESTED, true)
end

return RequestFeedbackUseCase
