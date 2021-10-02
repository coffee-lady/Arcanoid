local App = require('src.app')
local PuzzleGenerator = require('src.scripts.common.services.game.PuzzleGeneratorService.PuzzleGeneratorService')

local Entities = App.entities
local SudokuGridEntity = Entities.SudokuGridEntity

local FILENAME = App.config.app.file
local KEY_LVLS_PASSED = App.config.app.keys.levels_passed
local KEY_LAST_PUZZLE = App.config.app.keys.last_loaded_puzzle
local ResourcesConfig = App.config.resources

local ResourcesStorage = App.libs.resources_storage

local PuzzleConfig = App.config.game.puzzle

--- @class PuzzleLoaderService
local PuzzleLoaderService = class('PuzzleLoader')

function PuzzleLoaderService:initialize(player_data_storage)
    self.player_data_storage = player_data_storage
end

function PuzzleLoaderService:generate_new(config)
    local grid = PuzzleGenerator.generate(config, PuzzleConfig.mixing_cells_iterations)

    return grid:get_plain_data()
end

function PuzzleLoaderService:load_from_file(difficulty_id)
    local levels_passed = self.player_data_storage:get(FILENAME, KEY_LVLS_PASSED)

    if not levels_passed then
        levels_passed = {}
    end

    local path = ResourcesConfig.levels .. difficulty_id .. ResourcesConfig.format
    local levels = ResourcesStorage:get_json_data(path) or {}
    local level_pointer = self:_get_level_pointer(levels_passed, difficulty_id, #levels)
    self:_set_level_pointer(levels_passed, difficulty_id, level_pointer)

    local level_string = levels[level_pointer]
    local grid = self:get_grid_from_string(level_string)
    self.player_data_storage:set(FILENAME, KEY_LAST_PUZZLE, grid:get_plain_data())

    return grid:get_plain_data(), level_pointer
end

function PuzzleLoaderService:restart_last_level_from_file(difficulty_id)
    local levels_passed = self.player_data_storage:get(FILENAME, KEY_LVLS_PASSED)

    if not levels_passed then
        levels_passed = {}
    end

    local level_pointer = levels_passed[difficulty_id]
    local last_puzzle = self.player_data_storage:get(FILENAME, KEY_LAST_PUZZLE)

    return SudokuGridEntity.copy(last_puzzle), level_pointer
end

function PuzzleLoaderService:_get_level_pointer(levels_passed, difficulty_id, levels_count)
    local passes_count = levels_passed[difficulty_id]

    if not passes_count then
        passes_count = 0
    end

    passes_count = passes_count + 1 > levels_count and 1 or passes_count + 1

    return passes_count
end

function PuzzleLoaderService:_set_level_pointer(levels_passed, difficulty_id, passes_count)
    levels_passed[difficulty_id] = passes_count

    self.player_data_storage:set(FILENAME, KEY_LVLS_PASSED, levels_passed)
end

function PuzzleLoaderService:get_grid_from_string(level_string, mixing_cells_iterations)
    mixing_cells_iterations = mixing_cells_iterations or 0
    local grid = PuzzleGenerator.make_from_string(level_string, mixing_cells_iterations or PuzzleConfig.mixing_cells_iterations)
    return grid
end

function PuzzleLoaderService.is_valid_level_str(cells_str)
    local grid_size = math.sqrt(string.len(cells_str))

    if grid_size ~= math.floor(grid_size) then
        return false
    end

    local cells = {}

    for value in string.gmatch(cells_str, '%d') do
        cells[#cells + 1] = tonumber(value)
    end

    return #cells == grid_size * grid_size
end

return PuzzleLoaderService
