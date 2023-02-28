
class Experice_cfg { 
	class Master_exp { 
		debug_exp = 0; // this will set up simple experience with no real cfg
	};
};
class Upgrades_exp {
	class prossesing_exp { 
		id = 2;
		name = "Prossesing";
		conditions = "";
		description = "STR_EXP_PROS";
		cost[] = {2,4,6};
	};
	class break_in_exp {
		id = 1; 
		name = "Break in";
		conditions = "";
		description = "STR_EXP_REP";
		cost[] = {1,2,3};
	};
	class break_home_exp { 
		id = 3;
		name = "Break into home";
		conditions = "life_exp_level > 2";
		description = "STR_EXP_Home";
		cost[] = {1,2,3};
	};
	class steal_car_exp { 
		id = 5;
		name = "Steal Car";
		conditions = "";
		description = "STR_EXP_Steal";
		cost[] = {1,2,3};
	};
	class rob_store_exp { 
		id = 4;
		name = "Rob store";
		conditions = "";
		description = "STR_EXP_ROB";
		cost[] = {1,2,3};
	};
	class rob_store_fed_exp { 
		id = 6;
		name = "Rob fed";
		conditions = "";
		description = "STR_EXP_ROB_fed";
		cost[] = {1,2,3};
	};
};
class Level_exp { 
	class 1_exp { 
		points = 1;
		exp_req = 100;
	};
	class 2_exp { 
		points = 2;
		exp_req = 200;
	};
	class 3_exp { 
		points = 3;
		exp_req = 300;
	};
	class 4_exp { 
		points = 4;
		exp_req = 400;
	};
	class 5_exp { 
		points = 1;
		exp_req = 500;
	};
	class 6_exp { 
		points = 1;
		exp_req = 600;
	};
	class 7_exp { 
		points = 1;
		exp_req = 700;
	};
	class 8_exp { 
		points = 1;
		exp_req = 800;
	};
	class 9_exp { 
		points = 1;
		exp_req = 900;
	};
	class 10_exp { 
		points = 1;
		exp_req = 1000;
	};
	class 11_exp { 
		points = 1;
		exp_req = 1100;
	};
	class 12_exp { 
		points = 1;
		exp_req = 1200;
	};
	class 13_exp { 
		points = 1;
		exp_req = 1300;
	};
	class 14_exp { 
		points = 1;
		exp_req = 1400;
	};
	class 15_exp { 
		points = 1;
		exp_req = 1500;
	};
	class 16_exp { 
		points = 1;
		exp_req = 1600;
	};
	class 17_exp { 
		points = 1;
		exp_req = 1700;
	};
	class 18_exp { 
		points = 1;
		exp_req = 1800;
	};
	class 19_exp { 
		points = 1;
		exp_req = 1900;
	};
	class 20_exp { 
		points = 1;
		exp_req = 2000;
	};
};