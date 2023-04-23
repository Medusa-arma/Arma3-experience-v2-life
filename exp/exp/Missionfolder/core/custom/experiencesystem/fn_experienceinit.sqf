#include "..\..\..\script_macros.hpp"

/* 
    File: fn_experienceinit.sqf
    Author: Medusa
    Description: Sets up the experience system by initializing variables and parsing configuration files
*/

// Initialize variables
private _timeStamp = diag_tickTime;
private _unit = player;
private _sender = player;
private _uid = getPlayerUID _sender;
life_exp_init = false;
life_exp_debug = getNumber(missionConfigFile >> "Experice_cfg" >> "Master_exp" >> "debug_exp");
life_exp_Experience = 0; 
life_exp_number_upgrades = count (missionConfigFile >> "Upgrades_exp");
life_exp_level = 0;
life_exp_points = 0;  
life_exp_perks = []; 
life_exp_perks_temp = [];
life_exp_for_level = [];
life_exp_exp_queue = []; 
life_exp_max_level = count (missionConfigFile >> "Level_exp");
life_exp_recived = true;
life_exp_experience_gained = 0;
life_exp_graph_done = true;
life_exp_perks_choice = [];

// Parse the Upgrades_exp configuration file and add the results to the life_exp_perks_choice array
{
    // Get the data for each upgrade
    private _temp = getNumber (missionConfigFile >> "Upgrades_exp" >> _x  >> "id");
    private _temp2 = gettext (missionConfigFile >> "Upgrades_exp" >> _x  >> "name");
    private _temp3 = gettext (missionConfigFile >> "Upgrades_exp" >> _x  >> "conditions");
    private _temp4 = gettext (missionConfigFile >> "Upgrades_exp" >> _x  >> "description");
    private _temp5 = getarray (missionConfigFile >> "Upgrades_exp" >> _x >> "cost");
    private _temp6 = [[_temp, _temp2, _temp3, _temp4, _temp5]]; 

    // Append the upgrade data to the life_exp_perks_choice array
    life_exp_perks_choice append _temp6;
} forEach ((missionConfigFile >> "Upgrades_exp") call BIS_fnc_getCfgSubClasses);

life_exp_perks_choice sort true; // Sort the life_exp_perks_choice array based on ID numbers 
{
    _x deleteAt 0; // Remove the ID number from each element
} forEach life_exp_perks_choice;

// Parse the Level_exp configuration file and add the results to the life_exp_for_level array
{
    // Get the data for each level
    private _temp = getNumber (missionConfigFile >> "Level_exp" >> _x  >> "points");
    private _temp2 = getNumber (missionConfigFile >> "Level_exp" >> _x  >> "exp_req");
    private _temp5 = [[_temp, _temp2]]; 

    // Append the level data to the life_exp_for_level array
    life_exp_for_level append _temp5;
} forEach ((missionConfigFile >> "Level_exp") call BIS_fnc_getCfgSubClasses);

// Add the names of the perks to the life_exp_perks array
{
    private _temp = [[_x select 0, 0]];
    life_exp_perks append _temp;
} forEach life_exp_perks_choice;

if (life_exp_debug == 1) then {
    diag_log format ["%1 life_exp_perks = ", life_exp_perks];
    diag_log format ["%1 life_exp_perks_choice = ", life_exp_perks_choice];
};
// Check if there were any changes to the configuration files
if (life_exp_debug == 1) then {
    diag_log "EXP_cfg changes detected!";
};
{
    if (_x select 0 == "Level_exp") then {
        if (life_exp_debug == 1) then {
            diag_log format ["%1 EXP System Config file changes found, reloading config data", diag_tickTime];
        };
        life_exp_for_level = [];
        {
            _temp = getNumber (_x select 1 >> "points");
            _temp2 = getNumber (_x select 1 >> "exp_req");
            _temp5 = [[_temp, _temp2]];
            life_exp_for_level append _temp5;
        } forEach ((missionConfigFile >> "Level_exp") call BIS_fnc_getCfgSubClasses);
    };
} forEach ["Upgrades_exp", "Level_exp"];

if (life_exp_debug == 1) then {
    diag_log format ["%1 life_exp_for_level after swap = ", life_exp_for_level];
};

// Reset player progress upon major changes or first start
if (life_exp_Experience > life_exp_for_level select life_exp_max_level select 1) then {
    if (life_exp_debug == 1) then {
        diag_log format ["%1 Experience out of bounds. Exp reset.", diag_tickTime];
    };
    life_exp_Experience = 0;
    life_exp_level = 0;
    life_exp_points = 0;
    life_exp_perks = [];
    {
        _temp = [[_x select 0, 0]];
        life_exp_perks append _temp;
    } forEach life_exp_perks_choice;
    [_uid, _sender] remoteExec ["TON_fnc_fetchexperience",RSERV];
    waitUntil {life_exp_init}; // wait because we need our vars from DB
}

if (life_exp_debug == 1) then {
    diag_log format ["%1 Experience Settings have been set!", diag_tickTime];
};
