private _type = lbData[1456,(lbCurSel 1456)];
private _price = lbValue[1456,(lbCurSel 1456)];

// Search for the right array index
private _lookup = 0;
private _search = false;
private _i = 0;
private _key = 0; 
private _exit = nil;

while {_search == false} do {
	_lookup = life_exp_perks_choice select _i find _type; 
	if (_lookup == 0) then {
		_key = _i; 
		_search = true; 
		break;
	};
	if (_i > count life_exp_perks_choice - 1) exitWith {
		hint "Error: could not find array. Please contact admin!"; 
	};
	_i = _i + 1;
};

// Get current count and price
private _count = count (life_exp_perks_choice select _i select 3);
_price = life_exp_perks_choice select _i select 3;
private _counter = life_exp_perks select _i select 1; 
_price = _price select _counter;

// Exit if maximum upgrades or not enough points
if ((life_exp_perks select _key select 1) == _count) exitWith {hint "You have reached the max amount of upgrades for this";};
if (_price > life_exp_points) exitWith {hint "You do not have enough points to do this"};

// Check for conditions
private _conditions = (life_exp_perks_choice select _i select 1);
if (_conditions != "") then {
	_exit = [_conditions] call life_fnc_levelcheck;
	waitUntil {_exit == false || _exit == true};
	if !(_exit) exitWith {
		hint "You do not meet the conditions for this level up!";
	};
};
if !(_exit) exitWith {};

// Update experience perks
private _temp = 0;
private _update = life_exp_perks select _key select 1;
_update = _update + 1;
life_exp_perks set [_key, [_type, _update]]; 

// Deduct points and save experience
life_exp_points = life_exp_points - _price;
[] call life_fnc_saveexperience;
[] call life_fnc_Experience_menu;
