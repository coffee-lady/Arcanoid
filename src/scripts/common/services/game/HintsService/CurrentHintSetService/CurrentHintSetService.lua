local App = require('src.app')
local Commands = require('src.scripts.common.services.game.HintsService.commands.commands')

local ApplyFreeHintCommand = Commands.ApplyFreeHint
local ApplyPaidHintCommand = Commands.ApplyPaidHint
local ApplyRewardedHintCommand = Commands.ApplyRewardedHint

local FIRST_HINT_TYPE = 1

local LinkedList = App.libs.linked_list

local COMMANDS = {ApplyFreeHintCommand, ApplyPaidHintCommand, ApplyRewardedHintCommand}

--- @class CurrentHintSetService
local CurrentHintSetService = {}

function CurrentHintSetService:init(services, hints_data_service)
    self.context_data = services.context_data
    self.event_bus = services.event_bus
    self.stats_service = services.stats_service
    self.player_data_storage = services.player_data_storage
    self.ads_service = services.ads_service
    self.services = services

    self.hints_data_service = hints_data_service

    self:_set_list()
end

function CurrentHintSetService:_set_list()
    self.context_data:get_game():set_hints_type(FIRST_HINT_TYPE)

    local hints = {}
    for i = 1, #COMMANDS do
        hints[#hints + 1] = COMMANDS[i](self.services, self.hints_data_service)
    end

    --- @type LinkedList
    self.current_hints_commands_list = LinkedList(hints)
    local hint_command = self.current_hints_commands_list:get_current()

    if not hint_command:is_available() then
        self:_next_hint_type()
    end
end

function CurrentHintSetService:on_continue_game()
    self:_set_list()
end

function CurrentHintSetService:reset()
    self:_set_list()
end

function CurrentHintSetService:prompt_current(cell_data)
    local hint_command = self.current_hints_commands_list:get_current()

    if not cell_data or cell_data.is_solved or not hint_command then
        return false
    end

    if not hint_command:is_available() then
        return false
    end

    local is_applied, add_params = hint_command:apply()

    if hint_command:get_count_left() == 0 then
        self:_next_hint_type()
    end

    return is_applied, add_params
end

function CurrentHintSetService:_next_hint_type()
    local hints_type = self.context_data:get_game_data().hints_type
    local next_hint = self.current_hints_commands_list:next()

    if not next_hint then
        return
    end

    if not next_hint:is_available() then
        if COMMANDS[hints_type + 2] then
            self.context_data:get_game():set_hints_type(hints_type + 1)
            self:_next_hint_type()
        else
            self.current_hints_commands_list:back()
        end

        return
    end

    self.context_data:get_game():set_hints_type(hints_type + 1)
end

function CurrentHintSetService:get_hints_type()
    return self.context_data:get_game_data().hints_type
end

return CurrentHintSetService
