#include "..\..\..\script_macros.hpp"

/* 
    File: fn_saveexperience.sqf
    Author: Medusa
    Description: Saves player experience data to server
*/ 

// Get player info
_uid = getPlayerUID player;
_owner = player;

// Get experience data
private _exp_experience = life_exp_Experience;
private _exp_level = life_exp_level;
private _exp_perks = life_exp_perks;
private _exp_points = life_exp_points;

// Create array to send to server
private _experiencearray = [_uid, _owner, _exp_experience, _exp_level, _exp_points, _exp_perks];

// Debug logging
if (life_exp_debug == 1) then {
    diag_log format ["%1 saving experience array = ", _experiencearray];
}

// Send array to server to save
_experiencearray remoteExecCall ["TON_fnc_saveexperienceserver",RSERV];
