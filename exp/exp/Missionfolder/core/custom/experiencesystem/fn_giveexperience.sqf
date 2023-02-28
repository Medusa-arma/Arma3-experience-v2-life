#include "..\..\..\script_macros.hpp"
/* 
    File: fn_giveexperience.sqf
    Author: Medusa
	give experience to the player 
    Note: big mess need to clean this up
*/
disableSerialization;
uisleep 0.25;
private _compare = life_exp_Experience; // to set base for progress bar
private _expplus = life_exp_Experience; // to help what is gonna be added 
life_exp_Experience = life_exp_Experience + _gained; // add the experience to player
private _next_level = life_exp_for_level select life_exp_level select 1;
life_exp_experience_gained = _gained; // life_exp_experience_gained maybe used for logs later
hint format ["You have gained %1 experience", _gained];
private _upp = "Experience"; // inspired by tonic brutalised by medusa
disableSerialization;
"MyProgressBar" cutRsc ["MyProgressBar","PLAIN"];
_ui = uiNamespace getVariable "PBarProgress";
_gainedtext = _ui displayCtrl 37204;
_gainedtext ctrlSetText format ["%1 you have gained %2 experience", _message, _gained]; 
_progress = _ui displayCtrl 37202;
_pgText = _ui displayCtrl 37203;
private _bar_exp = 1;
_pgText ctrlSetText format ["%1 %4, %2 / %3",_upp,life_exp_Experience,_next_level,_bar_exp];
_progress progressSetPosition (_compare / _next_level);
// this is a mess we need to reset the whole bar then we need make sure that we reset the vars 
// then we need to subtract the vars from what was recived and make sure that we make it look nice
// this is why scripting sucks
for [{_i = _compare}, {_i < life_exp_experience_gained + _expplus}, {_i = _i + 1}] do { 
    uiSleep 0.05; 
    _bar_exp = _bar_exp + 1;
    _progress progressSetPosition ((_bar_exp + _compare)  / _next_level);
    _pgText ctrlSetText format ["%1 %2 / %3",_upp,(_bar_exp - 1 + _compare), _next_level];
    if ((_bar_exp + _compare) >= _next_level) then {
        _pgText ctrlSetText format ["%1 %2 / %3",_upp,(_bar_exp + _compare), _next_level]; 
        hint "you have leveled up!"; 
        life_exp_points = life_exp_points + (life_exp_for_level select life_exp_level select 0);
        life_exp_level = life_exp_level + 1; 
        life_exp_Experience = life_exp_Experience - _bar_exp - _compare;
        uiSleep 2; 
        // new bar for level up!
        _compare = 0; 
        _bar_exp = 0;
        _next_level = life_exp_for_level select (life_exp_level + 1) select 1;
        _pgText ctrlSetText format ["%1 %2 / %3",_upp,(_bar_exp + _compare), _next_level];;
        _progress progressSetPosition (_bar_exp / _next_level);
    };
};
uiSleep 1.25;
"MyProgressBar" cutText ["","PLAIN"]; 
[] call life_fnc_saveexperience;
life_exp_experience_gained = 0; 
life_exp_graph_done = true; 