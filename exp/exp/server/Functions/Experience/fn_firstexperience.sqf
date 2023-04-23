#include "\life_server\script_macros.hpp"

/*
    File: fn_insertRequest.sqf
    Author: Bryan "Tonic" Boardwine
    Description:
    Adds a player to the database upon first joining of the server.
    Receives information from core\session\fn_insertPlayerInfo.sqf
*/

// Declare private variables
private ["_queryResult", "_query", "_alias"];

// Declare function parameters
params [
    "_uid",                     // Player's unique ID
    "_name",                    // Player's name
    ["_exp_experience", -1, [0]],  // Player's experience
    ["_exp_level", -1, [0]],        // Player's level
    ["_exp_points", -1, [0]],       // Player's points
    ["_life_exp_perks", [], [[]]],  // Player's perks
    ["_returnToSender", objNull, [objNull]] // Object to send the response to
];

// Check for errors
if ((_uid isEqualTo "") || (_name isEqualTo "")) then {
    // If the player's ID or name is empty, exit with an error message
    systemChat "Bad UID or name";
    exitWith {};
}

if (isNull _returnToSender) then {
    // If there is no object to send the response to, exit with an error message
    systemChat "ReturnToSender is Null!";
    exitWith {};
}

// Prepare the database query to check if the player already exists
_query = format ["SELECT pid, name FROM experience WHERE pid='%1'", _uid];

// Call the asynchronous database function to execute the query
_queryResult = [_query, 2] call DB_fnc_asyncCall;

// Double check to make sure the client isn't in the database...
if (_queryResult isEqualType "") then {
    // If the query result is empty, the player is already in the database
    [] remoteExecCall ["life_fnc_dataexperience", (owner _returnToSender)];
    exitWith {};
}

if !(count _queryResult isEqualTo 0) then {
    // If the query result is not empty, the player is already in the database
    [] remoteExecCall ["life_fnc_dataexperience", (owner _returnToSender)];
    exitWith {};
}

// Cleanse and prepare some information
_name = [_name] call DB_fnc_mresString;           // Remove bad characters from the player's name
_alias = [[_alias]] call DB_fnc_mresArray;        // Ensure that _alias is an array
_life_exp_perks = [_life_exp_perks] call DB_fnc_mresArray; // Ensure that _life_exp_perks is an array
_exp_experience = [_exp_experience] call DB_fnc_numberSafe; // Ensure that _exp_experience is a number
_exp_points = [_exp_points] call DB_fnc_numberSafe;           // Ensure that _exp_points is a number
_exp_level = [_exp_level] call DB_fnc_numberSafe;             // Ensure that _exp_level is a number

// Prepare the query statement to insert the player's data into the database
_query = format ["INSERT INTO experience (pid, name, exp_experience, exp_level, exp_points, exp_perks) VALUES('%1', '%2', '%3', '%4', '%5', '%6')",
    _uid,
    _name,
    _exp_experience,
    _exp_level,
    _exp_points,
    _life_exp_perks
];

// Call the asynchronous database function to execute the query
[_query, 1] call DB_fnc_asyncCall
