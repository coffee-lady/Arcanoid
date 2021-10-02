local DesignAnalytics = require('src.scripts.common.services.business.AnalyticsService.design.DesignAnalyticsService')
local ProgressionAnalytics = require('src.scripts.common.services.business.AnalyticsService.progression.ProgressionAnalyticsService')
local CustomDimensionsAnalytics = require('src.scripts.common.services.business.AnalyticsService.custom.CustomDimensionsAnalyticsService')

--- @class AnalyticsService
local AnalyticsService = {}

function AnalyticsService:init(ui_service)
    gameanalytics.setEnabledInfoLog(false)
    gameanalytics.setEnabledVerboseLog(false)

    self.design = DesignAnalytics
    self.progression = ProgressionAnalytics
    self.custom = CustomDimensionsAnalytics

    self.design:init()
    self.custom:init(ui_service)
end

return AnalyticsService
