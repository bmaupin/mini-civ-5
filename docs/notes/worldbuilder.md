# WorldBuilder

## Patch WorldBuilder for greater range in map sizes

#### Apply the patch

1. Back up WorldBuilder.exe

1. Create the patch file

   ```
   echo "000087c8: 08  # Decrease the minimum map height from 20 (0x14) to 8
   000087f1: 08  # Decrease the minimum map width from 20 (0x14) to 8" > WorldBuilder.exe.patch
   ```

1. Apply the patch file

   ```
   xxd -c1 -r WorldBuilder.exe.patch WorldBuilder.exe
   ```

1. (Optional) View the changes

   ```
   $ diff <(xxd WorldBuilder.exe.bak) <(xxd WorldBuilder.exe)
   2173c2173
   < 000087c0: 0a02 7bb0 0000 041f 146f 6701 000a 027b  ..{......og....{
   ---
   > 000087c0: 0a02 7bb0 0000 041f 086f 6701 000a 027b  ..{......og....{
   2176c2176
   < 000087f0: 1f14 6f67 0100 0a02 7baf 0000 041f 0a6f  ..og....{......o
   ---
   > 000087f0: 1f08 6f67 0100 0a02 7baf 0000 041f 0a6f  ..og....{......o
   ```

#### How the patch was created

ⓘ This is just for informational purposes as to how the patch was created

1. Back up WorldBuilder.exe

1. Use a tool such as [dnSpy](https://github.com/dnSpy/dnSpy) to examine and modify WorldBuilder.exe

1. Generate a patch file

   ```
   comm -13 <(xxd -c1 WorldBuilder.exe.bak) <(xxd -c1 WorldBuilder.exe) > WorldBuilder.exe.patch
   ```

## Getting WorldBuilder running in Linux

#### Run WorldBuilder using Wine

WorldBuilder opens, but

- It must be manually pointed to the Civ 5 directory
- Many of the map tiles don't show
- The map generation scripts don't seem to do anything

1. Install Wine

   - I used Wine 9

1. Set up the SDK in a new Wine prefix

   ```
   export WINEPREFIX=~/.local/share/wineprefixes/civ5sdk
   # I only tested a 32-bit prefix with Wine. Maybe this is why it didn't work with Proton, since it uses a 64-bit prefix?
   WINEARCH=win32 wineboot
   # If you don't install .NET, Wine will use Mono, but this caused a crash in the map editor
   winetricks -q dotnet35
   ```

**Testing**

no changes yet:

```
mkdir -p ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files/Steam/steamapps/common
ln -s ~/.steam/steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files/Steam/steamapps/common/
ln -s ~/.steam/steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files/Steam/steamapps/common/
```

```
mkdir -p ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common
ln -s ~/.steam/steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common/
ln -s ~/.steam/steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common/
```

```
STEAM_COMPAT_DATA_PATH="/home/$USER/.local/share/Steam/steamapps/compatdata/16830" STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/$USER/.local/share/Steam" "$HOME/.local/share/Steam/steamapps/common/Proton 8.0"/proton waitforexitandrun regedit
```

1. Open WorldBuilder

   ```
   #wine ~/.steam/steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK/WorldBuilder/x86/WorldBuilder.exe -PromptForGamePath
   #wine ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK/WorldBuilder/x86/WorldBuilder.exe -PromptForGamePath
   #wine ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK/WorldBuilder/x86/WorldBuilder.exe -PromptForGamePath
   #cd ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK/WorldBuilder/x86/; wine WorldBuilder.exe -PromptForGamePath
   cd ~/.local/share/wineprefixes/civ5sdk/drive_c/Program\ Files\ \(x86\)/Steam/steamapps/common/Sid\ Meier\'s\ Civilization\ V\ SDK/WorldBuilder/x86/; wine WorldBuilder.exe -PromptForGamePath
   ```

   ```
   #C:\Program Files\Steam\steamapps\common\Sid Meier's Civilization V\CivilizationV.exe
   C:\Program Files (x86)\Steam\steamapps\common\Sid Meier's Civilization V\CivilizationV.exe
   ```

1. Start Civ 5 using Proton

   - It doesn't seem necessary to start Civ 5 first, then close it, then start it again; when WorldBuilder is first started, it will appear to hang. Then start Civ 5 with `-Nexus 4320`

   ```
   STEAM_COMPAT_DATA_PATH="/home/$USER/.local/share/Steam/steamapps/compatdata/8930" STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/$USER/.local/share/Steam" "$HOME/.local/share/Steam/steamapps/common/Proton 8.0"/proton waitforexitandrun "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/CivilizationV.exe" \\dx9 -Nexus 4320
   ```

#### Run WorldBuilder using Proton

Currently gets to the WorldBuilder menu but crashes when clicking _New Map_ with this error:

```
X Error of failed request:  BadWindow (invalid Window parameter)
  Major opcode of failed request:  12 (X_ConfigureWindow)
  Resource id in failed request:  0x9400a35
  Serial number of failed request:  2845
  Current serial number in output stream:  2845
```

1. Start the Civ 5 SDK at least once to create the Wine prefix

1. Run Civ 5 using Proton (instead of Native)

   👉 TODO: is this needed?

1. Set Civ 5 launch options

   ```
   %command% \\dx9 -Nexus 4320`
   ```

1. Start Civ 5

1. Set Civ 5 SDK launch options

   👉 TODO: is this needed?

   ```
   /home/$USER/.local/share/Steam/ubuntu12_32/reaper SteamLaunch AppId=16830 -- /home/$USER/.local/share/Steam/ubuntu12_32/steam-launch-wrapper -- "/home/$USER/.local/share/Steam/steamapps/common/SteamLinuxRuntime_sniper"/_v2-entry-point --verb=waitforexitandrun -- "/home/$USER/.local/share/Steam/steamapps/common/Proton 8.0"/proton waitforexitandrun  "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V SDK/WorldBuilder/x86/WorldBuilder.exe" -PromptForGamePath # %command%
   ```

1. Start Civ 5 SDK

1. When prompted, browse to Civ 5 exe, e.g.

   👉 TODO: is this needed?

   ```
   z:\home\user\.steam\steam\steamapps\common\Sid Meier's Civilization V\CivilizationV.exe
   ```

   - Replace `user` with your username

1. Wait until connection is established between SDK and Civ 5, e.g.

   ```
   $ netstat -antlp | grep 4320
   tcp        0      0 127.0.0.1:4320          0.0.0.0:*               LISTEN      439482/wineserver
   tcp     6450      0 127.0.0.1:4320          127.0.0.1:32944         ESTABLISHED 439482/wineserver
   tcp        0      0 127.0.0.1:32944         127.0.0.1:4320          ESTABLISHED 433820/wineserver
   ```

1. Stop Civ 5

   - Ignore the SDK message

1. Start Civ 5 again, and the WorldBuilder menu should show

#### To do

- [ ] Confirm that the BadWindow error only happens when the game crashes
- [ ] Try installing .NET 3.5

  - [ ] Try installing from Steam depot

    ```
    STEAM_COMPAT_DATA_PATH="/home/$USER/.local/share/Steam/steamapps/compatdata/16830" STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/$USER/.local/share/Steam" "/home/$USER/.local/share/Steam/steamapps/common/Proton 8.0"/proton waitforexitandrun  ~/.steam/steam/steamapps/common/Steamworks\ Shared/_CommonRedist/DotNet/3.5/dotnetfx35.exe
    ```

  - [ ] Try installing using protontricks

    ```

    protontricks 16830 -q dotnet35
    ```

- [ ] Try launching WorldBuilder with `-PromptForGamePath`?

  - (https://forums.civfanatics.com/threads/if-youre-having-problems-launching-worldbuilder.490200/)

  - `z:\home\user\.steam\steam\steamapps\common\Sid Meier's Civilization V\CivilizationV.exe`

- [x] Try launching Civ 5 manually: `%command% \\dx9 -Nexus 4320`
- [ ] Try launching WorldBuilder with wine/proton outside of Steam?

#### Notes

- WorldBuilder needs .NET 3.5

- WorldBuilder starts Civ 5 with this parameter: `-Nexus 4320`
  - Maybe this is some kind of socket connection so WorldBuilder can connect to Civ 5?
  - Does WorldBuilder also need access to
