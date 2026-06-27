# rainmeter-waifu-desktop

A tiny Rainmeter suite I threw together to get that clean Linux-ricing look on Windows -> a character cutout, a weather widget, a clock, and a month calendar, all sitting on a black wallpaper. No bloated all-in-one suite, no API keys, no telemetry. Just four small skins you can read top to bottom.

I built it for myself first (I wanted a Wuthering Waves character on my desktop next to the weather), then stripped out anything personal so it works for whatever character and city you want.

## What's inside

-> `Waifu` -> one image meter that draws your character. Click-through, so it never steals your mouse.
-> `Weather` -> live weather from the free Open-Meteo API. No signup, no key.
-> `Clock` -> time + date.
-> `Calendar` -> month grid with today highlighted. Pure Lua, no plugins.

## Install

1. Install Rainmeter -> https://www.rainmeter.net
2. Copy the whole repo folder into `Documents\Rainmeter\Skins\` so you end up with `Documents\Rainmeter\Skins\rainmeter-waifu-desktop\...`
3. Right-click the Rainmeter tray icon -> Refresh all
4. Right-click tray icon -> Skins -> rainmeter-waifu-desktop -> load `Waifu`, `Weather`, `Clock`, `Calendar`
5. Drag each one where you want it

## Make it yours

Everything you'd want to change lives in one file: `@Resources/Variables.inc`

-> `City`, `Lat`, `Lon` -> your location. Grab coordinates from https://open-meteo.com (type your city in their box and read the URL).
-> `TempUnit` -> `celsius` or `fahrenheit`. `WindUnit` -> `kmh` or `mph`.
-> `FontName`, `TextColor`, `AccentColor` -> the whole look. Colors are `R,G,B,A`.
-> `WaifuImage` -> the filename of your art in `@Resources/Images/`. `WaifuWidth` -> how big.

> Tip: drop a transparent PNG in `@Resources/Images/` for a real cutout. A JPG works too, it just shows as a rectangle. On a black wallpaper a dark-background JPG blends in fine.

## How the weather actually works

The whole thing is one HTTP GET and some regex. `Weather/Weather.ini` hits:

```
https://api.open-meteo.com/v1/forecast?latitude=#Lat#&longitude=#Lon#&current=temperature_2m,weather_code,wind_speed_10m,is_day&...
```

Open-Meteo returns the `current` block with the keys in the same order you asked for them, so the `RegExp` can pull each value out by position with `StringIndex`. The numeric `weather_code` goes through `@Resources/weathercode.lua` which maps it to words like "Partly cloudy". That's the entire trick -> fetch, match, map.

> If the weather shows blank: refresh the skin once (it needs one fetch to populate), and double-check `Lat`/`Lon` are numbers with a dot, not a comma.

## Bring your own art

I don't ship character images -> they're not mine to redistribute. The `Images/` folder is git-ignored. Drop your own in and point `WaifuImage` at it.

## License

MIT for the code. The art is yours and stays yours.

## More than one character

`Waifu.ini` draws one image. Want several cutouts like a Linux setup? Duplicate the file -> `Waifu2.ini`, `Waifu3.ini`, each with its own `ThisImage` and `ThisWidth` at the top, then load them all. Each is a separate skin you drag where you want.

## CPU temperature

`CpuTemp` reads the hottest core via Rainmeter's bundled Core Temp plugin.

> It needs the free Core Temp app (alcpu.com/CoreTemp) running in the background -> the plugin just reads its shared memory. No Core Temp running = it shows 0. The skin assumes 6 cores (indexes 0-5); add or remove `MeasureCoreN` lines to match your CPU.
