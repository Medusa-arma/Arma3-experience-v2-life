#include "..\..\..\script_macros.hpp"
/* 
    File: fn_experienceinit.sqf
    Author: Medusa
	setup experience system
    notes: This should be fully modularized code for any new addtions for new levels and perks 
*/ 
private _timeStamp = diag_tickTime;
private _unit = player;
private _sender = player;
private _uid = getPlayerUID _sender;
// lets set up our vars
life_exp_init = false;
life_exp_debug = getNumber(missionConfigFile >> "Experice_cfg" >> "Master_exp" >> "debug_exp");
life_exp_Experience = 0; 
life_exp_number_upgrades = count (missionConfigFile >> "Upgrades_exp");
life_exp_level = 0;
life_exp_points = 0;  
life_exp_perks = []; // [[classname, lvl], [...]] format?
life_exp_perks_temp = [];
life_exp_for_level = [];
life_exp_exp_queue = []; 
life_exp_max_level = count (missionConfigFile >> "Level_exp");
life_exp_recived = true;
life_exp_experience_gained = 0;
life_exp_graph_done = true;

life_exp_perks_choice = [];
private ["_temp","_temp2","_temp3","_temp4", "_temp5", "_temp6"]; // This will be our temp vars to make sure we dont overide anything
// lets go through the config!
{
    _temp = getNumber (missionConfigFile >> "Upgrades_exp" >> _x  >> "id");
    _temp2 = gettext (missionConfigFile >> "Upgrades_exp" >> _x  >> "name");
    _temp3 = gettext (missionConfigFile >> "Upgrades_exp" >> _x  >> "conditions");
    _temp4 = gettext (missionConfigFile >> "Upgrades_exp" >> _x  >> "description");
    _temp5 = getarray (missionConfigFile >> "Upgrades_exp" >> _x >> "cost");
    _temp6 = [[_temp, _temp2, _temp3, _temp4, _temp5]]; 
    life_exp_perks_choice append _temp6;
} forEach ((missionConfigFile >> "Upgrades_exp") call BIS_fnc_getCfgSubClasses);

life_exp_perks_choice sort true; // sort them based on ID numbers 
{
	_x deleteAt 0;
} forEach life_exp_perks_choice;

{
    _temp = getNumber (missionConfigFile >> "Level_exp" >> _x  >> "points");
    _temp2 = getNumber (missionConfigFile >> "Level_exp" >> _x  >> "exp_req");
    _temp5 = [[_temp, _temp2]]; 
    life_exp_for_level append _temp5;
    
} forEach ((missionConfigFile >> "Level_exp") call BIS_fnc_getCfgSubClasses);
// same things as above, just a little differnt 
{
    _temp = [[_x select 0, 0]]; // we will pull names for easy reading of database
    life_exp_perks append _temp;
    
} forEach life_exp_perks_choice;

if (life_exp_debug == 1) then {
    diag_log format ["%1 life_exp_perks = ", life_exp_perks];
    diag_log format ["%1 life_exp_perks_choice = ", life_exp_perks_choice];
};

// one last check to see if there was a config change
[_uid, _sender] remoteExec ["TON_fnc_fetchexperience",RSERV];
waitUntil {life_exp_init}; // wait because we need our vars from DB
private _search_var = 0;
private _search_var2 = 0;
private _split_array = [];
private _split_array2 = [];
{ 
    _split_array pushBack (_x select 0); // split array for search
} forEach life_exp_perks;

{ 
    _split_array2 pushBack (_x select 0); // same as above
} forEach life_exp_perks_temp; // we need this temp for what we are pulling from the database to compare 
{ 
    _search_var = _split_array find (_x select 0); 
    if (_search_var == -1) then { 
        diag_log "Error in exp init check cfg for error";
    } else {
        _search_var2 = _split_array2 find (life_exp_perks select _search_var select 0);
        if (_search_var2 == -1) then { // this is pretty neat 
            life_exp_perks set [_search_var, [(_x select 0), 0]];
        } else { // 
            life_exp_perks set [_search_var, [(_x select 0), (life_exp_perks_temp select _search_var2 select 1)]]; 
        };
    };  
} forEach life_exp_perks;
if (life_exp_debug == 1) then {
    diag_log format ["%1 life_exp_perks after swap = ", life_exp_perks];
    diag_log format ["%1 life_exp_perks_choice after swap = ", life_exp_perks_choice];
};


{
    life_exp_names pushBack (_x select 0);
} forEach life_exp_perks;

life_exp_perks_temp = nil; // not needed anymore

diag_log format  ["[EXP_system] system loaded in %1", (diag_tickTime - _timeStamp)];