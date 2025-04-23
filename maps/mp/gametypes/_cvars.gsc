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
	cvardef("ui_m1carbine_cost", "(" + level.cost_m1carbine + " points)", "", "", "string");
	
	level.allow_m2carbine = cvardef("scr_allow_m2carbine",1,0,1,"int");
	cvardef("ui_allow_m2carbine",level.allow_m2carbine,0,1,"int");
	level.cost_m2carbine = cvardef("scr_m2carbine_cost",2,0,"","int");
	cvardef("ui_m2carbine_cost", "(" + level.cost_m2carbine + " points)", "", "", "string");
	
	level.allow_m3carbine = cvardef("scr_allow_m3carbine",1,0,1,"int");
	cvardef("ui_allow_m3carbine",level.allow_m3carbine,0,1,"int");
	level.cost_m3carbine = cvardef("scr_m3carbine_cost",2,0,"","int");
	cvardef("ui_m3carbine_cost", "(" + level.cost_m3carbine + " points)", "", "", "string");
	
	level.allow_m1garand = cvardef("scr_allow_m1garand",1,0,1,"int");
	cvardef("ui_allow_m1garand",level.allow_m1garand,0,1,"int");
	makeCvarServerInfo("ui_allow_m1garand", "1");
	
	level.allow_m1garand_none = cvardef("scr_allow_m1garand_none",1,0,1,"int");
	cvardef("ui_allow_m1garand_none",level.allow_m1garand_none,0,1,"int");
	level.cost_m1garand = cvardef("scr_m1garand_cost",1,0,"","int");
	cvardef("ui_m1garand_cost", "(" + level.cost_m1garand + " points)", "", "", "string");
	
	level.allow_m1garand_sniper = cvardef("scr_allow_m1garand_sniper",1,0,1,"int");
	cvardef("ui_allow_m1garand_sniper",level.allow_m1garand_sniper,0,1,"int");
	level.cost_m1garand_sniper = cvardef("scr_m1garand_sniper_cost",2,0,"","int");
	cvardef("ui_m1garand_sniper_cost", "(" + level.cost_m1garand_sniper + " points)", "", "", "string");
	
	level.allow_m1garand_grenade = cvardef("scr_allow_m1garand_grenade",1,0,1,"int");
	cvardef("ui_allow_m1garand_grenade",level.allow_m1garand_grenade,0,1,"int");
	level.cost_m1garand_grenade = cvardef("scr_m1garand_grenade_cost",2,0,"","int");
	cvardef("ui_m1garand_grenade_cost", "(" + level.cost_m1garand_grenade + " points)", "", "", "string");
	
	level.allow_svt40 = cvardef("scr_allow_svt40",1,0,1,"int");
	cvardef("ui_allow_svt40",level.allow_svt40,0,1,"int");
	makeCvarServerInfo("ui_allow_svt40", "1");
	
	level.allow_svt40_none = cvardef("scr_allow_svt40_none",1,0,1,"int");
	cvardef("ui_allow_svt40_none",level.allow_svt40_none,0,1,"int");
	level.cost_svt40 = cvardef("scr_svt40_cost",1,0,"","int");
	cvardef("ui_svt40_cost", "(" + level.cost_svt40 + " points)", "", "", "string");
	
	level.allow_svt40_sniper = cvardef("scr_allow_svt40_sniper",1,0,1,"int");
	cvardef("ui_allow_svt40_sniper",level.allow_svt40_sniper,0,1,"int");
	level.cost_svt40_sniper = cvardef("scr_svt40_sniper_cost",2,0,"","int");
	cvardef("ui_svt40_sniper_cost", "(" + level.cost_svt40_sniper + " points)", "", "", "string");
	
	level.allow_gewehr43 = cvardef("scr_allow_gewehr43",1,0,1,"int");
	cvardef("ui_allow_gewehr43",level.allow_gewehr43,0,1,"int");
	makeCvarServerInfo("ui_allow_gewehr43", "1");
	
	level.allow_gewehr43_none = cvardef("scr_allow_gewehr43_none",1,0,1,"int");
	cvardef("ui_allow_gewehr43_none",level.allow_gewehr43_none,0,1,"int");
	level.cost_gewehr43 = cvardef("scr_gewehr43_cost",1,0,"","int");
	cvardef("ui_gewehr43_cost", "(" + level.cost_gewehr43 + " points)", "", "", "string");
	
	level.allow_gewehr43_sniper = cvardef("scr_allow_gewehr43_sniper",1,0,1,"int");
	cvardef("ui_allow_gewehr43_sniper",level.allow_gewehr43_sniper,0,1,"int");
	level.cost_gewehr43_sniper = cvardef("scr_gewehr43_sniper_cost",2,0,"","int");
	cvardef("ui_gewehr43_sniper_cost", "(" + level.cost_gewehr43_sniper + " points)", "", "", "string");
	
	level.allow_gewehr43_grenade = cvardef("scr_allow_gewehr43_grenade",1,0,1,"int");
	cvardef("ui_allow_gewehr43_grenade",level.allow_gewehr43_grenade,0,1,"int");
	level.cost_gewehr43_grenade = cvardef("scr_gewehr43_grenade_cost",2,0,"","int");
	cvardef("ui_gewehr43_grenade_cost", "(" + level.cost_gewehr43_grenade + " points)", "", "", "string");
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
	cvardef("ui_thompson_cost", "(" + level.cost_thompson + " points)", "", "", "string");
	
	level.allow_thompson_silenced = cvardef("scr_allow_thompson_silenced",1,0,1,"int");
	cvardef("ui_allow_thompson_silenced",level.allow_thompson_silenced,0,1,"int");
	level.cost_thompson_silenced = cvardef("scr_thompson_silenced_cost",2,0,"","int");
	cvardef("ui_thompson_silenced_cost", "(" + level.cost_thompson_silenced + " points)", "", "", "string");
	
	level.allow_thompson_drum = cvardef("scr_allow_thompson_drum",1,0,1,"int");
	cvardef("ui_allow_thompson_drum",level.allow_thompson_drum,0,1,"int");
	level.cost_thompson_drum = cvardef("scr_thompson_drum_cost",2,0,"","int");
	cvardef("ui_thompson_drum_cost", "(" + level.cost_thompson_drum + " points)", "", "", "string");
	
	level.allow_sten = cvardef("scr_allow_sten",1,0,1,"int");
	cvardef("ui_allow_sten",level.allow_sten,0,1,"int");
	makeCvarServerInfo("ui_allow_sten", "1");
	
	level.allow_sten_none = cvardef("scr_allow_sten_none",1,0,1,"int");
	cvardef("ui_allow_sten_none",level.allow_sten_none,0,1,"int");
	level.cost_sten = cvardef("scr_sten_cost",1,0,"","int");
	cvardef("ui_sten_cost", "(" + level.cost_sten + " points)", "", "", "string");
	
	level.allow_sten_silenced = cvardef("scr_allow_sten_silenced",1,0,1,"int");
	cvardef("ui_allow_sten_silenced",level.allow_sten_silenced,0,1,"int");
	level.cost_sten_silenced = cvardef("scr_sten_silenced_cost",2,0,"","int");
	cvardef("ui_sten_silenced_cost", "(" + level.cost_sten_silenced + " points)", "", "", "string");
	
	level.allow_ppsh = cvardef("scr_allow_ppsh",1,0,1,"int");
	cvardef("ui_allow_ppsh",level.allow_ppsh,0,1,"int");
	makeCvarServerInfo("ui_allow_ppsh", "1");
	level.cost_ppsh = cvardef("scr_ppsh_cost",2,0,"","int");
	cvardef("ui_ppsh_cost", "(" + level.cost_ppsh + " points)", "", "", "string");
	
	level.allow_mp40 = cvardef("scr_allow_mp40",1,0,1,"int");
	cvardef("ui_allow_mp40",level.allow_mp40,0,1,"int");
	makeCvarServerInfo("ui_allow_mp40", "1");
	
	level.allow_mp40_none = cvardef("scr_allow_mp40_none",1,0,1,"int");
	cvardef("ui_allow_mp40_none",level.allow_mp40_none,0,1,"int");
	level.cost_mp40 = cvardef("scr_mp40_cost",1,0,"","int");
	cvardef("ui_mp40_cost", "(" + level.cost_mp40 + " points)", "", "", "string");
	
	level.allow_mp40_silenced = cvardef("scr_allow_mp40_silenced",1,0,1,"int");
	cvardef("ui_allow_mp40_silenced",level.allow_mp40_silenced,0,1,"int");
	level.cost_mp40_silenced = cvardef("scr_mp40_silenced_cost",2,0,"","int");
	cvardef("ui_mp40_silenced_cost", "(" + level.cost_mp40_silenced + " points)", "", "", "string");
	
	level.allow_greasegun = cvardef("scr_allow_greasegun",1,0,1,"int");
	cvardef("ui_allow_greasegun",level.allow_greasegun,0,1,"int");
	makeCvarServerInfo("ui_allow_greasegun", "1");
	level.cost_greasegun = cvardef("scr_greasegun_cost",2,0,"","int");
	cvardef("ui_greasegun_cost", "(" + level.cost_greasegun + " points)", "", "", "string");
	
	level.allow_pps43 = cvardef("scr_allow_pps43",1,0,1,"int");
	cvardef("ui_allow_pps43",level.allow_pps43,0,1,"int");
	makeCvarServerInfo("ui_allow_pps43", "1");
	level.cost_pps43 = cvardef("scr_pps43_cost",2,0,"","int");
	cvardef("ui_pps43_cost", "(" + level.cost_pps43 + " points)", "", "", "string");
}

initMGCvars()
{
	level.allow_mgs = cvardef("scr_allow_mgs",1,0,1,"int");
	cvardef("ui_allow_mgs",level.allow_mgs,0,1,"int");
	makeCvarServerInfo("ui_allow_mgs","1");
	
	level.allow_bar = cvardef("scr_allow_bar",1,0,1,"int");
	cvardef("ui_allow_bar",level.allow_bar,0,1,"int");
	makeCvarServerInfo("ui_allow_bar", "1");
	level.cost_bar = cvardef("scr_bar_cost",2,0,"","int");
	cvardef("ui_bar_cost", "(" + level.cost_bar + " points)", "", "", "string");
	
	level.allow_bren = cvardef("scr_allow_bren",1,0,1,"int");
	cvardef("ui_allow_bren",level.allow_bren,0,1,"int");
	makeCvarServerInfo("ui_allow_bren", "1");
	level.cost_bren = cvardef("scr_bren_cost",2,0,"","int");
	cvardef("ui_bren_cost", "(" + level.cost_bren + " points)", "", "", "string");
	
	level.allow_mp44 = cvardef("scr_allow_mp44",1,0,1,"int");
	cvardef("ui_allow_mp44",level.allow_mp44,0,1,"int");
	makeCvarServerInfo("ui_allow_mp44", "1");
	
	level.allow_mp44_none = cvardef("scr_allow_mp44_none",1,0,1,"int");
	cvardef("ui_allow_mp44_none",level.allow_mp44_none,0,1,"int");
	level.cost_mp44 = cvardef("scr_mp44_cost",1,0,"","int");
	cvardef("ui_mp44_cost", "(" + level.cost_mp44 + " points)", "", "", "string");
	
	level.allow_scopedmp44 = cvardef("scr_allow_scopedmp44",1,0,1,"int");
	cvardef("ui_allow_scopedmp44",level.allow_scopedmp44,0,1,"int");
	level.cost_scopedmp44 = cvardef("scr_scopedmp44_cost",2,0,"","int");
	cvardef("ui_scopedmp44_cost", "(" + level.cost_scopedmp44 + " points)", "", "", "string");
	
	level.allow_fg42 = cvardef("scr_allow_fg42",1,0,1,"int");
	cvardef("ui_allow_fg42",level.allow_fg42,0,1,"int");
	makeCvarServerInfo("ui_allow_fg42", "1");
	
	level.allow_fg42_none = cvardef("scr_allow_fg42_none",1,0,1,"int");
	cvardef("ui_allow_fg42_none",level.allow_fg42_none,0,1,"int");
	level.cost_fg42 = cvardef("scr_fg42_cost",1,0,"","int");
	cvardef("ui_fg42_cost", "(" + level.cost_fg42 + " points)", "", "", "string");
	
	level.allow_fg42_scoped = cvardef("scr_allow_fg42_scoped",1,0,1,"int");
	cvardef("ui_allow_fg42_scoped",level.allow_fg42_scoped,0,1,"int");
	level.cost_fg42_scoped = cvardef("scr_fg42_scoped_cost",2,0,"","int");
	cvardef("ui_fg42_scoped_cost", "(" + level.cost_fg42_scoped + " points)", "", "", "string");
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
	cvardef("ui_mg30cal_cost", "(" + level.cost_mg30cal + " points)", "", "", "string");
	
	level.allow_dp28 = cvardef("scr_allow_dp28",1,0,1,"int");
	cvardef("ui_allow_dp28",level.allow_dp28,0,1,"int");
	makeCvarServerInfo("ui_allow_dp28", "1");
	level.cost_dp28 = cvardef("scr_dp28_cost",2,0,"","int");
	cvardef("ui_dp28_cost", "(" + level.cost_dp28 + " points)", "", "", "string");
	
	level.allow_mg34 = cvardef("scr_allow_mg34",1,0,1,"int");
	cvardef("ui_allow_mg34",level.allow_mg34,0,1,"int");
	makeCvarServerInfo("ui_allow_mg34", "1");
	level.cost_mg34 = cvardef("scr_mg34_cost",3,0,"","int");
	cvardef("ui_mg34_cost", "(" + level.cost_mg34 + " points)", "", "", "string");
	
	level.allow_mg42_mp = cvardef("scr_allow_mg42_mp",1,0,1,"int");
	cvardef("ui_allow_mg42_mp",level.allow_mg42_mp,0,1,"int");
	makeCvarServerInfo("ui_allow_mg42_mp", "1");
	level.cost_mg42 = cvardef("scr_mg42_cost",3,0,"","int");
	cvardef("ui_mg42_cost", "(" + level.cost_mg42 + " points)", "", "", "string");
	
	level.allow_trenchgun = cvardef("scr_allow_trenchgun",1,0,1,"int");
	cvardef("ui_allow_trenchgun",level.allow_trenchgun,0,1,"int");
	makeCvarServerInfo("ui_allow_trenchgun", "1");
	level.cost_trenchgun = cvardef("scr_trenchgun_cost",2,0,"","int");
	cvardef("ui_trenchgun_cost", "(" + level.cost_trenchgun + " points)", "", "", "string");
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
	cvardef("ui_m1903a3_cost", "(" + level.cost_m1903a3 + " points)", "", "", "string");
	
	level.allow_springfield_scoped = cvardef("scr_allow_springfield_scoped",1,0,1,"int");
	cvardef("ui_allow_springfield_scoped",level.allow_springfield_scoped,0,1,"int");
	level.cost_springfield_scoped = cvardef("scr_springfield_scoped_cost",2,0,"","int");
	cvardef("ui_springfield_scoped_cost", "(" + level.cost_springfield_scoped + " points)", "", "", "string");
	
	level.allow_enfield = cvardef("scr_allow_enfield",1,0,1,"int");
	cvardef("ui_allow_enfield",level.allow_enfield,0,1,"int");
	makeCvarServerInfo("ui_allow_enfield", "1");
	
	level.allow_enfield_none = cvardef("scr_allow_enfield_none",1,0,1,"int");
	cvardef("ui_allow_enfield_none",level.allow_enfield_none,0,1,"int");
	level.cost_enfield = cvardef("scr_enfield_cost",1,0,"","int");
	cvardef("ui_enfield_cost", "(" + level.cost_enfield + " points)", "", "", "string");
	
	level.allow_enfield_sniper = cvardef("scr_allow_enfield_sniper",1,0,1,"int");
	cvardef("ui_allow_enfield_sniper",level.allow_enfield_sniper,0,1,"int");
	level.cost_enfield_sniper = cvardef("scr_enfield_sniper_cost",2,0,"","int");
	cvardef("ui_enfield_sniper_cost", "(" + level.cost_enfield_sniper + " points)", "", "", "string");
	
	level.allow_nagant = cvardef("scr_allow_nagant",1,0,1,"int");
	cvardef("ui_allow_nagant",level.allow_nagant,0,1,"int");
	makeCvarServerInfo("ui_allow_nagant", "1");
	
	level.allow_nagant_none = cvardef("scr_allow_nagant_none",1,0,1,"int");
	cvardef("ui_allow_nagant_none",level.allow_nagant_none,0,1,"int");
	level.cost_nagant = cvardef("scr_nagant_cost",1,0,"","int");
	cvardef("ui_nagant_cost", "(" + level.cost_nagant + " points)", "", "", "string");
	
	level.allow_nagantsniper = cvardef("scr_allow_nagantsniper",1,0,1,"int");
	cvardef("ui_allow_nagantsniper",level.allow_nagantsniper,0,1,"int");
	level.cost_nagantsniper = cvardef("scr_nagantsniper_cost",2,0,"","int");
	cvardef("ui_nagantsniper_cost", "(" + level.cost_nagantsniper + " points)", "", "", "string");
	
	level.allow_kar98k = cvardef("scr_allow_kar98k",1,0,1,"int");
	cvardef("ui_allow_kar98k",level.allow_kar98k,0,1,"int");
	makeCvarServerInfo("ui_allow_kar98k", "1");
	
	level.allow_kar98k_none = cvardef("scr_allow_kar98k_none",1,0,1,"int");
	cvardef("ui_allow_kar98k_none",level.allow_kar98k_none,0,1,"int");
	level.cost_kar98k = cvardef("scr_kar98k_cost",1,0,"","int");
	cvardef("ui_kar98k_cost", "(" + level.cost_kar98k + " points)", "", "", "string");
	
	level.allow_kar98ksniper = cvardef("scr_allow_kar98ksniper",1,0,1,"int");
	cvardef("ui_allow_kar98ksniper",level.allow_kar98ksniper,0,1,"int");
	level.cost_kar98ksniper = cvardef("scr_kar98ksniper_cost",2,0,"","int");
	cvardef("ui_kar98ksniper_cost", "(" + level.cost_kar98ksniper + " points)", "", "", "string");
	
	level.allow_delisle = cvardef("scr_allow_delisle",1,0,1,"int");
	cvardef("ui_allow_delisle",level.allow_delisle,0,1,"int");
	makeCvarServerInfo("ui_allow_delisle", "1");
	level.cost_delisle = cvardef("scr_delisle_cost",2,0,"","int");
	cvardef("ui_delisle_cost", "(" + level.cost_delisle + " points)", "", "", "string");
	
	level.allow_ptrs = cvardef("scr_allow_ptrs",1,0,1,"int");
	cvardef("ui_allow_ptrs",level.allow_ptrs,0,1,"int");
	makeCvarServerInfo("ui_allow_ptrs", "1");
	level.cost_ptrs = cvardef("scr_ptrs_cost",3,0,"","int");
	cvardef("ui_ptrs_cost", "(" + level.cost_ptrs + " points)", "", "", "string");
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
	cvardef("ui_colt_cost", "(" + level.cost_colt + " points)", "", "", "string");
	
	level.allow_webley = cvardef("scr_allow_webley",1,0,1,"int");
	cvardef("ui_allow_webley",level.allow_webley,0,1,"int");
	makeCvarServerInfo("ui_allow_webley", "1");
	level.cost_webley = cvardef("scr_webley_cost",2,0,"","int");
	cvardef("ui_webley_cost", "(" + level.cost_webley + " points)", "", "", "string");
	
	level.allow_tt33 = cvardef("scr_allow_tt33",1,0,1,"int");
	cvardef("ui_allow_tt33",level.allow_tt33,0,1,"int");
	makeCvarServerInfo("ui_allow_tt33", "1");
	level.cost_tt33 = cvardef("scr_tt33_cost",1,0,"","int");
	cvardef("ui_tt33_cost", "(" + level.cost_tt33 + " points)", "", "", "string");
	
	level.allow_luger = cvardef("scr_allow_luger",1,0,1,"int");
	cvardef("ui_allow_luger",level.allow_luger,0,1,"int");
	makeCvarServerInfo("ui_allow_luger", "1");
	level.cost_luger = cvardef("scr_luger_cost",1,0,"","int");
	cvardef("ui_luger_cost", "(" + level.cost_luger + " points)", "", "", "string");
	
	level.allow_welrod = cvardef("scr_allow_welrod",1,0,1,"int");
	cvardef("ui_allow_welrod",level.allow_welrod,0,1,"int");
	makeCvarServerInfo("ui_allow_welrod", "1");
	level.cost_welrod = cvardef("scr_welrod_cost",2,0,"","int");
	cvardef("ui_welrod_cost", "(" + level.cost_welrod + " points)", "", "", "string");
	
	level.allow_m712 = cvardef("scr_allow_m712",1,0,1,"int");
	cvardef("ui_allow_m712",level.allow_m712,0,1,"int");
	makeCvarServerInfo("ui_allow_m712", "1");
	level.cost_m712 = cvardef("scr_m712_cost",1,0,"","int");
	cvardef("ui_m712_cost", "(" + level.cost_m712 + " points)", "", "", "string");
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
	cvardef("ui_fraggrenade_cost", "(" + level.cost_fraggrenade + " points)", "", "", "string");
	
	level.allow_mk1britishfraggrenade = cvardef("scr_allow_mk1britishfraggrenade",1,0,1,"int");
	cvardef("ui_allow_mk1britishfraggrenade",level.allow_mk1britishfraggrenade,0,1,"int");
	makeCvarServerInfo("ui_allow_mk1britishfraggrenade", "1");
	level.cost_mk1britishfraggrenade = cvardef("scr_mk1britishfraggrenade_cost",1,0,"","int");
	cvardef("ui_mk1britishfraggrenade_cost", "(" + level.cost_mk1britishfraggrenade + " points)", "", "", "string");
	
	level.allow_rgd33russianfraggrenade = cvardef("scr_allow_rgd33russianfraggrenade",1,0,1,"int");
	cvardef("ui_allow_rgd33russianfraggrenade",level.allow_rgd33russianfraggrenade,0,1,"int");
	makeCvarServerInfo("ui_allow_rgd33russianfraggrenade", "1");
	level.cost_rgd33russianfraggrenade = cvardef("scr_rgd33russianfraggrenade_cost",1,0,"","int");
	cvardef("ui_rgd33russianfraggrenade_cost", "(" + level.cost_rgd33russianfraggrenade + " points)", "", "", "string");
	
	level.allow_stielhandgranate = cvardef("scr_allow_stielhandgranate",1,0,1,"int");
	cvardef("ui_allow_stielhandgranate",level.allow_stielhandgranate,0,1,"int");
	makeCvarServerInfo("ui_allow_stielhandgranate", "1");
	level.cost_stielhandgranate = cvardef("scr_stielhandgranate_cost",1,0,"","int");
	cvardef("ui_stielhandgranate_cost", "(" + level.cost_stielhandgranate + " points)", "", "", "string");
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
	cvardef("ui_smokegrenade_cost", "(" + level.cost_smokegrenade + " points)", "", "", "string");
	
	level.allow_molotov = cvardef("scr_allow_molotov",1,0,1,"int");
	cvardef("ui_allow_molotov",level.allow_molotov,0,1,"int");
	makeCvarServerInfo("ui_allow_molotov", "1");
	level.cost_molotov = cvardef("scr_molotov_cost",1,0,"","int");
	cvardef("ui_molotov_cost", "(" + level.cost_molotov + " points)", "", "", "string");
	
	level.allow_mustardgas = cvardef("scr_allow_mustardgas",1,0,1,"int");
	cvardef("ui_allow_mustardgas",level.allow_mustardgas,0,1,"int");
	makeCvarServerInfo("ui_allow_mustardgas", "1");
	level.cost_mustardgas = cvardef("scr_mustardgas_cost",1,0,"","int");
	cvardef("ui_mustardgas_cost", "(" + level.cost_mustardgas + " points)", "", "", "string");
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
	cvardef("ui_satchelcharge_cost", "(" + level.cost_satchelcharge + " points)", "", "", "string");
	
	level.allow_geballte = cvardef("scr_allow_geballte",1,0,1,"int");
	cvardef("ui_allow_geballte",level.allow_geballte,0,1,"int");
	makeCvarServerInfo("ui_allow_geballte", "1");
	level.cost_geballte = cvardef("scr_geballte_cost",1,0,"","int");
	cvardef("ui_geballte_cost", "(" + level.cost_geballte + " points)", "", "", "string");
	
	level.allow_panzerschreck = cvardef("scr_allow_panzerschreck",1,0,1,"int");
	cvardef("ui_allow_panzerschreck",level.allow_panzerschreck,0,1,"int");
	makeCvarServerInfo("ui_allow_panzerschreck", "1");
	level.cost_panzerschreck = cvardef("scr_panzerschreck_cost",1,0,"","int");
	cvardef("ui_panzerschreck_cost", "(" + level.cost_panzerschreck + " points)", "", "", "string");
	
	level.allow_bazooka = cvardef("scr_allow_bazooka",1,0,1,"int");
	cvardef("ui_allow_bazooka",level.allow_bazooka,0,1,"int");
	makeCvarServerInfo("ui_allow_bazooka", "1");
	level.cost_bazooka = cvardef("scr_bazooka_cost",1,0,"","int");
	cvardef("ui_bazooka_cost", "(" + level.cost_bazooka + " points)", "", "", "string");
	
	level.allow_flamethrower = cvardef("scr_allow_flamethrower",1,0,1,"int");
	cvardef("ui_allow_flamethrower",level.allow_flamethrower,0,1,"int");
	makeCvarServerInfo("ui_allow_flamethrower", "1");
	level.cost_flamethrower = cvardef("scr_flamethrower_cost",1,0,"","int");
	cvardef("ui_flamethrower_cost", "(" + level.cost_flamethrower + " points)", "", "", "string");
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
	cvardef("ui_extra_equipment_cost", "(" + level.cost_extra_equipment + " points)", "", "", "string");
	
	level.allow_bombsquad = cvardef("scr_allow_bombsquad",1,0,1,"int");
	cvardef("ui_allow_bombsquad",level.allow_bombsquad,0,1,"int");
	level.cost_bombsquad = cvardef("scr_bombsquad_cost",1,0,"","int");
	cvardef("ui_bombsquad_cost", "(" + level.cost_bombsquad + " points)", "", "", "string");
	
	level.allow_tripwire = cvardef("scr_allow_tripwire",1,0,1,"int");
	cvardef("ui_allow_tripwire",level.allow_tripwire,0,1,"int");
	level.cost_tripwire = cvardef("scr_tripwire_cost",1,0,"","int");
	cvardef("ui_tripwire_cost", "(" + level.cost_tripwire + " points)", "", "", "string");
	
	level.allow_tier2_perks = cvardef("scr_allow_tier2_perks",1,0,1,"int");
	cvardef("ui_allow_tier2_perks",level.allow_tier2_perks,0,1,"int");
	
	level.allow_extra_smoke = cvardef("scr_allow_extra_smoke",1,0,1,"int");
	cvardef("ui_allow_extra_smoke",level.allow_extra_smoke,0,1,"int");
	level.cost_extra_smoke = cvardef("scr_extra_smoke_cost",1,0,"","int");
	cvardef("ui_extra_smoke_cost", "(" + level.cost_extra_smoke + " points)", "", "", "string");
	
	level.allow_extra_grenade = cvardef("scr_allow_extra_grenade",1,0,1,"int");
	cvardef("ui_allow_extra_grenade",level.allow_extra_grenade,0,1,"int");
	level.cost_extra_grenade = cvardef("scr_extra_grenade_cost",1,0,"","int");
	cvardef("ui_extra_grenade_cost", "(" + level.cost_extra_grenade + " points)", "", "", "string");
	
	level.allow_extra_ammo = cvardef("scr_allow_extra_ammo",1,0,1,"int");
	cvardef("ui_allow_extra_ammo",level.allow_extra_ammo,0,1,"int");
	level.cost_extra_ammo = cvardef("scr_extra_ammo_cost",1,0,"","int");
	cvardef("ui_extra_ammo_cost", "(" + level.cost_extra_ammo + " points)", "", "", "string");
	
	level.allow_tier3_perks = cvardef("scr_allow_tier3_perks",1,0,1,"int");
	cvardef("ui_allow_tier3_perks",level.allow_tier3_perks,0,1,"int");
	
	level.allow_marathon = cvardef("scr_allow_marathon",1,0,1,"int");
	cvardef("ui_allow_marathon",level.allow_marathon,0,1,"int");
	level.cost_marathon = cvardef("scr_marathon_cost",1,0,"","int");
	cvardef("ui_marathon_cost", "(" + level.cost_marathon + " points)", "", "", "string");
	
	level.allow_medic = cvardef("scr_allow_medic",1,0,1,"int");
	cvardef("ui_allow_medic",level.allow_medic,0,1,"int");
	level.cost_medic = cvardef("scr_medic_cost",1,0,"","int");
	cvardef("ui_medic_cost", "(" + level.cost_medic + " points)", "", "", "string");
	
	level.allow_scavenger = cvardef("scr_allow_scavenger",1,0,1,"int");
	cvardef("ui_allow_scavenger",level.allow_scavenger,0,1,"int");
	level.cost_scavenger = cvardef("scr_scavenger_cost",1,0,"","int");
	cvardef("ui_scavenger_cost", "(" + level.cost_scavenger + " points)", "", "", "string");
}

initKSCvars()
{
	level.allow_killstreaks = cvardef("scr_allow_killstreaks",1,0,1,"int");
	cvardef("ui_allow_killstreaks",level.allow_killstreaks,0,1,"int");
	makeCvarServerInfo("ui_allow_killstreaks","1");
	
	level.allow_artillery_ks = cvardef("scr_allow_artillery_ks",1,0,1,"int");
	cvardef("ui_allow_artillery_ks",level.allow_artillery_ks,0,1,"int");
	level.kills_artillery = cvardef("scr_artillery_kills",5,0,"","int");
	cvardef("ui_artillery_kills", "(" + level.kills_artillery + " kills)", "", "", "string");
	
	level.allow_binoculars = cvardef("scr_allow_binoculars",1,0,1,"int");
	cvardef("ui_allow_binoculars",level.allow_binoculars,0,1,"int");
	makeCvarServerInfo("ui_allow_binoculars","1");
	
	level.allow_artillery = cvardef("scr_allow_artillery",1,0,1,"int");
	cvardef("ui_allow_artillery",level.allow_artillery,0,1,"int");
}

updateWeaponCvars()
{
	for(;;)
	{
	////////////////////////////////////////////////////////////////
	// ADDED US CARBINE
	////////////////////////////////////////////////////////////////
		scr_allow_uscarbine = getCvar("scr_allow_uscarbine");
		if(level.allow_uscarbine != scr_allow_uscarbine)
		{
			level.allow_uscarbine = scr_allow_uscarbine;
			setCvar("ui_allow_uscarbine", level.allow_uscarbine);
		}
		
		scr_allow_m1carbine = getCvar("scr_allow_m1carbine");
		if(level.allow_m1carbine != scr_allow_m1carbine)
		{
			level.allow_m1carbine = scr_allow_m1carbine;
			setCvar("ui_allow_m1carbine", level.allow_m1carbine);
		}
		
		scr_m1carbine_cost = getCvarInt("scr_m1carbine_cost");
		if(level.cost_m1carbine != scr_m1carbine_cost)
		{
			level.cost_m1carbine = scr_m1carbine_cost;
			setCvar("ui_m1carbine_cost", "(" + level.cost_m1carbine + " points)");
		}

	/////////////////////////////////////////////////////////////////
	// ADDED M2 CARBINE
	/////////////////////////////////////////////////////////////////
		scr_allow_m2carbine = getCvar("scr_allow_m2carbine");
		if(level.allow_m2carbine != scr_allow_m2carbine)
		{
			level.allow_m2carbine = scr_allow_m2carbine;
			setCvar("ui_allow_m2carbine", level.allow_m2carbine);
		}
		
		scr_m2carbine_cost = getCvar("scr_m2carbine_cost");
		if(level.cost_m2carbine != scr_m2carbine_cost)
		{
			level.cost_m2carbine = scr_m2carbine_cost;
			setCvar("ui_m2carbine_cost", "(" + level.cost_m2carbine + " points)");
		}
		
	//////////////////////////////////////////////////////////////////
	// ADDED M3 CARBINE
	//////////////////////////////////////////////////////////////////
		scr_allow_m3carbine = getCvar("scr_allow_m3carbine");
		if(level.allow_m3carbine != scr_allow_m3carbine)
		{
			level.allow_m3carbine = scr_allow_m3carbine;
			setCvar("ui_allow_m3carbine", level.allow_m3carbine);
		}
		
		scr_m3carbine_cost = getCvar("scr_m3carbine_cost");
		if(level.cost_m3carbine != scr_m3carbine_cost)
		{
			level.cost_m3carbine = scr_m3carbine_cost;
			setCvar("ui_m3carbine_cost", "(" + level.cost_m3carbine + " points)");
		}
		
		scr_allow_m1garand = getCvar("scr_allow_m1garand");
		if(level.allow_m1garand != scr_allow_m1garand)
		{
			level.allow_m1garand = scr_allow_m1garand;
			setCvar("ui_allow_m1garand", level.allow_m1garand);
		}
		
		scr_allow_m1garand_none = getCvar("scr_allow_m1garand_none");
		if(level.allow_m1garand_none != scr_allow_m1garand_none)
		{
			level.allow_m1garand_none = scr_allow_m1garand_none;
			setCvar("ui_allow_m1garand_none", level.allow_m1garand_none);
		}
		
		scr_m1garand_cost = getCvar("scr_m1garand_cost");
		if(level.cost_m1garand != scr_m1garand_cost)
		{
			level.cost_m1garand = scr_m1garand_cost;
			setCvar("ui_m1garand_cost", "(" + level.cost_m1garand + " points)");
		}
		
		//////////////////////////////////////////////////////////
		// ADDED M1 GARAND SNIPER
		//////////////////////////////////////////////////////////
		scr_allow_m1garand_sniper = getCvar("scr_allow_m1garand_sniper");
		if(level.allow_m1garand_sniper != scr_allow_m1garand_sniper)
		{
			level.allow_m1garand_sniper = scr_allow_m1garand_sniper;
			setCvar("ui_allow_m1garand_sniper", level.allow_m1garand_sniper);
		}
		
		scr_m1garand_sniper_cost = getCvar("scr_m1garand_sniper_cost");
		if(level.cost_m1garand_sniper != scr_m1garand_sniper_cost)
		{
			level.cost_m1garand_sniper = scr_m1garand_sniper_cost;
			setCvar("ui_m1garand_sniper_cost", "(" + level.cost_m1garand_sniper + " points)");
		}
		
		///////////////////////////////////////////////////////////////
		// ADDED M1 GARAND Grenade
		///////////////////////////////////////////////////////////////
		scr_allow_m1garand_grenade = getCvar("scr_allow_m1garand_grenade");
		if(level.allow_m1garand_grenade != scr_allow_m1garand_grenade)
		{
			level.allow_m1garand_grenade = scr_allow_m1garand_grenade;
			setCvar("ui_allow_m1garand_grenade", level.allow_m1garand_grenade);
		}
		
		scr_m1garand_grenade_cost = getCvar("scr_m1garand_grenade_cost");
		if(level.cost_m1garand_grenade != scr_m1garand_grenade_cost)
		{
			level.cost_m1garand_grenade = scr_m1garand_grenade_cost;
			setCvar("ui_m1garand_grenade_cost", "(" + level.cost_m1garand_grenade + " points)");
		}
		
		scr_allow_thompson = getCvar("scr_allow_thompson");
		if(level.allow_thompson != scr_allow_thompson)
		{
			level.allow_thompson = scr_allow_thompson;
			setCvar("ui_allow_thompson", level.allow_thompson);
		}
		
		scr_allow_thompson_none = getCvar("scr_allow_thompson_none");
		if(level.allow_thompson_none != scr_allow_thompson_none)
		{
			level.allow_thompson_none = scr_allow_thompson_none;
			setCvar("ui_allow_thompson_none", level.allow_thompson_none);
		}
	
		scr_thompson_cost = getCvar("scr_thompson_cost");
		if(level.cost_thompson != scr_thompson_cost)
		{
			level.cost_thompson = scr_thompson_cost;
			setCvar("ui_thompson_cost", "(" + level.cost_thompson + " points)");
		}
		
		//////////////////////////////////////////////////////////
		// ADDED TOMMY SILENCED
		//////////////////////////////////////////////////////////
		scr_allow_thompson_silenced = getCvar("scr_allow_thompson_silenced");
		if(level.allow_thompson_silenced != scr_allow_thompson_silenced)
		{
			level.allow_thompson_silenced = scr_allow_thompson_silenced;
			setCvar("ui_allow_thompson_silenced", level.allow_thompson_silenced);
		}
		
		scr_thompson_silenced_cost = getCvar("scr_thompson_silenced_cost");
		if(level.cost_thompson_silenced != scr_thompson_silenced_cost)
		{
			level.cost_thompson_silenced = scr_thompson_silenced_cost;
			setCvar("ui_thompson_silenced_cost", "(" + level.cost_thompson_silenced + " points)");
		}

		////////////////////////////////////////////////////////////
		// ADDED TOMMY DRUM
		////////////////////////////////////////////////////////////
		scr_allow_thompson_drum = getCvar("scr_allow_thompson_drum");
		if(level.allow_thompson_drum != scr_allow_thompson_drum)
		{
			level.allow_thompson_drum = scr_allow_thompson_drum;
			setCvar("ui_allow_thompson_drum", level.allow_thompson_drum);
		}
		
		scr_thompson_drum_cost = getCvar("scr_thompson_drum_cost");
		if(level.cost_thompson_drum != scr_thompson_drum_cost)
		{
			level.cost_thompson_drum = scr_thompson_drum_cost;
			setCvar("ui_thompson_drum_cost", "(" + level.cost_thompson_drum + " points)");
		}
		
		//////////////////////////////////////////////////////////////
		// ADDED GREASE GUN
		//////////////////////////////////////////////////////////////
		scr_allow_greasegun = getCvar("scr_allow_greasegun");
		if(level.allow_greasegun != scr_allow_greasegun)
		{
			level.allow_greasegun = scr_allow_greasegun;
			setCvar("ui_allow_greasegun", level.allow_greasegun);
		}
		
		scr_greasegun_cost = getCvar("scr_greasegun_cost");
		if(level.cost_greasegun != scr_greasegun_cost)
		{
			level.cost_greasegun = scr_greasegun_cost;
			setCvar("ui_greasegun_cost", "(" + level.cost_greasegun + " points)");
		}
		
		scr_allow_bar = getCvar("scr_allow_bar");
		if(level.allow_bar != scr_allow_bar)
		{
			level.allow_bar = scr_allow_bar;
			setCvar("ui_allow_bar", level.allow_bar);
		}
		
		scr_bar_cost = getCvar("scr_bar_cost");
		if(level.cost_bar != scr_bar_cost)
		{
			level.cost_bar = scr_bar_cost;
			setCvar("ui_bar_cost", "(" + level.cost_bar + " points)");
		}
	
		scr_allow_springfield = getCvar("scr_allow_springfield");
		if(level.allow_springfield != scr_allow_springfield)
		{
			level.allow_springfield = scr_allow_springfield;
			setCvar("ui_allow_springfield", level.allow_springfield);
		}
		
		//////////////////////////////////////////////////////////////////
		// ADDED M1903A3
		///////////////////////////////////////////////////////////////////
		scr_allow_m1903a3 = getCvar("scr_allow_m1903a3");
		if(level.allow_m1903a3 != scr_allow_m1903a3)
		{
			level.allow_m1903a3 = scr_allow_m1903a3;
			setCvar("ui_allow_m1903a3", level.allow_m1903a3);
		}
		
		scr_m1903a3_cost = getCvar("scr_m1903a3_cost");
		if(level.cost_m1903a3 != scr_m1903a3_cost)
		{
			level.cost_m1903a3 = scr_m1903a3_cost;
			setCvar("ui_m1903a3_cost", "(" + level.cost_m1903a3 + " points)");
		}
		
		scr_allow_springfield_scoped = getCvar("scr_allow_springfield_scoped");
		if(level.allow_springfield_scoped != scr_allow_springfield_scoped)
		{
			level.allow_springfield_scoped = scr_allow_springfield_scoped;
			setCvar("ui_allow_springfield_scoped", level.allow_springfield_scoped);
		}
		
		scr_springfield_cost = getCvar("scr_springfield_cost");
		if(level.cost_springfield != scr_springfield_cost)
		{
			level.cost_springfield = scr_springfield_cost;
			setCvar("ui_springfield_cost", "(" + level.cost_springfield + " points)");
		}

		scr_allow_mg30cal = getCvar("scr_allow_mg30cal");
		if(level.allow_mg30cal != scr_allow_mg30cal)
		{
			level.allow_mg30cal = scr_allow_mg30cal;
			setCvar("ui_allow_mg30cal", level.allow_mg30cal);
		}
		
		scr_mg30cal_cost = getCvar("scr_mg30cal_cost");
		if(level.cost_mg30cal != scr_mg30cal_cost)
		{
			level.cost_mg30cal = scr_mg30cal_cost;
			setCvar("ui_mg30cal_cost", "(" + level.cost_mg30cal + " points)");
		}
		
		///////////////////////////////////////////////////////////////////
		// ADDED TRENCHGUN
		///////////////////////////////////////////////////////////////////
		scr_allow_trenchgun = getCvar("scr_allow_trenchgun");
		if(level.allow_trenchgun != scr_allow_trenchgun)
		{
			level.allow_trenchgun = scr_allow_trenchgun;
			setCvar("ui_allow_trenchgun", level.allow_trenchgun);
		}
		
		scr_trenchgun_cost = getCvar("scr_trenchgun_cost");
		if(level.cost_trenchgun != scr_trenchgun_cost)
		{
			level.cost_trenchgun = scr_trenchgun_cost;
			setCvar("ui_trenchgun_cost", "(" + level.cost_trenchgun + " points)");
		}

		scr_allow_enfield = getCvar("scr_allow_enfield");
		if(level.allow_enfield != scr_allow_enfield)
		{
			level.allow_enfield = scr_allow_enfield;
			setCvar("ui_allow_enfield", level.allow_enfield);
		}
		
		scr_allow_enfield_none = getCvar("scr_allow_enfield_none");
		if(level.allow_enfield_none != scr_allow_enfield_none)
		{
			level.allow_enfield_none = scr_allow_enfield_none;
			setCvar("ui_allow_enfield_none", level.allow_enfield_none);
		}
		
		scr_enfield_cost = getCvar("scr_enfield_cost");
		if(level.cost_enfield != scr_enfield_cost)
		{
			level.cost_enfield = scr_enfield_cost;
			setCvar("ui_enfield_cost", "(" + level.cost_enfield + " points)");
		}
		
		//////////////////////////////////////////////////////////////////
		// ADDED ENFIELD Sniper
		//////////////////////////////////////////////////////////////////
		scr_allow_enfield_sniper = getCvar("scr_allow_enfield_sniper");
		if(level.allow_enfield_sniper != scr_allow_enfield_sniper)
		{
			level.allow_enfield_sniper = scr_allow_enfield_sniper;
			setCvar("ui_allow_enfield_sniper", level.allow_enfield_sniper);
		}
		
		scr_enfield_sniper_cost = getCvar("scr_enfield_sniper_cost");
		if(level.cost_enfield_sniper != scr_enfield_sniper_cost)
		{
			level.cost_enfield_sniper = scr_enfield_sniper_cost;
			setCvar("ui_enfield_sniper_cost", "(" + level.cost_enfield_sniper + " points)");
		}
		
		////////////////////////////////////////////////////////////////////
		// ADDED DELISLE
		////////////////////////////////////////////////////////////////////
		scr_allow_delisle = getCvar("scr_allow_delisle");
		if(level.allow_delisle != scr_allow_delisle)
		{
			level.allow_delisle = scr_allow_delisle;
			setCvar("ui_allow_delisle", level.allow_delisle);
		}
		
		scr_delisle_cost = getCvar("scr_delisle_cost");
		if(level.cost_delisle != scr_delisle_cost)
		{
			level.cost_delisle = scr_delisle_cost;
			setCvar("ui_delisle_cost", "(" + level.cost_delisle + " points)");
		}
		
		scr_allow_sten = getCvar("scr_allow_sten");
		if(level.allow_sten != scr_allow_sten)
		{
			level.allow_sten = scr_allow_sten;
			setCvar("ui_allow_sten", level.allow_sten);
		}
		
		scr_allow_sten_none = getCvar("scr_allow_sten_none");
		if(level.allow_sten_none != scr_allow_sten_none)
		{
			level.allow_sten_none = scr_allow_sten_none;
			setCvar("ui_allow_sten_none", level.allow_sten_none);
		}
		
		scr_sten_cost = getCvar("scr_sten_cost");
		if(level.cost_sten != scr_sten_cost)
		{
			level.cost_sten = scr_sten_cost;
			setCvar("ui_sten_cost", "(" + level.cost_sten + " points)");
		}
		
		/////////////////////////////////////////
		// ADDED CVAR FOR STEN SILENCED
		/////////////////////////////////////////
		scr_allow_sten_silenced = getCvar("scr_allow_sten_silenced");
		if(level.allow_sten_silenced != scr_allow_sten_silenced)
		{
			level.allow_sten_silenced = scr_allow_sten_silenced;
			setCvar("ui_allow_sten_silenced", level.allow_sten_silenced);
		}
		
		scr_sten_silenced_cost = getCvar("scr_sten_silenced_cost");
		if(level.cost_sten_silenced != scr_sten_silenced_cost)
		{
			level.cost_sten_silenced = scr_sten_silenced_cost;
			setCvar("ui_sten_silenced_cost", "(" + level.cost_sten_silenced + " points)");
		}
		
		scr_allow_bren = getCvar("scr_allow_bren");
		if(level.allow_bren != scr_allow_bren)
		{
			level.allow_bren = scr_allow_bren;
			setCvar("ui_allow_bren", level.allow_bren);
		}
		
		scr_bren_cost = getCvar("scr_bren_cost");
		if(level.cost_bren != scr_bren_cost)
		{
			level.cost_bren = scr_bren_cost;
			setCvar("ui_bren_cost", "(" + level.cost_bren + " points)");
		}

		scr_allow_nagant = getCvar("scr_allow_nagant");
		if(level.allow_nagant != scr_allow_nagant)
		{
			level.allow_nagant = scr_allow_nagant;
			setCvar("ui_allow_nagant", level.allow_nagant);
		}
		
		scr_allow_nagant_none = getCvar("scr_allow_nagant_none");
		if(level.allow_nagant_none != scr_allow_nagant_none)
		{
			level.allow_nagant_none = scr_allow_nagant_none;
			setCvar("ui_allow_nagant_none", level.allow_nagant_none);
		}

		scr_nagant_cost = getCvar("scr_nagant_cost");
		if(level.cost_nagant != scr_nagant_cost)
		{
			level.cost_nagant = scr_nagant_cost;
			setCvar("ui_nagant_cost", "(" + level.cost_nagant + " points)");
		}

		scr_allow_svt40 = getCvar("scr_allow_svt40");
		if(level.allow_svt40 != scr_allow_svt40)
		{
			level.allow_svt40 = scr_allow_svt40;
			setCvar("ui_allow_svt40", level.allow_svt40);
		}
		
		scr_allow_svt40_none = getCvar("scr_allow_svt40_none");
		if(level.allow_svt40_none != scr_allow_svt40_none)
		{
			level.allow_svt40_none = scr_allow_svt40_none;
			setCvar("ui_allow_svt40_none", level.allow_svt40_none);
		}
		
		scr_svt40_cost = getCvar("scr_svt40_cost");
		if(level.cost_svt40 != scr_svt40_cost)
		{
			level.cost_svt40 = scr_svt40_cost;
			setCvar("ui_svt40_cost", "(" + level.cost_svt40 + " points)");
		}
		
		/////////////////////////////////////////////////////
		// ADDED SVT40 SNIPER
		/////////////////////////////////////////////////////
		scr_allow_svt40_sniper = getCvar("scr_allow_svt40_sniper");
		if(level.allow_svt40_sniper != scr_allow_svt40_sniper)
		{
			level.allow_svt40_sniper = scr_allow_svt40_sniper;
			setCvar("ui_allow_svt40_sniper", level.allow_svt40_sniper);
		}
		
		scr_svt40_sniper_cost = getCvar("scr_svt40_sniper_cost");
		if(level.cost_svt40_sniper != scr_svt40_sniper_cost)
		{
			level.cost_svt40_sniper = scr_svt40_sniper_cost;
			setCvar("ui_svt40_sniper_cost", "(" + level.cost_svt40_sniper + " points)");
		}
		
		scr_allow_ppsh = getCvar("scr_allow_ppsh");
		if(level.allow_ppsh != scr_allow_ppsh)
		{
			level.allow_ppsh = scr_allow_ppsh;
			setCvar("ui_allow_ppsh", level.allow_ppsh);
		}
		
		scr_ppsh_cost = getCvar("scr_ppsh_cost");
		if(level.cost_ppsh != scr_ppsh_cost)
		{
			level.cost_ppsh = scr_ppsh_cost;
			setCvar("ui_ppsh_cost", "(" + level.cost_ppsh + " points)");
		}
		
		//////////////////////////////////////////////////////////
		// ADDED PPS 43
		////////////////////////////////////////////////////////////
		scr_allow_pps43 = getCvar("scr_allow_pps43");
		if(level.allow_pps43 != scr_allow_pps43)
		{
			level.allow_pps43 = scr_allow_pps43;
			setCvar("ui_allow_pps43", level.allow_pps43);
		}
		
		scr_pps43_cost = getCvar("scr_pps43_cost");
		if(level.cost_pps43 != scr_pps43_cost)
		{
			level.cost_pps43 = scr_pps43_cost;
			setCvar("ui_pps43_cost", "(" + level.cost_pps43 + " points)");
		}
		
		scr_allow_nagantsniper = getCvar("scr_allow_nagantsniper");
		if(level.allow_nagantsniper != scr_allow_nagantsniper)
		{
			level.allow_nagantsniper = scr_allow_nagantsniper;
			setCvar("ui_allow_nagantsniper", level.allow_nagantsniper);
		}
		
		scr_nagantsniper_cost = getCvar("scr_nagantsniper_cost");
		if(level.cost_nagantsniper != scr_nagantsniper_cost)
		{
			level.cost_nagantsniper = scr_nagantsniper_cost;
			setCvar("ui_nagantsniper_cost", "(" + level.cost_nagantsniper + " points)");
		}
		
		///////////////////////////////////////////////////////////////
		// ALLOW PTRS
		///////////////////////////////////////////////////////////////
		scr_allow_ptrs = getCvar("scr_allow_ptrs");
		if(level.allow_ptrs != scr_allow_ptrs)
		{
			level.allow_ptrs = scr_allow_ptrs;
			setCvar("ui_allow_ptrs", level.allow_ptrs);
		}
		
		scr_ptrs_cost = getCvar("scr_ptrs_cost");
		if(level.cost_ptrs != scr_ptrs_cost)
		{
			level.cost_ptrs = scr_ptrs_cost;
			setCvar("ui_ptrs_cost", "(" + level.cost_ptrs + " points)");
		}

		scr_allow_dp28 = getCvar("scr_allow_dp28");
		if(level.allow_dp28 != scr_allow_dp28)
		{
			level.allow_dp28 = scr_allow_dp28;
			setCvar("ui_allow_dp28", level.allow_dp28);
		}
		
		scr_dp28_cost = getCvar("scr_dp28_cost");
		if(level.cost_dp28 != scr_dp28_cost)
		{
			level.cost_dp28 = scr_dp28_cost;
			setCvar("ui_dp28_cost", "(" + level.cost_dp28 + " points)");
		}

		scr_allow_kar98k = getCvar("scr_allow_kar98k");
		if(level.allow_kar98k != scr_allow_kar98k)
		{
			level.allow_kar98k = scr_allow_kar98k;
			setCvar("ui_allow_kar98k", level.allow_kar98k);
		}
		
		scr_allow_kar98k_none = getCvar("scr_allow_kar98k_none");
		if(level.allow_kar98k_none != scr_allow_kar98k_none)
		{
			level.allow_kar98k_none = scr_allow_kar98k_none;
			setCvar("ui_allow_kar98k_none", level.allow_kar98k_none);
		}
		
		scr_kar98k_cost = getCvar("scr_kar98k_cost");
		if(level.cost_kar98k != scr_kar98k_cost)
		{
			level.cost_kar98k = scr_kar98k_cost;
			setCvar("ui_kar98k_cost", "(" + level.cost_kar98k + " points)");
		}

		scr_allow_gewehr43 = getCvar("scr_allow_gewehr43");
		if(level.allow_gewehr43 != scr_allow_gewehr43)
		{
			level.allow_gewehr43 = scr_allow_gewehr43;
			setCvar("ui_allow_gewehr43", level.allow_gewehr43);
		}
		
		scr_allow_gewehr43_none = getCvar("scr_allow_gewehr43_none");
		if(level.allow_gewehr43_none != scr_allow_gewehr43_none)
		{
			level.allow_gewehr43_none = scr_allow_gewehr43_none;
			setCvar("ui_allow_gewehr43_none", level.allow_gewehr43_none);
		}
		
		scr_gewehr43_cost = getCvar("scr_gewehr43_cost");
		if(level.cost_gewehr43 != scr_gewehr43_cost)
		{
			level.cost_gewehr43 = scr_gewehr43_cost;
			setCvar("ui_gewehr43_cost", "(" + level.cost_gewehr43 + " points)");
		}
		
		/////////////////////////////////////////////////////////
		// ADDED GEWHER Sniper
		/////////////////////////////////////////////////////////
		scr_allow_gewehr43_sniper = getCvar("scr_allow_gewehr43_sniper");
		if(level.allow_gewehr43_sniper != scr_allow_gewehr43_sniper)
		{
			level.allow_gewehr43_sniper = scr_allow_gewehr43_sniper;
			setCvar("ui_allow_gewehr43_sniper", level.allow_gewehr43_sniper);
		}
		
		scr_gewehr43_sniper_cost = getCvar("scr_gewehr43_sniper_cost");
		if(level.cost_gewehr43_sniper != scr_gewehr43_sniper_cost)
		{
			level.cost_gewehr43_sniper = scr_gewehr43_sniper_cost;
			setCvar("ui_gewehr43_sniper_cost", "(" + level.cost_gewehr43_sniper + " points)");
		}
		
		//////////////////////////////////////////////////////////////
		// ADDED GEWEHR GRENADE
		//////////////////////////////////////////////////////////////
		scr_allow_gewehr43_grenade = getCvar("scr_allow_gewehr43_grenade");
		if(level.allow_gewehr43_grenade != scr_allow_gewehr43_grenade)
		{
			level.allow_gewehr43_grenade = scr_allow_gewehr43_grenade;
			setCvar("ui_allow_gewehr43_grenade", level.allow_gewehr43_grenade);
		}

		scr_gewehr43_grenade_cost = getCvar("scr_gewehr43_grenade_cost");
		if(level.cost_gewehr43_grenade != scr_gewehr43_grenade_cost)
		{
			level.cost_gewehr43_grenade = scr_gewehr43_grenade_cost;
			setCvar("ui_gewehr43_grenade_cost", "(" + level.cost_gewehr43_grenade + " points)");
		}
		
		scr_allow_mp40 = getCvar("scr_allow_mp40");
		if(level.allow_mp40 != scr_allow_mp40)
		{
			level.allow_mp40 = scr_allow_mp40;
			setCvar("ui_allow_mp40", level.allow_mp40);
		}
		
		scr_allow_mp40_none = getCvar("scr_allow_mp40_none");
		if(level.allow_mp40_none != scr_allow_mp40_none)
		{
			level.allow_mp40_none = scr_allow_mp40_none;
			setCvar("ui_allow_mp40_none", level.allow_mp40_none);
		}
		
		scr_mp40_cost = getCvar("scr_mp40_cost");
		if(level.cost_mp40 != scr_mp40_cost)
		{
			level.cost_mp40 = scr_mp40_cost;
			setCvar("ui_mp40_cost", "(" + level.cost_mp40 + " points)");
		}
		
		///////////////////////////////////////////////////////////////////
		// ADDED MP40 Silenced
		///////////////////////////////////////////////////////////////////
		scr_allow_mp40_silenced = getCvar("scr_allow_mp40_silenced");
		if(level.allow_mp40_silenced != scr_allow_mp40_silenced)
		{
			level.allow_mp40_silenced = scr_allow_mp40_silenced;
			setCvar("ui_allow_mp40_silenced", level.allow_mp40_silenced);
		}
		
		scr_mp40_silenced_cost = getCvar("scr_mp40_silenced_cost");
		if(level.cost_mp40_silenced != scr_mp40_silenced_cost)
		{
			level.cost_mp40_silenced = scr_mp40_silenced_cost;
			setCvar("ui_mp40_silenced_cost", "(" + level.cost_mp40_silenced + " points)");
		}
		
		scr_allow_mp44 = getCvar("scr_allow_mp44");
		if(level.allow_mp44 != scr_allow_mp44)
		{
			level.allow_mp44 = scr_allow_mp44;
			setCvar("ui_allow_mp44", level.allow_mp44);
		}
		
		scr_allow_mp44_none = getCvar("scr_allow_mp44_none");
		if(level.allow_mp44_none != scr_allow_mp44_none)
		{
			level.allow_mp44_none = scr_allow_mp44_none;
			setCvar("ui_allow_mp44_none", level.allow_mp44_none);
		}
		
		scr_mp44_cost = getCvar("scr_mp44_cost");
		if(level.cost_mp44 != scr_mp44_cost)
		{
			level.cost_mp44 = scr_mp44_cost;
			setCvar("ui_mp44_cost", "(" + level.cost_mp44 + " points)");
		}
		
		/////////////////////////////////////////////////////////
		// ADDED MP44 SCOPED
		/////////////////////////////////////////////////////////
		scr_allow_scopedmp44 = getCvar("scr_allow_scopedmp44");
		if(level.allow_scopedmp44 != scr_allow_scopedmp44)
		{
			level.allow_scopedmp44 = scr_allow_scopedmp44;
			setCvar("ui_allow_scopedmp44", level.allow_scopedmp44);
		}
		
		scr_scopedmp44_cost = getCvar("scr_scopedmp44_cost");
		if(level.cost_scopedmp44 != scr_scopedmp44_cost)
		{
			level.cost_scopedmp44 = scr_scopedmp44_cost;
			setCvar("ui_scopedmp44_cost", "(" + level.cost_scopedmp44 + " points)");
		}
		
		scr_allow_kar98ksniper = getCvar("scr_allow_kar98ksniper");
		if(level.allow_kar98ksniper != scr_allow_kar98ksniper)
		{
			level.allow_kar98ksniper = scr_allow_kar98ksniper;
			setCvar("ui_allow_kar98ksniper", level.allow_kar98ksniper);
		}
		
		scr_kar98ksniper_cost = getCvar("scr_kar98ksniper_cost");
		if(level.cost_kar98ksniper != scr_kar98ksniper_cost)
		{
			level.cost_kar98ksniper = scr_kar98ksniper_cost;
			setCvar("ui_kar98ksniper_cost", "(" + level.cost_kar98ksniper + " points)");
		}

		scr_allow_mg34 = getCvar("scr_allow_mg34");
		if(level.allow_mg34 != scr_allow_mg34)
		{
			level.allow_mg34 = scr_allow_mg34;
			setCvar("ui_allow_mg34", level.allow_mg34);
		}
		
		scr_mg34_cost = getCvar("scr_mg34_cost");
		if(level.cost_mg34 != scr_mg34_cost)
		{
			level.cost_mg34 = scr_mg34_cost;
			setCvar("ui_mg34_cost", "(" + level.cost_mg34 + " points)");
		}
		
		//////////////////////////////////////////////////////////
		// ADDED MG42
		//////////////////////////////////////////////////////////
		scr_allow_mg42_mp = getCvar("scr_allow_mg42_mp");
		if(level.allow_mg42_mp != scr_allow_mg42_mp)
		{
			level.allow_mg42_mp = scr_allow_mg42_mp;
			setCvar("ui_allow_mg42_mp", level.allow_mg42);
		}
		
		scr_mg42_cost = getCvar("scr_mg42_cost");
		if(level.cost_mg42 != scr_mg42_cost)
		{
			level.cost_mg42 = scr_mg42_cost;
			setCvar("ui_mg42_cost", "(" + level.cost_mg42 + " points)");
		}
		
		//////////////////////////////////////////////////////////
		// ADDED UNSCOPED FG42
		//////////////////////////////////////////////////////////
		scr_allow_fg42 = getCvar("scr_allow_fg42");
		if(level.allow_fg42 != scr_allow_fg42)
		{
			level.allow_fg42 = scr_allow_fg42;
			setCvar("ui_allow_fg42", level.allow_fg42);
		}
		
		scr_allow_fg42_none = getCvar("scr_allow_fg42_none");
		if(level.allow_fg42_none != scr_allow_fg42_none)
		{
			level.allow_fg42_none = scr_allow_fg42_none;
			setCvar("ui_allow_fg42_none", level.allow_fg42_none);
		}
		
		scr_fg42_cost = getCvar("scr_fg42_cost");
		if(level.cost_fg42 != scr_fg42_cost)
		{
			level.cost_fg42 = scr_fg42_cost;
			setCvar("ui_fg42_cost", "(" + level.cost_fg42 + " points)");
		}
		
		scr_allow_fg42_scoped = getCvar("scr_allow_fg42_scoped");
		if(level.allow_fg42_scoped != scr_allow_fg42_scoped)
		{
			level.allow_fg42_scoped = scr_allow_fg42_scoped;
			setCvar("ui_allow_fg42_scoped", level.allow_fg42_scoped);
		}
		
		scr_fg42_scoped_cost = getCvar("scr_fg42_scoped_cost");
		if(level.cost_fg42_scoped != scr_fg42_scoped_cost)
		{
			level.cost_fg42_scoped = scr_fg42_scoped_cost;
			setCvar("ui_fg42_scoped_cost", "(" + level.cost_fg42_scoped + " points)");
		}
		
		////////////////////////////////////////////
		// ADDED SIDEARMS
		///////////////////////////////////////////
		scr_allow_colt = getCvar("scr_allow_colt");
		if(level.allow_colt != scr_allow_colt)
		{
			level.allow_colt = scr_allow_colt;
			setCvar("ui_allow_colt", level.allow_colt);
		}
		
		scr_colt_cost = getCvar("scr_colt_cost");
		if(level.cost_colt != scr_colt_cost)
		{
			level.cost_colt = scr_colt_cost;
			setCvar("ui_colt_cost", "(" + level.cost_colt + " points)");
		}
		
		scr_allow_webley = getCvar("scr_allow_webley");
		if(level.allow_webley != scr_allow_webley)
		{
			level.allow_webley = scr_allow_webley;
			setCvar("ui_allow_webley", level.allow_webley);
		}
		
		scr_webley_cost = getCvar("scr_webley_cost");
		if(level.cost_webley != scr_webley_cost)
		{
			level.cost_webley = scr_webley_cost;
			setCvar("ui_webley_cost", "(" + level.cost_webley + " points)");
		}
		
		scr_allow_tt33 = getCvar("scr_allow_tt33");
		if(level.allow_tt33 != scr_allow_tt33)
		{
			level.allow_tt33 = scr_allow_tt33;
			setCvar("ui_allow_tt33", level.allow_tt33);
		}
		
		scr_tt33_cost = getCvar("scr_tt33_cost");
		if(level.cost_tt33 != scr_tt33_cost)
		{
			level.cost_tt33 = scr_tt33_cost;
			setCvar("ui_tt33_cost", "(" + level.cost_tt33 + " points)");
		}
		
		scr_allow_luger = getCvar("scr_allow_luger");
		if(level.allow_luger != scr_allow_luger)
		{
			level.allow_luger = scr_allow_luger;
			setCvar("ui_allow_luger", level.allow_luger);
		}
		
		scr_luger_cost = getCvar("scr_luger_cost");
		if(level.cost_luger != scr_luger_cost)
		{
			level.cost_luger = scr_luger_cost;
			setCvar("ui_luger_cost", "(" + level.cost_luger + " points)");
		}
		
		//////////////////////////////////////////////////
		// ADDED NEW PISTOLS
		//////////////////////////////////////////////////
		
		scr_allow_welrod = getCvar("scr_allow_welrod");
		if(level.allow_welrod != scr_allow_welrod)
		{
			level.allow_welrod = scr_allow_welrod;
			setCvar("ui_allow_welrod", level.allow_welrod);
		}
		
		scr_welrod_cost = getCvar("scr_welrod_cost");
		if(level.cost_welrod != scr_welrod_cost)
		{
			level.cost_welrod = scr_welrod_cost;
			setCvar("ui_welrod_cost", "(" + level.cost_welrod + " points)");
		}
		
		scr_allow_m712 = getCvar("scr_allow_m712");
		if(level.allow_m712 != scr_allow_m712)
		{
			level.allow_m712 = scr_allow_m712;
			setCvar("ui_allow_m712", level.allow_m712);
		}
		
		scr_m712_cost = getCvar("scr_m712_cost");
		if(level.cost_m712 != scr_m712_cost)
		{
			level.cost_m712 = scr_m712_cost;
			setCvar("ui_m712_cost", "(" + level.cost_m712 + " points)");
		}
		
		//////////////////////////////////////////////////
		//ADDED GRENADES
		//////////////////////////////////////////////////
		scr_allow_fraggrenade = getCvar("scr_allow_fraggrenade");
		if(level.allow_fraggrenade != scr_allow_fraggrenade)
		{
			level.allow_fraggrenade = scr_allow_fraggrenade;
			setCvar("ui_allow_fraggrenade", level.allow_fraggrenade);
		}
		
		scr_fraggrenade_cost = getCvar("scr_fraggrenade_cost");
		if(level.cost_fraggrenade != scr_fraggrenade_cost)
		{
			level.cost_fraggrenade = scr_fraggrenade_cost;
			setCvar("ui_fraggrenade_cost", "(" + level.cost_fraggrenade + " points)");
		}
		
		scr_allow_mk1britishfraggrenade = getCvar("scr_allow_mk1britishfraggrenade");
		if(level.allow_mk1britishfraggrenade != scr_allow_mk1britishfraggrenade)
		{
			level.allow_mk1britishfraggrenade = scr_allow_mk1britishfraggrenade;
			setCvar("ui_allow_mk1britishfraggrenade", level.allow_mk1britishfraggrenade);
		}
		
		scr_mk1britishfraggrenade_cost = getCvar("scr_mk1britishfraggrenade_cost");
		if(level.cost_mk1britishfraggrenade != scr_mk1britishfraggrenade_cost)
		{
			level.cost_mk1britishfraggrenade = scr_mk1britishfraggrenade_cost;
			setCvar("ui_mk1britishfraggrenade_cost", "(" + level.cost_mk1britishfraggrenade + " points)");
		}
		
		scr_allow_rgd33russianfraggrenade = getCvar("scr_allow_rgd33russianfraggrenade");
		if(level.allow_rgd33russianfraggrenade != scr_allow_rgd33russianfraggrenade)
		{
			level.allow_rgd33russianfraggrenade = scr_allow_rgd33russianfraggrenade;
			setCvar("ui_allow_rgd33russianfraggrenade", level.allow_rgd33russianfraggrenade);
		}
		
		scr_rgd33russianfraggrenade_cost = getCvar("scr_rgd33russianfraggrenade_cost");
		if(level.cost_rgd33russianfraggrenade != scr_rgd33russianfraggrenade_cost)
		{
			level.cost_rgd33russianfraggrenade = scr_rgd33russianfraggrenade_cost;
			setCvar("ui_rgd33russianfraggrenade_cost", "(" + level.cost_rgd33russianfraggrenade + " points)");
		}
		
		scr_allow_stielhandgranate = getCvar("scr_allow_stielhandgranate");
		if(level.allow_stielhandgranate != scr_allow_stielhandgranate)
		{
			level.allow_stielhandgranate = scr_allow_stielhandgranate;
			setCvar("ui_allow_stielhandgranate", level.allow_stielhandgranate);
		}
		
		scr_stielhandgranate_cost = getCvar("scr_stielhandgranate_cost");
		if(level.cost_stielhandgranate != scr_stielhandgranate_cost)
		{
			level.cost_stielhandgranate = scr_stielhandgranate_cost;
			setCvar("ui_stielhandgranate_cost", "(" + level.cost_stielhandgranate + " points)");
		}
		
		//////////////////////////////
		// ADDED SMOKE GRENADE WEAPON
		//////////////////////////////
		scr_allow_smokegrenade = getCvar("scr_allow_smokegrenade");
		if(level.allow_smokegrenade != scr_allow_smokegrenade)
		{
			level.allow_smokegrenade = scr_allow_smokegrenade;
			setCvar("ui_allow_smokegrenade", level.allow_smokegrenade);
		}
		
		scr_smokegrenade_cost = getCvar("scr_smokegrenade_cost");
		if(level.cost_smokegrenade != scr_smokegrenade_cost)
		{
			level.cost_smokegrenade = scr_smokegrenade_cost;
			setCvar("ui_smokegrenade_cost", "(" + level.cost_smokegrenade + " points)");
		}
		
		//////////////////////////////
		// ADDED MOLOTOV WEAPON
		//////////////////////////////
		scr_allow_molotov = getCvar("scr_allow_molotov");
		if(level.allow_molotov != scr_allow_molotov)
		{
			level.allow_molotov = scr_allow_molotov;
			setCvar("ui_allow_molotov", level.allow_molotov);
		}
		
		scr_molotov_cost = getCvar("scr_molotov_cost");
		if(level.cost_molotov != scr_molotov_cost)
		{
			level.cost_molotov = scr_molotov_cost;
			setCvar("ui_molotov_cost", "(" + level.cost_molotov + " points)");
		}
		
		/////////////////////////////
		// ADDED MUSTARDGAS WEAPON
		//////////////////////////////
		scr_allow_mustardgas = getCvar("scr_allow_mustardgas");
		if(level.allow_mustardgas != scr_allow_mustardgas)
		{
			level.allow_mustardgas = scr_allow_mustardgas;
			setCvar("ui_allow_mustardgas", level.allow_mustardgas);
		}
		
		scr_mustardgas_cost = getCvar("scr_mustardgas_cost");
		if(level.cost_mustardgas != scr_mustardgas_cost)
		{
			level.cost_mustardgas = scr_mustardgas_cost;
			setCvar("ui_mustardgas_cost", "(" + level.cost_mustardgas + " points)");
		}
		
		///////////////////////////////
		// ADDED SATCHEL WEAPON
		//////////////////////////////
		scr_allow_satchelcharge = getCvar("scr_allow_satchelcharge");
		if(level.allow_satchelcharge != scr_allow_satchelcharge)
		{
			level.allow_satchelcharge = scr_allow_satchelcharge;
			setCvar("ui_allow_satchelcharge", level.allow_satchelcharge);
		}
		
		scr_satchelcharge_cost = getCvar("scr_satchelcharge_cost");
		if(level.cost_satchelcharge != scr_satchelcharge_cost)
		{
			level.cost_satchelcharge = scr_satchelcharge_cost;
			setCvar("ui_satchelcharge_cost", "(" + level.cost_satchelcharge + " points)");
		}
		
		///////////////////////////////
		// ADDED GEBALLTE
		//////////////////////////////
		scr_allow_geballte = getCvar("scr_allow_geballte");
		if(level.allow_geballte != scr_allow_geballte)
		{
			level.allow_geballte = scr_allow_geballte;
			setCvar("ui_allow_geballte", level.allow_geballte);
		}
		
		scr_geballte_cost = getCvar("scr_geballte_cost");
		if(level.cost_geballte != scr_geballte_cost)
		{
			level.cost_geballte = scr_geballte_cost;
			setCvar("ui_geballte_cost", "(" + level.cost_geballte + " points)");
		}
		
		scr_allow_panzerfaust = getCvar("scr_allow_panzerfaust");
		if(level.allow_panzerfaust != scr_allow_panzerfaust)
		{
			level.allow_panzerfaust = scr_allow_panzerfaust;
			setCvar("ui_allow_panzerfaust", level.allow_panzerfaust);
		}

		scr_allow_panzerschreck = getCvar("scr_allow_panzerschreck");
		if(level.allow_panzerschreck != scr_allow_panzerschreck)
		{
			level.allow_panzerschreck = scr_allow_panzerschreck;
			setCvar("ui_allow_panzerschreck", level.allow_panzerschreck);
		}
		
		scr_panzerschreck_cost = getCvar("scr_panzerschreck_cost");
		if(level.cost_panzerschreck != scr_panzerschreck_cost)
		{
			level.cost_panzerschreck = scr_panzerschreck_cost;
			setCvar("ui_panzerschreck_cost", "(" + level.cost_panzerschreck + " points)");
		}

		scr_allow_bazooka = getCvar("scr_allow_bazooka");
		if(level.allow_bazooka != scr_allow_bazooka)
		{
			level.allow_bazooka = scr_allow_bazooka;
			setCvar("ui_allow_bazooka", level.allow_bazooka);
		}
		
		scr_bazooka_cost = getCvar("scr_bazooka_cost");
		if(level.cost_bazooka != scr_bazooka_cost)
		{
			level.cost_bazooka = scr_bazooka_cost;
			setCvar("ui_bazooka_cost", "(" + level.cost_bazooka + " points)");
		}
		
		scr_allow_flamethrower = getCvar("scr_allow_flamethrower");
		if(level.allow_flamethrower != scr_allow_flamethrower)
		{
			level.allow_flamethrower = scr_allow_flamethrower;
			setCvar("ui_allow_flamethrower", level.allow_flamethrower);
		}
		
		scr_flamethrower_cost = getCvar("scr_flamethrower_cost");
		if(level.cost_flamethrower != scr_flamethrower_cost)
		{
			level.cost_flamethrower = scr_flamethrower_cost;
			setCvar("ui_flamethrower_cost", "(" + level.cost_flamethrower + " points)");
		}

		scr_allow_binoculars = getCvar("scr_allow_binoculars");
		if(level.allow_binoculars != scr_allow_binoculars)
		{
			level.allow_binoculars = scr_allow_binoculars;
			setCvar("ui_allow_binoculars", level.allow_binoculars);
		}

		scr_allow_artillery = getCvar("scr_allow_artillery");
		if(level.allow_artillery != scr_allow_artillery)
		{
			level.allow_artillery = scr_allow_artillery;
			setCvar("ui_allow_artillery", level.allow_artillery);
		}

		scr_allow_satchel = getCvar("scr_allow_satchel");
		if(level.allow_satchel != scr_allow_satchel)
		{
			level.allow_satchel = scr_allow_satchel;
			setCvar("ui_allow_satchel", level.allow_satchel);
		}

		scr_allow_smoke = getCvar("scr_allow_smoke");
		if(level.allow_smoke != scr_allow_smoke)
		{
			level.allow_smoke = scr_allow_smoke;
			setCvar("ui_allow_smoke", level.allow_smoke);
		}

		scr_allow_grenades = getCvar("scr_allow_grenades");
		if(level.allow_grenades != scr_allow_grenades)
		{
			level.allow_grenades = scr_allow_grenades;
			setCvar("ui_allow_grenades", level.allow_grenades);
		}

		scr_allow_pistols = getCvar("scr_allow_pistols");
		if(level.allow_pistols != scr_allow_pistols)
		{
			level.allow_pistols = scr_allow_pistols;
			setCvar("ui_allow_pistols", level.allow_pistols);
		}
		
		////////////////////////////////////////
		//ADDED CLASS BASED RESTRICTION CVARS
		////////////////////////////////////////
		scr_allow_rifles = getCvar("scr_allow_rifles");
		if(level.allow_rifles != scr_allow_rifles)
		{
			level.allow_rifles = scr_allow_rifles;
			setCvar("ui_allow_rifles", level.allow_rifles);
		}
		
		scr_allow_smgs = getCvar("scr_allow_smgs");
		if(level.allow_smgs != scr_allow_smgs)
		{
			level.allow_smgs = scr_allow_smgs;
			setCvar("ui_allow_smgs", level.allow_smgs);
		}
		
		scr_allow_mgs = getCvar("scr_allow_mgs");
		if(level.allow_mgs != scr_allow_mgs)
		{
			level.allow_mgs = scr_allow_mgs;
			setCvar("ui_allow_mgs", level.allow_mgs);
		}
		
		scr_allow_heavies = getCvar("scr_allow_heavies");
		if(level.allow_heavies != scr_allow_heavies)
		{
			level.allow_heavies = scr_allow_heavies;
			setCvar("ui_allow_heavies", level.allow_heavies);
		}
		
		scr_allow_snipers = getCvar("scr_allow_snipers");
		if(level.allow_snipers != scr_allow_snipers)
		{
			level.allow_snipers = scr_allow_snipers;
			setCvar("ui_allow_snipers", level.allow_snipers);
		}
		
		///////////////////////////////////////////////////////
		// ADDED PERKS
		///////////////////////////////////////////////////////
		scr_allow_perks = getCvar("scr_allow_perks");
		if(level.allow_perks != scr_allow_perks)
		{
			level.allow_perks = scr_allow_perks;
			setCvar("ui_allow_perks", level.allow_perks);
		}
		
		///////////////////////////////////////////////////////
		// TIER 1 PERKS
		///////////////////////////////////////////////////////
		scr_allow_tier1_perks = getCvar("scr_allow_tier1_perks");
		if(level.allow_tier1_perks != scr_allow_tier1_perks)
		{
			level.allow_tier1_perks = scr_allow_tier1_perks;
			setCvar("ui_allow_tier1_perks", level.allow_tier1_perks);
		}
		
		///////////////////////////////////////////////////////
		// ADDED EXTRA EQUIPMENT
		///////////////////////////////////////////////////////
		scr_allow_extra_equipment = getCvar("scr_allow_extra_equipment");
		if(level.allow_extra_equipment != scr_allow_extra_equipment)
		{
			level.allow_extra_equipment = scr_allow_extra_equipment;
			setCvar("ui_allow_extra_equipment", level.allow_extra_equipment);
		}
		
		scr_extra_equipment_cost = getCvar("scr_extra_equipment_cost");
		if(level.cost_extra_equipment != scr_extra_equipment_cost)
		{
			level.cost_extra_equipment = scr_extra_equipment_cost;
			setCvar("ui_extra_equipment_cost", "(" + level.cost_extra_equipment + " points)");
		}
		
		///////////////////////////////////////////////////////
		// TIER 2 PERKS
		///////////////////////////////////////////////////////
		scr_allow_tier2_perks = getCvar("scr_allow_tier2_perks");
		if(level.allow_tier2_perks != scr_allow_tier2_perks)
		{
			level.allow_tier2_perks = scr_allow_tier2_perks;
			setCvar("ui_allow_tier2_perks", level.allow_tier2_perks);
		}
		
		///////////////////////////////////////////////////////
		// ADDED EXTRA SMOKE
		///////////////////////////////////////////////////////
		scr_allow_extra_smoke = getCvar("scr_allow_extra_smoke");
		if(level.allow_extra_smoke != scr_allow_extra_smoke)
		{
			level.allow_extra_smoke = scr_allow_extra_smoke;
			setCvar("ui_allow_extra_smoke", level.allow_smoke);
		}
		
		scr_extra_smoke_cost = getCvar("scr_extra_smoke_cost");
		if(level.cost_extra_smoke != scr_extra_smoke_cost)
		{
			level.cost_extra_smoke = scr_extra_smoke_cost;
			setCvar("ui_extra_smoke_cost", "(" + level.cost_extra_smoke + " points)");
		}
		
		///////////////////////////////////////////////////////
		// ADDED EXTRA GRENADE
		///////////////////////////////////////////////////////
		scr_allow_extra_grenade = getCvar("scr_allow_extra_grenade");
		if(level.allow_extra_grenade != scr_allow_extra_grenade)
		{
			level.allow_extra_grenade = scr_allow_extra_grenade;
			setCvar("ui_allow_extra_grenade", level.allow_grenade);
		}
		
		scr_extra_grenade_cost = getCvar("scr_extra_grenade_cost");
		if(level.cost_extra_grenade != scr_extra_grenade_cost)
		{
			level.cost_extra_grenade = scr_extra_grenade_cost;
			setCvar("ui_extra_grenade_cost", "(" + level.cost_extra_grenade + " points)");
		}
		
		///////////////////////////////////////////////////////
		// ADDED EXTA AMMO
		///////////////////////////////////////////////////////
		scr_allow_extra_ammo = getCvar("scr_allow_extra_ammo");
		if(level.allow_extra_ammo != scr_allow_extra_ammo)
		{
			level.allow_extra_ammo = scr_allow_extra_ammo;
			setCvar("ui_allow_extra_ammo", level.allow_ammo);
		}
		
		scr_extra_ammo_cost = getCvar("scr_extra_ammo_cost");
		if(level.cost_extra_ammo != scr_extra_ammo_cost)
		{
			level.cost_extra_ammo = scr_extra_ammo_cost;
			setCvar("ui_extra_ammo_cost", "(" + level.cost_extra_ammo + " points)");
		}
		
		///////////////////////////////////////////////////////
		// ADDED KILLSTREAKS
		///////////////////////////////////////////////////////
		scr_allow_killstreaks = getCvar("scr_allow_killstreaks");
		if(level.allow_killstreaks != scr_allow_killstreaks)
		{
			level.allow_killstreaks = scr_allow_killstreaks;
			setCvar("ui_allow_killstreaks", level.allow_killstreaks);
		}
		
		scr_allow_artillery_ks = getCvar("scr_allow_artillery_ks");
		if(level.allow_artillery_ks != scr_allow_artillery_ks)
		{
			level.allow_artillery_ks = scr_allow_artillery_ks;
			setCvar("ui_allow_artillery_ks", level.allow_artillery_ks);
		}
		
		scr_artillery_kills = getCvar("scr_artillery_kills");
		if(level.kills_artillery != scr_artillery_kills)
		{
			level.kills_artillery = scr_artillery_kills;
			setCvar("ui_artillery_kills", "(" + level.kills_artillery + " kills)");
		}
		
		wait 5;
	}
}

/*
USAGE OF "cvardef"
cvardef replaces the multiple lines of code used repeatedly in the setup areas of the script.
The function requires 5 parameters, sets the cvar, and returns the set value of the specified cvar
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
*/
cvardef(varname, vardefault, min, max, type)
{
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
	setCvar(varname,definition);

	return definition;
}