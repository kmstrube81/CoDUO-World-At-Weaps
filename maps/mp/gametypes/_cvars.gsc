initServerCvars()
{
	//init debug level
	level.waw_debug = cvardef("scr_waw_debug", "", "", "", "string");
	
	//init loadout points
	if(getCvar("scr_default_loadout_points") == "")		
		setCvar("scr_default_loadout_points", "3");	//default is ON
	level.default_loadout_points = getCvarint("scr_default_loadout_points");
	setCvar("ui_default_loadout_points", level.default_loadout_points);
	makeCvarServerInfo("ui_default_loadout_points", "0");
	
	//init bleedout
	level.waw_bleeding	= cvardef("scr_waw_bleedout", 20, 0, 100, "int");
	if(level.waw_bleeding)
		level.waw_bleedingfx = loadfx("fx/atmosphere/drop1.efx");
	
	//init body burning
	level.waw_burningbodies		= cvardef("scr_waw_burn_time", 30, 0, 90, "float");
	if(level.waw_burningbodies)
	{
		level.waw_burningbodies_smokefx = loadfx("fx/smoke/smoke_flamethrower.efx");
		level.waw_burningbodies_burnfx = loadfx("fx/fire/barreloil_fire.efx");
	}
	
	//init team play
	level.waw_gametype = getCvar("g_gametype");
	switch(level.waw_gametype)
	{
		case "dm":
			level.waw_teamplay = false;
			break;
		default:
			level.waw_teamplay = true;
	}
}

initWeaponCvars()
{
	initRifleCvars();
	initSMGCvars();
	initMGCvars();
	initHeavyCvars();
	initSniperCvars();
	initPistolCvars();
	initGrenadeCvars();
	initSmokeCvars();
	initSatchelCvars();
	initPerkCvars();
	initKSCvars();
	
	//Other Misc Weapon Cvars
	level.allow_panzerfaust = cvardef("scr_allow_panzerfaust",1,0,1,"int");
	cvardef("ui_allow_panzerfaust",level.allow_panzerfaust,0,1,"int");
	makeCvarServerInfo("ui_allow_panzerfaust","1");
}

initRifleCvars()
{
	level.allow_rifles = cvardef("scr_allow_rifles",1,0,1,"int");
	cvardef("ui_allow_rifles",level.allow_rifles,0,1,"int");
	makeCvarServerInfo("ui_allow_rifles","1");
	
	level.allow_uscarbine = cvardef("scr_allow_uscarbine",1,0,1,"int");
	cvardef("ui_allow_uscarbine",level.allow_uscarbine,0,1,"int");
	makeCvarServerInfo("ui_allow_uscarbine", "1");
	
	level.allow_m1carbine = cvardef("scr_allow_m1carbine",1,0,1,"int");
	cvardef("ui_allow_m1carbine",level.allow_m1carbine,0,1,"int");
	level.cost_m1carbine = cvardef("scr_m1carbine_cost",1,0,"","int");
	updateCostStringCvar(level.cost_m1carbine, "ui_m1carbine_cost");
	
	level.allow_m2carbine = cvardef("scr_allow_m2carbine",1,0,1,"int");
	cvardef("ui_allow_m2carbine",level.allow_m2carbine,0,1,"int");
	level.cost_m2carbine = cvardef("scr_m2carbine_cost",2,0,"","int");
	updateCostStringCvar(level.cost_m2carbine, "ui_m2carbine_cost");
	
	level.allow_m3carbine = cvardef("scr_allow_m3carbine",1,0,1,"int");
	cvardef("ui_allow_m3carbine",level.allow_m3carbine,0,1,"int");
	level.cost_m3carbine = cvardef("scr_m3carbine_cost",2,0,"","int");
	updateCostStringCvar(level.cost_m3carbine, "ui_m3carbine_cost");
	
	level.allow_m1garand = cvardef("scr_allow_m1garand",1,0,1,"int");
	cvardef("ui_allow_m1garand",level.allow_m1garand,0,1,"int");
	makeCvarServerInfo("ui_allow_m1garand", "1");
	
	level.allow_m1garand_none = cvardef("scr_allow_m1garand_none",1,0,1,"int");
	cvardef("ui_allow_m1garand_none",level.allow_m1garand_none,0,1,"int");
	level.cost_m1garand = cvardef("scr_m1garand_cost",1,0,"","int");
	updateCostStringCvar(level.cost_m1garand, "ui_m1garand_cost");
	
	level.allow_m1garand_sniper = cvardef("scr_allow_m1garand_sniper",1,0,1,"int");
	cvardef("ui_allow_m1garand_sniper",level.allow_m1garand_sniper,0,1,"int");
	level.cost_m1garand_sniper = cvardef("scr_m1garand_sniper_cost",2,0,"","int");
	updateCostStringCvar(level.cost_m1garand_sniper, "ui_m1garand_sniper_cost");
	
	level.allow_m1garand_grenade = cvardef("scr_allow_m1garand_grenade",1,0,1,"int");
	cvardef("ui_allow_m1garand_grenade",level.allow_m1garand_grenade,0,1,"int");
	level.cost_m1garand_grenade = cvardef("scr_m1garand_grenade_cost",2,0,"","int");
	updateCostStringCvar(level.cost_m1garand_grenade, "ui_m1garand_grenade_cost");
	
	level.allow_svt40 = cvardef("scr_allow_svt40",1,0,1,"int");
	cvardef("ui_allow_svt40",level.allow_svt40,0,1,"int");
	makeCvarServerInfo("ui_allow_svt40", "1");
	
	level.allow_svt40_none = cvardef("scr_allow_svt40_none",1,0,1,"int");
	cvardef("ui_allow_svt40_none",level.allow_svt40_none,0,1,"int");
	level.cost_svt40 = cvardef("scr_svt40_cost",1,0,"","int");
	updateCostStringCvar(level.cost_svt40, "ui_svt40_cost");
	
	level.allow_svt40_sniper = cvardef("scr_allow_svt40_sniper",1,0,1,"int");
	cvardef("ui_allow_svt40_sniper",level.allow_svt40_sniper,0,1,"int");
	level.cost_svt40_sniper = cvardef("scr_svt40_sniper_cost",2,0,"","int");
	updateCostStringCvar(level.cost_svt40_sniper, "ui_svt40_sniper_cost");
	
	level.allow_gewehr43 = cvardef("scr_allow_gewehr43",1,0,1,"int");
	cvardef("ui_allow_gewehr43",level.allow_gewehr43,0,1,"int");
	makeCvarServerInfo("ui_allow_gewehr43", "1");
	
	level.allow_gewehr43_none = cvardef("scr_allow_gewehr43_none",1,0,1,"int");
	cvardef("ui_allow_gewehr43_none",level.allow_gewehr43_none,0,1,"int");
	level.cost_gewehr43 = cvardef("scr_gewehr43_cost",1,0,"","int");
	updateCostStringCvar(level.cost_gewehr43, "ui_gewehr43_cost");
	
	level.allow_gewehr43_sniper = cvardef("scr_allow_gewehr43_sniper",1,0,1,"int");
	cvardef("ui_allow_gewehr43_sniper",level.allow_gewehr43_sniper,0,1,"int");
	level.cost_gewehr43_sniper = cvardef("scr_gewehr43_sniper_cost",2,0,"","int");
	updateCostStringCvar(level.cost_gewehr43_sniper, "ui_gewehr43_sniper_cost");
	
	level.allow_gewehr43_grenade = cvardef("scr_allow_gewehr43_grenade",1,0,1,"int");
	cvardef("ui_allow_gewehr43_grenade",level.allow_gewehr43_grenade,0,1,"int");
	level.cost_gewehr43_grenade = cvardef("scr_gewehr43_grenade_cost",2,0,"","int");
	updateCostStringCvar(level.cost_gewehr43_grenade, "ui_gewehr43_grenade_cost");
}

initSMGCvars()
{
	level.allow_smgs = cvardef("scr_allow_smgs",1,0,1,"int");
	cvardef("ui_allow_smgs",level.allow_smgs,0,1,"int");
	makeCvarServerInfo("ui_allow_smgs","1");
	
	level.allow_thompson = cvardef("scr_allow_thompson",1,0,1,"int");
	cvardef("ui_allow_thompson",level.allow_thompson,0,1,"int");
	makeCvarServerInfo("ui_allow_thompson", "1");
	
	level.allow_thompson_none = cvardef("scr_allow_thompson_none",1,0,1,"int");
	cvardef("ui_allow_thompson_none",level.allow_thompson_none,0,1,"int");
	level.cost_thompson = cvardef("scr_thompson_cost",1,0,"","int");
	updateCostStringCvar(level.cost_thompson, "ui_thompson_cost");
	
	level.allow_thompson_silenced = cvardef("scr_allow_thompson_silenced",1,0,1,"int");
	cvardef("ui_allow_thompson_silenced",level.allow_thompson_silenced,0,1,"int");
	level.cost_thompson_silenced = cvardef("scr_thompson_silenced_cost",2,0,"","int");
	updateCostStringCvar(level.cost_thompson_silenced, "ui_thompson_silenced_cost");
	
	level.allow_thompson_drum = cvardef("scr_allow_thompson_drum",1,0,1,"int");
	cvardef("ui_allow_thompson_drum",level.allow_thompson_drum,0,1,"int");
	level.cost_thompson_drum = cvardef("scr_thompson_drum_cost",2,0,"","int");
	updateCostStringCvar(level.cost_thompson_drum, "ui_thompson_drum_cost");
	
	level.allow_sten = cvardef("scr_allow_sten",1,0,1,"int");
	cvardef("ui_allow_sten",level.allow_sten,0,1,"int");
	makeCvarServerInfo("ui_allow_sten", "1");
	
	level.allow_sten_none = cvardef("scr_allow_sten_none",1,0,1,"int");
	cvardef("ui_allow_sten_none",level.allow_sten_none,0,1,"int");
	level.cost_sten = cvardef("scr_sten_cost",1,0,"","int");
	updateCostStringCvar(level.cost_sten, "ui_sten_cost");
	
	level.allow_sten_silenced = cvardef("scr_allow_sten_silenced",1,0,1,"int");
	cvardef("ui_allow_sten_silenced",level.allow_sten_silenced,0,1,"int");
	level.cost_sten_silenced = cvardef("scr_sten_silenced_cost",2,0,"","int");
	updateCostStringCvar(level.cost_sten_silenced, "ui_sten_silenced_cost");
	
	level.allow_ppsh = cvardef("scr_allow_ppsh",1,0,1,"int");
	cvardef("ui_allow_ppsh",level.allow_ppsh,0,1,"int");
	makeCvarServerInfo("ui_allow_ppsh", "1");
	level.cost_ppsh = cvardef("scr_ppsh_cost",2,0,"","int");
	updateCostStringCvar(level.cost_ppsh, "ui_ppsh_cost");
	
	level.allow_mp40 = cvardef("scr_allow_mp40",1,0,1,"int");
	cvardef("ui_allow_mp40",level.allow_mp40,0,1,"int");
	makeCvarServerInfo("ui_allow_mp40", "1");
	
	level.allow_mp40_none = cvardef("scr_allow_mp40_none",1,0,1,"int");
	cvardef("ui_allow_mp40_none",level.allow_mp40_none,0,1,"int");
	level.cost_mp40 = cvardef("scr_mp40_cost",1,0,"","int");
	updateCostStringCvar(level.cost_mp40, "ui_mp40_cost");
	
	level.allow_mp40_silenced = cvardef("scr_allow_mp40_silenced",1,0,1,"int");
	cvardef("ui_allow_mp40_silenced",level.allow_mp40_silenced,0,1,"int");
	level.cost_mp40_silenced = cvardef("scr_mp40_silenced_cost",2,0,"","int");
	updateCostStringCvar(level.cost_mp40_silenced, "ui_mp40_silenced_cost");
	
	level.allow_greasegun = cvardef("scr_allow_greasegun",1,0,1,"int");
	cvardef("ui_allow_greasegun",level.allow_greasegun,0,1,"int");
	makeCvarServerInfo("ui_allow_greasegun", "1");
	level.cost_greasegun = cvardef("scr_greasegun_cost",1,0,"","int");
	updateCostStringCvar(level.cost_greasegun, "ui_greasegun_cost");
	
	level.allow_pps43 = cvardef("scr_allow_pps43",1,0,1,"int");
	cvardef("ui_allow_pps43",level.allow_pps43,0,1,"int");
	makeCvarServerInfo("ui_allow_pps43", "1");
	level.cost_pps43 = cvardef("scr_pps43_cost",1,0,"","int");
	updateCostStringCvar(level.cost_pps43, "ui_pps43_cost");
}

initMGCvars()
{
	level.allow_mgs = cvardef("scr_allow_mgs",1,0,1,"int");
	cvardef("ui_allow_mgs",level.allow_mgs,0,1,"int");
	makeCvarServerInfo("ui_allow_mgs","1");
	
	level.allow_bar = cvardef("scr_allow_bar",1,0,1,"int");
	cvardef("ui_allow_bar",level.allow_bar,0,1,"int");
	makeCvarServerInfo("ui_allow_bar", "1");
	level.cost_bar = cvardef("scr_bar_cost",1,0,"","int");
	updateCostStringCvar(level.cost_bar, "ui_bar_cost");
	
	level.allow_bren = cvardef("scr_allow_bren",1,0,1,"int");
	cvardef("ui_allow_bren",level.allow_bren,0,1,"int");
	makeCvarServerInfo("ui_allow_bren", "1");
	level.cost_bren = cvardef("scr_bren_cost",1,0,"","int");
	updateCostStringCvar(level.cost_bren, "ui_bren_cost");
	
	level.allow_mp44 = cvardef("scr_allow_mp44",1,0,1,"int");
	cvardef("ui_allow_mp44",level.allow_mp44,0,1,"int");
	makeCvarServerInfo("ui_allow_mp44", "1");
	
	level.allow_mp44_none = cvardef("scr_allow_mp44_none",1,0,1,"int");
	cvardef("ui_allow_mp44_none",level.allow_mp44_none,0,1,"int");
	level.cost_mp44 = cvardef("scr_mp44_cost",1,0,"","int");
	updateCostStringCvar(level.cost_mp44, "ui_mp44_cost");
	
	level.allow_scopedmp44 = cvardef("scr_allow_scopedmp44",1,0,1,"int");
	cvardef("ui_allow_scopedmp44",level.allow_scopedmp44,0,1,"int");
	level.cost_scopedmp44 = cvardef("scr_scopedmp44_cost",2,0,"","int");
	updateCostStringCvar(level.cost_scopedmp44, "ui_scopedmp44_cost");
	
	level.allow_fg42 = cvardef("scr_allow_fg42",1,0,1,"int");
	cvardef("ui_allow_fg42",level.allow_fg42,0,1,"int");
	makeCvarServerInfo("ui_allow_fg42", "1");
	
	level.allow_fg42_none = cvardef("scr_allow_fg42_none",1,0,1,"int");
	cvardef("ui_allow_fg42_none",level.allow_fg42_none,0,1,"int");
	level.cost_fg42 = cvardef("scr_fg42_cost",1,0,"","int");
	updateCostStringCvar(level.cost_fg42, "ui_fg42_cost");
	
	level.allow_fg42_scoped = cvardef("scr_allow_fg42_scoped",1,0,1,"int");
	cvardef("ui_allow_fg42_scoped",level.allow_fg42_scoped,0,1,"int");
	level.cost_fg42_scoped = cvardef("scr_fg42_scoped_cost",2,0,"","int");
	updateCostStringCvar(level.cost_fg42_scoped, "ui_fg42_scoped_cost");
}

initHeavyCvars()
{
	level.allow_heavies = cvardef("scr_allow_heavies",1,0,1,"int");
	cvardef("ui_allow_heavies",level.allow_heavies,0,1,"int");
	makeCvarServerInfo("ui_allow_heavies","1");
	
	level.allow_mg30cal = cvardef("scr_allow_mg30cal",1,0,1,"int");
	cvardef("ui_allow_mg30cal",level.allow_mg30cal,0,1,"int");
	makeCvarServerInfo("ui_allow_mg30cal", "1");
	level.cost_mg30cal = cvardef("scr_mg30cal_cost",3,0,"","int");
	updateCostStringCvar(level.cost_mg30cal, "ui_mg30cal_cost");
	
	level.allow_dp28 = cvardef("scr_allow_dp28",1,0,1,"int");
	cvardef("ui_allow_dp28",level.allow_dp28,0,1,"int");
	makeCvarServerInfo("ui_allow_dp28", "1");
	level.cost_dp28 = cvardef("scr_dp28_cost",2,0,"","int");
	updateCostStringCvar(level.cost_dp28, "ui_dp28_cost");
	
	level.allow_mg34 = cvardef("scr_allow_mg34",1,0,1,"int");
	cvardef("ui_allow_mg34",level.allow_mg34,0,1,"int");
	makeCvarServerInfo("ui_allow_mg34", "1");
	level.cost_mg34 = cvardef("scr_mg34_cost",3,0,"","int");
	updateCostStringCvar(level.cost_mg34, "ui_mg34_cost");
	
	level.allow_mg42_mp = cvardef("scr_allow_mg42_mp",1,0,1,"int");
	cvardef("ui_allow_mg42_mp",level.allow_mg42_mp,0,1,"int");
	makeCvarServerInfo("ui_allow_mg42_mp", "1");
	level.cost_mg42 = cvardef("scr_mg42_cost",3,0,"","int");
	updateCostStringCvar(level.cost_mg42, "ui_mg42_cost");
	
	level.allow_trenchgun = cvardef("scr_allow_trenchgun",1,0,1,"int");
	cvardef("ui_allow_trenchgun",level.allow_trenchgun,0,1,"int");
	makeCvarServerInfo("ui_allow_trenchgun", "1");
	level.cost_trenchgun = cvardef("scr_trenchgun_cost",2,0,"","int");
	updateCostStringCvar(level.cost_trenchgun, "ui_trenchgun_cost");
}

initSniperCvars()
{
	level.allow_snipers = cvardef("scr_allow_snipers",1,0,1,"int");
	cvardef("ui_allow_snipers",level.allow_snipers,0,1,"int");
	makeCvarServerInfo("ui_allow_snipers","1");
	
	level.allow_springfield = cvardef("scr_allow_springfield",1,0,1,"int");
	cvardef("ui_allow_springfield",level.allow_springfield,0,1,"int");
	makeCvarServerInfo("ui_allow_springfield", "1");
	
	level.allow_m1903a3 = cvardef("scr_allow_m1903a3",1,0,1,"int");
	cvardef("ui_allow_m1903a3",level.allow_m1903a3,0,1,"int");
	level.cost_m1903a3 = cvardef("scr_m1903a3_cost",1,0,"","int");
	updateCostStringCvar(level.cost_m1903a3, "ui_m1903a3_cost");
	
	level.allow_springfield_scoped = cvardef("scr_allow_springfield_scoped",1,0,1,"int");
	cvardef("ui_allow_springfield_scoped",level.allow_springfield_scoped,0,1,"int");
	level.cost_springfield_scoped = cvardef("scr_springfield_scoped_cost",2,0,"","int");
	updateCostStringCvar(level.cost_springfield, "ui_springfield_cost");
	
	level.allow_enfield = cvardef("scr_allow_enfield",1,0,1,"int");
	cvardef("ui_allow_enfield",level.allow_enfield,0,1,"int");
	makeCvarServerInfo("ui_allow_enfield", "1");
	
	level.allow_enfield_none = cvardef("scr_allow_enfield_none",1,0,1,"int");
	cvardef("ui_allow_enfield_none",level.allow_enfield_none,0,1,"int");
	level.cost_enfield = cvardef("scr_enfield_cost",1,0,"","int");
	updateCostStringCvar(level.cost_enfield, "ui_enfield_cost");
	
	level.allow_enfield_sniper = cvardef("scr_allow_enfield_sniper",1,0,1,"int");
	cvardef("ui_allow_enfield_sniper",level.allow_enfield_sniper,0,1,"int");
	level.cost_enfield_sniper = cvardef("scr_enfield_sniper_cost",2,0,"","int");
	updateCostStringCvar(level.cost_enfield_sniper, "ui_enfield_sniper_cost");
	
	level.allow_nagant = cvardef("scr_allow_nagant",1,0,1,"int");
	cvardef("ui_allow_nagant",level.allow_nagant,0,1,"int");
	makeCvarServerInfo("ui_allow_nagant", "1");
	
	level.allow_nagant_none = cvardef("scr_allow_nagant_none",1,0,1,"int");
	cvardef("ui_allow_nagant_none",level.allow_nagant_none,0,1,"int");
	level.cost_nagant = cvardef("scr_nagant_cost",1,0,"","int");
	updateCostStringCvar(level.cost_nagant, "ui_nagant_cost");
	
	level.allow_nagantsniper = cvardef("scr_allow_nagantsniper",1,0,1,"int");
	cvardef("ui_allow_nagantsniper",level.allow_nagantsniper,0,1,"int");
	level.cost_nagantsniper = cvardef("scr_nagantsniper_cost",2,0,"","int");
	updateCostStringCvar(level.cost_nagantsniper, "ui_nagantsniper_cost");
	
	level.allow_kar98k = cvardef("scr_allow_kar98k",1,0,1,"int");
	cvardef("ui_allow_kar98k",level.allow_kar98k,0,1,"int");
	makeCvarServerInfo("ui_allow_kar98k", "1");
	
	level.allow_kar98k_none = cvardef("scr_allow_kar98k_none",1,0,1,"int");
	cvardef("ui_allow_kar98k_none",level.allow_kar98k_none,0,1,"int");
	level.cost_kar98k = cvardef("scr_kar98k_cost",1,0,"","int");
	updateCostStringCvar(level.cost_kar98k, "ui_kar98k_cost");
	
	level.allow_kar98ksniper = cvardef("scr_allow_kar98ksniper",1,0,1,"int");
	cvardef("ui_allow_kar98ksniper",level.allow_kar98ksniper,0,1,"int");
	level.cost_kar98ksniper = cvardef("scr_kar98ksniper_cost",2,0,"","int");
	updateCostStringCvar(level.cost_kar98ksniper, "ui_kar98ksniper_cost");
	
	level.allow_delisle = cvardef("scr_allow_delisle",1,0,1,"int");
	cvardef("ui_allow_delisle",level.allow_delisle,0,1,"int");
	makeCvarServerInfo("ui_allow_delisle", "1");
	level.cost_delisle = cvardef("scr_delisle_cost",2,0,"","int");
	updateCostStringCvar(level.cost_delisle, "ui_delisle_cost");
	
	level.allow_ptrs = cvardef("scr_allow_ptrs",1,0,1,"int");
	cvardef("ui_allow_ptrs",level.allow_ptrs,0,1,"int");
	makeCvarServerInfo("ui_allow_ptrs", "1");
	level.cost_ptrs = cvardef("scr_ptrs_cost",3,0,"","int");
	updateCostStringCvar(level.cost_ptrs, "ui_ptrs_cost");
}

initPistolCvars()
{
	level.allow_pistols = cvardef("scr_allow_pistols",1,0,1,"int");
	cvardef("ui_allow_pistols",level.allow_pistols,0,1,"int");
	makeCvarServerInfo("ui_allow_pistols","1");
	
	level.allow_colt = cvardef("scr_allow_colt",1,0,1,"int");
	cvardef("ui_allow_colt",level.allow_colt,0,1,"int");
	makeCvarServerInfo("ui_allow_colt", "1");
	level.cost_colt = cvardef("scr_colt_cost",1,0,"","int");
	updateCostStringCvar(level.cost_colt, "ui_colt_cost");
	
	level.allow_webley = cvardef("scr_allow_webley",1,0,1,"int");
	cvardef("ui_allow_webley",level.allow_webley,0,1,"int");
	makeCvarServerInfo("ui_allow_webley", "1");
	level.cost_webley = cvardef("scr_webley_cost",2,0,"","int");
	updateCostStringCvar(level.cost_webley, "ui_webley_cost");
	
	level.allow_tt33 = cvardef("scr_allow_tt33",1,0,1,"int");
	cvardef("ui_allow_tt33",level.allow_tt33,0,1,"int");
	makeCvarServerInfo("ui_allow_tt33", "1");
	level.cost_tt33 = cvardef("scr_tt33_cost",1,0,"","int");
	updateCostStringCvar(level.cost_tt33, "ui_tt33_cost");
	
	level.allow_luger = cvardef("scr_allow_luger",1,0,1,"int");
	cvardef("ui_allow_luger",level.allow_luger,0,1,"int");
	makeCvarServerInfo("ui_allow_luger", "1");
	level.cost_luger = cvardef("scr_luger_cost",1,0,"","int");
	updateCostStringCvar(level.cost_luger, "ui_luger_cost");
	
	level.allow_welrod = cvardef("scr_allow_welrod",1,0,1,"int");
	cvardef("ui_allow_welrod",level.allow_welrod,0,1,"int");
	makeCvarServerInfo("ui_allow_welrod", "1");
	level.cost_welrod = cvardef("scr_welrod_cost",2,0,"","int");
	updateCostStringCvar(level.cost_welrod, "ui_welrod_cost");
	
	level.allow_m712 = cvardef("scr_allow_m712",1,0,1,"int");
	cvardef("ui_allow_m712",level.allow_m712,0,1,"int");
	makeCvarServerInfo("ui_allow_m712", "1");
	level.cost_m712 = cvardef("scr_m712_cost",2,0,"","int");
	updateCostStringCvar(level.cost_m712, "ui_m712_cost");
}

initGrenadeCvars()
{
	level.allow_grenades = cvardef("scr_allow_grenades",1,0,1,"int");
	cvardef("ui_allow_grenades",level.allow_grenades,0,1,"int");
	makeCvarServerInfo("ui_allow_grenades","1");
	
	level.allow_fraggrenade = cvardef("scr_allow_fraggrenade",1,0,1,"int");
	cvardef("ui_allow_fraggrenade",level.allow_fraggrenade,0,1,"int");
	makeCvarServerInfo("ui_allow_fraggrenade", "1");
	level.cost_fraggrenade = cvardef("scr_fraggrenade_cost",1,0,"","int");
	updateCostStringCvar(level.cost_fraggrenade, "ui_fraggrenade_cost");
	
	level.allow_mk1britishfraggrenade = cvardef("scr_allow_mk1britishfraggrenade",1,0,1,"int");
	cvardef("ui_allow_mk1britishfraggrenade",level.allow_mk1britishfraggrenade,0,1,"int");
	makeCvarServerInfo("ui_allow_mk1britishfraggrenade", "1");
	level.cost_mk1britishfraggrenade = cvardef("scr_mk1britishfraggrenade_cost",1,0,"","int");
	updateCostStringCvar(level.cost_mk1britishfraggrenade, "ui_mk1britishfraggrenade_cost");
	
	level.allow_rgd33russianfraggrenade = cvardef("scr_allow_rgd33russianfraggrenade",1,0,1,"int");
	cvardef("ui_allow_rgd33russianfraggrenade",level.allow_rgd33russianfraggrenade,0,1,"int");
	makeCvarServerInfo("ui_allow_rgd33russianfraggrenade", "1");
	level.cost_rgd33russianfraggrenade = cvardef("scr_rgd33russianfraggrenade_cost",1,0,"","int");
	updateCostStringCvar(level.cost_rgd33russianfraggrenade, "ui_rgd33russianfraggrenade_cost");
	
	level.allow_stielhandgranate = cvardef("scr_allow_stielhandgranate",1,0,1,"int");
	cvardef("ui_allow_stielhandgranate",level.allow_stielhandgranate,0,1,"int");
	makeCvarServerInfo("ui_allow_stielhandgranate", "1");
	level.cost_stielhandgranate = cvardef("scr_stielhandgranate_cost",1,0,"","int");
	updateCostStringCvar(level.cost_stielhandgranate, "ui_stielhandgranate_cost");
}

initSmokeCvars()
{
	level.allow_smoke = cvardef("scr_allow_smoke",1,0,1,"int");
	cvardef("ui_allow_smoke",level.allow_smoke,0,1,"int");
	makeCvarServerInfo("ui_allow_smoke","1");
	
	level.allow_smokegrenade = cvardef("scr_allow_smokegrenade",1,0,1,"int");
	cvardef("ui_allow_smokegrenade",level.allow_smokegrenade,0,1,"int");
	makeCvarServerInfo("ui_allow_smokegrenade", "1");
	level.cost_smokegrenade = cvardef("scr_smokegrenade_cost",1,0,"","int");
	updateCostStringCvar(level.cost_smokegrenade, "ui_smokegrenade_cost");
	
	level.allow_molotov = cvardef("scr_allow_molotov",1,0,1,"int");
	cvardef("ui_allow_molotov",level.allow_molotov,0,1,"int");
	makeCvarServerInfo("ui_allow_molotov", "1");
	level.cost_molotov = cvardef("scr_molotov_cost",1,0,"","int");
	updateCostStringCvar(level.cost_molotov, "ui_molotov_cost");
	level.molotov_burn_time = cvardef("scr_molotov_burn_time",10,1,60,"int");
	updateTimeStringCvar(level.molotov_burn_time, "ui_molotov_burn_time");
	
	level.allow_mustardgas = cvardef("scr_allow_mustardgas",1,0,1,"int");
	cvardef("ui_allow_mustardgas",level.allow_mustardgas,0,1,"int");
	makeCvarServerInfo("ui_allow_mustardgas", "1");
	level.cost_mustardgas = cvardef("scr_mustardgas_cost",1,0,"","int");
	updateCostStringCvar(level.cost_mustardgas, "ui_mustardgas_cost");
	level.mustardgas_linger_time = cvardef("scr_mustardgas_linger_time",10,1,60,"int");
	updateTimeStringCvar(level.mustardgas_linger_time, "ui_mustardgas_linger_time");
}

initSatchelCvars()
{
	level.allow_satchel = cvardef("scr_allow_satchel",1,0,1,"int");
	cvardef("ui_allow_satchel",level.allow_satchel,0,1,"int");
	makeCvarServerInfo("ui_allow_satchel","1");
	
	level.allow_satchelcharge = cvardef("scr_allow_satchelcharge",1,0,1,"int");
	cvardef("ui_allow_satchelcharge",level.allow_satchelcharge,0,1,"int");
	makeCvarServerInfo("ui_allow_satchelcharge", "1");
	level.cost_satchelcharge = cvardef("scr_satchelcharge_cost",1,0,"","int");
	updateCostStringCvar(level.cost_satchelcharge, "ui_satchelcharge_cost");
	
	level.allow_geballte = cvardef("scr_allow_geballte",1,0,1,"int");
	cvardef("ui_allow_geballte",level.allow_geballte,0,1,"int");
	makeCvarServerInfo("ui_allow_geballte", "1");
	level.cost_geballte = cvardef("scr_geballte_cost",1,0,"","int");
	updateCostStringCvar(level.cost_geballte, "ui_geballte_cost");
	
	level.allow_panzerschreck = cvardef("scr_allow_panzerschreck",1,0,1,"int");
	cvardef("ui_allow_panzerschreck",level.allow_panzerschreck,0,1,"int");
	makeCvarServerInfo("ui_allow_panzerschreck", "1");
	level.cost_panzerschreck = cvardef("scr_panzerschreck_cost",1,0,"","int");
	updateCostStringCvar(level.cost_panzerschreck, "ui_panzerschreck_cost");
	
	level.allow_bazooka = cvardef("scr_allow_bazooka",1,0,1,"int");
	cvardef("ui_allow_bazooka",level.allow_bazooka,0,1,"int");
	makeCvarServerInfo("ui_allow_bazooka", "1");
	level.cost_bazooka = cvardef("scr_bazooka_cost",1,0,"","int");
	updateCostStringCvar(level.cost_bazooka, "ui_bazooka_cost");
	
	level.allow_flamethrower = cvardef("scr_allow_flamethrower",1,0,1,"int");
	cvardef("ui_allow_flamethrower",level.allow_flamethrower,0,1,"int");
	makeCvarServerInfo("ui_allow_flamethrower", "1");
	level.cost_flamethrower = cvardef("scr_flamethrower_cost",1,0,"","int");
	updateCostStringCvar(level.cost_flamethrower, "ui_flamethrower_cost");
}

initPerkCvars()
{
	level.allow_perks = cvardef("scr_allow_perks",1,0,1,"int");
	cvardef("ui_allow_perks",level.allow_perks,0,1,"int");
	makeCvarServerInfo("ui_allow_perks","1");
	
	level.allow_tier1_perks = cvardef("scr_allow_tier1_perks",1,0,1,"int");
	cvardef("ui_allow_tier1_perks",level.allow_tier1_perks,0,1,"int");
	
	level.allow_extra_equipment = cvardef("scr_allow_extra_equipment",1,0,1,"int");
	cvardef("ui_allow_extra_equipment",level.allow_extra_equipment,0,1,"int");
	level.cost_extra_equipment = cvardef("scr_extra_equipment_cost",1,0,"","int");
	updateCostStringCvar(level.cost_extra_equipment, "ui_extra_equipment_cost");
	
	level.allow_bombsquad = cvardef("scr_allow_bombsquad",1,0,1,"int");
	cvardef("ui_allow_bombsquad",level.allow_bombsquad,0,1,"int");
	level.cost_bombsquad = cvardef("scr_bombsquad_cost",1,0,"","int");
	updateCostStringCvar(level.cost_bombsquad, "ui_bombsquad_cost");
	
	level.allow_tripwire = cvardef("scr_allow_tripwire",1,0,3,"int");
	cvardef("ui_allow_tripwire",level.allow_tripwire,0,1,"int");
	level.cost_tripwire = cvardef("scr_tripwire_cost",1,0,"","int");
	updateCostStringCvar(level.cost_tripwire, "ui_tripwire_cost");
	
	level.tripwire_num_traps = cvardef("scr_tripwire_num_traps",16,1,32,"int");
	level.tripwire_satchels = cvardef("scr_tripwire_satchels",1,0,1,"int");
	updateEnableStringCvar(level.tripwire_satchels, "ui_tripwire_satchels");
	level.tripwire_stickynades = cvardef("scr_tripwire_stickynades",1,0,2,"int");
	updateEnableStringCvar(level.tripwire_stickynades, "ui_tripwire_stickynades");
	level.tripwire_plant_time = cvardef("scr_tripwire_plant_time",5,1,99,"int");
	updateTimeStringCvar(level.tripwire_plant_time, "ui_tripwire_plant_time");
	level.tripwire_defuse_time = cvardef("scr_tripwire_defuse_time",5,1,99,"int");
	updateTimeStringCvar(level.tripwire_defuse_time, "ui_tripwire_defuse_time");
	
	if(!level.waw_teamplay)
	{
		level.tripwire_traps["axis"] = 0;
		level.tripwire_traps["allies"] = 0;
	}
	else
	{
		level.tripwire_traps = 0;
	}
	
	level.allow_tier2_perks = cvardef("scr_allow_tier2_perks",1,0,1,"int");
	cvardef("ui_allow_tier2_perks",level.allow_tier2_perks,0,1,"int");
	
	level.allow_extra_smoke = cvardef("scr_allow_extra_smoke",1,0,1,"int");
	cvardef("ui_allow_extra_smoke",level.allow_extra_smoke,0,1,"int");
	level.cost_extra_smoke = cvardef("scr_extra_smoke_cost",1,0,"","int");
	updateCostStringCvar(level.cost_extra_smoke, "ui_extra_smoke_cost");
	
	level.allow_extra_grenade = cvardef("scr_allow_extra_grenade",1,0,1,"int");
	cvardef("ui_allow_extra_grenade",level.allow_extra_grenade,0,1,"int");
	level.cost_extra_grenade = cvardef("scr_extra_grenade_cost",1,0,"","int");
	updateCostStringCvar(level.cost_extra_grenade, "ui_extra_grenade_cost");
	
	level.allow_extra_ammo = cvardef("scr_allow_extra_ammo",1,0,1,"int");
	cvardef("ui_allow_extra_ammo",level.allow_extra_ammo,0,1,"int");
	level.cost_extra_ammo = cvardef("scr_extra_ammo_cost",1,0,"","int");
	updateCostStringCvar(level.cost_extra_ammo, "ui_extra_ammo_cost");
	
	level.allow_tier3_perks = cvardef("scr_allow_tier3_perks",1,0,1,"int");
	cvardef("ui_allow_tier3_perks",level.allow_tier3_perks,0,1,"int");
	
	level.allow_marathon = cvardef("scr_allow_marathon",1,0,2,"int");
	cvardef("ui_allow_marathon",level.allow_marathon,0,1,"int");
	level.cost_marathon = cvardef("scr_marathon_cost",1,0,"","int");
	updateCostStringCvar(level.cost_marathon, "ui_marathon_cost");
	
	level.marathon_sprint_time_value = cvardef("scr_marathon_sprint_time",200,100,999,"int");
	level.marathon_sprint_time = (float)100 / (float)level.marathon_sprint_time_value;
	if(level.allow_marathon == 2)
		setCvar("ui_marathon_sprint_time", "Unlimited");
	else
		updateMultiplierStringCvar(level.marathon_sprint_time_value, "ui_marathon_sprint_time");
	level.marathon_sprint_speed_value = cvardef("scr_marathon_sprint_speed", 100, 100, 200, "int");
	level.marathon_sprint_speed = (float)level.marathon_sprint_speed_value * (float)0.01;
	updateMultiplierStringCvar(level.marathon_sprint_speed_value, "ui_marathon_sprint_speed");
	level.marathon_sprint_recovery_value = cvardef("scr_marathon_sprint_recovery", 100, 100, 200, "int");
	level.marathon_sprint_recovery = (float)level.marathon_sprint_recovery_value * (float)0.01;
	updateMultiplierStringCvar(level.marathon_sprint_recovery_value, "ui_marathon_sprint_recovery");
	
	level.allow_medic = cvardef("scr_allow_medic",1,0,1,"int");
	cvardef("ui_allow_medic",level.allow_medic,0,1,"int");
	level.cost_medic = cvardef("scr_medic_cost",1,0,"","int");
	updateCostStringCvar(level.cost_medic, "ui_medic_cost");
	
	level.medic_firstaidkits = cvardef("scr_medic_firstaidkits", 2, 0, 99, "int");
	level.medic_firstaidhealth = cvardef("scr_medic_firstaidhealth", 50, 1, 100, "int");
	level.medic_firstaiddelay = cvardef("scr_medic_firstaiddelay", 10,0,999, "int");
	updateTimeStringCvar(level.medic_firstaiddelay, "ui_medic_firstaiddelay");
	
	level.allow_scavenger = cvardef("scr_allow_scavenger",2,0,2,"int");
	cvardef("ui_allow_scavenger",level.allow_scavenger,0,1,"int");
	level.cost_scavenger = cvardef("scr_scavenger_cost",1,0,"","int");
	updateCostStringCvar(level.cost_scavenger,"ui_scavenger_cost");
	
	if(level.allow_scavenger == 2)
		setCvar("ui_scavenger_autosearch", "Enabled");
	else
		setCvar("ui_scavenger_autosearch", "Disabled");
	
	level.scavenger_search_time = cvardef("scr_scavenger_search_time", 1, 1, 10, "int");
	updateTimeStringCvar(level.scavenger_search_time,"ui_scavenger_search_time");
	
}

initKSCvars()
{
	level.allow_killstreaks = cvardef("scr_allow_killstreaks",1,0,1,"int");
	cvardef("ui_allow_killstreaks",level.allow_killstreaks,0,1,"int");
	makeCvarServerInfo("ui_allow_killstreaks","1");
	
	level.allow_artillery_ks = cvardef("scr_allow_artillery_ks",1,0,1,"int");
	cvardef("ui_allow_artillery_ks",level.allow_artillery_ks,0,1,"int");
	level.kills_artillery = cvardef("scr_artillery_kills",5,1,"","int");
	updateKillStringCvar(level.kills_artillery, "ui_artillery_kills");
	makeCvarServerInfo("ui_artillery_kills","1");
	
	level.allow_binoculars = cvardef("scr_allow_binoculars",1,0,1,"int");
	cvardef("ui_allow_binoculars",level.allow_binoculars,0,1,"int");
	makeCvarServerInfo("ui_allow_binoculars","1");
	
	level.allow_artillery = cvardef("scr_allow_artillery",1,0,1,"int");
	cvardef("ui_allow_artillery",level.allow_artillery,0,1,"int");
	
	level.allow_deployablemg_ks = cvardef("scr_allow_deployablemg_ks",6,0,20,"int");
	cvardef("ui_allow_deployablemg_ks",level.allow_deployablemg_ks,0,1,"int");
	level.kills_deployablemg = cvardef("scr_deployablemg_kills",5,1,"","int");
	updateKillStringCvar(level.kills_deployablemg, "ui_deployablemg_kills");
	makeCvarServerInfo("ui_deployablemg_kills","1");
}

updateWeaponCvars()
{
	for(;;)
	{
		updateRifleCvars();
		updateSMGCvars();
		updateMGCvars();
		updateHeavyCvars();
		updateSniperCvars();
		updatePistolCvars();
		updateGrenadeCvars();
		updateSmokeCvars();
		updateSatchelCvars();
		updatePerkCvars();
		updateKSCvars();
		
		//Misc weapon related CVARS
		level.allow_panzerfaust = updateCvar("scr_allow_panzerfaust", level.allow_panzerfaust, 0, 1, "int");
		updateCvar("ui_allow_panzerfaust", level.allow_panzerfaust, 0, 1, "int");
		
		wait 5;
	}
}

updateRifleCvars()
{
	////////////////////////////////////////////////////////////////
	// ADDED US CARBINE
	////////////////////////////////////////////////////////////////
	level.allow_uscarbine = updateCvar("scr_allow_uscarbine", level.allow_uscarbine, 0, 1, "int");
	updateCvar("ui_allow_uscarbine", level.allow_uscarbine, 0, 1, "int");
	
	/////////////////////////////////////////////////////////////////
	// M1 CARBINE
	/////////////////////////////////////////////////////////////////
	level.allow_m1carbine = updateCvar("scr_allow_m1carbine", level.allow_m1carbine, 0, 1, "int");
	updateCvar("ui_allow_m1carbine", level.allow_m1carbine, 0, 1, "int");
	level.cost_m1carbine = updateCvar("scr_m1carbine_cost", level.cost_m1carbine, 0,"","int");
	updateCostStringCvar(level.cost_m1carbine, "ui_m1carbine_cost");

	/////////////////////////////////////////////////////////////////
	// ADDED M2 CARBINE
	/////////////////////////////////////////////////////////////////
	level.allow_m2carbine = updateCvar("scr_allow_m2carbine", level.allow_m2carbine, 0, 1, "int");
	updateCvar("ui_allow_m2carbine", level.allow_m2carbine, 0, 1, "int");
	level.cost_m2carbine = updateCvar("scr_m2carbine_cost", level.cost_m2carbine, 0,"","int");
	updateCostStringCvar(level.cost_m2carbine, "ui_m2carbine_cost");
		
	//////////////////////////////////////////////////////////////////
	// ADDED M3 CARBINE
	//////////////////////////////////////////////////////////////////
	level.allow_m3carbine = updateCvar("scr_allow_m3carbine", level.allow_m3carbine, 0, 1, "int");
	updateCvar("ui_allow_m3carbine", level.allow_m3carbine, 0, 1, "int");
	level.cost_m3carbine = updateCvar("scr_m3carbine_cost", level.cost_m3carbine, 0,"","int");
	updateCostStringCvar(level.cost_m3carbine, "ui_m3carbine_cost");
	
	/////////////////////////////////////////////////////////////////
	// M1 GARAND
	/////////////////////////////////////////////////////////////////
	level.allow_m1garand = updateCvar("scr_allow_m1garand", level.allow_m1garand, 0, 1, "int");
	updateCvar("ui_allow_m1garand", level.allow_m1garand, 0, 1, "int");
	
	level.allow_m1garand_none = updateCvar("scr_allow_m1garand_none", level.allow_m1garand_none, 0, 1, "int");
	updateCvar("ui_allow_m1garand_none", level.allow_m1garand_none, 0, 1, "int");
	level.cost_m1garand = updateCvar("scr_m1garand_cost", level.cost_m1garand, 0,"","int");
	updateCostStringCvar(level.cost_m1garand, "ui_m1garand_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED M1 GARAND SNIPER
	//////////////////////////////////////////////////////////
	level.allow_m1garand_sniper = updateCvar("scr_allow_m1garand_sniper", level.allow_m1garand_sniper, 0, 1, "int");
	updateCvar("ui_allow_m1garand_sniper", level.allow_m1garand_sniper, 0, 1, "int");
	level.cost_m1garand_sniper = updateCvar("scr_m1garand_sniper_cost", level.cost_m1garand_sniper, 0,"","int");
	updateCostStringCvar(level.cost_m1garand_sniper, "ui_m1garand_sniper_cost");
		
	///////////////////////////////////////////////////////////////
	// ADDED M1 GARAND Grenade
	///////////////////////////////////////////////////////////////
	level.allow_m1garand_grenade = updateCvar("scr_allow_m1garand_grenade", level.allow_m1garand_grenade, 0, 1, "int");
	updateCvar("ui_allow_m1garand_grenade", level.allow_m1garand_grenade, 0, 1, "int");
	level.cost_m1garand_grenade = updateCvar("scr_m1garand_grenade_cost", level.cost_m1garand_grenade, 0,"","int");
	updateCostStringCvar(level.cost_m1garand_grenade, "ui_m1garand_grenade_cost");
	
	/////////////////////////////////////////////////////////////////
	// SVT40
	/////////////////////////////////////////////////////////////////
	level.allow_svt40 = updateCvar("scr_allow_svt40", level.allow_svt40, 0, 1, "int");
	updateCvar("ui_allow_svt40", level.allow_svt40, 0, 1, "int");
	
	level.allow_svt40_none = updateCvar("scr_allow_svt40_none", level.allow_svt40_none, 0, 1, "int");
	updateCvar("ui_allow_svt40_none", level.allow_svt40_none, 0, 1, "int");
	level.cost_svt40 = updateCvar("scr_svt40_cost", level.cost_svt40, 0,"","int");
	updateCostStringCvar(level.cost_svt40, "ui_svt40_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED SVT40 SNIPER
	//////////////////////////////////////////////////////////
	level.allow_svt40_sniper = updateCvar("scr_allow_svt40_sniper", level.allow_svt40_sniper, 0, 1, "int");
	updateCvar("ui_allow_svt40_sniper", level.allow_svt40_sniper, 0, 1, "int");
	level.cost_svt40_sniper = updateCvar("scr_svt40_sniper_cost", level.cost_svt40_sniper, 0,"","int");
	updateCostStringCvar(level.cost_svt40_sniper, "ui_svt40_sniper_cost");
		
	/////////////////////////////////////////////////////////////////
	// GEWEHR43
	/////////////////////////////////////////////////////////////////
	level.allow_gewehr43 = updateCvar("scr_allow_gewehr43", level.allow_gewehr43, 0, 1, "int");
	updateCvar("ui_allow_gewehr43", level.allow_gewehr43, 0, 1, "int");
	
	level.allow_gewehr43_none = updateCvar("scr_allow_gewehr43_none", level.allow_gewehr43_none, 0, 1, "int");
	updateCvar("ui_allow_gewehr43_none", level.allow_gewehr43_none, 0, 1, "int");
	level.cost_gewehr43 = updateCvar("scr_gewehr43_cost", level.cost_gewehr43, 0,"","int");
	updateCostStringCvar(level.cost_gewehr43, "ui_gewehr43_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED GEWEHR43 SNIPER
	//////////////////////////////////////////////////////////
	level.allow_gewehr43_sniper = updateCvar("scr_allow_gewehr43_sniper", level.allow_gewehr43_sniper, 0, 1, "int");
	updateCvar("ui_allow_gewehr43_sniper", level.allow_gewehr43_sniper, 0, 1, "int");
	level.cost_gewehr43_sniper = updateCvar("scr_gewehr43_sniper_cost", level.cost_gewehr43_sniper, 0,"","int");
	updateCostStringCvar(level.cost_gewehr43_sniper, "ui_gewehr43_sniper_cost");
		
	///////////////////////////////////////////////////////////////
	// ADDED GEWEHR43 Grenade
	///////////////////////////////////////////////////////////////
	level.allow_gewehr43_grenade = updateCvar("scr_allow_gewehr43_grenade", level.allow_gewehr43_grenade, 0, 1, "int");
	updateCvar("ui_allow_gewehr43_grenade", level.allow_gewehr43_grenade, 0, 1, "int");
	level.cost_gewehr43_grenade = updateCvar("scr_gewehr43_grenade_cost", level.cost_gewehr43_grenade, 0,"","int");
	updateCostStringCvar(level.cost_gewehr43_grenade, "ui_gewehr43_grenade_cost");
	
	////////////////////////////////////////
	//ADDED CLASS BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_rifles = updateCvar("scr_allow_rifles", level.allow_rifles, 0, 1, "int");
	updateCvar("ui_allow_rifles", level.allow_rifles, 0, 1, "int");
}

updateSMGCvars()
{
	/////////////////////////////////////////////////////////////////
	// THOMPSON
	/////////////////////////////////////////////////////////////////
	level.allow_thompson = updateCvar("scr_allow_thompson", level.allow_thompson, 0, 1, "int");
	updateCvar("ui_allow_thompson", level.allow_thompson, 0, 1, "int");
	
	level.allow_thompson_none = updateCvar("scr_allow_thompson_none", level.allow_thompson_none, 0, 1, "int");
	updateCvar("ui_allow_thompson_none", level.allow_thompson_none, 0, 1, "int");
	level.cost_thompson = updateCvar("scr_thompson_cost", level.cost_thompson, 0,"","int");
	updateCostStringCvar(level.cost_thompson, "ui_thompson_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED THOMPSON SILENCED
	//////////////////////////////////////////////////////////
	level.allow_thompson_silenced = updateCvar("scr_allow_thompson_silenced", level.allow_thompson_silenced, 0, 1, "int");
	updateCvar("ui_allow_thompson_silenced", level.allow_thompson_silenced, 0, 1, "int");
	level.cost_thompson_silenced = updateCvar("scr_thompson_silenced_cost", level.cost_thompson_silenced, 0,"","int");
	updateCostStringCvar(level.cost_thompson_silenced, "ui_thompson_silenced_cost");
		
	///////////////////////////////////////////////////////////////
	// ADDED THOMPSON DRUM
	///////////////////////////////////////////////////////////////
	level.allow_thompson_drum = updateCvar("scr_allow_thompson_drum", level.allow_thompson_drum, 0, 1, "int");
	updateCvar("ui_allow_thompson_drum", level.allow_thompson_drum, 0, 1, "int");
	level.cost_thompson_drum = updateCvar("scr_thompson_drum_cost", level.cost_thompson_drum, 0,"","int");
	updateCostStringCvar(level.cost_thompson_drum, "ui_thompson_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED GREASE GUN
	///////////////////////////////////////////////////////////////
	level.allow_greasegun = updateCvar("scr_allow_greasegun", level.allow_greasegun, 0, 1, "int");
	updateCvar("ui_allow_greasegun", level.allow_greasegun, 0, 1, "int");
	level.cost_greasegun = updateCvar("scr_greasegun_cost", level.cost_greasegun, 0,"","int");
	updateCostStringCvar(level.cost_greasegun, "ui_greasegun_cost");
	
	/////////////////////////////////////////////////////////////////
	// STEN
	/////////////////////////////////////////////////////////////////
	level.allow_sten = updateCvar("scr_allow_sten", level.allow_sten, 0, 1, "int");
	updateCvar("ui_allow_sten", level.allow_sten, 0, 1, "int");
	
	level.allow_sten_none = updateCvar("scr_allow_sten_none", level.allow_sten_none, 0, 1, "int");
	updateCvar("ui_allow_sten_none", level.allow_sten_none, 0, 1, "int");
	level.cost_sten = updateCvar("scr_sten_cost", level.cost_sten, 0,"","int");
	updateCostStringCvar(level.cost_sten, "ui_sten_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED STEN SILENCED
	//////////////////////////////////////////////////////////
	level.allow_sten_silenced = updateCvar("scr_allow_sten_silenced", level.allow_sten_silenced, 0, 1, "int");
	updateCvar("ui_allow_sten_silenced", level.allow_sten_silenced, 0, 1, "int");
	level.cost_sten_silenced = updateCvar("scr_sten_silenced_cost", level.cost_sten_silenced, 0,"","int");
	updateCostStringCvar(level.cost_sten_silenced, "ui_sten_silenced_cost");
	
	///////////////////////////////////////////////////////////////
	// PPSH
	///////////////////////////////////////////////////////////////
	level.allow_ppsh = updateCvar("scr_allow_ppsh", level.allow_ppsh, 0, 1, "int");
	updateCvar("ui_allow_ppsh", level.allow_ppsh, 0, 1, "int");
	level.cost_ppsh = updateCvar("scr_ppsh_cost", level.cost_ppsh, 0,"","int");
	updateCostStringCvar(level.cost_ppsh, "ui_ppsh_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED PPS43
	///////////////////////////////////////////////////////////////
	level.allow_pps43 = updateCvar("scr_allow_pps43", level.allow_pps43, 0, 1, "int");
	updateCvar("ui_allow_pps43", level.allow_pps43, 0, 1, "int");
	level.cost_pps43 = updateCvar("scr_pps43_cost", level.cost_pps43, 0,"","int");
	updateCostStringCvar(level.cost_pps43, "ui_pps43_cost");
	
	/////////////////////////////////////////////////////////////////
	// MP40
	/////////////////////////////////////////////////////////////////
	level.allow_mp40 = updateCvar("scr_allow_mp40", level.allow_mp40, 0, 1, "int");
	updateCvar("ui_allow_mp40", level.allow_mp40, 0, 1, "int");
	
	level.allow_mp40_none = updateCvar("scr_allow_mp40_none", level.allow_mp40_none, 0, 1, "int");
	updateCvar("ui_allow_mp40_none", level.allow_mp40_none, 0, 1, "int");
	level.cost_mp40 = updateCvar("scr_mp40_cost", level.cost_mp40, 0,"","int");
	updateCostStringCvar(level.cost_mp40, "ui_mp40_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED MP40 SILENCED
	//////////////////////////////////////////////////////////
	level.allow_mp40_silenced = updateCvar("scr_allow_mp40_silenced", level.allow_mp40_silenced, 0, 1, "int");
	updateCvar("ui_allow_mp40_silenced", level.allow_mp40_silenced, 0, 1, "int");
	level.cost_mp40_silenced = updateCvar("scr_mp40_silenced_cost", level.cost_mp40_silenced, 0,"","int");
	updateCostStringCvar(level.cost_mp40_silenced, "ui_mp40_silenced_cost");
	
	////////////////////////////////////////
	//ADDED CLASS BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_smgs = updateCvar("scr_allow_smgs", level.allow_smgs, 0, 1, "int");
	updateCvar("ui_allow_smgs", level.allow_smgs, 0, 1, "int");
}

updateMGCvars()
{
	///////////////////////////////////////////////////////////////
	// BAR
	///////////////////////////////////////////////////////////////
	level.allow_bar = updateCvar("scr_allow_bar", level.allow_bar, 0, 1, "int");
	updateCvar("ui_allow_bar", level.allow_bar, 0, 1, "int");
	level.cost_bar = updateCvar("scr_bar_cost", level.cost_bar, 0,"","int");
	updateCostStringCvar(level.cost_bar, "ui_bar_cost");
	
	///////////////////////////////////////////////////////////////
	// BREN
	///////////////////////////////////////////////////////////////
	level.allow_bren = updateCvar("scr_allow_bren", level.allow_bren, 0, 1, "int");
	updateCvar("ui_allow_bren", level.allow_bren, 0, 1, "int");
	level.cost_bren = updateCvar("scr_bren_cost", level.cost_bren, 0,"","int");
	updateCostStringCvar(level.cost_bren, "ui_bren_cost");
	
	/////////////////////////////////////////////////////////////////
	// MP44
	/////////////////////////////////////////////////////////////////
	level.allow_mp44 = updateCvar("scr_allow_mp44", level.allow_mp44, 0, 1, "int");
	updateCvar("ui_allow_mp44", level.allow_mp44, 0, 1, "int");
	
	level.allow_mp44_none = updateCvar("scr_allow_mp44_none", level.allow_mp44_none, 0, 1, "int");
	updateCvar("ui_allow_mp44_none", level.allow_mp44_none, 0, 1, "int");
	level.cost_mp44 = updateCvar("scr_mp44_cost", level.cost_mp44, 0,"","int");
	updateCostStringCvar(level.cost_mp44, "ui_mp44_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED SCOPED MP44
	//////////////////////////////////////////////////////////
	level.allow_scopedmp44 = updateCvar("scr_allow_scopedmp44", level.allow_scopedmp44, 0, 1, "int");
	updateCvar("ui_allow_scopedmp44", level.allow_scopedmp44, 0, 1, "int");
	level.cost_scopedmp44 = updateCvar("scr_scopedmp44_cost", level.cost_scopedmp44, 0,"","int");
	updateCostStringCvar(level.cost_scopedmp44, "ui_scopedmp44_cost");
	
	/////////////////////////////////////////////////////////////////
	// ADDED FG42 UNSCOPED
	/////////////////////////////////////////////////////////////////
	level.allow_fg42 = updateCvar("scr_allow_fg42", level.allow_fg42, 0, 1, "int");
	updateCvar("ui_allow_fg42", level.allow_fg42, 0, 1, "int");
	
	level.allow_fg42_none = updateCvar("scr_allow_fg42_none", level.allow_fg42_none, 0, 1, "int");
	updateCvar("ui_allow_fg42_none", level.allow_fg42_none, 0, 1, "int");
	level.cost_fg42 = updateCvar("scr_fg42_cost", level.cost_fg42, 0,"","int");
	updateCostStringCvar(level.cost_fg42, "ui_fg42_cost");
		
	level.allow_fg42_scoped = updateCvar("scr_allow_fg42_scoped", level.allow_fg42_scoped, 0, 1, "int");
	updateCvar("ui_allow_fg42_scoped", level.allow_fg42_scoped, 0, 1, "int");
	level.cost_fg42_scoped = updateCvar("scr_fg42_scoped_cost",level.cost_fg42_scoped, 0,"","int");
	updateCostStringCvar(level.cost_fg42_scoped, "ui_fg42_scoped_cost");
	
	////////////////////////////////////////
	//ADDED CLASS BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_mgs = updateCvar("scr_allow_mgs", level.allow_mgs, 0, 1, "int");
	updateCvar("ui_allow_mgs", level.allow_mgs, 0, 1, "int");
}

updateHeavyCvars()
{
	///////////////////////////////////////////////////////////////
	// MG30Cal
	///////////////////////////////////////////////////////////////
	level.allow_mg30cal = updateCvar("scr_allow_mg30cal", level.allow_mg30cal, 0, 1, "int");
	updateCvar("ui_allow_mg30cal", level.allow_mg30cal, 0, 1, "int");
	level.cost_mg30cal = updateCvar("scr_mg30cal_cost", level.cost_mg30cal, 0,"","int");
	updateCostStringCvar(level.cost_mg30cal, "ui_mg30cal_cost");
	
	///////////////////////////////////////////////////////////////
	// DP28
	///////////////////////////////////////////////////////////////
	level.allow_dp28 = updateCvar("scr_allow_dp28", level.allow_dp28, 0, 1, "int");
	updateCvar("ui_allow_dp28", level.allow_dp28, 0, 1, "int");
	level.cost_dp28 = updateCvar("scr_dp28_cost", level.cost_dp28, 0,"","int");
	updateCostStringCvar(level.cost_dp28, "ui_dp28_cost");
	
	///////////////////////////////////////////////////////////////
	// MG34
	///////////////////////////////////////////////////////////////
	level.allow_mg34 = updateCvar("scr_allow_mg34", level.allow_mg34, 0, 1, "int");
	updateCvar("ui_allow_mg34", level.allow_mg34, 0, 1, "int");
	level.cost_mg34 = updateCvar("scr_mg34_cost", level.cost_mg34, 0,"","int");
	updateCostStringCvar(level.cost_mg34, "ui_mg34_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED MG42
	///////////////////////////////////////////////////////////////
	level.allow_mg42_mp = updateCvar("scr_allow_mg42_mp", level.allow_mg42_mp, 0, 1, "int");
	updateCvar("ui_allow_mg42_mp", level.allow_mg42_mp, 0, 1, "int");
	level.cost_mg42 = updateCvar("scr_mg42_cost", level.cost_mg42, 0,"","int");
	updateCostStringCvar(level.cost_mg42, "ui_mg42_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED TRENCHGUN
	///////////////////////////////////////////////////////////////
	level.allow_trenchgun = updateCvar("scr_allow_trenchgun", level.allow_trenchgun, 0, 1, "int");
	updateCvar("ui_allow_trenchgun", level.allow_trenchgun, 0, 1, "int");
	level.cost_trenchgun = updateCvar("scr_trenchgun_cost", level.cost_trenchgun, 0,"","int");
	updateCostStringCvar(level.cost_trenchgun, "ui_trenchgun_cost");
	
	////////////////////////////////////////
	//ADDED CLASS BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_heavies = updateCvar("scr_allow_heavies", level.allow_heavies, 0, 1, "int");
	updateCvar("ui_allow_heavies", level.allow_heavies, 0, 1, "int");
}

updateSniperCvars()
{
	/////////////////////////////////////////////////////////////////
	// ADDED M1903A3
	/////////////////////////////////////////////////////////////////
	level.allow_springfield = updateCvar("scr_allow_springfield", level.allow_springfield, 0, 1, "int");
	updateCvar("ui_allow_springfield", level.allow_springfield, 0, 1, "int");
	
	level.allow_m1903a3 = updateCvar("scr_allow_m1903a3", level.allow_m1903a3, 0, 1, "int");
	updateCvar("ui_allow_m1903a3", level.allow_m1903a3, 0, 1, "int");
	level.cost_m1903a3 = updateCvar("scr_m1903a3_cost", level.cost_m1903a3, 0,"","int");
	updateCostStringCvar(level.cost_m1903a3, "ui_m1903a3_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED SPRINGFIELD SNIPER
	//////////////////////////////////////////////////////////
	level.allow_springfield_scoped = updateCvar("scr_allow_springfield_scoped", level.allow_springfield_scoped, 0, 1, "int");
	updateCvar("ui_allow_springfield_scoped", level.allow_springfield_scoped, 0, 1, "int");
	level.cost_springfield_scoped = updateCvar("scr_springfield_scoped_cost", level.cost_springfield_scoped, 0,"","int");
	updateCostStringCvar(level.cost_springfield_scoped, "ui_springfield_cost");
	
	/////////////////////////////////////////////////////////////////
	// ENFIELD
	/////////////////////////////////////////////////////////////////
	level.allow_enfield = updateCvar("scr_allow_enfield", level.allow_enfield, 0, 1, "int");
	updateCvar("ui_allow_enfield", level.allow_enfield, 0, 1, "int");
	
	level.allow_enfield_none = updateCvar("scr_allow_enfield_none", level.allow_enfield_none, 0, 1, "int");
	updateCvar("ui_allow_enfield_none", level.allow_enfield_none, 0, 1, "int");
	level.cost_enfield = updateCvar("scr_enfield_cost", level.cost_enfield, 0,"","int");
	updateCostStringCvar(level.cost_enfield, "ui_enfield_cost");
		
	//////////////////////////////////////////////////////////
	// ADDED ENFIELD SNIPER
	//////////////////////////////////////////////////////////
	level.allow_enfield_sniper = updateCvar("scr_allow_enfield_sniper", level.allow_enfield_sniper, 0, 1, "int");
	updateCvar("ui_allow_enfield_sniper", level.allow_enfield_sniper, 0, 1, "int");
	level.cost_enfield_sniper = updateCvar("scr_enfield_sniper_cost", level.cost_enfield_sniper, 0,"","int");
	updateCostStringCvar(level.cost_enfield_sniper, "ui_enfield_sniper_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED DELISLE
	///////////////////////////////////////////////////////////////
	level.allow_delisle = updateCvar("scr_allow_delisle", level.allow_delisle, 0, 1, "int");
	updateCvar("ui_allow_delisle", level.allow_delisle, 0, 1, "int");
	level.cost_delisle = updateCvar("scr_delisle_cost", level.cost_delisle, 0,"","int");
	updateCostStringCvar(level.cost_delisle, "ui_delisle_cost");
	
	/////////////////////////////////////////////////////////////////
	// NAGANT
	/////////////////////////////////////////////////////////////////
	level.allow_nagant = updateCvar("scr_allow_nagant", level.allow_nagant, 0, 1, "int");
	updateCvar("ui_allow_nagant", level.allow_nagant, 0, 1, "int");
	
	level.allow_nagant_none = updateCvar("scr_allow_nagant_none", level.allow_nagant_none, 0, 1, "int");
	updateCvar("ui_allow_nagant_none", level.allow_nagant_none, 0, 1, "int");
	level.cost_nagant = updateCvar("scr_nagant_cost", level.cost_nagant, 0,"","int");
	updateCostStringCvar(level.cost_nagant, "ui_nagant_cost");
		
	//////////////////////////////////////////////////////////
	//NAGANT SNIPER
	//////////////////////////////////////////////////////////
	level.allow_nagantsniper = updateCvar("scr_allow_nagantsniper", level.allow_nagantsniper, 0, 1, "int");
	updateCvar("ui_allow_nagantsniper", level.allow_nagantsniper, 0, 1, "int");
	level.cost_nagantsniper = updateCvar("scr_nagantsniper_cost", level.cost_nagantsniper, 0,"","int");
	updateCostStringCvar(level.cost_nagantsniper, "ui_nagantsniper_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED PTRS
	///////////////////////////////////////////////////////////////
	level.allow_ptrs = updateCvar("scr_allow_ptrs", level.allow_ptrs, 0, 1, "int");
	updateCvar("ui_allow_ptrs", level.allow_ptrs, 0, 1, "int");
	level.cost_ptrs = updateCvar("scr_ptrs_cost", level.cost_ptrs, 0,"","int");
	updateCostStringCvar(level.cost_ptrs, "ui_ptrs_cost");
	
	/////////////////////////////////////////////////////////////////
	// KAR98K
	/////////////////////////////////////////////////////////////////
	level.allow_kar98k = updateCvar("scr_allow_kar98k", level.allow_kar98k, 0, 1, "int");
	updateCvar("ui_allow_kar98k", level.allow_kar98k, 0, 1, "int");
	
	level.allow_kar98k_none = updateCvar("scr_allow_kar98k_none", level.allow_kar98k_none, 0, 1, "int");
	updateCvar("ui_allow_kar98k_none", level.allow_kar98k_none, 0, 1, "int");
	level.cost_kar98k = updateCvar("scr_kar98k_cost", level.cost_kar98k, 0,"","int");
	updateCostStringCvar(level.cost_kar98k, "ui_kar98k_cost");
		
	//////////////////////////////////////////////////////////
	// KAR98K SNIPER
	//////////////////////////////////////////////////////////
	level.allow_kar98ksniper = updateCvar("scr_allow_kar98ksniper", level.allow_kar98ksniper, 0, 1, "int");
	updateCvar("ui_allow_kar98ksniper", level.allow_kar98ksniper, 0, 1, "int");
	level.cost_kar98ksniper = updateCvar("scr_kar98ksniper_cost", level.cost_kar98ksniper, 0,"","int");
	updateCostStringCvar(level.cost_kar98ksniper, "ui_kar98ksniper_cost");
	
	////////////////////////////////////////
	//ADDED CLASS BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_snipers = updateCvar("scr_allow_snipers", level.allow_snipers, 0, 1, "int");
	updateCvar("ui_allow_snipers", level.allow_snipers, 0, 1, "int");
}

updatePistolCvars()
{
	///////////////////////////////////////////////////////////////
	// COLT
	///////////////////////////////////////////////////////////////
	level.allow_colt = updateCvar("scr_allow_colt", level.allow_colt, 0, 1, "int");
	updateCvar("ui_allow_colt", level.allow_colt, 0, 1, "int");
	level.cost_colt = updateCvar("scr_colt_cost", level.cost_colt, 0,"","int");
	updateCostStringCvar(level.cost_colt, "ui_colt_cost");
	
	///////////////////////////////////////////////////////////////
	// WEBLEY
	///////////////////////////////////////////////////////////////
	level.allow_webley = updateCvar("scr_allow_webley", level.allow_webley, 0, 1, "int");
	updateCvar("ui_allow_webley", level.allow_webley, 0, 1, "int");
	level.cost_webley = updateCvar("scr_webley_cost", level.cost_webley, 0,"","int");
	updateCostStringCvar(level.cost_webley, "ui_webley_cost");
	
	///////////////////////////////////////////////////////////////
	// TT33
	///////////////////////////////////////////////////////////////
	level.allow_tt33 = updateCvar("scr_allow_tt33", level.allow_tt33, 0, 1, "int");
	updateCvar("ui_allow_tt33", level.allow_tt33, 0, 1, "int");
	level.cost_tt33 = updateCvar("scr_tt33_cost", level.cost_tt33, 0,"","int");
	updateCostStringCvar(level.cost_tt33, "ui_tt33_cost");
	
	///////////////////////////////////////////////////////////////
	// LUGER
	///////////////////////////////////////////////////////////////
	level.allow_luger = updateCvar("scr_allow_luger", level.allow_luger, 0, 1, "int");
	updateCvar("ui_allow_luger", level.allow_luger, 0, 1, "int");
	level.cost_luger = updateCvar("scr_luger_cost", level.cost_luger, 0,"","int");
	updateCostStringCvar(level.cost_luger, "ui_luger_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED WELROD
	///////////////////////////////////////////////////////////////
	level.allow_welrod = updateCvar("scr_allow_welrod", level.allow_welrod, 0, 1, "int");
	updateCvar("ui_allow_welrod", level.allow_welrod, 0, 1, "int");
	level.cost_welrod = updateCvar("scr_welrod_cost", level.cost_welrod, 0,"","int");
	updateCostStringCvar(level.cost_welrod, "ui_welrod_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED M712
	///////////////////////////////////////////////////////////////
	level.allow_m712 = updateCvar("scr_allow_m712", level.allow_m712, 0, 1, "int");
	updateCvar("ui_allow_m712", level.allow_m712, 0, 1, "int");
	level.cost_m712 = updateCvar("scr_m712_cost", level.cost_m712, 0,"","int");
	updateCostStringCvar(level.cost_m712, "ui_m712_cost");
	
	////////////////////////////////////////
	//ADDED SLOT BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_pistols = updateCvar("scr_allow_pistols", level.allow_pistols, 0, 1, "int");
	updateCvar("ui_allow_pistols", level.allow_pistols, 0, 1, "int");
}

updateGrenadeCvars()
{
	///////////////////////////////////////////////////////////////
	// FRAGGRENADE
	///////////////////////////////////////////////////////////////
	level.allow_fraggrenade = updateCvar("scr_allow_fraggrenade", level.allow_fraggrenade, 0, 1, "int");
	updateCvar("ui_allow_fraggrenade", level.allow_fraggrenade, 0, 1, "int");
	level.cost_fraggrenade = updateCvar("scr_fraggrenade_cost", level.cost_fraggrenade, 0,"","int");
	updateCostStringCvar(level.cost_fraggrenade, "ui_fraggrenade_cost");
	
	///////////////////////////////////////////////////////////////
	// MK1BRITISHFRAG
	///////////////////////////////////////////////////////////////
	level.allow_mk1britishfraggrenade = updateCvar("scr_allow_mk1britishfraggrenade", level.allow_mk1britishfraggrenade, 0, 1, "int");
	updateCvar("ui_allow_mk1britishfraggrenade", level.allow_mk1britishfraggrenade, 0, 1, "int");
	level.cost_mk1britishfraggrenade = updateCvar("scr_mk1britishfraggrenade_cost", level.cost_mk1britishfraggrenade, 0,"","int");
	updateCostStringCvar(level.cost_mk1britishfraggrenade, "ui_mk1britishfraggrenade_cost");
	
	///////////////////////////////////////////////////////////////
	// RGD33 RUSSIAN FRAGGRENADE
	///////////////////////////////////////////////////////////////
	level.allow_rgd33russianfraggrenade = updateCvar("scr_allow_rgd33russianfraggrenade", level.allow_rgd33russianfraggrenade, 0, 1, "int");
	updateCvar("ui_allow_rgd33russianfraggrenade", level.allow_rgd33russianfraggrenade, 0, 1, "int");
	level.cost_rgd33russianfraggrenade = updateCvar("scr_rgd33russianfraggrenade_cost", level.cost_rgd33russianfraggrenade, 0,"","int");
	updateCostStringCvar(level.cost_rgd33russianfraggrenade, "ui_rgd33russianfraggrenade_cost");
	
	///////////////////////////////////////////////////////////////
	// STEILHANDGRANATE
	///////////////////////////////////////////////////////////////
	level.allow_stielhandgranate = updateCvar("scr_allow_stielhandgranate", level.allow_stielhandgranate, 0, 1, "int");
	updateCvar("ui_allow_stielhandgranate", level.allow_stielhandgranate, 0, 1, "int");
	level.cost_stielhandgranate = updateCvar("scr_stielhandgranate_cost", level.cost_stielhandgranate, 0,"","int");
	updateCostStringCvar(level.cost_stielhandgranate, "ui_stielhandgranate_cost");
	
	////////////////////////////////////////
	//ADDED SLOT BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_grenades = updateCvar("scr_allow_grenades", level.allow_grenades, 0, 1, "int");
	updateCvar("ui_allow_grenades", level.allow_grenades, 0, 1, "int");
}

updateSmokeCvars()
{
	///////////////////////////////////////////////////////////////
	// SMOKEGRENADE
	///////////////////////////////////////////////////////////////
	level.allow_smokegrenade = updateCvar("scr_allow_smokegrenade", level.allow_smokegrenade, 0, 1, "int");
	updateCvar("ui_allow_smokegrenade", level.allow_smokegrenade, 0, 1, "int");
	level.cost_smokegrenade = updateCvar("scr_smokegrenade_cost", level.cost_smokegrenade, 0,"","int");
	updateCostStringCvar(level.cost_smokegrenade, "ui_smokegrenade_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED MOLOTOV
	///////////////////////////////////////////////////////////////
	level.allow_molotov = updateCvar("scr_allow_molotov", level.allow_molotov, 0, 1, "int");
	updateCvar("ui_allow_molotov", level.allow_molotov, 0, 1, "int");
	level.cost_molotov = updateCvar("scr_molotov_cost", level.cost_molotov, 0,"","int");
	updateCostStringCvar(level.cost_molotov, "ui_molotov_cost");
	level.molotov_burn_time = updateCvar("scr_molotov_burn_time",level.molotov_burn_time,1,60,"int");
	updateTimeStringCvar(level.molotov_burn_time, "ui_molotov_burn_time");
	
	///////////////////////////////////////////////////////////////
	// ADDED MUSTARD GAS
	///////////////////////////////////////////////////////////////
	level.allow_mustardgas = updateCvar("scr_allow_mustardgas", level.allow_mustardgas, 0, 1, "int");
	updateCvar("ui_allow_mustardgas", level.allow_mustardgas, 0, 1, "int");
	level.cost_mustardgas = updateCvar("scr_mustardgas_cost", level.cost_mustardgas, 0,"","int");
	updateCostStringCvar(level.cost_mustardgas, "ui_mustardgas_cost");
	level.mustardgas_linger_time = updateCvar("scr_mustardgas_linger_time",level.mustardgas_linger_time,1,60,"int");
	updateTimeStringCvar(level.mustardgas_linger_time, "ui_mustardgas_linger_time");
	
	////////////////////////////////////////
	//ADDED SLOT BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_smoke = updateCvar("scr_allow_smoke", level.allow_smoke, 0, 1, "int");
	updateCvar("ui_allow_smoke", level.allow_smoke, 0, 1, "int");
}

updateSatchelCvars()
{
	///////////////////////////////////////////////////////////////
	// SATCHELCHARGE
	///////////////////////////////////////////////////////////////
	level.allow_satchelcharge = updateCvar("scr_allow_satchelcharge", level.allow_satchelcharge, 0, 1, "int");
	updateCvar("ui_allow_satchelcharge", level.allow_satchelcharge, 0, 1, "int");
	level.cost_satchelcharge = updateCvar("scr_satchelcharge_cost", level.cost_satchelcharge, 0,"","int");
	updateCostStringCvar(level.cost_satchelcharge, "ui_satchelcharge_cost");
	
	///////////////////////////////////////////////////////////////
	// ADDED GEBALLTE
	///////////////////////////////////////////////////////////////
	level.allow_geballte = updateCvar("scr_allow_geballte", level.allow_geballte, 0, 1, "int");
	updateCvar("ui_allow_geballte", level.allow_geballte, 0, 1, "int");
	level.cost_geballte = updateCvar("scr_geballte_cost", level.cost_geballte, 0,"","int");
	updateCostStringCvar(level.cost_geballte, "ui_geballte_cost");
	
	///////////////////////////////////////////////////////////////
	// PANZERSCHRECK
	///////////////////////////////////////////////////////////////
	level.allow_panzerschreck = updateCvar("scr_allow_panzerschreck", level.allow_panzerschreck, 0, 1, "int");
	updateCvar("ui_allow_panzerschreck", level.allow_panzerschreck, 0, 1, "int");
	level.cost_panzerschreck = updateCvar("scr_panzerschreck_cost", level.cost_panzerschreck, 0,"","int");
	updateCostStringCvar(level.cost_panzerschreck, "ui_panzerschreck_cost");
	
	///////////////////////////////////////////////////////////////
	// BAZOOKA
	///////////////////////////////////////////////////////////////
	level.allow_bazooka = updateCvar("scr_allow_bazooka", level.allow_bazooka, 0, 1, "int");
	updateCvar("ui_allow_bazooka", level.allow_bazooka, 0, 1, "int");
	level.cost_bazooka = updateCvar("scr_bazooka_cost", level.cost_bazooka, 0,"","int");
	updateCostStringCvar(level.cost_bazooka, "ui_bazooka_cost");
	
	///////////////////////////////////////////////////////////////
	// FLAMETHROWER
	///////////////////////////////////////////////////////////////
	level.allow_flamethrower = updateCvar("scr_allow_flamethrower", level.allow_flamethrower, 0, 1, "int");
	updateCvar("ui_allow_flamethrower", level.allow_flamethrower, 0, 1, "int");
	level.cost_flamethrower = updateCvar("scr_flamethrower_cost", level.cost_flamethrower, 0,"","int");
	updateCostStringCvar(level.cost_flamethrower, "ui_flamethrower_cost");
	
	////////////////////////////////////////
	//ADDED SLOT BASED RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_satchel = updateCvar("scr_allow_satchel", level.allow_satchel, 0, 1, "int");
	updateCvar("ui_allow_satchel", level.allow_satchel, 0, 1, "int");
}

updatePerkCvars()
{
	///////////////////////////////////////////////////////////////
	// 2X EQUIPMENT
	///////////////////////////////////////////////////////////////
	level.allow_extra_equipment = updateCvar("scr_allow_extra_equipment", level.allow_extra_equipment, 0, 1, "int");
	updateCvar("ui_allow_extra_equipment", level.allow_extra_equipment, 0, 1, "int");
	level.cost_extra_equipment = updateCvar("scr_extra_equipment_cost", level.cost_extra_equipment, 0,"","int");
	updateCostStringCvar(level.cost_extra_equipment, "ui_extra_equipment_cost");
	
	///////////////////////////////////////////////////////////////
	// BOMB SQUAD
	///////////////////////////////////////////////////////////////
	level.allow_bombsquad = updateCvar("scr_allow_bombsquad", level.allow_bombsquad, 0, 1, "int");
	updateCvar("ui_allow_bombsquad", level.allow_bombsquad, 0, 1, "int");
	level.cost_bombsquad = updateCvar("scr_bombsquad_cost", level.cost_bombsquad, 0,"","int");
	updateCostStringCvar(level.cost_bombsquad, "ui_bombsquad_cost");
	
	///////////////////////////////////////////////////////////////
	// TRIPWIRE
	///////////////////////////////////////////////////////////////
	level.allow_tripwire = updateCvar("scr_allow_tripwire", level.allow_tripwire, 0, 3, "int");
	updateCvar("ui_allow_tripwire", level.allow_tripwire, 0, 3, "int");
	level.cost_tripwire = updateCvar("scr_tripwire_cost", level.cost_tripwire, 0,"","int");
	updateCostStringCvar(level.cost_tripwire, "ui_tripwire_cost");
	
	level.tripwire_num_traps = updateCvar("scr_tripwire_num_traps",level.tripwire_num_traps,1,32,"int");
	level.tripwire_satchels = updateCvar("scr_tripwire_satchels",level.tripwire_satchels,0,1,"int");
	updateEnableStringCvar(level.tripwire_satchels,"ui_tripwire_satchels");
	level.tripwire_stickynades = updateCvar("scr_tripwire_stickynades",level.tripwire_stickynades,0,2,"int");
	updateEnableStringCvar(level.tripwire_stickynades,"ui_tripwire_stickynades");
	level.tripwire_plant_time = updateCvar("scr_tripwire_plant_time",level.tripwire_plant_time,1,99,"int");
	updateTimeStringCvar(level.tripwire_plant_time,"ui_tripwire_plant_time");
	level.tripwire_defuse_time = updateCvar("scr_tripwire_defuse_time",level.tripwire_defuse_time,1,99,"int");
	updateTimeStringCvar(level.tripwire_defuse_time,"ui_tripwire_defuse_time");
	
	///////////////////////////////////////////////////////////////
	// 3X SMOKE
	///////////////////////////////////////////////////////////////
	level.allow_extra_smoke = updateCvar("scr_allow_extra_smoke", level.allow_extra_smoke, 0, 1, "int");
	updateCvar("ui_allow_extra_smoke", level.allow_extra_smoke, 0, 1, "int");
	level.cost_extra_smoke = updateCvar("scr_extra_smoke_cost", level.cost_extra_smoke, 0,"","int");
	updateCostStringCvar(level.cost_extra_smoke, "ui_extra_smoke_cost");
	
	///////////////////////////////////////////////////////////////
	// 3X GRENADE
	///////////////////////////////////////////////////////////////
	level.allow_extra_grenade = updateCvar("scr_allow_extra_grenade", level.allow_extra_grenade, 0, 1, "int");
	updateCvar("ui_allow_extra_grenade", level.allow_extra_grenade, 0, 1, "int");
	level.cost_extra_grenade = updateCvar("scr_extra_grenade_cost", level.cost_extra_grenade, 0,"","int");
	updateCostStringCvar(level.cost_extra_grenade, "ui_extra_grenade_cost");
	
	///////////////////////////////////////////////////////////////
	// MAX AMMO
	///////////////////////////////////////////////////////////////
	level.allow_extra_ammo = updateCvar("scr_allow_extra_ammo", level.allow_extra_ammo, 0, 1, "int");
	updateCvar("ui_allow_extra_ammo", level.allow_extra_ammo, 0, 1, "int");
	level.cost_extra_ammo = updateCvar("scr_extra_ammo_cost", level.cost_extra_ammo, 0,"","int");
	updateCostStringCvar(level.cost_extra_ammo, "ui_extra_ammo_cost");
	
	///////////////////////////////////////////////////////////////
	// MARATHON
	///////////////////////////////////////////////////////////////
	level.allow_marathon = updateCvar("scr_allow_marathon", level.allow_marathon, 0, 2, "int");
	updateCvar("ui_allow_marathon", level.allow_marathon, 0, 2, "int");
	level.cost_marathon = updateCvar("scr_marathon_cost",level.cost_marathon, 0,"","int");
	updateCostStringCvar(level.cost_marathon, "ui_marathon_cost");
	
	level.marathon_sprint_time_value = updateCvar("scr_marathon_sprint_time",level.marathon_sprint_time_value,100,999,"int");
	level.marathon_sprint_time = (float)100 / (float)level.marathon_sprint_time_value;
	if(level.allow_marathon == 2)
		setCvar("ui_marathon_sprint_time", "Unlimited");
	else
		updateMultiplierStringCvar(level.marathon_sprint_time_value, "ui_marathon_sprint_time");
	level.marathon_sprint_speed_value = updateCvar("scr_marathon_sprint_speed", level.marathon_sprint_speed_value, 100, 200, "int");
	level.marathon_sprint_speed = (float)level.marathon_sprint_speed_value * (float)0.01;
	updateMultiplierStringCvar(level.marathon_sprint_speed_value, "ui_marathon_sprint_speed");
	level.marathon_sprint_recovery_value = updateCvar("scr_marathon_sprint_recovery", level.marathon_sprint_recovery_value, 100, 200, "int");
	level.marathon_sprint_recovery = (float)level.marathon_sprint_recovery_value * (float)0.01;
	updateMultiplierStringCvar(level.marathon_sprint_recovery_value, "ui_marathon_sprint_recovery");
	
	///////////////////////////////////////////////////////////////
	// MEDIC
	///////////////////////////////////////////////////////////////
	level.allow_medic = updateCvar("scr_allow_medic", level.allow_medic, 0, 1, "int");
	updateCvar("ui_allow_medic", level.allow_medic, 0, 1, "int");
	level.cost_medic = updateCvar("scr_medic_cost", level.cost_medic, 0,"","int");
	updateCostStringCvar(level.cost_medic, "ui_medic_cost");
	
	level.medic_firstaidkits = updateCvar("scr_medic_firstaidkits", level.medic_firstaidkits, 0, 99, "int");
	level.medic_firstaidhealth = updateCvar("scr_medic_firstaidhealth", level.medic_firstaidhealth, 1, 100, "int");
	level.medic_firstaiddelay = updateCvar("scr_medic_firstaiddelay", level.medic_firstaiddelay,0,999, "int");
	updateTimeStringCvar(level.medic_firstaiddelay,"ui_medic_firstaiddelay");
	
	///////////////////////////////////////////////////////////////
	// SCAVENGER
	///////////////////////////////////////////////////////////////
	level.allow_scavenger = updateCvar("scr_allow_scavenger", level.allow_scavenger, 0, 2, "int");
	updateCvar("ui_allow_scavenger", level.allow_scavenger, 0, 2, "int");
	level.cost_scavenger = updateCvar("scr_scavenger_cost", level.cost_scavenger, 0,"","int");
	updateCostStringCvar(level.cost_scavenger, "ui_scavenger_cost");
	
	if(level.allow_scavenger == 2)
		setCvar("ui_scavenger_autosearch", "Enabled");
	else
		setCvar("ui_scavenger_autosearch", "Disabled");
	
	level.scavenger_search_time = updateCvar("scr_scavenger_search_time", level.scavenger_search_time, 1, 10, "int");
	
	updateTimeStringCvar(level.scavenger_search_time, "ui_scavenger_search_time");
	
	////////////////////////////////////////
	//PERK RESTRICTION CVARS
	////////////////////////////////////////
	level.allow_perks = updateCvar("scr_allow_perks", level.allow_perks, 0, 1, "int");
	updateCvar("ui_allow_perks", level.allow_perks, 0, 1, "int");
	
	level.allow_tier1_perks = updateCvar("scr_allow_tier1_perks", level.allow_tier1_perks, 0, 1, "int");
	updateCvar("ui_allow_tier1_perks", level.allow_tier1_perks, 0, 1, "int");
	level.allow_tier2_perks = updateCvar("scr_allow_tier2_perks", level.allow_tier2_perks, 0, 1, "int");
	updateCvar("ui_allow_tier2_perks", level.allow_tier2_perks, 0, 1, "int");
	level.allow_tier3_perks = updateCvar("scr_allow_tier3_perks", level.allow_tier3_perks, 0, 1, "int");
	updateCvar("ui_allow_tier3_perks", level.allow_tier3_perks, 0, 1, "int");
}

updateKSCvars()
{
	level.allow_artillery_ks = updateCvar("scr_allow_artillery_ks", level.allow_artillery_ks, 0, 1, "int");
	updateCvar("ui_allow_artillery_ks", level.allow_artillery_ks, 0, 1, "int");
	level.kills_artillery = updateCvar("scr_artillery_kills", level.kills_artillery, 0, "", "int");
	updateKillStringCvar(level.kills_artillery,"ui_artillery_kills");
	
	level.allow_binoculars = updateCvar("scr_allow_binoculars", level.allow_binoculars, 0, 1, "int");
	updateCvar("ui_allow_binoculars", level.allow_binoculars, 0, 1, "int");
	
	level.allow_artillery = updateCvar("scr_allow_artillery", level.allow_artillery, 0, 1, "int");
	updateCvar("ui_allow_artillery", level.allow_artillery, 0, 1, "int");
	
	level.allow_deployablemg_ks = updateCvar("scr_allow_deployablemg_ks",level.allow_deployablemg_ks,0,20,"int");
	updateCvar("ui_allow_deployablemg_ks",level.allow_deployablemg_ks,0,1,"int");
	level.kills_deployablemg = updateCvar("scr_deployablemg_kills",level.kills_deployablemg,1,"","int");
	updateKillStringCvar(level.kills_deployablemg, "ui_deployablemg_kills");
	
	////////////////////////////////////////
	//RESTRICT KILLSTREAKS CVARS
	////////////////////////////////////////
	level.allow_killstreaks = updateCvar("scr_allow_killstreaks", level.allow_killstreaks, 0, 1, "int");
	updateCvar("ui_allow_killstreaks", level.allow_killstreaks, 0, 1, "int");
	
}
/*
USAGE OF "cvardef"
cvardef replaces the multiple lines of code used repeatedly in the setup areas of the script.
The function requires 6 parameters, sets the cvar, and returns the set value of the specified cvar
Parameters:
	varname - The name of the variable, i.e. "scr_teambalance", or "scr_dem_respawn"
		This function will automatically find map-sensitive overrides, i.e. "src_dem_respawn_mp_brecourt"

	vardefault - The default value for the variable.  
		Numbers do not require quotes, but strings do.  i.e.   10, "10", or "wave"

	min - The minimum value if the variable is an "int" or "float" type
		If there is no minimum, use "" as the parameter in the function call

	max - The maximum value if the variable is an "int" or "float" type
		If there is no maximum, use "" as the parameter in the function call

	type - The type of data to be contained in the vairable.
		"int" - integer value: 1, 2, 3, etc.
		"float" - floating point value: 1.0, 2.5, 10.384, etc.
		"string" - a character string: "wave", "player", "none", etc.
		
	update - whether the var is being defined or being updated
		false - define the var
		true - update the var
*/
cvardef(varname, vardefault, min, max, type, update)
{
	
	if(!isDefined(update))
	{
		update = false;
	}
	// get the variable's definition
	switch(type)
	{
		case "int":
			if(getcvar(varname) == "")		// if the cvar is blank
				definition = vardefault;	// set the default
			else
				definition = getcvarint(varname);
			break;
		case "float":
			if(getcvar(varname) == "")	// if the cvar is blank
				definition = vardefault;	// set the default
			else
				definition = getcvarfloat(varname);
			break;
		case "string":
		default:
			if(getcvar(varname) == "")		// if the cvar is blank
				definition = vardefault;	// set the default
			else
				definition = getcvar(varname);
			break;
	}

	// if it's a number, with a minimum, that violates the parameter
	if((type == "int" || type == "float") && min != "" && definition < min)
		definition = min;

	// if it's a number, with a maximum, that violates the parameter
	if((type == "int" || type == "float") && max != "" && definition > max)
		definition = max;
	
	//set cvar
	if(!update)
		setCvar(varname,definition);

	return definition;
}
////////////////////////////////////////////////////////////////////////////////
// updateCvar
//
//	varname - the cvar that holds the scr value
//  currentvalue - the current value of the cvars
//  min - minimun allowed value for update
//  max - maximum allowed value for update
//  type - The type of data to be used with the cvar
//    returns the updated value of the cvars
///////////////////////////////////////////////////////////////////////////////
updateCvar(varname, currentvalue, min, max, type)
{
	
	updatedvalue = cvardef(scrcvar, currentvalue, min, max, type, true);
	
	if(updatedvalue != currentvalue)
	{
		setCvar(varname,definition);
	}
	
	return updatedvalue;
}

////////////////////////////////////////////////////////////////////////////////
// updateCostStringCvar
//
//  cost
//  cvar - the cvar that holds the string
////////////////////////////////////////////////////////////////////////////////
updateCostStringCvar(cost, cvar)
{
	if(cost == 1)
	{
		string = "(1 point)";
	}
	else
	{
		string = "(" + cost + " points)";
	}
	if(getCvar(cvar) != string)
	{
		setCvar(cvar, string);
	}
}

updateKillStringCvar(cost, cvar)
{
	if(cost == 1)
	{
		string = "(1 kill)";
	}
	else
	{
		string = "(" + cost + " kills)";
	}
	if(getCvar(cvar) != string)
	{
		setCvar(cvar, string);
	}
}

updateTimeStringCvar(cost, cvar)
{
	if(cost == 1)
	{
		string = "(1 second)";
	}
	else
	{
		string = "(" + cost + " seconds)";
	}
	if(getCvar(cvar) != string)
	{
		setCvar(cvar, string);
	}
}
updateEnableStringCvar(cost, cvar)
{
	if(cost == 1)
	{
		string = "Enabled";
	}
	else
	{
		string = "Disabled";
	}
	if(getCvar(cvar) != string)
	{
		setCvar(cvar, string);
	}
}
updateMultiplierStringCvar(cost, cvar)
{
	multiplier = (float)cost * (float)0.01;
	
	string = "(" + multiplier + "x)";
	
	if(getCvar(cvar) != string)
	{
		setCvar(cvar, string);
	}
}