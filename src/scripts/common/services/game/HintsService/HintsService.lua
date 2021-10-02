local CurrentHintsSetService = require('src.scripts.common.services.game.HintsService.CurrentHintSetService.CurrentHintSetService')
local HintsDataService = require('src.scripts.common.services.game.HintsService.HintsDataService.HintsDataService')

local HintsService = {}

function HintsService:init(services)
    self.player_data_storage = services.player_data_storage
    self.services = services

    HintsDataService:init(services)
end

function HintsService:init_game_hints_set(context_data)
    self.services.context_data = context_data
    CurrentHintsSetService:init(self.services, HintsDataService)
end

function HintsService:on_continue_game()
    CurrentHintsSetService:on_continue_game()
end

function HintsService:reset()
    CurrentHintsSetService:reset()
end

function HintsService:prompt(cell_data)
    return CurrentHintsSetService:prompt_current(cell_data)
end

function HintsService:get_hints_type()
    return CurrentHintsSetService:get_hints_type()
end

function HintsService:get_free_hints()
    return HintsDataService:get_free_hints()
end

function HintsService:get_paid_hints()
    return HintsDataService:get_paid_hints()
end

function HintsService:add_free_hints(add_count)
    HintsDataService:add_free_hints(add_count)
end

function HintsService:add_paid_hints(add_count)
    HintsDataService:add_paid_hints(add_count)
end

function HintsService:apply_free_hint()
    HintsDataService:apply_free_hint()
end

function HintsService:apply_paid_hint()
    HintsDataService:apply_paid_hint()
end

return HintsService
