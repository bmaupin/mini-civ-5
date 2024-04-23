# Create custom DLC

#### To do

- [x] Create custom DLC with one of the tools below
- [x] Compare custom DLC to included DLC
- [ ] Try to get custom DLC to minimum set of files
- [ ] Figure out how overrides works
  - Mods directory seems to be ignored
  - [ ] Get full file listing of `Override/`
  - [ ] Compare to full file listing of XML files in `Assets/DLC/Expansion2/`
  - [ ] Wipe Override/ and replace with all XML files from `Assets/DLC/Expansion2/`

#### Reasons for creating custom DLC

- I don't think mods can be used in multiplayer games, but if they're installed as DLC this works
- Mods disable achievements whereas DLC don't

#### Convert existing mod to DLC using a tool

- https://forums.civfanatics.com/threads/mpmpm-converting-mods-to-dlc-format-for-multiplayer-use.523450/
- https://civ5.jaiiderherr.de/
- https://forums.civfanatics.com/threads/mpmpm-multiplayer-mod-dlc-hack-updated.533238/

#### Notes on existing DLC

- Each DLC has its own directory under `Assets/DLC/`
- Contents seem to be similar to mods
  - e.g. `Assets/DLC/DLC_01/Gameplay/XML/CIV5Traits_Mongol.xml` contains a typical `<GameData>` XML file
- The biggest difference seems to be the `.Civ5Pkg` at the root of the DLC directory
  - This seems to fulfill a similar purpose to a `.modinfo` file but the contents are completely different, containing a `<Civ5Package>` element instead of a `<Mod>` element

#### Testing MPMPM tool

(https://forums.civfanatics.com/threads/mpmpm-multiplayer-mod-dlc-hack-updated.533238/)

👉 In the end, I don't think this is the best option. Creating the mod pack DLC is pretty involved and must be re-done every time the mod is changed. The way MPMPM works is it dumps the entire game database of a running game as XML and I don't think it would be trivial to reproduce this.

- Works as listed, creates an `MP_MODSPACK` directory in `Assets/DLC` that can be dropped into another installation
- The `UI` directory can be removed, along with the corresponding entry in `MPModsPack.Civ5Pkg`
- Override directory
  - 523 files, 510 of which are empty
  - Removing the it caused the DLC not to work (but the game worked)
  - Replacing the files with empty files caused the game to crash
  - Removing the empty files caused the game to crash
  - Blanking some files caused the game to crash
    - CIV5Units.xml
  - Blanking or removing other files seems to work
    - CIV5Units_Mongol.xml
    - Civ5_Dialog\_\*
    - CIV5GameTextInfos\*
    - CIV5Leader\_\*
  - Removing something in \*\_\* causes it to crash

#### How does the MPMPM custom DLC work?

- It seems like all the game logic gets put into one file: CIV5Units.xml
- Is the Mods directory even needed?

#### Create custom DLC

1. Create custom directory under `Assets/DLC/`

   e.g. `DLC_Quick_Civ_5`

1. Create `.Civ5Pkg` file
