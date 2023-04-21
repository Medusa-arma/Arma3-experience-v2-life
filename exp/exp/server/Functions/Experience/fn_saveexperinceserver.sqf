private _uid = [_this,0,"",[""]] call BIS_fnc_param;
private _ownerID = [_this,1,objNull,[objNull]] call BIS_fnc_param;
private _exp_experience = [_this,2,0,[0]] call BIS_fnc_param;
private _exp_level = [_this,3,0,[0]] call BIS_fnc_param;
private _exp_points = [_this,4,0,[0]] call BIS_fnc_param;
private _exp_perks = [_this,5,[],[[]]] call BIS_fnc_param;


diag_log format ["%1 save experience log", _this];
_exp_experience = [_exp_experience] call DB_fnc_numberSafe;
_exp_level = [_exp_level] call DB_fnc_numberSafe;
_exp_points = [_exp_points] call DB_fnc_numberSafe;
_exp_perks = [_exp_perks] call DB_fnc_mresArray;
private _query = format ["UPDATE experience SET exp_experience='%1', exp_level='%2', exp_points='%3', exp_perks='%4' WHERE pid='%5'", _exp_experience, _exp_level, _exp_points, _exp_perks, _uid];
private _queryResult = [_query,1] call DB_fnc_asyncCall;