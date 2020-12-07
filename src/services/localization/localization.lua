local LocalizationService = {}

function LocalizationService:init(localization)
    local json_data = sys.load_resource('/src/resources/localization/' .. localization .. '.json')
    self.data = json.decode(json_data)

    self.listeners = {}
end

function LocalizationService:change(localization)
    local json_data = sys.load_resource('/src/resources/localization/' .. localization .. '.json')
    self.data = json.decode(json_data)

    for i = 1, #self.listeners do
        msg.post(self.listeners[i], 'localization_changed')
    end
end

function LocalizationService:add_change_listener(listener)
    self.listeners[#self.listeners + 1] = listener
end

function LocalizationService:remove_change_listener(listener)
    for i = 1, #self.listeners do
        if self.listeners[i] == listener then
            table.remove(self.listeners, i)
        end
    end
end

return LocalizationService
