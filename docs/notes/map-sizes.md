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


