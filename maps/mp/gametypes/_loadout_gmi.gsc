//////////////////////////////////////////////////////////////////////////////
// NewPlayerSpawnLoadout
//
//		sets the players loadout according to the new menu loadout system
//////////////////////////////////////////////////////////////////////////////
PlayerSpawnLoadout()
{
	if (!isdefined(self.pers["weapon"]))
	{
	 	maps\mp\_utility::error("no defined weapon for the spawning player");
	 	return;
	}
	
	self givePerks();
	self giveKillstreaks();
	
	clip_size = getfullclipammo(self.pers["weapon"]);
	if(self.pers["perk2_active"] == "extra_ammo_perk")
		ammount = 999; //fill 'er up
	else
		ammount = GetGunAmmo(self.pers["weapon"]);

	self setWeaponSlotWeapon("primary", self.pers["weapon"]);

	//this will only give up to one full clip in the gun
	self setWeaponSlotClipAmmo("primary", ammount);
	if ( ammount > clip_size )
		self setWeaponSlotAmmo("primary", ammount - clip_size);

	self.pers["spawnweapon"] = self.pers["weapon"];
	self setSpawnWeapon(self.pers["weapon"]);
	
	self givePistol();
	self giveGrenades(self.pers["weapon"]);
	self giveSmokeGrenades();
	self giveSatchelCharges();
	
	self giveBinoculars();
	
	//TODO: IMPLEMENT SKILLS AND KILLSTREAKS IN THE FUTURE VERSION OF THIS MOD
	
	
}


// ----------------------------------------------------------------------------------
//	GetGunAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
GetGunAmmo(weapon)
{
	
	switch(weapon)
	{
		//Rifles (4 clips in reserve with exceptions of m2 which only gets 2)
		case "m1carbine_mp":
		case "m3_mp":
			return 75;
		case "m1garand_mp":
		case "scopedm1garand_mp":
		case "m1garand_g_mp":
			return 40;
		case "svt40_mp":
		case "svt40_scoped_mp":
		case "svt40_scoped_iron_mp":
		case "gewehr43_mp":
		case "gewehr43_scoped_mp":
		case "gewehr43_scoped_iron_mp":
		case "gewehr43_g_mp":
			return 50;
		case "m2_mp":
		case "m2_semi_mp":
			return 90;
		//SMGs (2 clips in reserve with exception of greasegun which gets 3 and drum guns which get just 1)
		case "thompson_mp":
		case "thompson_semi_mp":
		case "tommy2_mp":
			return 90;
		case "mp40_mp":
		case "mp40_silenced_mp":
		case "sten_mp":
		case "sten_silenced_mp":
			return 96;
		case "pps43_mp":
			return 105;
		case "ppsh_mp":
		case "ppsh_semi_mp":
			return 142;
		case "greasegun_mp":
			return 120;
		case "tommy_mp":
			return 100;
		//MGs (2 clips in reserve)
		case "bar_mp":
		case "bar_slow_mp":
		case "fg42_mp":
		case "fg42_semi_mp":
		case "fg42_scoped_mp":
		case "fg42_scoped_semi_mp":
			return 60;
		case "mp44_mp":
		case "mp44_semi_mp":
		case "bren_mp":
		case "scopedmp44_mp":
		case "scopedmp44_semi_mp":
			return 90;
		//Heavies (2 ammo box/belt in reserve, with execption of 30 cal which only gets 1)
		case "mg30cal_mp":
		case "mg30cal_de_mp":
		case "mg34_mp":
		case "mg34_de_mp":
		case "mg42_mp":
		case "mg42_de_mp":
			return 150;
		case "dp28_mp":
		case "dp28_de_mp":
			return 141;
		//Trench Gun (special case)
		case "trenchgun_mp":
			return 144;
		//Snipers (7 clips in reserve)
		case "mosin_nagant_mp":
		case "mosin_nagant_sniper_mp":
		case "enfield_mp":
		case "enfieldscoped_mp":
		case "m1903a3_mp":
		case "springfield_mp":
		case "kar98k_mp":
		case "kar98k_sniper_mp":
		case "ptrs_mp":
			return 40;
		case "delisle_mp":
			return 66;
		// unrecognized weapon
		default:
		   	return 0;
		} 
	
	return 0;
}

// ----------------------------------------------------------------------------------
//	givePistol
//
// 		gives the player their set sidearm
// ----------------------------------------------------------------------------------
givePistol()
{
	if ( !level.allow_pistols )
		return;

	pistoltype = self.pers["pistol"];

	// clear out all ammo
	self setWeaponSlotAmmo("pistol", 0 );
	self setWeaponSlotClipAmmo("pistol", 0 );
	
	clip_size = getfullclipammo(pistoltype);
	if(self.pers["perk2_active"] == "extra_ammo_perk")
		ammount = 999; //fill 'er up
	else
		ammount = GetPistolAmmo(pistoltype);
	
	self giveWeapon(pistoltype);

	if ( ammount > clip_size )
	{
		self setWeaponSlotClipAmmo("pistol", clip_size );
		self setWeaponSlotAmmo("pistol", ammount - clip_size );
	}
	else
	{
		self setWeaponSlotClipAmmo("pistol", ammount );
	}
}

// ----------------------------------------------------------------------------------
//	GetPistolAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
GetPistolAmmo(weapon)
{
	switch(weapon)
	{
		//Pistols (3 clips in reserve)
		case "colt_mp":
			return 28;
		case "webley_mp":
		case "silencedpistol_mp":
			return 24;
		case "tt33_mp":
		case "luger_mp":
			return 32;
		case "m712_mp":
			return 40;
		// unrecognized weapon
		default:
		   	return 0;
	} 
	
	return 0;
}

// ----------------------------------------------------------------------------------
//	giveSmokeGrenades
//
// 		gives the player their set special grenade
// ----------------------------------------------------------------------------------
giveSmokeGrenades()
{

	grenadetype = self.pers["smoke"];

	count = 1; //edit this when skills are implemented

	if ( count )
	{
		if(self.pers["perk2_active"] == "extra_smoke_perk")
			count = count * 3;
		self setWeaponSlotWeapon("smokegrenade", grenadetype);
		self setWeaponSlotClipAmmo("smokegrenade",  count);
	}
}

// ----------------------------------------------------------------------------------
//	giveSatchelCharges
//
// 		gives the player their set equipment
// ----------------------------------------------------------------------------------
giveSatchelCharges()
{
	
	equipment = self.pers["equipment"];

	if (!level.allow_satchel)
		return;
	
	count = getWeaponBasedSatchelChargeCount(equipment); //modified to give ammo based on selected equipment
	
	if ( count )
	{
		self setWeaponSlotWeapon("satchel", equipment);
		if(self.pers["perk1_active"] == "extra_equipment_perk")
			count = count * 2;
		
		
		if(equipment == "panzerschreck_equip_mp" || equipment == "bazooka_equip_mp")
		{
			clip_size = getfullclipammo(equipment);
			self setWeaponSlotClipAmmo("satchel", clip_size );
			self setWeaponSlotAmmo("satchel", count - clip_size );
		}
		else
			self setWeaponSlotClipAmmo("satchel", count);
	}
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedSatchelChargeCount
//
// 		sets ammo given the player's set equipment
// ----------------------------------------------------------------------------------
getWeaponBasedSatchelChargeCount(weapon)
{

	switch(weapon){
		case "satchelcharge_mp":
		case "german_smoke_mp":
		  return 1;
		case "panzerschreck_equip_mp":
		case "bazooka_equip_mp":
			return 2;
		case "flamethrower_equip_mp":
			return 50;
		}

	return 0;
}

// ----------------------------------------------------------------------------------
//	giveGrenades
//
// 		gives the player their set grenade and rifle grenades if applicable
// ----------------------------------------------------------------------------------
giveGrenades(spawnweapon)
{

	grenadetype = self.pers["grenade"];

	count = 1; //edit this when skills are implemented
	if( count )
	{
		if(self.pers["perk2_active"] == "extra_grenade_perk")
			count = count * 3;
		self setWeaponSlotWeapon("grenade", grenadetype);
		self setWeaponSlotClipAmmo("grenade", count );
	}
	
	//dole out rifle grenades as well
	switch(spawnweapon)		
	{
	case "gewehr43_g_mp":
		self giveMaxAmmo("gewehr43_grenade_mp");
	case "m1garand_g_mp":
		self giveMaxAmmo("m1garand_grenade_mp");
	}
}

// ----------------------------------------------------------------------------------
//	giveBinoculars
//
// 		gives the player binoculars
// ----------------------------------------------------------------------------------
giveBinoculars()
{

	if ( !level.allow_binoculars )
		return;
	
	binoctype = "binoculars_mp";
		
	self setWeaponSlotWeapon("binocular", binoctype);
}

// ----------------------------------------------------------------------------------
//	givePerks
//
// 		gives the player perks
// ----------------------------------------------------------------------------------
givePerks()
{
	self.pers["perk1_active"] = self.pers["perk1"];
	self.pers["perk2_active"] = self.pers["perk2"];
	self.pers["perk3_active"] = self.pers["perk3"];
	
	//draw perk hud elements in spawnPlayer function
}
// ----------------------------------------------------------------------------------
//	giveKillStreaks
//
//		sets the selected killstreak as active
//-----------------------------------------------------------------------------------
giveKillstreaks()
{
	self.pers["killstreak_active"] = self.pers["killstreak"];
}
// ----------------------------------------------------------------------------------
//	updateAttachment
//
// 		updates the response to include the proper weapon file based on selected attachment
// ----------------------------------------------------------------------------------
updateAttachment(response){
	
	if(!isDefined(self.pers["lastresponse"]))
		self.pers["lastresponse"] = "Perk1";

	weapon = getFullWeaponName(response); //validate weapon name
	
	if(weapon != response){
		return weapon;
	}
	
	switch(response){
		case "nonePistol":
		case "noneGrenade":
		case "noneSmoke":
		case "noneSatchel":
		case "nonePerk":
		case "artillery":
		case "motorcycle":
		case "firebomb":
		case "mg":
			return response;
		case "Perk1":
		case "Perk2":
		case "Perk3":
			self.pers["lastresponse"] = response;
			return response;
		//if response didn't validate it must be an attachment
		default:
			if(isDefined(self.pers["weapon"]) && self.pers["weapon"] != ""){
				//can't select an attachment if weapon isn't defined
				weapon = self.pers["weapon"];
				//replace base weapon with version that has attacment
				//Attachment A is always the default version of the weapon
				
				switch(weapon){
					case "m1garand_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "scopedm1garand_mp";
							case "AttachmentC": //Grenade Launcer
								return "m1garand_g_mp";
							default:
								return "m1garand_mp";
						}
						break;
					case "m1carbine_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "m2_mp";
							case "AttachmentC": //Grenade Launcer
								return "m3_mp";
							default:
								return "m1carbine_mp";
						}
						break;
					case "svt40_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "svt40_scoped_mp";
							default:
								return "svt40_mp";
						}
						break;
					case "gewehr43_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "gewehr43_scoped_mp";
							case "AttachmentC": //Grenade Launcer
								return "gewehr43_g_mp";
							default:
								return "gewehr43_mp";
						}
						break;
					case "thompson_mp":
						switch(response){
							case "AttachmentB": //Silencer
								return "tommy2_mp";
							case "AttachmentC": //Drum
								return "tommy_mp";
							default:
								return "thompson_mp";
						}
						break;
					case "sten_mp":
						switch(response){
							case "AttachmentB": //Silencer
								return "sten_silenced_mp";
							default:
								return "sten_mp";
						}
						break;
					case "mp40_mp":
						switch(response){
							case "AttachmentB": //Silencer
								return "mp40_silenced_mp";
							default:
								return "mp40_mp";
						}
						break;
					case "mp18_mp":
						switch(response){
							case "AttachmentB": //Silencer
								return "mp18_silenced_mp";
							default:
								return "mp18_mp";
						}
						break;
					case "mp44_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "scopedmp44_mp";
							default:
								return "mp44_mp";
						}
						break;
					case "fg42_mp":
						switch(response){
							case "AttachmentB": //Silencer
								return "fg42_scoped_mp";
							default:
								return "fg42_mp";
						}
						break;
					case "m1903a3_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "springfield_mp";
							default:
								return "m1903a3_mp";
							}
						break;
					case "enfield_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "enfieldscoped_mp";
							default:
								return "enfield_mp";
							}
						break;
					case "mosin_nagant_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "mosin_nagant_sniper_mp";
							default:
								return "mosin_nagant_mp";
						}
					break;
					case "kar98k_mp":
						switch(response){
							case "AttachmentB": //Scope
								return "kar98k_sniper_mp";
							default:
								return "kar98k_mp";
						}
					break;
					default: //Weapon has no attachment, just use the base weapon
						return weapon;
				}	
			}//No weapon defined and no attachment, how did this happen, just skip it.
	}
	return response;

}
// ----------------------------------------------------------------------------------
//	getFullWeaponName
//
// 		returns full weapon name from partial weapon name
// ----------------------------------------------------------------------------------
getFullWeaponName(partialName)
{
	
	switch(partialName){
		case "m1carbine":
		case "m2":
		case "m3":
		case "m1garand":
		case "m1garand_g":
		case "scopedm1garand":
		case "m1903a3":
		case "springfield":
		case "thompson":
		case "tommy":
		case "tommy2":
		case "bar":
		case "bar2": 
		case "mg30cal":
		case "trenchgun":
		case "greasegun":
		case "ud42":
		//British Weapons
		case "enfield":
		case "enfieldscoped":
		case "delisle":
		case "sten":
		case "sten_silenced":
		case "stenmk5":
		case "bren": 
		//Russian Weapons
		case "mosin_nagant":
		case "svt40":
		case "svt40_scoped":
		case "ppsh":
		case "pps43":
		case "dp28":
		case "ptrs":
		//German Weapons
		case "kar98k":
		case "gewehr43":
		case "gewehr43_scoped":
		case "gewehr43_g":
		case "mp40":
		case "mp40_silenced":
		case "mp18":
		case "mp18_silenced":
		case "mp44":
		case "scopedmp44":
		case "mg34":
		case "mg42":
		case "panzerfaust":
		case "panzerfaust_equip":
		case "panzerschreck":
		case "panzerschreck_equip":
		case "bazooka":
		case "bazooka_equip":
		case "piat_equip":
		case "fg42":
		case "fg42_scoped":
		case "flamethrower":
		case "flamethrower_equip":
		//pistols
		case "luger":
		case "colt":
		case "webley":
		case "tt33":
		case "p38":
		case "silencedpistol":
		case "m712":
		//grenades
		case "fraggrenade":
		case "mk1britishfrag":
		case "rgd-33russianfrag":
		case "stielhandgranate":
		//smoke
		case "smokegrenade":
		//equipment
		case "satchelcharge":
		case "german_smoke":
		//added weapons
		case "cocktail":
		case "mustardgas":
			return partialName + "_mp";
		case "bPerk":
			switch(self.pers["lastresponse"]){
				case "Perk1":
					return "extra_equipment_perk";
				case "Perk2":
					return "extra_smoke_perk";
				default:
					return "";
			}
		case "cPerk":
			switch(self.pers["lastresponse"]){
				case "Perk1":
					return "";
				case "Perk2":
					return "extra_grenade_perk";
				case "Perk3":
					return "";
				default:
					return "";
			}
		case "dPerk":
			switch(self.pers["lastresponse"]){
				case "Perk1":
					return "";
				case "Perk2":
					return "extra_ammo_perk";
				case "Perk3":
					return "";
				default:
					return "";
			}
		case "nonePerk":
			switch(self.pers["lastresponse"]){
				case "Perk1":
					return "nonePerk1";
				case "Perk2":
					return "nonePerk2";
				case "Perk3":
					return "nonePerk3";
				default:
					return "nonePerk";
			}
		default:
			return partialName;
	} 
	return partialName;	
}
// ----------------------------------------------------------------------------------
//	updateLoadout
//
// 		updates the load cvars
// ----------------------------------------------------------------------------------
updateLoadout(weapon)
{
	
	switch(getLoadoutSlot(weapon)){
		case "primary":
			if(isDefined(self.pers["weapon"])) 
				slot = self.pers["weapon"];
			else
				slot = "none";
			break;
		case "pistol":
			if(isDefined(self.pers["pistol"])) 
				slot = self.pers["pistol"];
			else
				slot = "none";
			break;
		case "grenade":
			if(isDefined(self.pers["grenade"])) 
				slot = self.pers["grenade"];
			else
				slot = "none";
			break;
		case "smoke":
			if(isDefined(self.pers["smoke"])) 
				slot = self.pers["smoke"];
			else
				slot = "none";
			break;
		case "satchel":
			if(isDefined(self.pers["smoke"])) 
				slot = self.pers["equipment"];
			else
				slot = "none";
			break;
		case "perk1":
			if(isDefined(self.pers["perk1"])) 
				slot = self.pers["perk1"];
			else
				slot = "none";
			break;
		case "perk2":
			if(isDefined(self.pers["perk2"])) 
				slot = self.pers["perk2"];
			else
				slot = "none";
			break;
		case "perk3":
			if(isDefined(self.pers["perk3"])) 
				slot = self.pers["perk3"];
			else
				slot = "none";
			break;
		case "killstreak":
			if(isDefined(self.pers["killstreak"])) 
				slot = self.pers["killstreak"];
			else
				slot = "none";
			break;
		default:
			slot = "none";
	}
	difference = maps\mp\gametypes\_teams::getWeaponLoadoutScore(weapon) - maps\mp\gametypes\_teams::getWeaponLoadoutScore(slot);

	loadout_score = self.pers["loadout_score"] + difference;
	if(loadout_score <= self.pers["loadout_points"]){
		self.pers["loadout_score"] = loadout_score;
		
		switch(getLoadoutSlot(weapon)){
			case "primary":
				maps\mp\gametypes\_waw::printDebug("Selected Primary Weapon is " + weapon, "info","self");
				self setClientCvar("ui_primary_selected", weapon);
				self.pers["weapon"] = weapon;
				break;
			case "pistol":
				maps\mp\gametypes\_waw::printDebug("Selected Sidearm is " + weapon, "info", "self");
				self setClientCvar("ui_sidearm_selected", weapon);
				if(weapon != "nonePistol")
					self.pers["pistol"] = weapon;
				else
					self.pers["pistol"] = "";
				break;
			case "grenade":
				maps\mp\gametypes\_waw::printDebug("Selected Grenade is " + weapon, "info", "self");
				self setClientCvar("ui_grenade_selected", weapon);
				if(weapon != "noneGrenade")
					self.pers["grenade"] = weapon;
				else
					self.pers["grenade"] = "";
				break;
			case "smoke":
				maps\mp\gametypes\_waw::printDebug("Selected Secondary Grenade is " + weapon, "info", "self");
				self setClientCvar("ui_smoke_selected", weapon);
				if(weapon != "noneSmoke")
					self.pers["smoke"] = weapon;
				else
					self.pers["smoke"] = "";
				break;
			case "satchel":
				maps\mp\gametypes\_waw::printDebug("Selected Equipment is " + weapon, "info", "self");
				self setClientCvar("ui_equipment_selected", weapon);
				if(weapon != "noneSatchel")
					self.pers["equipment"] = weapon;
				else
					self.pers["equipment"] = "";
				break;
			case "perk1":
				maps\mp\gametypes\_waw::printDebug("Selected Tier 1 Perk is " + weapon, "info", "self");
				self setClientCvar("ui_perk1_selected", weapon);
				if(weapon != "nonePerk1")
					self.pers["perk1"] = weapon;
				else
					self.pers["perk1"] = "";
				break;
			case "perk2":
				maps\mp\gametypes\_waw::printDebug("Selected Tier 2 Perk is " + weapon, "info", "self");
				self setClientCvar("ui_perk2_selected", weapon);
				if(weapon != "nonePerk2")
					self.pers["perk2"] = weapon;
				else
					self.pers["perk2"] = "";
				break;
			case "perk3":
				maps\mp\gametypes\_waw::printDebug("Selected Tier 3 Perk is " + weapon, "info", "self");
				self setClientCvar("ui_perk3_selected", weapon);
				if(weapon != "nonePerk3")
					self.pers["perk3"] = weapon;
				else
					self.pers["perk3"] = "";
				break;
			case "killstreak":
				maps\mp\gametypes\_waw::printDebug("Selected Killstreak Reward is " + weapon, "info", "self");
				self setClientCvar("ui_killstreak_selected", weapon);
					self.pers["killstreak"] = weapon;
				break;
		}
		self setClientCvar("player_loadout_points_string", self.pers["loadout_score"] + " of " + self.pers["loadout_points"] + " loadout points used!");
		self setClientCvar("player_loadout_warning", "");
	}
}
// ----------------------------------------------------------------------------------
//	updateLoadout
//
// 		updates the load cvars
// ----------------------------------------------------------------------------------
updateDefaultLoadout(team)
{
	/* DEBUG */
	maps\mp\gametypes\_waw::printDebug("Setting default Loadout", "debug", "self");
	
	
	if(!isDefined(self.pers["weapon"])){
		self setClientCvar("ui_primary_selected", "");
		self.pers["weapon"] = "";
	}
	if(!isDefined(self.pers["pistol"])){
		self setClientCvar("ui_sidearm_selected", "");
		self.pers["pistol"] = "";
	}
	if(!isDefined(self.pers["grenade"])){
		self setClientCvar("ui_grenade_selected", "");
		self.pers["grenade"] = "";
	}
	if(!isDefined(self.pers["smoke"])){
		self setClientCvar("ui_smoke_selected", "");
		self.pers["smoke"] = "";
	}
	if(!isDefined(self.pers["equipment"])){
		self setClientCvar("ui_equipment_selected", "");
		self.pers["equipment"] = "";
	}
	if(!isDefined(self.pers["perk1"])){
		self setClientCvar("ui_perk1_selected", "");
		self.pers["perk1"] = "";
	}
	if(!isDefined(self.pers["perk2"])){
		self setClientCvar("ui_perk2_selected", "");
		self.pers["perk2"] = "";
	}
	if(!isDefined(self.pers["perk3"])){
		self setClientCvar("ui_perk3_selected", "");
		self.pers["perk3"] = "";
	}
	
	if(!isDefined(self.pers["killstreak"])){
		self setClientCvar("ui_killstreak_selected", "artillery");
		self.pers["killstreak"] = "artillery";
	}
			
	self.pers["loadout_score"] = 0;
	if(isDefined(self.pers["rank"]))
		self.pers["loadout_points"] = level.default_loadout_points + self.pers["rank"];
	else
		self.pers["loadout_points"] = level.default_loadout_points;
	self setClientCvar("player_loadout_points_string", self.pers["loadout_score"] + " of " + self.pers["loadout_points"] + " loadout points used!");
	self setClientCvar("player_loadout_warning", "");
}
// ----------------------------------------------------------------------------------
//	getLoadoutSlot
//
// 		returns the slot that the item belongs to in the loadout
// ----------------------------------------------------------------------------------
getLoadoutSlot(weapon)
{

	switch(weapon){
		case "m1carbine_mp":
		case "m2_mp":
		case "m3_mp":
		case "m1garand_mp":
		case "m1garand_g_mp":
		case "scopedm1garand_mp":
		case "m1903a3_mp":
		case "springfield_mp":
		case "thompson_mp":
		case "tommy_mp":
		case "tommy2_mp":
		case "ud42_mp":
		case "greasegun_mp":
		case "bar_mp":
		case "bar2_mp":
		case "mg30cal_mp":
		case "trenchgun_mp":
		//British Weapons
		case "enfield_mp":
		case "enfieldscoped_mp":
		case "delisle_mp":
		case "sten_mp":
		case "stenmk5_mp":
		case "sten_silenced_mp":
		case "bren_mp": 
		//Russian Weapons
		case "mosin_nagant_mp":
		case "svt40_mp":
		case "svt40_scoped_mp":
		case "mosin_nagant_sniper_mp":
		case "ppsh_mp":
		case "ppshstick_mp":
		case "pps43_mp":
		case "dp28_mp":
		case "ptrs_mp":
		//German Weapons
		case "kar98k_mp":
		case "kar98k_sniper_mp":
		case "gewehr43_mp":
		case "gewehr43_g_mp":
		case "gewehr43_scoped_mp":
		case "mp40_mp":
		case "mp40_silenced_mp":
		case "mp18_mp":
		case "mp18_silenced_mp":
		case "mp44_mp":
		case "scopedmp44_mp":
		case "mg34_mp":
		case "mg42_mp":
		case "fg42_mp":
		case "fg42_scoped_mp":
			return "primary";
		//Equipment
		case "panzerfaust_equip_mp":
		case "panzerschreck_equip_mp":
		case "bazooka_equip_mp":
		case "piat_equip_mp":
		case "flamethrower_equip_mp":
		case "satchelcharge_mp":
		case "german_smoke_mp":
		case "noneSatchel":
			return "satchel";
		//Pistols
		case "colt_mp":
		case "webley_mp":
		case "tt33_mp":
		case "luger_mp":
		case "p38_mp":
		case "silencedpistol_mp":
		case "m712_mp":
		case "nonePistol":
			return "pistol";
		//Grenade
		case "fraggrenade_mp":
		case "mk1britishfrag_mp":
		case "rgd-33russianfrag_mp":
		case "stielhandgranate_mp":
		case "noneGrenade":
			return "grenade";
		//Smoke
		case "smokegrenade_mp":
		case "cocktail_mp":
		case "mustardgas_mp":
		case "noneSmoke":
			return "smoke";
		//Perks
		case "nonePerk1":
		case "extra_equipment_perk":
			return "perk1";
		case "nonePerk2":
		case "extra_smoke_perk":
		case "extra_grenade_perk":
		case "extra_ammo_perk":
			return "perk2";
		case "nonePerk3":
			return "perk3";
		//Killstreaks
		case "artillery":
		case "motorcycle":
		case "firebomb":
		case "mg":
			return "killstreak";
	} 
	return "";
}