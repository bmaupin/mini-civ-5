#!/usr/bin/env bash

game_options_files=(
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/DLC/Expansion2/Gameplay/XML/GameInfo/CIV5GameOptions_Expansion2.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/DLC/Expansion2/Gameplay/XML/GameInfo/CIV5GameOptions_Inherited_Expansion2.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/DLC/Expansion/Gameplay/XML/GameInfo/CIV5GameOptions_Expansion.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/Gameplay/XML/GameInfo/CIV5GameOptions.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/dlc/expansion2/gameplay/xml/gameinfo/civ5gameoptions_expansion2.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/dlc/expansion2/gameplay/xml/gameinfo/civ5gameoptions_inherited_expansion2.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/dlc/expansion/gameplay/xml/gameinfo/civ5gameoptions_expansion.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/gameplay/xml/gameinfo/civ5gameoptions.xml"
)

echo "Modding game options"
for game_options_file in "${game_options_files[@]}"; do
    if [ -f "$game_options_file" ]; then
        sed -i '/<!-- <Visible>0<\/Visible> -->/!s|<Visible>0</Visible>|<!-- <Visible>0</Visible> -->|' "$game_options_file"
    fi
done

worlds_files=(
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/DLC/Expansion2/Gameplay/XML/GameInfo/CIV5Worlds.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/DLC/Expansion/Gameplay/XML/GameInfo/CIV5Worlds.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/Assets/Gameplay/XML/GameInfo/CIV5Worlds.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/dlc/expansion2/gameplay/xml/gameinfo/civ5worlds.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/dlc/expansion/gameplay/xml/gameinfo/civ5worlds.xml"
    "/home/$USER/.local/share/Steam/steamapps/common/Sid Meier's Civilization V/steamassets/assets/gameplay/xml/gameinfo/civ5worlds.xml"
)

echo "Modding map sizes"
for worlds_file in "${worlds_files[@]}"; do
    if [ -f "$worlds_file" ]; then
        # Duel
        # Replace only the first occurrence, and so on (https://stackoverflow.com/a/50624719/399105)
        sed -i ':a;N;$!ba;s/<GridWidth>[0-9]\+<\/GridWidth>/<GridWidth>16<\/GridWidth>/1' "$worlds_file"
        sed -i ':a;N;$!ba;s/<GridHeight>[0-9]\+<\/GridHeight>/<GridHeight>10<\/GridHeight>/1' "$worlds_file"
        # Tiny
        sed -i ':a;N;$!ba;s/<GridWidth>[0-9]\+<\/GridWidth>/<GridWidth>20<\/GridWidth>/2' "$worlds_file"
        sed -i ':a;N;$!ba;s/<GridHeight>[0-9]\+<\/GridHeight>/<GridHeight>13<\/GridHeight>/2' "$worlds_file"
        # Small
        sed -i ':a;N;$!ba;s/<GridWidth>[0-9]\+<\/GridWidth>/<GridWidth>25<\/GridWidth>/3' "$worlds_file"
        sed -i ':a;N;$!ba;s/<GridHeight>[0-9]\+<\/GridHeight>/<GridHeight>16<\/GridHeight>/3' "$worlds_file"
    fi
    break
done
