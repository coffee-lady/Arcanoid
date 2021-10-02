local App = require('src.app')
local LineKeyHash = require('src.scripts.common.services.game.PuzzleGeneratorService.helpers.LineHashHelper')

local Array = App.libs.array

--- @class ColsCover
local ColsCover = class('Cover')

--- @param grid GridMatrix
function ColsCover:initialize(grid)
    self.data = {}

    if grid then
        self:fill(grid)
    end
end

function ColsCover:fill(grid)
    local grid_size = grid:get_size()

    self.grid = grid

    for i = 1, grid_size do
        for j = 1, grid_size do
            local num = grid:get_cell(i, j)

            if num > 0 then
                local row_id = LineKeyHash.get_hash(i, j, num)
                self.data[#self.data + 1] = row_id
            end
        end
    end
end

function ColsCover:push(row_id)
    self.data[#self.data + 1] = row_id
end

function ColsCover:pop()
    table.remove(self.data)
end

function ColsCover:len()
    return #self.data
end

function ColsCover:copy()
    local new_cover = ColsCover()

    new_cover.data = Array.copy_1d(self.data)

    return new_cover
end

function ColsCover:get_matrix()
    local matrix = {}

    for i = 1, #self.data do
        local row, col, num = LineKeyHash.get_decoded(self.data[i])

        if not matrix[row] then
            matrix[row] = {}
        end

        matrix[row][col] = num
    end

    return matrix
end

return ColsCover
