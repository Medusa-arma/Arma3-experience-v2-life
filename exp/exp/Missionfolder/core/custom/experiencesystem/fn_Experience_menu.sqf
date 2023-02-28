#include "..\..\..\script_macros.hpp"
// [] spawn {sleep 2; createDialog "Experience_Menu";}
private ["_price","_tester"];
waitUntil {!isNull (findDisplay 1458)};
private _listbox = CONTROL(1458,1456);
lbClear _listbox;
private _price = 0;
private _i = 0;
private _count = 0;

CONTROL(1458,1455) ctrlSetStructuredText parseText format ["Experience points %1", life_exp_points]; 
{
	_count = count (life_exp_perks_choice select _i select 3);
	_price = _x select 3 select (life_exp_perks select _i select 1);
	if (isNil "_price") then {_price = 9999;};
	//systemChat format ["%1 %2 this is the type and price", _i, _price]; 
	_listbox lbAdd format ["%1, %2 / %3", _x select 0, life_exp_perks select _i select 1, _count]; // formated for the menu change if you would like it looks like this [name, level, max_level]
	_listbox lbSetData [(lbSize _listbox)-1,_x select 0];
	_listbox lbSetValue [(lbSize _listbox)-1,_price];
	if (life_exp_debug == 1) then {
		diag_log format ["%1, %2 / %3 experience menu", _x select 0, life_exp_perks select _i select 1, _count];
	};
	_i = _i + 1;
} foreach life_exp_perks_choice; 
private _nextlevel = life_exp_for_level select life_exp_level select 1;
private _level = life_exp_Experience; 
private _progress = _level / _nextlevel;
CONTROL(1458,1454) progressSetPosition _progress;
CONTROL(1458,1453) ctrlSetStructuredText parseText format ["Current level %1", life_exp_level];
