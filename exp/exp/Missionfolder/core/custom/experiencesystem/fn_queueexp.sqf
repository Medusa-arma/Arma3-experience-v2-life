#include "..\..\..\script_macros.hpp"

// This section uses a push-pop data structure to queue up experience gained by the player. 
// This ensures that the experience bar does not glitch when multiple calls to the give experience 
// function are made at the same time.

// Check if player has already reached the max level
if (life_exp_level == life_exp_max_level) exitwith {};

// Get the experience gained and the message to be displayed
private _gained =  _this select 0;
private _message = _this select 1;

// Queue up the experience
life_exp_exp_queue pushBack [_gained, _message];

// Check if any experience has been received
if (life_exp_recived == true) then { 

    // If experience has been received, give the player the experience and remove it from the queue
    while {count life_exp_exp_queue != 0} do {
        life_exp_recived = false;
        life_exp_graph_done = false;
        [life_exp_exp_queue select 0 select 1, life_exp_exp_queue select 0 select 1] call life_fnc_giveexperience; 
        life_exp_exp_queue deleteAt 0;
        
        // Wait until the experience bar is updated
        waitUntil {life_exp_graph_done == true};
    };
    life_exp_recived = true;
};

// Example usage: [10, "test"] spawn life_fnc_queueexp;
