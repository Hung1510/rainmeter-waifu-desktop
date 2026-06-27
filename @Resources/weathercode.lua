-- Maps an Open-Meteo WMO weather code to a human description.
-- Reads the MeasureCode WebParser value from the Weather skin.
function Update()
    local m = SKIN:GetMeasure('MeasureCode')
    local s = ''
    if m ~= nil then s = m:GetStringValue() end
    local code = tonumber(s)
    if code == nil then return '...' end
    code = math.floor(code)

    local map = {
        [0]='Clear sky',      [1]='Mainly clear',  [2]='Partly cloudy', [3]='Overcast',
        [45]='Fog',           [48]='Rime fog',
        [51]='Light drizzle', [53]='Drizzle',      [55]='Dense drizzle',
        [56]='Freezing drizzle', [57]='Freezing drizzle',
        [61]='Light rain',    [63]='Rain',         [65]='Heavy rain',
        [66]='Freezing rain', [67]='Freezing rain',
        [71]='Light snow',    [73]='Snow',         [75]='Heavy snow', [77]='Snow grains',
        [80]='Light showers', [81]='Showers',      [82]='Violent showers',
        [85]='Snow showers',  [86]='Snow showers',
        [95]='Thunderstorm',  [96]='Thunderstorm + hail', [99]='Thunderstorm + hail',
    }
    return map[code] or 'Unknown'
end
