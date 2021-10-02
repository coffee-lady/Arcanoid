local t1, t2, t3, t4 = 1, 2, 3, 4

local LineHashHelper = {}

function LineHashHelper.get_cell_subsets(row, col, num, sq_size)
    local get_hash = LineHashHelper.get_hash
    local quad = math.floor((row - 1) / sq_size) * sq_size + math.floor((col - 1) / sq_size) + 1

    return {get_hash(t1, row, col), get_hash(t2, row, num), get_hash(t3, col, num), get_hash(t4, quad, num)}
end

function LineHashHelper.get_hash(...)
    local args = {...}
    local result = 0
    local d = 1

    for i = #args, 1, -1 do
        result = result + args[i] * d
        d = d * 10
    end

    return result
end

local function decode(hash)
    while hash > 0 do
        local x = hash % 10

        hash = math.floor(hash / 10)

        return x, decode(hash)
    end
end

function LineHashHelper.get_decoded(hash)
    local c, b, a = decode(hash)

    return a, b, c
end

return LineHashHelper
