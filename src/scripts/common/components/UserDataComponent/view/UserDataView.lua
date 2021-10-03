local App = require('src.app')

local TextKeys = App.constants.localization.keys
local PlatformUIConfig = App.config.ui.platform

local LKEY_ANON_USERNAME = TextKeys.username_anonymous

local Async = App.libs.async

local WHITE = vmath.vector3(1, 1, 1)
local EMPTY_STR = ''
local DEFAULT_SETTINGS = {
    default_user_name_key = nil,
}

local UserDataView = class('UserDataView')

function UserDataView:initialize(context_services, nodes, ui_config, settings)
    self.auth_service = context_services.auth_service
    self.localization = context_services.localization
    self.ui_service = context_services.ui_service

    self.text_node = nodes.text_node
    self.icon_node = nodes.icon_node
    self.icon_bg_node = nodes.icon_bg_node
    self.ui_config = ui_config

    self.settings = settings or DEFAULT_SETTINGS

    self:init()
end

function UserDataView:init()
    self.icon_node:set_image(PlatformUIConfig.platform_icon)

    self:update()
end

function UserDataView:update()
    self:update_username()
    self:update_user_photo()
end

function UserDataView:update_username()
    local username = self:get_user_name() or self:get_default_username()

    if not username then
        return
    end

    self.text_node:set_text(username)
end

function UserDataView:get_default_username()
    if not self.settings.default_user_name_key then
        return nil
    end

    return self.localization:get_localized_text(self.settings.default_user_name_key)
end

function UserDataView:get_user_name()
    if not self.auth_service:is_authorized() then
        return nil
    end

    local username = self.auth_service:get_user().name

    if username == EMPTY_STR or not username then
        username = self.localization:get_localized_text(LKEY_ANON_USERNAME)
    end

    return username
end

function UserDataView:update_user_photo()
    if self.auth_service:is_authorized() then
        self:_set_user_photo()
    else
        self:_set_platform_logo()
    end

    self.icon_node:set_size_xy(self.ui_config.user_icon_sizes.x, self.ui_config.user_icon_sizes.y)
end

function UserDataView:_set_user_photo()
    local user = self.auth_service:get_user()
    local buffer, url = user.photo, user.photo_url
    local user_icon_node = self.icon_node
    user_icon_node:set_new_texture(url, buffer)
    user_icon_node:set_color(WHITE)
end

function UserDataView:_set_platform_logo()
    local user_icon_node = self.icon_node
    local scene_colors = self.ui_service:get_scene_colors()
    local logo_colors = scene_colors.platform_logo[App.config.platform]

    user_icon_node:set_color(logo_colors.icon)
    user_icon_node:set_image(PlatformUIConfig.platform_icon)

    if self.icon_bg_node then
        self.icon_bg_node:set_color(logo_colors.bg)
    end
end

return UserDataView
