local App = require('src.app')
local UseCases = require('src.scripts.use_cases.use_cases')
local JSAPI = require('src.scripts.include.js.js')
local Services = require('src.scripts.common.services.services')
local AuthBootstrap = require('src.scripts.scenes.bootstrap.common.auth_bootstrap')
local AdsBootstrap = require('src.scripts.scenes.bootstrap.common.ads_bootstrap')
local AnalyticsBootstrap = require('src.scripts.scenes.bootstrap.common.analytics_bootstrap')
local StoreBootstrap = require('src.scripts.scenes.bootstrap.common.store_bootstrap')
local JSEventsBootstrap = require('src.scripts.scenes.bootstrap.common.js_events_bootstrap')
local AppInstaller = require('src.scripts.app_installer.app_installer')

local URL = App.constants.urls
local MSG = App.constants.msg
local Langs = App.config.localization.langs
local INITIAL_DELAY = App.config.ui.transitions.init_delay

local ForkJoin = App.libs.event_observation.fork_join
local Async = App.libs.async
local ColorLib = App.libs.color
local CurrencyLib = App.libs.currency
local SubscriptionsMap = App.libs.SubscriptionsMap

local ConfigService = Services.ConfigService

sys.set_error_handler(function(source, message, traceback)
    if html5 then
        traceback = traceback or debug.traceback()
        html5.run(string.format('logError("%s");', tostring(message)))
    end
end)

local BootstrapGUI = {}

function BootstrapGUI:init(app_installer)
    app_installer:init()
    app_installer:install(self)

    AppInstaller:init(app_installer)

    msg.post('.', MSG.acquire_input_focus)

    math.randomseed(os.time())
    ColorLib.convert_v4_theme(App.config.themes)

    self.global_gui_caller_service:init(self.scenes_service)

    JSAPI.init(self.event_bus)

    Async.bootstrap(function()
        UseCases.App.ShowFirstSceneUseCase:update_services({
            scenes_service = self.scenes_service,
            auth_service = self.auth_service,
            puzzle_loader_service = self.puzzle_loader_service,
            player_data_storage = self.player_data_storage,
        })

        if not App.config.connect_static_config and not App.config.connect_static_test_config then
            ConfigService:handle()
        else
            ConfigService:init()
        end

        self.local_storage:init(sys.get_config('project.title'))
        self.platform_service:init(self.event_bus)
        AuthBootstrap:init_async(self.event_bus, app_installer)
        self.player_data_storage:init(self.auth_service, self.scenes_service)
        self.ui_service:init(self.player_data_storage, self.event_bus, self.global_gui_caller_service)
        self.progress_service:init(self.player_data_storage, self.leaderboards_service)
        self.ranks_service:init(self.player_data_storage)
        self.stats_service:init(self.player_data_storage)
        self.hints_service:init({
            event_bus = self.event_bus,
            stats_service = self.stats_service,
            player_data_storage = self.player_data_storage,
            ads_service = self.ads_service,
            global_gui_caller_service = self.global_gui_caller_service,
            scenes_service = self.scenes_service,
        })
        self.leaderboards_service:init({
            stats_service = self.stats_service,
            auth_service = self.auth_service,
            player_data_storage = self.player_data_storage,
            global_gui_caller_service = self.global_gui_caller_service,
            scenes_service = self.scenes_service,
        })
        self.feedback_service:init({
            player_data_storage = self.player_data_storage,
            scenes_service = self.scenes_service,
            stats_service = self.stats_service,
            hints_service = self.hints_service,
        })

        self.localization:init(self.player_data_storage, self.global_gui_caller_service, self.auth_service)
        CurrencyLib.set_localization_path(self.localization:get_localization_path())

        AdsBootstrap:init_async(self.event_bus, app_installer)
        AnalyticsBootstrap:init_async(self.event_bus, app_installer)
        StoreBootstrap:init_async(self.event_bus, app_installer)

        self.screen_service:init()
        self.scenes_service:init()

        local init_subs = ForkJoin(self.scenes_service.init_observer, self.screen_service.init_observer)
        init_subs:subscribe(self, self.initialize_game)
    end)

    JSEventsBootstrap:init(self.event_bus, app_installer)

    SubscriptionsMap(self, self.event_bus, {
        [MSG.localization.language_changed] = self.on_language_changed,
    })
end

function BootstrapGUI:initialize_game()
    self.auth_service:subscribe()
    self.ui_service:subscribe()
    self.localization:subscribe()
    self.scenes_service:subscribe()

    AdsBootstrap:on_game_initialized()

    if html5 then
        html5.run('loadGame();');
    end

    UseCases.App.ShowFirstSceneUseCase:show_first_scene()
    self.scenes_service:post_to_go(URL.bootstrap, MSG.game_loaded)
end

function BootstrapGUI:on_language_changed()
    CurrencyLib.set_localization_path(self.localization:get_localization_path())
end

function BootstrapGUI:update(dt)
    self.local_storage:update(dt)
end

function BootstrapGUI:on_message(message_id, message)
    self.scenes_service:on_message(message_id)
    self.screen_service:on_message(message_id)
    self.event_bus:emit(message_id, message)
    self.global_gui_caller_service:_bootstrap_on(message_id, message)
end

function BootstrapGUI:final()
    self.progress_service:save()
    self.local_storage:final()
end

return BootstrapGUI
