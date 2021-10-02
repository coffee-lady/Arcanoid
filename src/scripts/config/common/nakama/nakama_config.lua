local NakamaConfig = {}

NakamaConfig.DEFAULT_LEADERBOARD_LIMIT = 10
NakamaConfig.DEFAULT_TIMEOUT = 5
NakamaConfig.KEY_STORAGE_STATE = 'state'

NakamaConfig.RPC = {
    get_server_time = 'get_server_time',
    save_storage_secure = 'save_storage',
    load_storage_secure = 'get_storage',
    sync_currency_state = 'sync_currency_state',
    get_purchase_list = 'prch_catalog',
    sync_wallet_events = 'sync_wallet_events',

    update_level_complete = 'lvl_stat_update',
    get_level_complete_stats = 'lvl_stat_get',
}

return NakamaConfig
