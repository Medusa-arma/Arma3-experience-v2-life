#include "..\..\..\script_macros.hpp"

/* 
    File: fn_giveexperience.sqf
    Author: Medusa
    Description: This function gives experience points to the player and updates the progress bar
*/

// Disable serialization and wait for 0.25 seconds for smoothness
disableSerialization;
uiSleep 0.25;

// Set up variables
private _compare = life_exp_Experience; // Used to set the base for the progress bar
private _expplus = life_exp_Experience; // Used to calculate what is going to be added
life_exp_Experience = life_exp_Experience + _gained; // Add the experience to the player
private _next_level = life_exp_for_level select life_exp_level select 1; // The experience points required for the next level
life_exp_experience_gained = _gained; // The experience gained can be used for logging
hint format ["You have gained %1 experience", _gained]; // Display a hint message to the player

// Set up the progress bar
private _upp = "Experience";
disableSerialization;
"MyProgressBar" cutRsc ["MyProgressBar","PLAIN"];
_ui = uiNamespace getVariable "PBarProgress";
_gainedtext = _ui displayCtrl 37204;
_gainedtext ctrlSetText format ["%1 you have gained %2 experience", _message, _gained]; 
_progress = _ui displayCtrl 37202;
_pgText = _ui displayCtrl 37203;
private _bar_exp = 1; // Used to calculate the progress of the progress bar

// Update the progress bar for each experience point gained
for [{_i = _compare}, {_i < life_exp_experience_gained + _expplus}, {_i = _i + 1}] do { 
    uiSleep 0.05; 
    _bar_exp = _bar_exp + 1;
    _progress progressSetPosition ((_bar_exp + _compare)  / _next_level);
    _pgText ctrlSetText format ["%1 %2 / %3",_upp,(_bar_exp - 1 + _compare), _next_level];
    
    // If the player has reached the required experience points for the next level, level up!
    if ((_bar_exp + _compare) >= _next_level) then {
        _pgText ctrlSetText format ["%1 %2 / %3",_upp,(_bar_exp + _compare), _next_level]; 
        hint "you have leveled up!"; 
        life_exp_points = life_exp_points + (life_exp_for_level select life_exp_level select 0); // Add perk points
        life_exp_level = life_exp_level + 1; 
        life_exp_Experience = life_exp_Experience - _bar_exp - _compare; // Deduct experience points
        uiSleep 2; 
        
        // Set up a new progress bar for the next level
        _compare = 0; 
        _bar_exp = 0;
        _next_level = life_exp_for_level select (life_exp_level + 1) select 1;
        _pgText ctrlSetText format ["%1 %2 / %3",_upp,(_bar_exp + _compare), _next_level];
        _progress progressSetPosition (_bar_exp / _next_level);
    };
};

// Clean up the progress bar
uiSleep 1.25;
"MyProgressBar" cutText ["","PLAIN"]; 

// Save the experience points and reset the gained experience
[] call life_fnc_saveexperience;
life_exp_experience_gained = 0; 
life_exp_graph_done = true; 
