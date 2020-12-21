local LocalizationLib = {}

function LocalizationLib:update_gui(...)
    local data = ...
    for i = 1, #data do
        local node = data[i].node
        local text = data[i].text
        gui.set_text(node, text)
    end
end

function LocalizationLib:update_go(...)
    local data = ...
    for i = 1, #data do
        local url = data[i].url
        local text = data[i].text
        go.set(url, 'text', text)
    end
end

return LocalizationLib
