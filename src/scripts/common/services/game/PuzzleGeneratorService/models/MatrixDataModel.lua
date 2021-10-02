local App = require('src.app')
local LineHash = require('src.scripts.common.services.game.PuzzleGeneratorService.helpers.LineHashHelper')

local Array = App.libs.array

-- идентификаторы строк: (row, col, num)
-- идентификаторы столбцов:
-- (1, row, col) - на пересечении row и col стоит число
-- (2, row, num) - в строке row есть число num
-- (3, col, num) - в столбце col есть число num
-- (4, q, num) - в квадрате q есть число num

--- @class MatrixData
local MatrixData = class('MatrixData')

function MatrixData:initialize(grid_size)
    self.grid_size = grid_size
    self.square_size = math.sqrt(grid_size)

    self.data = {
        rows = {},
        cols = {},
    }

    self:fill_rows()
    self:fill_cols()
end

local function remove_row_from_cols(row, matrix_data)
    local cols = matrix_data.cols
    local rows = matrix_data.rows

    local intersected_cols = rows[row]

    for _, col in pairs(intersected_cols) do
        if cols[col] then
            Array.remove(row, cols[col])
        end
    end
end

function MatrixData:extract_row_intersects(base_row)
    local cols = self.data.cols
    local rows = self.data.rows

    local buf_cols = {}
    local intersected_cols = rows[base_row]

    for _, col in pairs(intersected_cols) do
        local intersected_rows = cols[col]

        if intersected_rows then
            buf_cols[#buf_cols + 1] = intersected_rows
            cols[col] = nil

            for _, row in pairs(intersected_rows) do
                remove_row_from_cols(row, self.data)
            end
        end
    end

    return buf_cols
end

local function restore_row_in_cols(restored_col, row, data)
    for _, col in pairs(data.rows[row]) do
        if col ~= restored_col then
            if not data.cols[col] then
                data.cols[col] = {}
            end

            table.insert(data.cols[col], row)
        end
    end
end

function MatrixData:restore_row_intersects(base_row, buf)
    local cols = self.data.cols
    local rows = self.data.rows

    local cols_to_restore = rows[base_row]

    for i = #cols_to_restore, 1, -1 do
        local restored_col = cols_to_restore[i]

        local rows_to_restore = buf[#buf]
        cols[restored_col] = rows_to_restore
        table.remove(buf)

        for _, added_row in pairs(rows_to_restore) do
            restore_row_in_cols(restored_col, added_row, self.data)
        end
    end
end

function MatrixData:fill_rows()
    for i = 1, self.grid_size do
        for j = 1, self.grid_size do
            for num = 1, self.grid_size do
                local subsets = LineHash.get_cell_subsets(i, j, num, self.square_size)
                local row_id = LineHash.get_hash(i, j, num)

                self.data.rows[row_id] = subsets
            end
        end
    end
end

function MatrixData:fill_cols()
    local type_first, type_last = 1, 4

    for type = type_first, type_last do
        for i = 1, self.grid_size do
            for j = 1, self.grid_size do
                local col_id = LineHash.get_hash(type, i, j)

                self.data.cols[col_id] = {}
            end
        end
    end

    for row_key, row_cols in pairs(self.data.rows) do
        for _, col_key in pairs(row_cols) do
            table.insert(self.data.cols[col_key], row_key)
        end
    end
end

--- @param grid GridMatrix
function MatrixData:extract_grid_intersects(grid)
    for i = 1, self.grid_size do
        for j = 1, self.grid_size do
            local num = grid:get_cell(i, j)

            if num > 0 then
                local row_id = LineHash.get_hash(i, j, num)
                self:extract_row_intersects(row_id)
            end
        end
    end
end

return MatrixData
