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

## Troubleshooting

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
