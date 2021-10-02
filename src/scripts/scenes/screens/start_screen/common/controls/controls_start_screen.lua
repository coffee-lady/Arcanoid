local App = require('src.app')
local GUI = require('gui.gui')

local ButtonsMenu = GUI.ButtonsMenu
local SubscriptionsMap = App.libs.SubscriptionsMap
local Async = App.libs.async

local ButtonsID = App.constants.gui.screens.start_screen.buttons
local URL = App.constants.urls
local MSG = App.constants.msg
local UIConfig = App.config.ui.start_screen

local Controls = {}

function Controls:init(context_services)
    self.progress_service = context_services.progress_service
    --- @type ScenesService
    self.scenes_service = context_services.scenes_service
    self.auth_service = context_services.auth_service
    --- @type LeaderboardsService
    self.leaderboards_service = context_services.leaderboards_service

    self.secondary_buttons = ButtonsMenu(context_services, {
        [ButtonsID.game_events] = function()
            self.scenes_service:switch_to_scene(URL.unavailable_feature_popup)
        end,

        [ButtonsID.daily_tasks] = function()
            self.scenes_service:switch_to_scene(URL.unavailable_feature_popup)
        end,

        [ButtonsID.rating_button] = function()
            if not self.leaderboards_service:is_available() then
                self.scenes_service:switch_to_scene(URL.rating_unlock_popup)
                return
            end

            if not self.auth_service:is_authorized() then
                self.scenes_service:switch_to_scene(URL.inter_auth_offer_popup, {
                    next_scene = URL.rating_popup,
                })
                return
            end

            self.scenes_service:switch_to_scene(URL.rating_popup)
        end,
    })

    local is_there_prev_game = self.progress_service:get_previous_game_data() ~= nil

    self.main_buttons = ButtonsMenu(context_services, {
        [ButtonsID.continue_game] = function()
            self.scenes_service:switch_to_scene(URL.game_screen, {
                restore = true,
            })
        end,

        [ButtonsID.new_game] = function()
            self.scenes_service:switch_to_scene(URL.difficulty_popup, {
                progress_will_be_lost = is_there_prev_game,
            })
        end,
    })
end

function Controls:get_secondary_buttons()
    return self.secondary_buttons
end

function Controls:get_main_buttons()
    return self.main_buttons
end

return Controls
