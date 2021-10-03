local App = require('src.app')
local Strategies = require('src.scripts.scenes.start_scene.strategies.strategies')

local SceneStrategiesMediator = App.libs.scenes.SceneStrategiesMediator

--- @class StartSceneStrategiesMediator : SceneStrategiesMediator
local StartSceneStrategiesMediator = class('StartSceneStrategiesMediator', SceneStrategiesMediator)

StartSceneStrategiesMediator.__cparams = {'event_bus', 'auth_service'}

function StartSceneStrategiesMediator:initialize(event_bus, auth_service)
    SceneStrategiesMediator.initialize(self, event_bus)

    self.auth_service = auth_service

    self:set_strategy(Strategies.StandardStrategy)
    self:add_subscriptions(self.auth_service)
end

return StartSceneStrategiesMediator
