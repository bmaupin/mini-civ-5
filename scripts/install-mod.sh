#!/usr/bin/env bash

source "$(dirname "$(which "$0")")/package-mod.sh"

# Detect whether we're using native or Proton
if [[ -f "/home/$USER/.steam/steam/steamapps/common/Sid Meier's Civilization V/Civ5XP" ]]; then
    user_directory="/home/${USER}/.local/share/Aspyr/Sid Meier's Civilization 5"
fi

if [[ -f "/home/$USER/.steam/steam/steamapps/common/Sid Meier's Civilization V/CivilizationV.exe" ]]; then
    user_directory="/home/${USER}/.steam/steam/steamapps/compatdata/8930/pfx/drive_c/users/steamuser/Documents/My Games/Sid Meier's Civilization 5"
fi

echo "Copying mod files ..."
mod_directory="${user_directory}/MODS/${mod_name_version}"

# We have to clean up the mod first because otherwise rename will fail because the files will exist
rm -rf "${mod_directory}"/*
7z x "${mod_name_version}.civ5mod" -o"${mod_directory}"
