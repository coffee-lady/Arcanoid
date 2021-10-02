local ServerConfig = {
    yandex = {},
    ok = {
        key_http = 'secret_runtime_key_2001',
        format_sign = '_omg_sign_%d',
        sign_key = 'osecret_key_omg_2000',
        encode_key = '_some_secrete_key12',
        session_interval = 60 * 60 * 24,

        config_client = {
            host = 'serveromg.cf',
            -- host = "127.0.0.1",
            port = 7050,
            use_ssl = true,
            username = 'secret_omg_serverkey_2001',
            password = '',
            timeout = 5,
        },
    },
}

return ServerConfig
