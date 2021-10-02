local Animations = require('animations.animations')

local GridWaveAnimator = class('GridWaveAnimator')

function GridWaveAnimator:initialize(grid)
    self.grid = grid
    self.grid_size = #grid
end

function GridWaveAnimator:animate(start_pos, animate_cell)
    local main_seq = Animations.Sequence()
    start_pos = start_pos or {
        i = 1,
        j = 1,
    }

    animate_cell(self.grid[start_pos.i][start_pos.j]):run()

    for k = 1, self.grid_size do
        local seq = Animations.Sequence()

        for _, di in pairs({-k, k}) do
            for dj = -k, k do
                if not (di == 0 and dj == 0) then
                    local i, j = start_pos.i + di, start_pos.j + dj
                    self:_try_to_animate_cell(i, j, seq, animate_cell)
                end
            end
        end

        for _, dj in pairs({-k, k}) do
            for di = -k + 1, k - 1 do
                if not (di == 0 and dj == 0) then
                    local i, j = start_pos.i + di, start_pos.j + dj
                    self:_try_to_animate_cell(i, j, seq, animate_cell)
                end
            end
        end

        main_seq:add(seq)
    end

    return main_seq
end

function GridWaveAnimator:_try_to_animate_cell(i, j, seq, animate_cell)
    if i > 0 and i <= self.grid_size and j > 0 and j <= self.grid_size then
        seq:join(animate_cell(self.grid[i][j]))
    end
end

return GridWaveAnimator
