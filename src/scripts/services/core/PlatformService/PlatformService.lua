local App = require('src.app')

local Debug = App.libs.debug

local Config = App.config

local PlatformService = {}

PlatformService.SYSTEM = {
    DARWIN = 'Darwin',
    LINUX = 'Linux',
    WINDOWS = 'Windows',
    WEB = 'HTML5',
    ANDROID = 'Android',
    IOS = 'iPhone OS',
}

local DEBUG = App.config.debug_mode.PlatformService

function PlatformService:init(event_bus)
    self.debug = Debug('[PlatformService]', DEBUG)

    self.data = {
        app_title = sys.get_config('project.title'),
        app_version = sys.get_config('project.version'),
        system_name = sys.get_sys_info().system_name,
    }

    self:_log_info()

    self.platform:init(event_bus)
end

function PlatformService:set_target_platform_service(platform_service)
    self.platform = platform_service
end

function PlatformService:on_resize()
    self.platform:on_resize()
end

function PlatformService:_log_info()
    local connect_static_config = Config.connect_static_config
    local connect_static_test_config = Config.connect_static_test_config
    local connect_local_test_config = Config.connect_local_test_config

    self.debug:log_html_dump({
        version = sys.get_config('project.version'),
        platform = Config.platform,
        high_dpi = sys.get_config('display.high_dpi'),
        verify_graphics_calls = sys.get_config('graphics.verify_graphics_calls'),
        is_connected_only_local_config = not connect_static_config and not connect_static_test_config,
        is_test_local_config = connect_local_test_config,
        is_prod_local_config = not connect_local_test_config,
        is_test_static_config = connect_static_test_config,
        is_prod_static_config = connect_static_config,
    })
end

function PlatformService:get_app_title()
    return self.data.app_title
end

function PlatformService:get_sys_name()
    return self.data.system_name
end

function PlatformService:get_version()
    return self.data.app_version
end

function PlatformService:on_online()
    self.is_online = true
end

function PlatformService:on_offline()
    self.is_online = false
end

return PlatformService
