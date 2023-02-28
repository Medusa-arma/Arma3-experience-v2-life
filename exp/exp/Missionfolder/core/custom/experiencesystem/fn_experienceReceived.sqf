life_exp_Experience = parseNumber (_this select 1);
life_exp_level = parseNumber (_this select 2);
life_exp_points = parseNumber (_this select 3); 
life_exp_perks_temp = _this select 4;

//systemChat format ["%1", life_exp_perks];
life_exp_init = true;

if (life_exp_debug == 1) then {
    diag_log format ["%1 life_exp_perks_temp from DB = ", life_exp_perks_temp];
};