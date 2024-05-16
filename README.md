# Quick Civ 5

💡 [See my other Civ projects here](https://github.com/search?q=user%3Abmaupin+topic%3Acivilization&type=Repositories)

## About

#### What is this?

A mod to make Civilization V games drastically shorter.

#### Features

- Smaller maps: this alone has the biggest impact on the length of the game
- Shows hidden game options: this allows disabling of some game features (religion, happiness, etc.) that could make the game quicker
- Disables buildings and wonders related to hidden game options. For example, if religion is disabled then the shrine building and the Grand Temple wonder will not show in the city's build queue.

#### Status

The mod is usable but still undergoing testing. As of this writing, map sizes have been reduced to 16% of their original size (40% of their height and 40% of their width), but this may be adjusted after further testing.

## Installation

The mod hasn't yet been published to Steam as it's still undergoing testing. You may install it manually if you wish.

#### Linux

Download the repository source file from [Releases](https://github.com/bmaupin/quick-civ-5/releases), extract it, and then run the install script:

```
./scripts/install-mod.sh
```

Or:

1. Go to [Releases](https://github.com/bmaupin/quick-civ-5/releases) and download the `.civ5mod` file
1. Get the version of the mod from [src/Quick Civ 5.modinfo](src/Quick%20Civ%205.modinfo)
   - It's add the end of the `Mod` element, e.g. `version="1"`
1. Create a new directory named `quick civ 5 (v 1)`
   - 👉 Update the value after `(v ` with the version from the previous step
1. Extract the contents of the `.civ5mod` file to the directory you created (it's compressed using 7zip)
1. Move the directory to the mods directory
   - Native: ~/.local/share/Aspyr/Sid Meier's Civilization 5/MODS
   - Proton: ~/.steam/steam/steamapps/compatdata/8930/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization 5/MODS

#### Windows

1. Go to [Releases](https://github.com/bmaupin/quick-civ-5/releases) and download the `.civ5mod` file
1. Copy it to Documents/My Games/Sid Meier's Civilization 5/MODS

## Usage

1. Start Civ 5 and go to the _Mods_ menu
1. Check _Quick Civ 5_ and then start a new game

## Wishlist

1. [ ] Publish to Steam
   - Once the mod has been more thoroughly tested
1. [ ] Option to install as DLC
   - It would be nice to be able to install the mod as DLC so it doesn't have to be loaded separately every time the game is run. But I'm not sure that's possible ([docs/notes/dlc.md](docs/notes/dlc.md))
1. [ ] Shrink built-in scenario maps?
   - This would allow scenarios to be played much more quickly. But the WorldBuilder seems to drop cities, units, etc. from maps when they're resized, and I'm not even sure if a mod can override a map from another mod/DLC.
1. [ ] Disable units from previous eras?
   - Maybe the game already does this?
