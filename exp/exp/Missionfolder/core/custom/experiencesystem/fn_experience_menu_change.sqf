#include "..\..\..\script_macros.hpp"
private _name = (_this select 0) lbData (_this select 1);
private _g = 0;
private _isfound = false;
// systemChat format ["the name is %1", _name];
for [{_i = 0}, {_i < (count life_exp_perks)}, {_i = _i + 1}] do {
	_isfound = life_exp_perks_choice select _i select 0 == _name; // bool to find the name
	// systemChat format ["%1", _i];
	if (_isfound == true) then {_g = _i; break;}; // break the loop to save cpu power
};
private _text_menu = life_exp_perks_choice select _g select 2; 
if (_isfound) then { 
	CONTROL(1458,1457) ctrlSetStructuredText parseText localize 
		format [_text_menu]; // this took me too long to find out :(
} else { 
	hint "there was an error finding the description please contact admin!"; // ccant find the description because of the name. cfg error!
};
  