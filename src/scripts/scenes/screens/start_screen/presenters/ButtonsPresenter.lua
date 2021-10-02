local App = require('src.app')
local GUI = require('gui.gui')
local SceneCommon = require('src.scripts.scenes.screens.start_screen.common.common')

local ButtonsMenu = GUI.ButtonsMenu
local SubscriptionsMap = App.libs.SubscriptionsMap
local Async = App.libs.async

local ButtonsID = App.constants.gui.screens.start_screen.buttons
local URL = App.constants.urls
local MSG = App.constants.msg
local UIConfig = App.config.ui.start_screen

local BUTTON_DISABLING_OPTIONS = {
    inner = true,
    text = false,
}

--- @class ButtonsPresenterStartScreen
local ButtonsPresenter = class('ButtonsPresenter')

function ButtonsPresenter:initialize(context_services, view)
    self.main_buttons = SceneCommon.ControlsMap:get_main_buttons()
    self.secondary_buttons = SceneCommon.ControlsMap:get_secondary_buttons()
    --- @type ViewStartScreen
    self.view = view
end

function ButtonsPresenter:disable_secondary_buttons_in_dev()
    self.secondary_buttons:set_disabled_color_by_id(ButtonsID.game_events, BUTTON_DISABLING_OPTIONS)
    self.secondary_buttons:set_disabled_color_by_id(ButtonsID.daily_tasks, BUTTON_DISABLING_OPTIONS)
end

function ButtonsPresenter:disable_rating_button()
    self.secondary_buttons:set_disabled_color_by_id(ButtonsID.rating_button, BUTTON_DISABLING_OPTIONS)
end

function ButtonsPresenter:show_button_continue()
    self.main_buttons:enable_by_id(ButtonsID.continue_game)
    self.main_buttons:show(ButtonsID.continue_game)
    self.view:update_button_continue_layout()
end

function ButtonsPresenter:hide_button_continue()
    self.main_buttons:disable_by_id(ButtonsID.continue_game)
    self.main_buttons:hide(ButtonsID.continue_game)
end

function ButtonsPresenter:update_main_buttons_layout()
    self.main_buttons:to_vertical_layout({ButtonsID.continue_game, ButtonsID.new_game}, UIConfig.main_buttons_gap):apply()
end

return ButtonsPresenter
