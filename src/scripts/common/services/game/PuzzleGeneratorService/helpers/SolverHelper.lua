local App = require('src.app')
local ColsCover = require('src.scripts.common.services.game.PuzzleGeneratorService.models.ColsCoverModel')
local MatrixData = require('src.scripts.common.services.game.PuzzleGeneratorService.models.MatrixDataModel')

local Array = App.libs.array

local Solver = class('Solver')

--- @param grid GridMatrix
function Solver:initialize(grid)
    self.matrix_data = MatrixData(grid:get_size())
    self.base_cover = ColsCover(grid)
    --- @type ColsCover[]
    self.results = {}

    self.matrix_data:extract_grid_intersects(grid)
end

local function get_min_col(cols)
    local min_column

    for _, col in pairs(cols) do
        if not min_column or #col < #min_column then
            min_column = col
        end
    end

    min_column = Array.copy_1d(min_column)

    return min_column
end

--- @return ColsCover
function Solver:find_solutions()
    if #self.results > 1 then
        return ColsCover()
    end

    local cols = self.matrix_data.data.cols

    if Array.length(cols) == 0 then
        return self.base_cover
    end

    local min_col = get_min_col(cols)

    for _, base_row in pairs(min_col) do
        self.base_cover:push(base_row)

        local buf = self.matrix_data:extract_row_intersects(base_row)
        local cover = self:find_solutions()

        if cover:len() > 0 then
            self.results[#self.results + 1] = cover:copy()
        end

        self.matrix_data:restore_row_intersects(base_row, buf)

        self.base_cover:pop()
    end

    return ColsCover()
end

function Solver:get_solution()
    if #self.results == 0 then
        return {}
    end

    if #self.results > 1 then
        return {}
    end

    return self.results[1]:get_matrix()
end

return Solver
