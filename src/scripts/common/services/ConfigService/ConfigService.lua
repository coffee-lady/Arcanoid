local Libs = require('src.libs.libs')
local Config = require('src.scripts.config.config')

local AuthOfferConfig = Config.auth_offer
local GameConfig = Config.game
local HintsConfig = GameConfig.hints
local DefeatConfig = GameConfig.defeat
local RanksConfig = GameConfig.ranks
local MasteryRanksConfig = GameConfig.ranks.mastery
local Difficulties = Config.game.puzzle.difficulty

local AdsConfig = Config.ads
local IntersAdsConfig = AdsConfig.interstitial
local RewardedAdsConfig = AdsConfig.rewarded
local BannerAdsConfig = AdsConfig.banner
local PaymentsConfig = Config.payments
local LeaderboardsConfig = Config.leaderboards
local FeedbackConfig = Config.feedback

local Async = Libs.async

local StaticConfigs = Config.static_config[Config.platform]
local PROD_CONFIG_URL = StaticConfigs.prod_config_url
local TEST_CONFIG_URL = StaticConfigs.test_config_url
local ERROR_CODE = 400
local STARTER_PACK_UI_ID = 1

local ConfigService = {}

function ConfigService:init()
    self:connect_to_static()
end

function ConfigService:handle()
    for i = 1, #Difficulties do
        Difficulties[i].difficulty_index = i
    end
end

function ConfigService:connect_to_static()
    return Async(function(done)
        local url = Config.connect_static_test_config and TEST_CONFIG_URL or PROD_CONFIG_URL

        http.request(url, 'GET', function(_, _, res)
            if res.status < ERROR_CODE then
                self:replace_with_static_config(res.response)
                self:handle()
            end

            done()
        end)
    end)
end

function ConfigService:replace_with_static_config(res_config)
    if not res_config then
        return
    end

    local status, static_config = pcall(json.decode, res_config)

    if not status then
        pprint('ERROR ConfigService:replace_with_static_config can`t parse config', static_config)
        return
    end

    local difficulty_config = static_config.sdi_difficulty

    if difficulty_config and #difficulty_config > 0 then
        for i = 1, #Difficulties do
            Difficulties[i].points = difficulty_config[i].points
            Difficulties[i].min = difficulty_config[i].min
            Difficulties[i].max = difficulty_config[i].max
        end
    end

    GameConfig.puzzle.max_errors = static_config.sdi_max_mistakes or GameConfig.puzzle.max_errors

    RanksConfig.points = static_config.sdi_rank_points or RanksConfig.points

    if static_config.sdi_mastery then
        local sdi_mastery = static_config.sdi_mastery

        MasteryRanksConfig.start_mastery = sdi_mastery.start_mastery or MasteryRanksConfig.start_mastery
        MasteryRanksConfig.decrease_points = sdi_mastery.decrease_points or MasteryRanksConfig.decrease_points
        MasteryRanksConfig.decrease_minutes = sdi_mastery.decrease_minutes or MasteryRanksConfig.decrease_minutes
        MasteryRanksConfig.points = sdi_mastery['100pc_points'] or MasteryRanksConfig.points
        MasteryRanksConfig.max_points = sdi_mastery.max_points or MasteryRanksConfig.max_points
    end

    DefeatConfig.max_errors = static_config.sdi_max_mistakes or DefeatConfig.max_errors
    DefeatConfig.lives_for_ad = static_config.sdi_hp_add or DefeatConfig.lives_for_ad

    local speed_test_config = GameConfig.speed_test
    speed_test_config.cycles = static_config.sdi_test_lvl_generator_cycles or speed_test_config.cycles

    Config.facts.frequency_learning = static_config.sdi_tutorial_fact_frequency or Config.facts.frequency_learning

    AuthOfferConfig.level_start = static_config.sdi_auth_dialog_lvl_start or Config.auth_offer.level_start
    AuthOfferConfig.level_increment = static_config.sdi_auth_dialog_lvl_increment or Config.auth_offer.level_increment

    local ads = static_config.ad_config

    if ads then
        local interstitial = ads.interstitial
        local rewarded = ads.rewarded
        local banner = ads.banner

        if interstitial then
            IntersAdsConfig.start_level = interstitial.start_level or IntersAdsConfig.start_level
            IntersAdsConfig.prob_end_game = interstitial.prob_end_game or IntersAdsConfig.prob_end_game
            IntersAdsConfig.prob_start_game = interstitial.prob_start_game or IntersAdsConfig.prob_start_game
            IntersAdsConfig.delay = interstitial.delay or IntersAdsConfig.delay
        end

        if rewarded then
            RewardedAdsConfig.start_level = rewarded.start_level or RewardedAdsConfig.start_level
            RewardedAdsConfig.video_ad_prob = rewarded.video_ad_prob or RewardedAdsConfig.video_ad_prob
            RewardedAdsConfig.delay = rewarded.delay or RewardedAdsConfig.delay
        end

        if banner then
            BannerAdsConfig.start_level = banner.start_level or BannerAdsConfig.start_level
            BannerAdsConfig.block_id = banner.block_id or BannerAdsConfig.block_id
            BannerAdsConfig.reload_time = banner.reload_time or BannerAdsConfig.reload_time
            BannerAdsConfig.visible = banner.visible or BannerAdsConfig.visible
        end
    end

    HintsConfig.free.count = static_config.sdi_free_hint_number or HintsConfig.free.count
    HintsConfig.rewarded.timer = RewardedAdsConfig.delay

    for i = 1, #PaymentsConfig.products do
        local product = PaymentsConfig.products[i]

        if product.ui_id == STARTER_PACK_UI_ID then
            product.offer_duration = static_config.sdi_offer_duration or product.offer_duration
            product.interstitial_till_offer = static_config.sdi_interstitial_till_offer or product.interstitial_till_offer
        end
    end

    local leaderboards = static_config.sdi_leaderboard_settings

    if leaderboards then
        LeaderboardsConfig.id = leaderboards.sdi_leaderboard_name or LeaderboardsConfig.id
        LeaderboardsConfig.top_count_by_player = leaderboards.sdi_rating_top_count or LeaderboardsConfig.top_count_by_player
        LeaderboardsConfig.around_player_count = leaderboards.sdi_rating_around_count or LeaderboardsConfig.around_player_count
        LeaderboardsConfig.level_start = leaderboards.sdi_leaderboard_lvl_start or LeaderboardsConfig.level_start
    end

    FeedbackConfig.start_level = static_config.sdi_rate_us_lvl or FeedbackConfig.start_level
    FeedbackConfig.reward_hints = static_config.sdi_rate_us_reward_hints or FeedbackConfig.reward_hints

    GameConfig.feed_level.points = static_config.sdi_ad_lvl_points or GameConfig.feed_level.points
end

return ConfigService
