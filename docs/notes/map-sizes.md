## Notes

#### To do

- [ ] What is the smallest map size allowed?
  - Could we use the WorldBuilder for this?
    - WorldBuilder can be used to create maps with the same map generation scripts, which might give us an idea of how many cities could fit on a map without having to start a new game
    - Currently it only allows creating a 20x20 map; could this be modified?
      - Current range is 20x20 - 128x80
      - Yes, it can be modified; see [worldbuilder.md](worldbuilder.md)
      - See also: https://forums.civfanatics.com/threads/worldbuilder-unofficial-updates-modifications.392023/
- [ ] Document smallest map sizes per map type

#### Basics

- Cities have to be built at least 4 tiles from another city, i.e. with no less than 3 tiles between
  - This is more than Civ 4, which allows 2 tiles between cities
  - Can this be modified?
  - Should this be modified?
    - Maybe we should leave this as-is, because of 1 unit per tile. Otherwise there might not be enough spaces between cities for military units. We could still limit map sizes as appropriate
- Map sizes are defined in `civ5worlds.xml`
- Maps use "grid" sizes like Civ 4, but instead of an actual grid

#### Number of cities allowed

- 13x17 - 16x20
  - Would allow up to 20 cities 😬 (4x5)
    - This would be > 6 cities per player at 3 players, and so on
  - Formula: number of cities = number of tiles / 4, round up to nearest integer

#### Compare Civ 4 to Civ 5 map sizes

- Civ 4 map sizes were defined by "grids" where each grid was 3x3 tiles
  - Civ 5 map sizes still use "grids" but this seems to correspond to the number of tiles
- Civ 4 duel: 12x12 grids (3x3 tiles)
  - In Civ 4 this allows how many cities, with 2 between them?
    - Up to 16 cities ...
  - So this would be the equivalent of a 16x16 map in Civ 5
    - Formula: \* 4/3, due to the distance between cities
    - So really 14x18 isn't too egregious ...

#### Default sizes

| Name     | Size   | Number of tiles |
| -------- | ------ | --------------- |
| Duel     | 40x24  | 960             |
| Tiny     | 56x36  | 2016            |
| Small    | 66x42  | 2772            |
| Standard | 80x52  | 4160            |
| Large    | 104x64 | 6656            |

The in-game sizes can be different since some map scripts override the defaults:

| Name | Size in XML | Size in game | Map            |
| ---- | ----------- | ------------ | -------------- |
| Duel | 40x24       | 40x24        | Continents     |
| Duel |             | 18x14        | Great Plains   |
| Duel |             | 16x16        | North vs South |
| Duel |             | 40x24        | Pangaea        |
| Tiny | 56x36       | 56x36        | Continents     |
| Tiny |             | 28x22        | Great Plains   |
| Tiny |             | 24x24        | North vs South |

It looks like these are the map scripts that have custom map sizes:

```
$ find . -iname "*.lua" -exec sh -c "grep -H 'GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {' \"{}\" | head -n 1" \; | sed 's!.*/!!' | sort -u
Amazon.lua:             [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {22, 20},
Amazon_XP.lua:          [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {22, 20},
AssignStartingPlots.lua:                        [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {14, 3},
Boreal.lua:             [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {32, 20},
ContinentsPlus.lua:             [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {30, 24},
Donut.lua:              [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {24, 24},
Europe.lua:             [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {20, 16},
Four_Corners.lua:               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {16, 16},
Frontier.lua:           [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {52, 32},
Great_Plains.lua:               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {18, 14},
Great_Plains_XP.lua:            [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {18, 14},
Hemispheres.lua:                [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {30, 24},
Highlands.lua:          [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {32, 20},
Ice_Age.lua:            [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {40, 16},
InlandSea.lua:          [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {24, 16},
Lakes.lua:              [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {24, 16},
Large_Islands.lua:              [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {30, 24},
North_vs_South.lua:             [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {16, 16},
Oval.lua:               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {32, 20},
PangaeaPlus.lua:                [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {30, 24},
Ring.lua:               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {32, 20},
Script_Random_China.lua:                [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {26, 20},
Skirmish.lua:           [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {24, 16},
Terra.lua:              [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {52, 32},
Tilted_Axis.lua:                [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {52, 32},
WB_Script_Random_Scandinavia.lua:               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {5, 4},
West_vs_East.lua:               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {20, 14},
```

#### Get map size

1. (Optional) Modify ~/.steam/steam/steamapps/compatdata/8930/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization 5/

   1. Set `DebugPanel = 1`

      ⓘ This enables the debug panel, which allows revealing the entire map

1. Modify ~/.steam/steam/steamapps/compatdata/8930/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization 5/UserSettings.ini

   1. Set `DebugMode = 1`

      ⓘ This will show coordinates when hovering over a tile

1. Start a game

1. Press Ctrl-Z and dismiss dialogues

   ⓘ This will allow seeing the coordinates for all tiles, not just the visible tiles

1. (Optional) Press ~ > _Reveal All_

   💡 This isn't necessary but it will make it easier to see all the map tiles and get the map size

1. Move the mouse to the upper-right corner of the map and get the coordinates from the tooltip

1. Add 1 to each coordinate to get the map size

   e.g. a coordinate of `17x 13y` is an 18x12 map
