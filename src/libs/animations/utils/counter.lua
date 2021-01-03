return function(duration, prev, next, update)
    local range = next - prev
    local elapsed_time = 0

    if range == 0 then
        return
    end

    timer.delay(duration / range, true, function(_, handle, dt)
        elapsed_time = elapsed_time + dt

        local remaining_time = math.max((duration - elapsed_time) / duration, 0)
        local current = math.modf(next - remaining_time * range)

        update(current)

        if current == next then
            timer.cancel(handle)
        end
    end)
end
