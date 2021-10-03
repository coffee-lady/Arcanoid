local App = require('src.app')
local JSAPI = require('src.scripts.include.js.js')
local Services = require('src.scripts.services.services')
local AuthBootstrap = require('src.scripts.scenes.bootstrap.common.auth_bootstrap')
local AdsBootstrap = require('src.scripts.scenes.bootstrap.common.ads_bootstrap')
local StoreBootstrap = require('src.scripts.scenes.bootstrap.common.store_bootstrap')
local JSEventsBootstrap = require('src.scripts.scenes.bootstrap.common.js_events_bootstrap')

local URL = App.constants.urls
local MSG = App.constants.msg
local Langs = App.config.localization.langs

local ForkJoin = App.libs.event_observation.fork_join
local ColorLib = App.libs.color
local Luject = App.libs.luject

local BootstrapGUI = class('BootstrapGUI')

BootstrapGUI.__cparams = {'event_bus', 'scenes_service', 'screen_service', 'auth_service', 'ui_service', 'localization_service', 'global_gui_caller_service', 'local_storage',
                          'progress_service', 'use_case_show_first_scene'}

function BootstrapGUI:initialize(event_bus, scenes_service, screen_service, auth_service, ui_service, localization_service, global_gui_caller_service, local_storage,
    progress_service, use_case_show_first_scene)
    self.event_bus = event_bus
    self.scenes_service = scenes_service
    self.screen_service = screen_service
    self.auth_service = auth_service
    self.ui_service = ui_service
    self.localization_service = localization_service
    self.global_gui_caller_service = global_gui_caller_service
    self.local_storage = local_storage
    self.progress_service = progress_service
    self.use_case_show_first_scene = use_case_show_first_scene

    msg.post('.', MSG.acquire_input_focus)

    math.randomseed(os.time())
    ColorLib.convert_v4_theme(App.config.ui.themes)

    JSAPI.init(self.event_bus)

    Luject:resolve_class(AuthBootstrap)
    self.ads_bootstrap = Luject:resolve_class(AdsBootstrap)
    Luject:resolve_class(StoreBootstrap)
    Luject:resolve_class(JSEventsBootstrap)

    self.auth_service:subscribe()
    self.ui_service:subscribe()
    self.localization_service:subscribe()
    self.scenes_service:subscribe()

    if self.scenes_service.init_observer.completed then
        self:initialize_game()
    else
        self.scenes_service.init_observer:subscribe(nil, function()
            self:initialize_game()
        end)
    end
end

function BootstrapGUI:initialize_game()
    self.ads_bootstrap:on_game_initialized()

    if html5 then
        html5.run('loadGame();');
    end

    self.use_case_show_first_scene:show_first_scene()
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
