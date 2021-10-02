local App = require('src.app')
local GUI = require('gui.gui')
local CommonComponents = require('src.scripts.common.components.components')
local ComponentCommon = require('src.scripts.common.templates.simple_popup.common.common')
local Presenters = require('src.scripts.common.templates.simple_popup.presenters.presenters')
local View = require('src.scripts.common.templates.simple_popup.view.SimplePopupView')

local CheckboxID = App.constants.gui.common.components.checkbox

local SimplePopupTemplate = class('SimplePopupTemplate')

function SimplePopupTemplate:initialize(context_services, buttons_map)
    self.context_services = context_services

    self.nodes_map = ComponentCommon.NodesMap(context_services, buttons_map)

    local nodes = self.nodes_map:get_objects()
    self.theme = ComponentCommon.ThemeMap(context_services, nodes)
    self.localization = ComponentCommon.localization(context_services, nodes)

    self.view = View(context_services, nodes)
    self.presenter = Presenters.PopupPresenter(context_services, self.view)

    self.transition = CommonComponents.PopupTransition()
end

function SimplePopupTemplate:localize(keys, is_platform_dependent, vars)
    self.localization:update(keys, is_platform_dependent, vars)
    self:localize_checkbox(keys, vars)
    self.presenter:update_layout()
end

function SimplePopupTemplate:localize_checkbox(keys, vars)
    if not self.checkbox then
        return
    end

    self.checkbox:localize(keys.text_checkbox, vars)
end

function SimplePopupTemplate:add_checkbox(params, on_switch)
    params.ID = CheckboxID
    self.checkbox = GUI.Checkbox(self.context_services, params)
    self.checkbox:on_switch(on_switch)
    self.presenter:add_checkbox(self.checkbox)
    self.nodes_map:add_checkbox(self.checkbox)
end

function SimplePopupTemplate:on_message(message_id, message, sender)
    self.transition:on_message(message_id, message, sender)
end

function SimplePopupTemplate:final()
    self.transition:final()
end

return SimplePopupTemplate
