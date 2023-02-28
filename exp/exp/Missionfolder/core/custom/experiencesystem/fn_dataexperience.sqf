#include "..\..\..\script_macros.hpp"
private ["_uid","_sender"];
_sender = player;
_uid = getPlayerUID _sender;
[_uid, _sender] remoteExec ["TON_fnc_fetchexperience",RSERV];

