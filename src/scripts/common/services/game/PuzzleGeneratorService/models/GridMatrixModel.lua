local App = require('src.app')
local Utils = require('src.scripts.common.services.game.PuzzleGeneratorService.models.utils.utils')

local Math = App.libs.math
local Array = App.libs.array

--- @class GridMatrix
local GridMatrix = class('GridMatrix')

function GridMatrix:initialize(size)
    self.data = {}
    self.size = size

    if size then
        local quad = math.sqrt(size)

        for i = 1, size do
            self.data[i] = {}

            for j = 1, size do
                self.data[i][j] = (math.ceil(i / quad) + (i - 1) * quad + j - 2) % size + 1
            end
        end
    end
end

function GridMatrix:from_cells_array(cells)
    self.size = math.sqrt(#cells)

    for k = 1, #cells do
        local value = cells[k]
        local i = math.ceil(k / self.size)
        local j = k - (i - 1) * self.size

        if not self.data[i] then
            self.data[i] = {}
        end

        self.data[i][j] = value
    end

    return self
end

function GridMatrix:fill_from_matrix(matrix)
    self.data = Array.copy_2d(matrix)
    self.size = #matrix
end

function GridMatrix:get_size()
    return self.size
end

function GridMatrix:_swap_cells(i, j, m, n)
    local tmp = self.data[i][j]
    self.data[i][j] = self.data[m][n]
    self.data[m][n] = tmp
end

function GridMatrix:transpose()
    for i = 1, self.size do
        for j = i, self.size do
            self:_swap_cells(i, j, j, i)
        end
    end
end

function GridMatrix:random_swap_rows()
    local row1, row2 = Utils.get_random_lines(self.size)

    for j = 1, self.size do
        self:_swap_cells(row1, j, row2, j)
    end
end

function GridMatrix:random_swap_cols()
    local col1, col2 = Utils.get_random_lines(self.size)

    for i = 1, self.size do
        self:_swap_cells(i, col1, i, col2)
    end
end

function GridMatrix:random_swap_horizontal_areas()
    local square_size = math.sqrt(self.size)
    local region1, region2 = Utils.get_random_regions(square_size)

    for i = 1, square_size do
        for j = 1, self.size do
            local row1 = (region1 - 1) * square_size + i
            local row2 = (region2 - 1) * square_size + i

            self:_swap_cells(row1, j, row2, j)
        end
    end
end

function GridMatrix:random_swap_vertical_areas()
    local square_size = math.sqrt(self.size)
    local region1, region2 = Utils.get_random_regions(square_size)

    for i = 1, self.size do
        for j = 1, square_size do
            local col1 = (region1 - 1) * square_size + j
            local col2 = (region2 - 1) * square_size + j

            self:_swap_cells(i, col1, i, col2)
        end
    end
end

function GridMatrix:random_mix(iterations_count)
    if iterations_count == 0 then
        return
    end

    local stirring_count = Math.random_arr(iterations_count)

    local methods = {self.transpose, self.random_swap_rows, self.random_swap_cols, self.random_swap_horizontal_areas, self.random_swap_vertical_areas}

    for _ = 1, stirring_count do
        local method_index = math.random(#methods)

        methods[method_index](self)
    end
end

function GridMatrix:set_cell(i, j, value)
    self.data[i][j] = value
end

function GridMatrix:get_cell(i, j)
    return self.data[i][j]
end

function GridMatrix:get_data()
    return self.data
end

function GridMatrix:copy()
    local new_grid = GridMatrix()

    new_grid.size = self.size
    new_grid.data = Array.copy_2d(self.data)

    return new_grid
end

return GridMatrix
