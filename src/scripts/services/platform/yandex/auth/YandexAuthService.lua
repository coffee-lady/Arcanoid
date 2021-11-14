local App = require('src.app')
local YandexAdapter = require('src.scripts.include.yandex.yandex')

local UserEntity = App.entities.UserEntity
local YandexAuth = YandexAdapter.YandexAuth
local Notifier = App.libs.notifier

local MSG = App.constants.msg
local IMAGES_URL = App.config.images_url

--- @class AuthService
local YandexAuthService = class('YandexAuthService')

YandexAuthService.__cparams = {'global_gui_caller_service'}

YandexAuthService.IMAGE_SIZE = YandexAuth.IMAGE_SIZE

function YandexAuthService:initialize(global_gui_caller_service)
    self.global_gui_caller_service = global_gui_caller_service
    self.success_auth_notifier = Notifier(MSG.auth.success_auth)
    self.auth_attempt_notifier = Notifier(MSG.auth.auth_attempt)

    self.yandex_auth = YandexAuth()

    self.global_gui_caller_service:set_callback(
        MSG.auth._success_emit_msg,
        function()
            self.success_auth_notifier:emit()
        end
    )

    self.global_gui_caller_service:set_callback(
        MSG.auth._attempt_emit_msg,
        function(data)
            self.auth_attempt_notifier:emit(data)
        end
    )

    local is_authorized = self.yandex_auth:init_async()
    if is_authorized then
        self:_set_current_user_data()
    end
end

function YandexAuthService:on_authenticate(cb)
    self._on_authenticate = cb
end

function YandexAuthService:on_auth_error(cb)
    self._on_auth_error = cb
end

function YandexAuthService:subscribe()
    self.success_auth_notifier:subscribe()
    self.auth_attempt_notifier:subscribe()
end

function YandexAuthService:unsubscribe()
    self.success_auth_notifier:unsubscribe()
    self.auth_attempt_notifier:unsubscribe()
end

function YandexAuthService:authenticate()
    local _on_success_auth = function()
        self:_set_current_user_data()

        if self._on_authenticate then
            self._on_authenticate()
        end

        self.global_gui_caller_service:call(
            MSG.auth._attempt_emit_msg,
            {
                success = true
            }
        )
        self.global_gui_caller_service:call(MSG.auth._success_emit_msg)
    end

    local _on_auth_fail = function()
        if self._on_auth_error then
            self._on_auth_error()
        end
        self.global_gui_caller_service:call(
            MSG.auth._attempt_emit_msg,
            {
                success = false
            }
        )
    end

    self.yandex_auth:authenticate(_on_success_auth, _on_auth_fail)
end

function YandexAuthService:_set_current_user_data()
    local photo, photo_url = self.yandex_auth:get_current_user_photo_async(IMAGES_URL)
    self.user =
        UserEntity(
        {
            id = self.yandex_auth:get_user_id(),
            name = self.yandex_auth:get_user_name(),
            photo = photo,
            photo_url = photo_url,
            lang = self.yandex_auth:get_environment().i18n.lang
        }
    )
end

function YandexAuthService:is_authorized()
    return self.yandex_auth:is_authorized()
end

--- @return UserEntityPlain
function YandexAuthService:get_user()
    return self.user and self.user:get_plain_data() or nil
end

function YandexAuthService:get_env_lang()
    -- return  self.yandex_auth:get_environment().i18n.lang
    return 'en'
end

function YandexAuthService:get_url_payload()
    return self.yandex_auth:get_environment().payload
end

return YandexAuthService
