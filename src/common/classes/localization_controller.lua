local App = require('src.app')
local class = App.libs.middleclass
local Services = require('src.services.services')

local LocalizationService = Services.localization
local LocalizationLib = App.libs.localization

local MSG = App.constants.messages

local CLASS_NAME = 'LocalizationController'

local LocalizationController = class(CLASS_NAME)

function LocalizationController:initialize(scene_url, text_nodes)
    self.URL = scene_url
    self.text_nodes = text_nodes
end

function LocalizationController:init(msg_service)
    self:update()

    msg_service:on(CLASS_NAME, MSG.common.localization_change, function()
        self:update()
    end)
end

function LocalizationController:update()
    local TEXT_DATA = LocalizationService:get(self.URL)

    for key, _ in pairs(self.text_nodes) do
        LocalizationLib:update(TEXT_DATA, key)
    end
end

return LocalizationController
