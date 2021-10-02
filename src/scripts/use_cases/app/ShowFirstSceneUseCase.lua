local App = require('src.app')

local Base64 = App.libs.base64
local Array = App.libs.array

local FilesConfig = App.config.app
local FILE = FilesConfig.file
local KEY_PASSED_FEEDS_LEVELS = FilesConfig.keys.passed_feeds_levels
local URL = App.constants.urls
local INITIAL_DELAY = App.config.ui.transitions.init_delay

local ShowFirstSceneUseCase = {}

function ShowFirstSceneUseCase:update_services(services)
    self.scenes_service = services.scenes_service
    self.auth_service = services.auth_service
    --- @type PuzzleLoaderService
    self.puzzle_loader_service = services.puzzle_loader_service
    self.player_data_storage = services.player_data_storage
end

function ShowFirstSceneUseCase:show_first_scene()
    local payload = self.auth_service:get_url_payload()
    local is_debug_payload = false

    if payload == 'test' then
        if App.config.debug_mode.Feeds then
            is_debug_payload = true
            payload = Base64.encode('174309825963208714285401936852000693000000000639000471528704369417603258396502147')
        else
            payload = nil
        end
    end

    if not payload then
        self:_show_start_screen()
        return
    end

    local status, level_to_load = pcall(Base64.decode, payload)

    if not status then
        self:_show_start_screen()
    end

    if not self.puzzle_loader_service.is_valid_level_str(level_to_load) then
        self:_show_start_screen()
        return
    end

    local passed_feeds_levels = self.player_data_storage:get(FILE, KEY_PASSED_FEEDS_LEVELS) or {}

    if Array.has(level_to_load, passed_feeds_levels) and not is_debug_payload then
        self:_show_start_screen()
        return
    end

    passed_feeds_levels[#passed_feeds_levels + 1] = level_to_load
    self.player_data_storage:set(FILE, KEY_PASSED_FEEDS_LEVELS, passed_feeds_levels)

    self:_show_game_screen(level_to_load)
end

function ShowFirstSceneUseCase:_show_start_screen()
    self.scenes_service:switch_to_scene_delayed(INITIAL_DELAY, URL.start_screen)
end

function ShowFirstSceneUseCase:_show_game_screen(level_to_load)
    self.scenes_service:switch_to_scene_delayed(INITIAL_DELAY, URL.game_screen, {
        feed_level = true,
        level_to_load = level_to_load,
        reset = true,
    })
end

return ShowFirstSceneUseCase
