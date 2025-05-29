function CanCityConstructBuilding(playerID, cityID, buildingID)
    local player = Players[playerID]
    local city = player:GetCityByID(cityID)

    if (PreGame.GetGameOption("GAMEOPTION_NO_ESPIONAGE") == 1) then
        -- Buildings
        if buildingID == GameInfoTypes.BUILDING_CONSTABLE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_POLICE_STATION then
            return false

        -- Wonders
        elseif buildingID == GameInfoTypes.BUILDING_GREAT_FIREWALL then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_INTELLIGENCE_AGENCY then
            return false
        end
    end

    if (PreGame.GetGameOption("GAMEOPTION_NO_HAPPINESS") == 1) then
        -- Buildings
        if buildingID == GameInfoTypes.BUILDING_CIRCUS then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_COLOSSEUM then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_COURTHOUSE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_STADIUM then
            return false

        -- Wonders
        elseif buildingID == GameInfoTypes.BUILDING_CHICHEN_ITZA then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_CIRCUS_MAXIMUS then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_PRORA_RESORT then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_TAJ_MAHAL then
            return false
        end
    end

    if (PreGame.GetGameOption("GAMEOPTION_NO_RELIGION") == 1) then
        -- Buildings
        if buildingID == GameInfoTypes.BUILDING_MUD_PYRAMID_MOSQUE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_SHRINE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_TEMPLE then
            return false

        -- Wonders
        elseif buildingID == GameInfoTypes.BUILDING_BOROBUDUR then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_GRAND_TEMPLE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_HAGIA_SOPHIA then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_MOSQUE_OF_DJENNE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_STONEHENGE then
            return false
        end
    end

    if (PreGame.GetGameOption("GAMEOPTION_NO_SCIENCE") == 1) then
        -- Buildings
        if buildingID == GameInfoTypes.BUILDING_LABORATORY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_LIBRARY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_OBSERVATORY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_PAPER_MAKER then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_ROYAL_LIBRARY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_UNIVERSITY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_THEATRE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_WAT then
            return false

        -- Wonders
        elseif buildingID == GameInfoTypes.BUILDING_GREAT_LIBRARY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_HUBBLE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_INTERNATIONAL_SPACE_STATION then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_NATIONAL_COLLEGE then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_OXFORD_UNIVERSITY then
            return false
        elseif buildingID == GameInfoTypes.BUILDING_PORCELAIN_TOWER then
            return false
        end
    end

    if (PreGame.GetGameOption("GAMEOPTION_NO_HAPPINESS") == 1 and
        PreGame.GetGameOption("GAMEOPTION_NO_RELIGION") == 1) then
        if buildingID == GameInfoTypes.BUILDING_BURIAL_TOMB then
            return false
        end
    end

    if (PreGame.GetGameOption("GAMEOPTION_NO_RELIGION") == 1 and
        PreGame.GetGameOption("GAMEOPTION_NO_SCIENCE") == 1) then
        if buildingID == GameInfoTypes.BUILDING_PYRAMID then
            return false
        end
    end

    return true
end
GameEvents.CityCanConstruct.Add(CanCityConstructBuilding)

-- NOTE: The unit automation code has been copied from https://github.com/bmaupin/mini-beyond-earth/blob/main/src/Lua/Mini_Beyond_Earth.lua
--
-- Unfortunately Events.SerialEventUnitCreated is called more than just when a unit is
-- created: "SerialEventUnitCreated works for this. It triggers for all players, whever a
-- unit is created. Unfortunately, it ALSO triggers whenever a unit embarks, disembarks,
-- rebases, etc." (https://forums.civfanatics.com/threads/any-way-to-get-the-unit-create-event-to-work-as-expected.434826/#post-10764768)
--
-- We could maybe use this mod instead?: https://steamcommunity.com/sharedfiles/filedetails/?id=264749558
-- But this code is copied from Mini Beyond Earth and has already been tested
local automatedUnits = {};
function MaybeAutomateUnit(playerID, unitID)
    local player = Players[playerID];
    local unit = player:GetUnitByID(unitID);

    if not player:IsHuman() or not player:IsAlive() then
        return;
    end

    -- Scouts seem to stay automated until there's nothing left to explore
    if (PreGame.GetGameOption("GAMEOPTION_SCOUTS_START_AUTO") == 1) then
        if unit ~= nil and unit:GetUnitType() == GameInfo.Units["UNIT_SCOUT"].ID then
            -- If the unit isn't in the table we're using to track automated units
            if not automatedUnits[unitID] then
                -- If the unit is already automated (e.g. after loading a save)
                if unit:IsAutomated() then
                    -- Mark the unit as automated by adding its ID to the table
                    automatedUnits[unitID] = true;

                -- If the unit isn't automated, first check that we can automated it
                elseif unit:CanDoCommand(CommandTypes.COMMAND_AUTOMATE, 1) then
                    print("(Mini Civ 5) Automating scout");
                    -- 1 = AutomateTypes.AUTOMATE_EXPLORE in CvEnums.h (from Civ 5 SDK)
                    unit:DoCommand(CommandTypes.COMMAND_AUTOMATE, 1);

                    automatedUnits[unitID] = true;
                end
            end
        end
    end

    -- Every once in a while a worker seems to get ... un-automated, maybe because
    -- another unit is occupying a tile it was going to move to? I'm not sure
    -- it's worth worrying about since the workaround is as simple as clicking automate
    -- again (Does this happen in Civ 5 too?)
    if (PreGame.GetGameOption("GAMEOPTION_WORKERS_START_AUTO") == 1) then
        if unit ~= nil and unit:GetUnitType() == GameInfo.Units["UNIT_WORKER"].ID then
            if not automatedUnits[unitID] then
                if unit:IsAutomated() then
                    automatedUnits[unitID] = true;

                elseif unit:CanDoCommand(CommandTypes.COMMAND_AUTOMATE, 0) then
                    print("(Mini Civ 5) Automating worker");
                    -- 0 = AutomateTypes.AUTOMATE_BUILD in CvEnums.h (from Civ 5 SDK)
                    unit:DoCommand(CommandTypes.COMMAND_AUTOMATE, 0);

                    automatedUnits[unitID] = true;
                end
            end
        end
    end
end
Events.SerialEventUnitCreated.Add(MaybeAutomateUnit);
