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

#### Number of cities allowed

- 13x17 - 16x20
  - Would allow up to 20 cities 😬 (4x5)
    - This would be > 6 cities per player at 3 players, and so on
  - Formula: number of cities = number of tiles / 4, round up to nearest integer

#### Compare Civ 4 to Civ 5 map sizes

- Civ 4 duel: 12x12 grids (3x3 tiles)
  - In Civ 4 this allows how many cities, with 2 between them?
    - Up to 16 cities ...
  - So this would be the equivalent of a 16x16 map in Civ 5
    - Formula: * 4/3, due to the distance between cities
    - So really 14x18 isn't too egregious ...

#### Default sizes

| Name     | Size   | Number of tiles |
| -------- | ------ | --------------- |
| Duel     | 40x24  | 960             |
| Tiny     | 56x36  | 2016            |
| Small    | 66x42  | 2772            |
| Standard | 80x52  | 4160            |
| Large    | 104x64 | 6656            |

#### Testing various map sizes

| Name | Size in XML | Size in game | Map            |
| ---- | ----------- | ------------ | -------------- |
| Duel | 40x24       | 40x24        | Archipelago    |
| Duel |             | 40x24        | Continents     |
| Duel |             | 40x24        | Earth          |
| Duel |             | 40x24        | Fractal        |
| Duel |             | 18x14        | Great Plains   |
| Duel |             | 16x16        | North vs South |
| Duel |             | 40x24        | Pangaea        |
| Tiny | 56x36       | 56x36        | Continents     |
| Tiny |             | 28x22        | Great Plains   |
| Tiny |             | 24x24        | North vs South |

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
