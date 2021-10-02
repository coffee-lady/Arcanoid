local GridUtils = {}

function GridUtils.get_random_lines(size)
    local line1 = math.random(size)
    local square_size = math.sqrt(size)
    local region = math.ceil(line1 / square_size)
    local line2

    repeat
        line2 = math.random(square_size * (region - 1) + 1, square_size * region)
    until line1 ~= line2

    return line1, line2
end

function GridUtils.get_random_regions(square_size)
    local region1 = math.random(square_size)
    local region2

    repeat
        region2 = math.random(square_size)
    until region1 ~= region2

    return region1, region2
end

return GridUtils
