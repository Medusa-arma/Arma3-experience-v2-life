#include "..\..\..\script_macros.hpp"

// Declare private variables
private ["_uid", "_sender"];

// Set the sender variable to the current player object
_sender = player;

// Get the unique ID of the current player
_uid = getPlayerUID _sender;

// Call the remote function TON_fnc_fetchexperience on the server with the UID and sender as parameters
[_uid, _sender] remoteExec ["TON_fnc_fetchexperience", RSERV];
