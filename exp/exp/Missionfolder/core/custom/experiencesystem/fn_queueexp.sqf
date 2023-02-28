#include "..\..\..\script_macros.hpp"
// queue up the experience using a push pop type data structure to queue up the experience recived
// this should fix the probmlem of making the exp bar glitch when given more than one call at a time.
// so lets make it into a queue

if (life_exp_level == life_exp_max_level) exitwith {};
private _gained =  _this select 0;
private _message = _this select 1;

life_exp_exp_queue pushBack [_gained, _message];
if (life_exp_recived == true) then { 
	while {count life_exp_exp_queue != 0} do {
		life_exp_recived = false;
		life_exp_graph_done = false;
		[life_exp_exp_queue select 0 select 1, life_exp_exp_queue select 0 select 1] call life_fnc_giveexperience; 
		life_exp_exp_queue deleteAt 0;
		waitUntil {life_exp_graph_done == true};
	};
	life_exp_recived = true;
};

// [10, "test"] spawn life_fnc_queueexp;