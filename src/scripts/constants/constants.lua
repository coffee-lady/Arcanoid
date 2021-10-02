local Constants = {
    gui = require('src.scripts.constants.gui.gui_constants'),
    sounds = require('src.scripts.constants.sounds.sounds_constants'),
}

Constants.urls = {
    bootstrap = 'bootstrap',
    game_screen = 'game_screen',
    start_screen = 'start_screen',
    defeat_popup = 'defeat_popup',
    victory_screen = 'victory_screen',
    stats_screen = 'stats_screen',
    store_screen = 'store_screen',
    help_screen = 'help_screen',
    settings_screen = 'settings_screen',

    difficulty_popup = 'difficulty_popup',
    pause_popup = 'pause_popup',
    mastery_popup = 'mastery_popup',
    unavailable_feature_popup = 'unavailable_feature_popup',
    auth_error_popup = 'auth_error_popup',
    purchase_auth_popup = 'purchase_auth_popup',
    tabs_warning_popup = 'tabs_warning_popup',
    auth_offer_popup = 'auth_offer_popup',
    ads_error_popup = 'ads_error_popup',
    short_ad_preview_popup = 'short_ad_preview_popup',
    starter_pack_offer_popup = 'starter_pack_offer_popup',
    post_purchase_popup = 'post_purchase_popup',
    data_saving_error_popup = 'data_saving_error_popup',
    inter_auth_offer_popup = 'inter_auth_offer_popup',
    rating_help_popup = 'rating_help_popup',
    rating_popup = 'rating_popup',
    rating_reach_level_popup = 'rating_reach_level_popup',
    rate_game_popup = 'rate_game_popup',
    reward_rate_game_popup = 'reward_rate_game_popup',
    rating_unlock_popup = 'rating_unlock_popup',
}

Constants.msg = {
    acquire_input_focus = hash('acquire_input_focus'),

    screen = {
        resize = hash('_screen_resized'),
    },

    game_loaded = hash('game_loaded'),
    localization_change = hash('localization_change'),

    sounds = {
        _play_sound = hash('_play_sound'),
        _stop_sound = hash('_stop_sound'),
        _pause_sound = hash('_pause_sound'),
    },

    appbars = {
        appbar_button_click = hash('appbar_button_click'),
    },

    popups = {
        popup_closed = hash('popup_closed'),
    },

    add_action = hash('add_action'),
    theme_changed = hash('theme_changed'),
    themes_unlocked = hash('themes_unlocked'),
    undo_action = hash('undo_action'),
    redo_action = hash('redo_action'),

    localization = {
        _lang_changed = hash('_lang_changed'),
        language_changed = hash('language_changed'),
    },

    ads = {
        _resume_interstitial_timer = hash('_ads_resume_int_timer'),
        short_ad_preview = hash('short_ad_preview'),
        close_banner = hash('close_banner'),
        error = hash('ads_error'),
    },

    auth = {
        _success_emit_msg = hash('_auth_success_emit_msg'),
        _attempt_emit_msg = hash('_auth_attempt_emit_msg'),
        auth_attempt = hash('auth_attempt'),
        success_auth = hash('success_auth'),
    },

    themes = {
        _unlocked_emit_msg = hash('_themes_unlocked_emit'),
        _theme_changed_emit = hash('_theme_changed_emit'),
        all_unlocked = hash('themes_unlocked'),
        theme_changed = hash('theme_changed'),
        preview_end = hash('theme_preview_end'),
    },

    actions = {
        add_action = hash('add_action'),
        undo_action = hash('undo_action'),
        redo_action = hash('redo_action'),
        global_paid_canceling_error_applied = hash('global_paid_canceling_error_applied'),
        global_paid_hint_applied = hash('global_paid_hint_applied'),
        global_free_hint_applied = hash('global_free_hint_applied'),
        global_rewarded_hint_applied = hash('global_rewarded_hint_applied'),
    },

    js = {
        save_data = hash('save_data'),
        get_loading_time = hash('get_loading_time'),
        several_tabs_warning = hash('several_tabs_warning'),
        online = hash('online'),
        offline = hash('offline'),
        resize = hash('resize'),
    },

    store = {
        _start_offer_timer = hash('_start_offer_timer'),
        _end_offer_timer = hash('_end_offer_timer'),
        offer_finished = hash('offer_finished'),
        _emit_starter_pack_bought = hash('_emit_starter_pack_bought'),
        starter_pack_bought = hash('starter_pack_bought'),
        promotion_started = hash('promotion_started'),
    },

    game_screen = {
        reset = hash('reset'),
        undo_error = hash('undo_error'),
        errors_count_changed = hash('errors_count_changed'),
        errors_increase = hash('errors_increase'),
        hint_applied = hash('hint_applied'),

        victory = hash('victory'),
        defeat = hash('defeat'),
        pause = hash('pause'),
        continue = hash('continue'),
        game_screen_left = hash('game_screen_left'),

        cells = {
            selection_updated = hash('selection_updated'),
            inserted = hash('cell_inserted'),
            error = hash('cell_error'),
        },

        tool_clicked = hash('tool_clicked'),
        note_clicked = hash('nums_item_clicked'),
        cell_clicked = hash('cell_clicked'),
        cell_right_num_inserted = hash('cell_right_num_inserted'),
        start_wave = hash('start_wave'),
        finish_wave = hash('finish_wave'),
    },

    difficulty_popup = {
        difficulty_clicked = hash('difficulty_clicked'),
    },

    defeat_popup = {
        cancel_error = hash('defeat_popup_cancel_error'),
    },

    rank_widget = {
        animations_finished = hash('rank_widget_animations_finished'),
        star_start_flying = hash('rank_widget_star_start_flying'),
        star_stop_flying = hash('rank_widget_star_stop_flying'),
        icon_scale = hash('rank_widget_icon_scale'),
        icon_change = hash('rank_widget_icon_change'),
        star_change = hash('rank_widget_star_change'),
        progressbar_start = hash('rank_widget_progressbar_start'),
        progressbar_end = hash('rank_widget_progressbar_end'),
    },

    leaderboards = {
        score_updated = hash('leaderboards_score_updated'),
        _emit_score_updated = hash('leaderboards_emit_score_updatedd'),
        _show_leaderboards_tutorial = hash('_show_leaderboards_tutorial'),
    },

    feedback = {
        feedback_close = hash('feedback_close'),
        feedback_accept = hash('feedback_accept'),
    },

    rating_popup = {
        leaderboard_loaded = hash('rating_popup_leaderboard_loaded'),
    },
}

Constants.actions = {
    click = hash('click'),
    key_up = hash('up'),
    key_down = hash('down'),
    key_left = hash('left'),
    key_right = hash('right'),
    key_number = {},
}

for i = 1, 9 do
    Constants.actions.key_number[i] = hash('number_' .. i)
end

return Constants
