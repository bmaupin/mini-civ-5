# Publish to Steam workshop

https://partner.steamgames.com/doc/features/workshop/implementation

#### Prerequisites

Install steamcmd, e.g.

```
sudo apt install steamcmd
```

#### Instructions

1. Package the content as needed

   e.g. A Civ 5 mod should be compressed with 7zip and the extension should be renamed to `.civ5mod`

1. Create a preview image

   - This is the image shown on the workshop search page and in the workshop item page
     - This is not the same as the screenshots, which can be added later
   - Existing preview images appear to be square, so this is probably best
   - Steam recommends JPG, PNG and GIF

1. Upload the mod to Steam

   ⓘ It appears that steamcmd's `workshop_build_item` parameter only works with games that use Steam's newer UGC storage. Using it with Beyond Earth (and Civ 5?) will result in an error. steamcmd does have another parameter (`workshop_create_legacy_item`) for older Steam games using the legacy storage (remote storage), however this seems to only work for the initial file upload and not updates.

   1. Download steamremotestorage-uploader

      https://github.com/nnnn20430/steamremotestorage-uploader/releases

   1. Extract steamremotestorage-uploader

      ```
      tar xvf steamremotestorage-uploader-v1.0.tar.xz
      ```

   1. Start Steam

      ⓘ Steam must be running for steamremotestorage-uploader to work

   1. Upload to Steam

      e.g. for Beyond Earth:

      ```
      cd steamremotestorage-uploader/amd64
      ./steamremotestorage-uploader -a 65980 -t "Micro Beyond Earth" -f /path/to/micro\ beyond\ earth\ \(v\ 1\).civbemod -p /path/to/preview.png -n "Initial release"
      ```

1. Later, upload screenshots

   https://steamcommunity.com/sharedfiles/filedetails/?id=2042081690

#### Update an existing mod

e.g.

```
./steamremotestorage-uploader -a 65980 -i 1234567890 -f /path/to/micro\ beyond\ earth\ \(v\ 1\).civbemod -n "New release"
```

## Troubleshooting

#### `Item upload failed: 21`

Updating an existing mod normally goes quickly, but sometimes it takes a while and throws this error. If it happens, close and reopen Steam and try again.

#### Mod doesn't install after uploading it to Steam

Check ~/.local/share/aspyr-media/Sid Meier's Civilization Beyond Earth/Logs/ModInstaller.log

## Upload a mod with steamcmd

⚠️ These instructions don't work with Civ 5 or Beyond Earth since they use Steam's legacy remote storage and not UGC. They're left here for legacy purposes.

1. Create a VDF file

   ```
   "workshopitem"
    {
     "appid" "8930"
     "publishedfileid" "0"
     "contentfolder" "D:\\Content\\workshopitem"
     "previewfile" "D:\\Content\\preview.jpg"
     "visibility" "0"
     "title" "My title"
     "description" "My description"
     "changenote" "v1"
    }
   ```

   - `publishedfileid` should be `0` for new items
     - It can be set to an ID to update an item
   - `visibility`
     - 0: public
     - 1: friends
     - 2: private

1. Log into steamcmd

   ```
   steamcmd +login username
   ```

   (Replace `username` with your Steam username)

1. Upload with `workshop_build_item`

   https://partner.steamgames.com/doc/features/workshop/implementation#SteamCmd

   ```
   steamcmd +login username +workshop_build_item "$(pwd)/workshop.vdf" +quit
   ```

   (Replace `username` with your Steam username)

1. Later, upload screenshots

   https://steamcommunity.com/sharedfiles/filedetails/?id=2042081690

## Troubleshooting steamcmd

#### General troubleshooting

Check log file at ~/.local/share/Steam/logs/workshop_log.txt

#### `ERROR! Failed to load build config file "workshop.vdf".`

If this occurs with no other errors, make sure you pass the full path to the .vdf file you wish to publish.

#### `ERROR! Failed to update workshop item (Invalid Parameter).`

Check the logs in ~/.local/share/Steam/logs/workshop_log.txt

If you see a log like this:

```
Upload workshop item 1234567890 failed (no workshop depot found)
```

The game only supports legacy (remote storage) uploads, not newer (UGC) uploads
