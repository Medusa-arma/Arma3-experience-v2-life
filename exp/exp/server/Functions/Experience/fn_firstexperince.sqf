#include "\life_server\script_macros.hpp"
/*
    File: fn_insertRequest.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Adds a player to the database upon first joining of the server.
    Recieves information from core\sesison\fn_insertPlayerInfo.sqf
*/
private ["_queryResult","_query","_alias"];
params [
    "_uid",
    "_name",
    ["_exp_experice",-1,[0]],
    ["_exp_level",-1,[0]], 
    ["_exp_points",-1,[0]],
	["_life_exp_perks",[],[[]]],
    ["_returnToSender",objNull,[objNull]]
];
//Error checks
if ((_uid isEqualTo "") || (_name isEqualTo "")) exitWith {systemChat "Bad UID or name";}; //Let the client be 'lost' in 'transaction'
if (isNull _returnToSender) exitWith {systemChat "ReturnToSender is Null!";}; //No one to send this to!

_query = format ["SELECT pid, name FROM experience WHERE pid='%1'",_uid];


_tickTime = diag_tickTime;
_queryResult = [_query,2] call DB_fnc_asyncCall;


//Double check to make sure the client isn't in the database...
if (_queryResult isEqualType "") exitWith {[] remoteExecCall ["life_fnc_dataexperience",(owner _returnToSender)];}; //There was an entry!
if !(count _queryResult isEqualTo 0) exitWith {[] remoteExecCall ["life_fnc_dataexperience",(owner _returnToSender)];};

//Clense and prepare some information.
_name = [_name] call DB_fnc_mresString; //Clense the name of bad chars.
_alias = [[_alias]] call DB_fnc_mresArray;
_life_exp_perks = [_life_exp_perks] call DB_fnc_mresArray;
_exp_experice = [_exp_experice] call DB_fnc_numberSafe;
_exp_points = [_exp_points] call DB_fnc_numberSafe;
_exp_level = [_exp_level] call DB_fnc_numberSafe;

//Prepare the query statement..
_query = format ["INSERT INTO experience (pid, name, exp_experience, exp_level, exp_points, exp_perks) VALUES('%1', '%2', '%3', '%4', '%5', '%6')",
    _uid,
    _name,
    _exp_experice,
    _exp_level,
    _exp_points,
	_life_exp_perks
];

[_query,1] call DB_fnc_asyncCall;
[] remoteExecCall ["life_fnc_expericeinit",(owner _returnToSender)];
