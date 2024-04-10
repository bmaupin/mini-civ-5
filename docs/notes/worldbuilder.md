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

#### To do

- [ ] Try launching WorldBuilder with `-PromptForGamePath`?
  - (https://forums.civfanatics.com/threads/if-youre-having-problems-launching-worldbuilder.490200/)
- [ ] Try launching Civ 5 manually: `%command% \\dx9 -Nexus 4320`
  - Then launch WorldBuilder with wine/proton outside of Steam?

#### Notes

- WorldBuilder starts Civ 5 with this parameter: `-Nexus 4320`
  - Maybe this is some kind of socket connection so WorldBuilder can connect to Civ 5?
  - Does WorldBuilder also need access to
