class Experience_Menu
{
	idd = 1458;
	name= "Experience_Menu";
    movingEnable = 0;
    enableSimulation = 1;
	onLoad = "[] spawn life_fnc_Experience_menu;";

	class ControlsBackground
	{
		class Background: Life_RscText{
		idc = -1;

		x = 0.29375 * safezoneW + safezoneX;
		y = 0.224913 * safezoneH + safezoneY;
		w = 0.4125 * safezoneW;
		h = 0.550174 * safezoneH;
		colorText[] = {0.6706,0.3608,0.3804,1};
		colorBackground[] = {0,0,0,0.7};
	};
		
	};
	class Controls
	{
		class Experience_list: Life_RscListBox
	{
		idc = 1456;
		onLBSelChanged = "_this call life_fnc_experience_menu_change";

		x = 0.319222 * safezoneW + safezoneX;
		y = 0.299076 * safezoneH + safezoneY;
		w = 0.1125 * safezoneW;
		h = 0.400001 * safezoneH;
		colorText[] = {0.6,0.6,0.6,1};
		colorBackground[] = {0,0,0,0.7};
	};
		class Description: Life_RscText
	{
		type = 13;
		idc = 1457;
		size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

		x = 0.443797 * safezoneW + safezoneX;
		y = 0.299957 * safezoneH + safezoneY;
		w = 0.2375 * safezoneW;
		h = 0.400001 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
		class Welcome_message: Life_RscText
	{
		idc = 0;
		font = "PuristaMedium";

		text = "Experience Menu"; //--- ToDo: Localize;
		x = 0.319531 * safezoneW + safezoneX;
		y = 0.268927 * safezoneH + safezoneY;
		w = 0.1125 * safezoneW;
		h = 0.0249999 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
		class buy_experience: Life_RscButtonMenu
	{
		onButtonClick = "[] call life_fnc_upgrade_experience;";

		idc = 1004;
		text = "Purchase XP"; //--- ToDo: Localize;
		x = 0.583428 * safezoneW + safezoneX;
		y = 0.709066 * safezoneH + safezoneY;
		w = 0.0979687 * safezoneW;
		h = 0.022007 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0.7};
	};
		class Close: Life_RscButtonMenu
	{
		onButtonClick = "closeDialog 0;";

		idc = 1005;
		text = "Close"; //--- ToDo: Localize;
		x = 0.319531 * safezoneW + safezoneX;
		y = 0.709066 * safezoneH + safezoneY;
		w = 0.0928125 * safezoneW;
		h = 0.022007 * safezoneH;
		colorText[] = {1,1,1,1};
		colorBackground[] = {0,0,0,0.7};
	};
		class Experience_points: Life_RscText
	{
		type = 13;
		idc = 1455;
		size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

		x = 0.577344 * safezoneW + safezoneX;
		y = 0.268927 * safezoneH + safezoneY;
		w = 0.102604 * safezoneW;
		h = 0.0249999 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
		class Experience: Life_RscProgress
	{
		idc = 1454;
		colorBar[] = {1,1,1,1};
		texture = "#(argb,8,8,3)color(1,1,1,1)";

		x = 0.324687 * safezoneW + safezoneX;
		y = 0.742077 * safezoneH + safezoneY;
		w = 0.350625 * safezoneW;
		h = 0.022007 * safezoneH;
	};
	class Current_experience: Life_RscText
	{
		type = 13;
		idc = 1453;
		size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

		x = 0.444313 * safezoneW + safezoneX;
		y = 0.709066 * safezoneH + safezoneY;
		w = 0.0721875 * safezoneW;
		h = 0.022007 * safezoneH;
		colorBackground[] = {0,0,0,0.2};
	};
		
	};
	
};