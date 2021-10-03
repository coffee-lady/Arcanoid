local App = require('src.app')

local SubscriptionsMap = App.libs.SubscriptionsMap
local SceneController = App.libs.scenes.SceneController

local MSG = App.constants.msg

--- @class ButtonsController : SceneController
local ButtonsController = class('ButtonsController', SceneController)

ButtonsController.__cparams = {'event_bus'}

function ButtonsController:initialize(event_bus, presenters)
    SceneController.initialize(event_bus)

    self:set_subscription_map({
        [MSG.auth.success_auth] = self.on_authorized,
    })
end

function ButtonsController:on_authorized()

end

return ButtonsController
