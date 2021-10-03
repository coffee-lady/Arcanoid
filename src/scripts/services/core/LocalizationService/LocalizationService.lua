local App = require('src.app')
local ResourcesStorage = require('src.libs.resources_storage.resources_storage')
local Config = require('src.scripts.config.config')

local Notifier = App.libs.notifier

local MSG = App.constants.msg
local ResourcesConfig = App.config.resources
local DataStorageConfig = App.config.data_storage
local FILE = DataStorageConfig.file
local KEY_LANG = DataStorageConfig.keys.lang

local function replace_vars(str, vars)
    if not vars then
        vars = str
    end

    return (string.gsub(str, '({([^}]+)})', function(whole, key)
        return vars[key] or whole
    end))
end

--- @class LocalizationService
local LocalizationService = class('LocalizationService')

LocalizationService.__cparams = {'player_data_storage', 'global_gui_caller_service', 'auth_service'}

function LocalizationService:initialize(player_data_storage, global_gui_caller_service, auth_service)
    self.global_gui_caller_service = global_gui_caller_service
    self.player_data_storage = player_data_storage
    self.auth_service = auth_service

    self.notifier = Notifier(MSG.localization.language_changed)

    self.global_gui_caller_service:set_callback(MSG.localization._lang_changed, function()
        self.notifier:emit()
    end)

    self:_check_current_lang()
end

function LocalizationService:on_authorized()
    self:_check_current_lang()
end

function LocalizationService:_check_current_lang()
    local user_lang = self.auth_service:get_env_lang()
    self.lang = self.player_data_storage:get(FILE, KEY_LANG) or user_lang

    self:change_lang(self.lang)
end

function LocalizationService:subscribe()
    self.notifier:subscribe()
end

function LocalizationService:unsubscribe()
    self.notifier:unsubscribe()
end

function LocalizationService:get_language()
    return self.lang
end

function LocalizationService:get_localization_path()
    return string.format(ResourcesConfig.localization, self.lang)
end

function LocalizationService:change_lang(lang)
    self.lang = lang

    local path = self:get_localization_path()
    self.data = ResourcesStorage:get_json_data(path)

    self.player_data_storage:set(FILE, KEY_LANG, self.lang)
    self.global_gui_caller_service:call(MSG.localization._lang_changed)
    self:_run_web_change_lang()
end

function LocalizationService:_run_web_change_lang()
    if html5 then
        html5.run('changeLang("' .. self.lang .. '");')
    end
end

local function get_localized_table(data, vars)
    local result = {}

    for node_id, str in pairs(data) do
        if type(str) == 'table' then
            result[node_id] = get_localized_table(str, vars)
        else
            result[node_id] = replace_vars(str, vars)
        end
    end

    return result
end

function LocalizationService:get_localized_text(key, vars)
    if type(self.data[key]) == 'string' then
        return replace_vars(self.data[key], vars)
    end

    return get_localized_table(self.data[key], vars)
end

return LocalizationService
