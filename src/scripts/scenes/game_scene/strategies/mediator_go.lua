local App = require('src.app')
local Strategies = require('src.scripts.scenes.game_scene.strategies.strategies')

local SceneStrategiesMediator = App.libs.scenes.SceneStrategiesMediator

--- @class StartSceneStrategiesMediator : SceneStrategiesMediator
local StartSceneStrategiesMediator = class('StartSceneStrategiesMediator', SceneStrategiesMediator)

StartSceneStrategiesMediator.__cparams = {'event_bus_go', 'auth_service'}

function StartSceneStrategiesMediator:initialize(event_bus, auth_service)
    SceneStrategiesMediator.initialize(self, event_bus)

    self.auth_service = auth_service

    self:set_strategy(Strategies.StandardStrategyGO)
    self:set_services_subscriptions(self.auth_service)
end

return StartSceneStrategiesMediator
