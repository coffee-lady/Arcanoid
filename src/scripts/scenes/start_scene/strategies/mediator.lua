local App = require('src.app')
local Strategies = require('src.scripts.scenes.start_scene.strategies.strategies')

local SceneStrategiesMediator = App.libs.scenes.SceneStrategiesMediator

--- @class StartSceneStrategiesMediator : SceneStrategiesMediator
local StartSceneStrategiesMediator = class('StartSceneStrategiesMediator', SceneStrategiesMediator)

StartSceneStrategiesMediator.__cparams = {'event_bus', 'auth_service', 'ui_service'}

function StartSceneStrategiesMediator:initialize(event_bus, auth_service, ui_service)
    SceneStrategiesMediator.initialize(self, event_bus)

    self.auth_service = auth_service
    self.ui_service = ui_service

    self:set_strategy(Strategies.StandardStrategy)
    self:set_services_subscriptions(self.ui_service, self.auth_service)
end

return StartSceneStrategiesMediator
