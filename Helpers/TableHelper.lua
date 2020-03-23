-- From https://gist.github.com/walterlua/978150
function table.indexOf(t, object)
    if type(t) ~= "table" then error("table expected, got " .. type(t), 2) end
    for i, v in pairs(t) do
        if object == v then
            return i
        end
    end
end

-- Compatibility: Lua-5.1
function split(str, pat)
    local t = {}  -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
          table.insert(t,cap)
       end
       last_end = e+1
       s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
       cap = str:sub(last_end)
       table.insert(t, cap)
    end
    return t
end
