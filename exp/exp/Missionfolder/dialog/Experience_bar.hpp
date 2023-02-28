#include "CustomControlClasses.hpp"
class MyProgressBar {
	name = "MyProgressBar";
	idd = 37200;
	fadein=0;
	duration = 99999999999;
	fadeout=0;
	movingEnable = 0;
	onLoad = "uiNamespace setVariable ['PBarProgress',_this select 0];";
	objects[]={};
	class ControlsBackground
	{
		class Experiencebar
		{
			type = 8;
			idc = 37202;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.875;
			w = safeZoneW * 0.4125;
			h = safeZoneH * 0.02962963;
			style = 0;
			colorBar[] = {1,1,1,1};
			colorFrame[] = {0,0,0,1};
			texture = "#(argb,8,8,3)color(1,1,1,1)";
			
		};
		class Experiencetext
		{
			type = 13;
			idc = 37204;
			x = safeZoneX + safeZoneW * 0.29375;
			y = safeZoneY + safeZoneH * 0.85;
			w = safeZoneW * 0.27083334;
			h = safeZoneH * 0.025;
			style = 0;
			text = "";
			size = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			colorBackground[] = {1,1,1,0};
			class Attributes
			{
				
			};
			
		};
		
		class Experiencepg
		{
			type = 0;
			idc = 37203;
			x = safeZoneX + safeZoneW * 0.29583334;
			y = safeZoneY + safeZoneH * 0.87870371;
			w = safeZoneW * 0.1515625;
			h = safeZoneH * 0.02222223;
			style = 0;
			text = "";
			colorBackground[] = {0.1176,0.4314,0.8784,0};
			colorText[] = {0.302,0.102,0.302,1};
			font = "PuristaMedium";
			sizeEx = (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1);
			
		};
	};

	class Controls
	{

		
	};
	
};
