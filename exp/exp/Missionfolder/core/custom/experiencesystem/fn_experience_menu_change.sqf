#include "..\..\..\script_macros.hpp"

// Get the name of the selected perk from the listbox
private _name = (_this select 0) lbData (_this select 1);

// Initialize variables
private _g = 0;
private _isfound = false;

// Loop through each perk in the life_exp_perks array and check if it matches the selected name
for [{_i = 0}, {_i < (count life_exp_perks)}, {_i = _i + 1}] do {
    _isfound = life_exp_perks_choice select _i select 0 == _name;

    // If the name is found, set the index variable and break out of the loop
    if (_isfound == true) then {
        _g = _i;
        break;
    }
}

// Get the description text for the selected perk
private _text_menu = life_exp_perks_choice select _g select 2; 

// If the perk is found, set the structured text of the description label to the description of the perk
if (_isfound) then { 
    CONTROL(1458, 1457) ctrlSetStructuredText parseText localize format [_text_menu];
} else { 
    hint "there was an error finding the description please contact admin!"; 
};
