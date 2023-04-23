#include "..\..\..\script_macros.hpp"

// Wait until the experience menu display exists before continuing
waitUntil {!isNull (findDisplay 1458)};

// Clear the listbox
private _listbox = CONTROL(1458, 1456);
lbClear _listbox;

// Initialize variables
private _price = 0;
private _i = 0;
private _count = 0;

// Set the structured text of the experience points label to the current value of life_exp_points
CONTROL(1458, 1455) ctrlSetStructuredText parseText format ["Experience points %1", life_exp_points];

// Loop through each perk in the life_exp_perks_choice array and add it to the listbox
{
    // Get the count and price of the perk
    _count = count (life_exp_perks_choice select _i select 3);
    _price = _x select 3 select (life_exp_perks select _i select 1);

    // If the price is undefined, set it to 9999
    if (isNil "_price") then {
        _price = 9999;
    }

    // Add the perk to the listbox
    _listbox lbAdd format ["%1, %2 / %3", _x select 0, life_exp_perks select _i select 1, _count];
    _listbox lbSetData [(lbSize _listbox) - 1, _x select 0];
    _listbox lbSetValue [(lbSize _listbox) - 1, _price];

    // Output debug information if life_exp_debug is set to 1
    if (life_exp_debug == 1) then {
        diag_log format ["%1, %2 / %3 experience menu", _x select 0, life_exp_perks select _i select 1, _count];
    }

    // Increment the index variable
    _i = _i + 1;
} foreach life_exp_perks_choice;

// Set the progress bar to show the current level progress
private _nextlevel = life_exp_for_level select life_exp_level select 1;
private _level = life_exp_Experience; 
private _progress = _level / _nextlevel;
CONTROL(1458, 1454) progressSetPosition _progress;

// Set the structured text of the current level label to the current value of life_exp_level
CONTROL(1458, 1453) ctrlSetStructuredText parseText format ["Current level %1", life_exp_level];
