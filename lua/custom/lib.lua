local M = {}

M.spread = function(template)
    local result = {}
    for key, value in pairs(template) do
        result[key] = value
    end

    return function(table)
        for key, value in pairs(table) do
            result[key] = value
        end
        return result
    end
end

M.countWords = function(string)
    local _, n = string:gsub("%S+", "")
    return n
end

M.split = function(inputstr, sep)
    local res = {}

    if sep == nil then
        sep = "%s"
    end

    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(res, str)
    end

    return res
end

M.is_windows = vim.loop.os_uname().sysname == "Windows_NT"

return M
