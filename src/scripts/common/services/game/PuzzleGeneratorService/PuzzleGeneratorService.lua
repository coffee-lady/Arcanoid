local App = require('src.app')
local Solver = require('src.scripts.common.services.game.PuzzleGeneratorService.helpers.SolverHelper')
local Models = require('src.scripts.common.services.game.PuzzleGeneratorService.models.models')

local GridMatrixModel = Models.GridMatrixModel

local Entities = App.entities
local SudokuGridEntity = Entities.SudokuGridEntity

local Array = App.libs.array

local PuzzleGenerator = {}

PuzzleGenerator.Models = Models

local function get_solution(grid)
    local solver = Solver(grid)

    solver:find_solutions()

    return solver:get_solution()
end

local function dig_cells_holes(current_difficulty, grid, cells, desired_difficulty, start_pos)
    if current_difficulty == desired_difficulty then
        return true
    end

    start_pos = start_pos or 1

    local grid_size = grid:get_size()
    local cell_index = cells[start_pos]
    local i = math.ceil(cell_index / grid_size)
    local j = cell_index - (i - 1) * grid_size

    local buf_cell = grid:get_cell(i, j)

    grid:set_cell(i, j, 0)

    local solution = get_solution(grid)

    if #solution == 0 then
        grid:set_cell(i, j, buf_cell)

        return false
    end

    current_difficulty = current_difficulty - 1

    for k = start_pos + 1, #cells do
        local result = dig_cells_holes(current_difficulty, grid, cells, desired_difficulty, k)

        if result then
            return result
        end
    end

    current_difficulty = current_difficulty + 1

    grid:set_cell(i, j, buf_cell)

    return false
end

function PuzzleGenerator.generate(config, mixing_iter_count)
    local desired_difficulty = math.random(config.min, config.max)
    local nums_count = config.grid_size * config.grid_size
    local difficulty = nums_count
    local grid = GridMatrixModel(config.grid_size)
    local cells = {}

    grid:random_mix(mixing_iter_count)

    for i = 1, nums_count do
        cells[#cells + 1] = i
    end

    Array.shuffle(cells)

    dig_cells_holes(difficulty, grid, cells, desired_difficulty)

    local solution_grid = get_solution(grid)

    return SudokuGridEntity(grid, solution_grid)
end

function PuzzleGenerator.make_from_string(cells_str, mixing_iter_count)
    local cells = {}

    for value in string.gmatch(cells_str, '%d') do
        cells[#cells + 1] = tonumber(value)
    end

    local grid_matrix = GridMatrixModel():from_cells_array(cells)
    grid_matrix:random_mix(mixing_iter_count)
    local solution_grid = get_solution(grid_matrix)

    return SudokuGridEntity(grid_matrix, solution_grid)
end

return PuzzleGenerator
