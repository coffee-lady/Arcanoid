local Constants = require('src.scripts.constants.constants')

local CommonConfig = {
    themes = require('src.scripts.config.common.themes.themes'),
    dummy_data = require('src.scripts.config.common.dummy_data.dummy_data'),
    ui = require('src.scripts.config.common.ui.ui'),
    localization = require('src.scripts.config.common.localization.localization'),
    bundle = require('src.scripts.config.common.bundle.bundle_config'),
    nakama = require('src.scripts.config.common.nakama.nakama_config'),
    server = require('src.scripts.config.common.server.server_config'),

    static_config = {
        yandex = {
            prod_config_url = 'https://static.openmygame.com/defold_games/yandex/sudoku_master/sdi_config.json',
            test_config_url = 'https://static.openmygame.com/defold_games/yandex/sudoku_master/sdi_config_test.json',
        },
        ok = {
            prod_config_url = 'https://static.openmygame.com/instant/ok/sdi/sdi_config.json',
            test_config_url = 'https://static.openmygame.com/instant/ok/sdi/sdi_config.json',
        },
    },

    images_url = 'https://openmygame.com/get-image.php?url=',

    debug_mode = {
        PlatformService = false,
        AuthService = false,
        PaymentsService = false,
        StoreService = false,
        PlayerDataStorage = false,
        RewardedAdsService = true,
        RewardedAdsAlgorithm = true,
        InterstitialAdsService = true,
        BannerAdsService = false,
        PaymentsCatalog = false,
        SoundService = false,
        NakamaAdapter = false,
        LeaderboardsService = false,
        HintsService = false,
        FeedbackService = false,
        FeedbackLocalVersion = false,
        Feeds = false,
    },

    platforms = {
        yandex = 'yandex',
        ok = 'ok',
        debug = 'debug',
    },

    platform = 'yandex',

    app = {
        default_theme = 'light',
        themes = {{
            key = 'light',
            color = 'FBFAFF',
        }, {
            key = 'dark',
            color = '3A3D42',
        }, {
            key = 'green',
            color = '9FC856',
        }, {
            key = 'yellow',
            color = 'F4C637',
        }, {
            key = 'blue',
            color = '4DAAF4',
        }},

        file = 'user_data',
        keys = {
            theme = 'theme',
            lang = 'lang',
            is_sound_disabled = 'is_sound_disabled',

            learn_fact_cycle = 'learn_fact_cycle',
            learn_facts_pointer = 'learning_facts_pointer',
            interest_facts_pointer = 'interest_facts_pointer',
            last_victory_text_index = 'last_victory_text_index',

            rank_index = 'rank_index',
            rank_points = 'rank_points',
            mastery_timer_started = 'mastery_timer_started',

            statistics = 'statistics',
            levels_passed = 'levels_passed',
            last_loaded_puzzle = 'last_loaded_puzzle',
            prev_game_data = 'prev_game_data',

            show_auth_offer = 'show_auth_offer',
            is_first_short_ad = 'is_first_short_ad',

            interstitial_timer = 'interstitial_timer',
            rewarded_timer = 'rewarded_timer',

            purchase_item_offer_timer = 'purchase_item_offer_timer_',

            free_hints_count = 'free_hints_count',
            paid_hints_count = 'paid_hints_count',
            paid_canceling_errors_count = 'paid_canceling_errors_count',

            interstitial_view_count = 'interstitial_view_count',
            last_starter_pack_offer_time = 'last_starter_pack_offer_time',

            wallet_to_sync = 'wallet_to_sync',

            last_loaded_player_leaderboard_info = 'last_loaded_player_leaderboard_info',
            was_feedback_requested = 'was_feedback_requested',
            was_leaderboards_tutorial_shown = 'was_leaderboards_tutorial_shown',

            additional_mastery_points = 'additional_mastery_points',
            passed_feeds_levels = 'passed_feeds_levels',
        },

        file_temp = {
            filename = 'temp',
            keys = {
                data_version = 'data_version',
            },
        },
    },

    resources = {
        levels = '/main/resources/levels/',
        localization = '/main/resources/localization/',
        format = '.json',
    },

    facts = {
        frequency_learning = 2,
        types = {
            LEARNING = 1,
            INTERESTING = 2,
        },
    },

    render_order = {
        game_screen = 1,

        defeat_popup = 2,
        victory_screen = 2,
        pause_popup = 2,

        start_screen = 3,

        stats_screen = 4,
        store_screen = 4,
        help_screen = 4,

        difficulty_popup = 5,

        rating_popup = 6,
        rating_help_popup = 7,
        rating_unlock_popup = 7,

        starter_pack_offer_popup = 6,

        post_purchase_popup = 7,
        purchase_auth_popup = 7,
        rate_game_popup = 7,

        reward_rate_game_popup = 8,
        feature_popups = 8,

        warning_popups = 9,
        error_popups = 10,
        mastery_popup = 11,
    },

    data_saving = {
        game_screen = {
            timer_interval = 10,
        },
    },

    auth_offer = {
        level_start = 1,
        level_increment = 1,
    },

    payments_items_keys = {
        canceling_errors = 'canceling_errors',
        hints = 'hints',
        all_themes = 'all_themes',
        no_ads = 'no_ads',
    },

    payments_not_consumable_items_keys = {
        all_themes = 'all_themes',
        no_ads = 'no_ads',
    },
}

local URL = Constants.urls
local POPUP_SOUND = Constants.sounds.popup

CommonConfig.sounds = {
    popups = {
        [hash(URL.difficulty_popup)] = POPUP_SOUND.sound_popup_difficulty,
        [hash(URL.defeat_popup)] = POPUP_SOUND.sound_popup_game_end,

        [hash(URL.mastery_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.unavailable_feature_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.auth_error_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.purchase_auth_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.tabs_warning_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.auth_offer_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.ads_error_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.short_ad_preview_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.starter_pack_offer_popup)] = POPUP_SOUND.sound_popup_notification,
        [hash(URL.post_purchase_popup)] = POPUP_SOUND.sound_popup_notification,
    },
}

return CommonConfig
