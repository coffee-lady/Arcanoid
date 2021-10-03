local App = require('src.app')

local Base64 = App.libs.base64
local Array = App.libs.array

local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_PASSED_FEEDS_LEVELS = DataStorageConfig.keys.passed_feeds_levels
local URL = App.constants.urls

--- @class ShowFirstSceneUseCase
local ShowFirstSceneUseCase = class('ShowFirstSceneUseCase')

ShowFirstSceneUseCase.__cparams = {'scenes_service', 'auth_service', 'player_data_storage'}

function ShowFirstSceneUseCase:initialize(scenes_service, auth_service, player_data_storage)
    --- @type ScenesService
    self.scenes_service = scenes_service
    --- @type AuthService
    self.auth_service = auth_service
    --- @type PlayerDataStorage
    self.player_data_storage = player_data_storage
end

function ShowFirstSceneUseCase:show_first_scene()
    -- local payload = self.auth_service:get_url_payload()
    -- local is_debug_payload = false

    -- if payload == 'test' then
    --     if App.config.debug_mode.Feeds then
    --         is_debug_payload = true
    --         payload = Base64.encode('')
    --     else
    --         payload = nil
    --     end
    -- end

    -- if not payload then
    self:_show_start_scene()
    --     return
    -- end

    -- local status, level_to_load = pcall(Base64.decode, payload)

    -- if not status then
    --     self:_show_start_scene()
    -- end

    -- local passed_feeds_levels = self.player_data_storage:get(FILE, KEY_PASSED_FEEDS_LEVELS) or {}

    -- if Array.has(level_to_load, passed_feeds_levels) and not is_debug_payload then
    --     self:_show_start_scene()
    --     return
    -- end

    -- passed_feeds_levels[#passed_feeds_levels + 1] = level_to_load
    -- self.player_data_storage:set(FILE, KEY_PASSED_FEEDS_LEVELS, passed_feeds_levels)

    -- self:_show_game_screen(level_to_load)
end

function ShowFirstSceneUseCase:_show_start_scene()
    self.scenes_service:switch_to_scene(URL.start_scene)
end

function ShowFirstSceneUseCase:_show_game_screen(level_to_load)
    -- self.scenes_service:switch_to_scene(URL.game_screen, {
    --     feed_level = true,
    --     level_to_load = level_to_load,
    --     reset = true,
    -- })
end

return ShowFirstSceneUseCase
