private _type = lbData[1456,(lbCurSel 1456)];
private _price = lbValue[1456,(lbCurSel 1456)];
//systemChat format ["%1 %2 this is the type and price", _type, _price];
private _lookup = 0;
private _search = false;
private _i = 0;
private _key = 0; 
private _exit = nil;
// search for the right array
while {_search == false} do { // fuck arma not allowing find multi dimensional arrays
	_lookup = life_exp_perks_choice select _i find _type; 
	if (_lookup == 0) then {
		_key = _i; // use this to find the right upgrade  
		_search = true; 
		break;
	};
	if (_i >  count life_exp_perks_choice - 1) exitwith { // its not in the life_exp_perks_choice array
		Hint "error could not find array. Please Contact admin!"; // if this happens you added a perk in wrong 
	};
	_i = _i + 1;
};


private _count = count (life_exp_perks_choice select _i select 3);   // redo this 
_price = life_exp_perks_choice select _i select 3; 
private _counter = life_exp_perks select _i select 1; 
_price = _price select _counter;
if ((life_exp_perks select _key select 1) == _count) exitwith {hint "You have reached the max amount of upgrades for this";};
if (_price >  life_exp_points) exitwith {hint "You do not have enough points to do this"};
private _conditions = (life_exp_perks_choice select _i select 1);
if (_conditions != "") then { // no condition why would we search
	_exit = [_conditions] call life_fnc_levelcheck; // thanks tonic for saving me time :)
	waitUntil {_exit == false || _exit == true};
	if !(_exit) exitwith {
		hint "you do not meet the conditions for this level up!";
	};
};
if !(_exit) exitwith {};
private _temp = 0; 

// systemChat format ["%1 %2 this is the vars", _type, life_exp_perks select _key select 1];
private _update = life_exp_perks select _key select 1;
_update = _update + 1;
life_exp_perks set [_key, [_type, _update]]; 
life_exp_points = life_exp_points - _price;
[] call life_fnc_saveexperience;
[] call life_fnc_Experience_menu; 

// life_exp_perks_choice select 0 select 3 select ((life_exp_perks select 1 select 1) - 1)
