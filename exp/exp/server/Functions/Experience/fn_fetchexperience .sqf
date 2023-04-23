private _uid = [_this,0,"",[""]] call BIS_fnc_param;
_ownerID = [_this,1,objNull,[objNull]] call BIS_fnc_param;
_ownerID = owner _ownerID;
diag_log format ["%1 fetch experience log", _this];
if (_uid isEqualTo "") exitWith {};
private _query = "";

_query = format ["SELECT PID, exp_experience, exp_level, exp_points, exp_perks FROM experience WHERE PID='%1'",_uid];
private _queryResult = [_query,2] call DB_fnc_asyncCall;
if (_queryResult isEqualType "") exitWith {
    [] remoteExecCall ["life_fnc_firstjoin",_ownerID];
};
if (count _queryResult isEqualTo 0) exitWith {
    [] remoteExecCall ["life_fnc_firstjoin",_ownerID];
};
_tmp = _queryResult select 1;
_queryResult set[1,[_tmp] call DB_fnc_numberSafe];
_tmp = _queryResult select 2;
_queryResult set[2,[_tmp] call DB_fnc_numberSafe];
_tmp = _queryResult select 3;
_queryResult set[3,[_tmp] call DB_fnc_numberSafe];
_new = [(_queryResult select 4)] call DB_fnc_mresToArray;
if (_new isEqualType "") then {_new = call compile format ["%1", _new];};
_queryResult set[4,_new];
_queryResult remoteExec ["life_fnc_experienceReceived",_ownerID];