local THEME_KEY_TO_ANALYTICS_KEY = {
    light = 'white',
    dark = 'black',
    green = 'green',
    yellow = 'yellow',
    blue = 'blue',
}

local CustomDimensionsAnalyticsService = {}

function CustomDimensionsAnalyticsService:init(ui_service)
    self.ui_service = ui_service

    local theme_key = self.ui_service:get_theme_key()
    gameanalytics.setCustomDimension01(THEME_KEY_TO_ANALYTICS_KEY[theme_key])
end

function CustomDimensionsAnalyticsService:on_theme_changed()
    local theme_key = self.ui_service:get_theme_key()
    gameanalytics.setCustomDimension01(THEME_KEY_TO_ANALYTICS_KEY[theme_key])
end

return CustomDimensionsAnalyticsService
