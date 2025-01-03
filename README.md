[![Discord](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge)](https://discord.gg/VuVhYUBbWE)[![Ko-Fi](https://img.shields.io/badge/Ko%E2%80%93Fi-ff5e5b?style=for-the-badge)](https://ko-fi.com/thesixthroc)

# PlanetsLib

Code and graphics to help modders creating planets and moons, plus thoughtful standardizations to avoid mod proliferations (such as [Surfaces Have Temperature](https://mods.factorio.com/mod/Surfaces-Have-Temperature)) each time we want to standardize something.

This library is fully open-source and will grow over time — feel free to contribute via pull requests on [Github](https://github.com/danielmartin0/PlanetsLib).

## Features

- Helper function `PlanetsLib:planet_extend({...` to define the orbit of planets with respect to another body.
- If a technology `[planet-name]-cargo-drops` is defined, players will be unable to drop cargo (excluding players and construction robots) to that planet before researching that technology.
  - The functionality is implemented automatically.
  - `PlanetsLib.technology_icons_planet_cargo_drops` and `PlanetsLib.technology_effect_cargo_drops` are provided for easy construction of the technology prototype.
- Extended support for moons:
  - `PlanetsLib.technology_icons_moon` is used to create icons for moon discovery.
  - A new row is available in Factoriopedia for moons.
- New surface condition 'temperature' with default values as follows. They are somewhat milder than astrophysical values so the engineer can more plausibly describe. They are spaced out to enable modded planets to slot in-between.
-- Helper function `PlanetLib:steal_music(source_planet, target_planet)` to clone music tracks from an existing planet.

| Surface         | Temperature (K) |
| --------------- | --------------- |
| Nauvis          | 288K            |
| Vulcanus        | 332K            |
| Fulgora         | 314K            |
| Gleba           | 298K            |
| Aquilo          | 258K            |
| Space Platforms | 268             |
| Default         | 288K            |

## Usage Examples

- See the [Cerys](https://mods.factorio.com/mod/Cerys-Moon-of-Fulgora) mod.

## Credits

- Art by [Tserup](https://mods.factorio.com/user/Tserup).
- Contributors will be listed below.
  - [thesixthroc](https://mods.factorio.com/user/thesixthroc)
  - [notnotmelon](https://mods.factorio.com/user/notnotmelon)
