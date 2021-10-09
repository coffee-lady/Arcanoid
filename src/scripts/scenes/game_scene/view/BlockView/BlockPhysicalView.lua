local App = require('src.app')

local class = App.libs.middleclass
local PROP = App.constants.go_props

local BlockPhysicalView = class('BlockPhysicalView')

function BlockPhysicalView:initialize(id)
    self.co_kinematic_url = msg.url(nil, id, PROP.block.co_kinematic)
    self.co_trigger = msg.url(nil, id, PROP.block.co_trigger)

    self.kinematic_enabled = true
    self.trigger_enabled = false

    msg.post(self.co_trigger, PROP.disable)
end

function BlockPhysicalView:switch_co()
    local message_id = self.kinematic_enabled and PROP.disable or PROP.enable

    msg.post(self.co_kinematic_url, message_id)

    message_id = self.trigger_enabled and PROP.disable or PROP.enable

    msg.post(self.co_trigger, message_id)

    self.kinematic_enabled = not self.kinematic_enabled
    self.trigger_enabled = not self.trigger_enabled
end

return BlockPhysicalView
