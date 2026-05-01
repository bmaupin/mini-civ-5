# Mini Civ 5

📌 [See my other Civ projects here](https://github.com/search?q=user%3Abmaupin+topic%3Acivilization&type=Repositories)

This is a mod to Sid Meier's Civilization V to allow much shorter games. Features include:

- **Very** small maps (hence the name)
- New game options to allow for faster play
- Compatible with the base game, Gods and Kings, and Brave New World

See [below](#features) for more information.

## Installation

Install the mod from Steam here or see below for manual installation instructions:<br>
<a href="https://steamcommunity.com/sharedfiles/filedetails/?id=3489957747">
<img src="assets/steam-store-badge.webp" alt="Available on Steam" width="200px">
</a>

## Usage

1. Start Civ 5 and go to the _Mods_ menu
1. Check _Mini Civ 5_ and then start a new game

## Features

> [!TIP]
> Try [Ozymandias](https://goblinzstudio.com/game/ozymandias/) if you would like a Civ-like game that plays much more quickly

- Smaller maps: this alone has the biggest impact on the length of the game
- Shows hidden game options: this allows disabling of some game features (religion, happiness, etc.) that could make the game quicker
- Disables buildings and wonders related to hidden game options. For example, if religion is disabled then the shrine building and the Grand Temple wonder will not show in the city's build queue.
- New game options:
  - Scouts Start Automated
  - Workers Start Automated
    - This does not include work boats, as they're one-time use units

## Known issues

ⓘ See [issues](https://github.com/bmaupin/mini-civ-5/issues) for other potential issues

#### Potential gameplay issues

The map sizes in this mod are so small that they may negatively impact gameplay. Testing of the map sizes is ongoing.

#### Not all maps are smaller

This mod doesn't make changes to individual maps, only the global map sizes. Maps that override the global map sizes are unaffected by this mod. This includes all of the maps for a specific location (Earth, Europe, South America, etc.) as well as:

- Amazon
- Boreal
- Continents Plus
- Donut
- Four Corners
- Frontier
- Great Plains
- Hemispheres
- Highlands
- Ice Age
- Inland Sea
- Lakes
- Large Islands
- North vs South
- Oval
- Pangaea Plus
- Ring
- Skirmish
- Terra
- Tilted Axis
- West vs East

## Manual installation

#### Linux

Download the repository source file from [Releases](https://github.com/bmaupin/mini-civ-5/releases), extract it, and then run the install script:

```
./scripts/install-mod.sh
```

Or:

1. Go to [Releases](https://github.com/bmaupin/mini-civ-5/releases) and download the `.civ5mod` file
1. Create a new directory named `Mini Civ 5 (v 1)`
   - 👉 Update the value after `(v ` with the version from the filename
1. Extract the contents of the `.civ5mod` file to the directory you created (it's compressed using 7zip)
1. Move the directory to the mods directory
   - Native: ~/.local/share/Aspyr/Sid Meier's Civilization 5/MODS
   - Proton: ~/.steam/steam/steamapps/compatdata/8930/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization 5/MODS

#### Windows

1. Go to [Releases](https://github.com/bmaupin/mini-civ-5/releases) and download the `.civ5mod` file
1. Copy it to Documents/My Games/Sid Meier's Civilization 5/MODS
