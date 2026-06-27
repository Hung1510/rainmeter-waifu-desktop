-- Builds a monospaced month grid and exposes #Today# for highlighting.
function Update()
    local t = os.date('*t')
    local year, month, today = t.year, t.month, t.day

    local startWday   = os.date('*t', os.time{year=year, month=month,   day=1, hour=12}).wday        -- 1=Sun
    local daysInMonth = tonumber(os.date('*t', os.time{year=year, month=month+1, day=0, hour=12}).day)

    SKIN:Bang('!SetVariable', 'Today', tostring(today))

    local header = os.date('%B %Y')
    local week   = 'Su Mo Tu We Th Fr Sa'

    local cells = {}
    for _=1,(startWday-1) do cells[#cells+1] = '  ' end
    for d=1,daysInMonth do cells[#cells+1] = string.format('%2d', d) end

    local rows = {}
    for i=1,#cells,7 do
        rows[#rows+1] = table.concat(cells, ' ', i, math.min(i+6, #cells))
    end

    return header .. '\n' .. week .. '\n' .. table.concat(rows, '\n')
end
