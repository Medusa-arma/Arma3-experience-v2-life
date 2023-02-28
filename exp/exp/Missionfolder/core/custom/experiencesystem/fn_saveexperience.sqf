#include "..\..\..\script_macros.hpp"
/* 
    File: fn_saveexperience.sqf
    Author: Medusa
	save your experience
*/ 
_uid = getPlayerUID player;
_owner = player;

private _exp_experience = life_exp_Experience;
private _exp_level = life_exp_level;
private _exp_perks = life_exp_perks;
private _exp_points = life_exp_points;

private _experiencearray = [_uid, _owner, _exp_experience, _exp_level, _exp_points, _exp_perks];
if (life_exp_debug == 1) then {
    diag_log format ["%1 saving experience array = ", _experiencearray];
};
_experiencearray remoteExecCall ["TON_fnc_saveexperienceserver",RSERV];
