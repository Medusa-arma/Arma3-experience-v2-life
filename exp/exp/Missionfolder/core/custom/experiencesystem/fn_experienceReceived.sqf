// Set the value of life_exp_Experience to the second element of the passed array
life_exp_Experience = parseNumber (_this select 1);

// Set the value of life_exp_level to the third element of the passed array
life_exp_level = parseNumber (_this select 2);

// Set the value of life_exp_points to the fourth element of the passed array
life_exp_points = parseNumber (_this select 3); 

// Set the value of life_exp_perks_temp to the fifth element of the passed array
life_exp_perks_temp = _this select 4;

// Set the value of life_exp_init to true
life_exp_init = true;

// If life_exp_debug is set to 1, output the value of life_exp_perks_temp to the debug log
if (life_exp_debug == 1) then {
    diag_log format ["%1 life_exp_perks_temp from DB = ", life_exp_perks_temp];
};
