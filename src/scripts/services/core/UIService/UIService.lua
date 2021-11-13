local App = require('src.app')
local GUI = require('gui.gui')
local ScenesService = require('src.scripts.services.core.ScenesService.ScenesService')

local Themes = App.config.ui.themes
local ThemesArray = App.config.ui.available_themes
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_THEME = DataStorageConfig.keys.theme

local BootstrapID = App.constants.gui.screens.bootstrap
local DEFAULT_THEME = App.config.ui.default_theme
local MSG = App.constants.msg

local BoxNode = GUI.BoxNode
local Notifier = App.libs.notifier
local ColorLib = App.libs.color

local DEFAULT_UNLOCKED_THEMES = {
    light = true,
    dark = true
}

--- @class UIService
local UIService = class('UIService')

UIService.__cparams = {'player_data_storage', 'event_bus_gui', 'global_gui_caller_service', 'scenes_service'}

UIService.MSG_THEME_CHANGED = MSG.themes.theme_changed

function UIService:initialize(player_data_storage, event_bus, global_gui_caller_service, scenes_service)
    self.player_data_storage = player_data_storage
    self.global_gui_caller_service = global_gui_caller_service
    self.scenes_service = scenes_service

    self.unlocked_all = false
    self.theme_changed_notifier = Notifier(MSG.themes.theme_changed)
    self.themes_unlocked_notifier = Notifier(MSG.themes.all_unlocked)

    self:_convert_themes()
    self:_set_global_callers()
    self:set_current_user_theme()
end

function UIService:_set_global_callers()
    self.global_gui_caller_service:set_callback(
        MSG.themes._theme_changed_emit,
        function()
            -- BoxNode(BootstrapID.container):set_color(self.theme_colors.common.background)
            self.theme_changed_notifier:emit()
        end
    )

    self.global_gui_caller_service:set_callback(
        MSG.themes._unlocked_emit_msg,
        function()
            self.themes_unlocked_notifier:emit()
        end
    )
end

function UIService:_convert_themes()
    for i = 1, #ThemesArray do
        local item = ThemesArray[i]
        ThemesArray[i].color = ColorLib.to_vector4(item.color)
    end
end

function UIService:on_authorized()
    if self.is_on_preview_theme then
        return
    end
    self:set_current_user_theme()
end

function UIService:set_current_user_theme()
    local theme_key = self.player_data_storage:get(FILE, KEY_THEME)
    self:change_theme(theme_key)
end

function UIService:unlock_all_themes()
    self.unlocked_all = true
    self.global_gui_caller_service:call(MSG.themes._unlocked_emit_msg)
end

function UIService:is_unlocked_theme(theme_key)
    return self.unlocked_all and true or DEFAULT_UNLOCKED_THEMES[theme_key]
end

function UIService:_load_theme(theme)
    self.theme_key = theme or DEFAULT_THEME
    self.theme_colors = Themes[self.theme_key]
end

function UIService:subscribe()
    self.theme_changed_notifier:subscribe()
    self.themes_unlocked_notifier:subscribe()
end

function UIService:unsubscribe()
    self.theme_changed_notifier:unsubscribe()
    self.themes_unlocked_notifier:unsubscribe()
end

function UIService:change_theme(theme_key)
    self.is_on_preview_theme = false
    self.player_data_storage:set(FILE, KEY_THEME, theme_key)
    self:_load_theme(theme_key)
    self:_run_web_change_theme(true)
    self.global_gui_caller_service:call(MSG.themes._theme_changed_emit)
end

function UIService:change_theme_without_saving(theme_key)
    self.is_on_preview_theme = true
    self:_load_theme(theme_key)
    self:_run_web_change_theme(false)
    self.global_gui_caller_service:call(MSG.themes._theme_changed_emit)
end

function UIService:_run_web_change_theme(is_saving)
    if html5 then
        html5.run('changeTheme("' .. self.theme_key .. '", ' .. tostring(is_saving) .. ');')
    end
end

function UIService:on_theme_changed()
    -- BoxNode(BootstrapID.container):set_color(self.theme_colors.common.background)
end

function UIService:get_theme()
    return self.theme_colors
end

function UIService:get_theme_key()
    return self.theme_key
end

function UIService:get_common_colors()
    return self.theme_colors.common
end

function UIService:get_common_pallettes()
    return self.theme_colors.common_pallettes
end

function UIService:get_scene_colors(scene_id)
    local current_scene = scene_id or self.scenes_service:get_current_scene()
    for key, colors in pairs(self.theme_colors) do
        if hash(key) == current_scene then
            return colors
        end
    end
end

return UIService
