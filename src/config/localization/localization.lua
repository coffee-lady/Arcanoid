local LocalizationConfig = {
    default_lang = 'en',
    file = {
        path = '/src/resources/localization/',
        type = 'json',
    }
}

function LocalizationConfig:get_file_path(lang)
    return self.file.path .. lang .. '.' .. self.file.type
end

return LocalizationConfig
