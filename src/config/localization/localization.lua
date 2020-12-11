local LocalizationConfig = {
    default_lang = 'en',
    path = '/src/resources/localization/',
    file_type = '.json',
}

function LocalizationConfig:get_resource_path(lang)
    return self.path .. lang .. self.file_type
end

return LocalizationConfig
