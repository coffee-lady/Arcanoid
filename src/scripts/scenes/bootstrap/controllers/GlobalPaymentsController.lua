local App = require('src.app')

local MSG = App.constants.msg

--- @class GlobalPaymentsController
local GlobalPaymentsController = class('GlobalPaymentsController')

GlobalPaymentsController.__cparams = {
    'payments_use_cases'
}

function GlobalPaymentsController:initialize(payments_use_cases)
    --- @type PaymentsUseCases
    self.payments_use_cases = payments_use_cases
end

function GlobalPaymentsController:on_authorized()
    self.payments_use_cases:init_server_payments()
end

return GlobalPaymentsController
