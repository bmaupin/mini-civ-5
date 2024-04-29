# Create custom DLC

## Read first

After a bunch of testing, it looks like custom DLC that overwrites game logic requires a UUID (which is hard-coded in the game executable) and key and only works with tools like MPMPM, which generate an entire dump of the game state. This is way too complicated and rigid.

DLC that only make UI changes seem to work without a key (see [Enhanced UI DLC mod](https://forums.civfanatics.com/threads/enhanced-user-interface.512263/)).

## Notes

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

#### Enhanced User Interface

This is interesting because it's installed as DLC but without all the Overrides created by MPMPM. This might be the best option.

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

   1. TODO: does it matter if there are spaces in name?

   1. Copy this

      ```xml
      <?xml version="1.0" encoding="utf-8"?>
      <Civ5Package>
        <GUID>{UUID}</GUID>
        <Version>1</Version>
        <Priority>999</Priority>
        <PTags>
          <Tag>Version</Tag>
        </PTags>
        <Name>
          <Value language="en_US">Name</Value>
        </Name>
        <Description>
          <Value language="en_US">Description</Value>
        </Description>
      </Civ5Package>
      ```

   1. Replace `UUID` with a randomly generated UUID

   1. Replace `Name` and `Description`

   1. Set `Priority` accordingly
      - DLC is loaded in order of priority, lowest to highest
   1. Any XML files that update the database need to be added as `GameData` elements, e.g.

      ```xml
      <Gameplay>
        <GameData>Quick_Civ_5.xml</GameData>
      </Gameplay>
      ```

## Testing DLC

👉 `<Gameplay>` doesn't seem to work without a key ....

#### Works

- Adding Quick_Civ_5.xml to Assets/DLC/Expansion2/Gameplay/
  - Requires `<GameData>Quick_Civ_5.xml</GameData>`
- XML/Quick_Civ_5.xml with `<GameData>Quick_Civ_5.xml</GameData>` without `<Directory>XML</Directory>`

#### Works 😕

This works unless the key is removed, then it doesn't work. Adding `<GameData>Quick_Civ_5.xml</GameData>` to Enhanced UI doesn't work, so the key seems to be necessary for gameplay overrides.

- Assets/DLC/Expansion2/Expansion2.Civ5Pkg
- Assets/DLC/Expansion2/Quick_Civ_5.xml

```
<?xml version="1.0" encoding="utf-8"?>
<Civ5Package>
  <GUID>{6DA07636-4123-4018-B643-6575B4EC336B}</GUID>
  <SteamApp>235580</SteamApp>
  <Version>1</Version>
  <Priority>200</Priority>
  <Key>bf6d34a0074b7ad4b1d1716475f7f7fe</Key>
  <PTags>
    <Tag>Version</Tag>
  </PTags>
  <Name>
    <Value language="en_US">Expansion - Brave New World</Value>
  </Name>
  <Description>
    <Value language="en_US">Expansion - Brave New World</Value>
  </Description>
  <Gameplay>
    <GameData>Quick_Civ_5.xml</GameData>
  </Gameplay>
</Civ5Package>
```
