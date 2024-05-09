mod_name="Quick_Civ_5"

# TODO: auto-detect Linux vs. Proton
game_directory="/home/${USER}/.steam/steam/steamapps/common/Sid Meier's Civilization V"
# game_directory="/home/${USER}/.local/share/Aspyr/Sid Meier's Civilization 5"

dlc_directory="${game_directory}/Assets/DLC/Expansion2"
lua_directory="${dlc_directory}/UI/${mod_name}"
xml_directory="${dlc_directory}/Gameplay/${mod_name}"

# Start with a clean slate every time
rm -rf "${lua_directory}"
rm -rf "${xml_directory}"
mkdir "${lua_directory}"
mkdir "${xml_directory}"
cp src/Lua/* "${lua_directory}"
cp src/XML/* "${xml_directory}"

# To load Lua files as DLC, an existing Lua file needs to explicitly import them
if ! grep -q 'table.insert(g_uiAddins, ContextPtr:LoadNewContext("Quick_Civ_5"));' "${dlc_directory}/UI/InGame/InGame.lua"; then
    echo -e '\ntable.insert(g_uiAddins, ContextPtr:LoadNewContext("Quick_Civ_5"));' >> "${dlc_directory}/UI/InGame/InGame.lua"
fi

# To load XML files as DLC, they need to be added to a Civ5Pkg file with a valid GUID and key
if ! grep -q '<GameData>Quick_Civ_5.xml</GameData>' "${dlc_directory}/Expansion2.Civ5Pkg"; then
    sed -E -i 's|(\s*)</Gameplay>|\1\1<GameData>Quick_Civ_5.xml</GameData>\n\1</Gameplay>|' "${dlc_directory}/Expansion2.Civ5Pkg"
fi
