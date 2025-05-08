/************************************************************************
Big Ben's World at Weaps by kmstrube

extending UO to support features of various mods and later titles

acknowledgements:
	Big Ben: for original Big Ben's All Weapons
	placeholder: Tripwires, bleedout, cavity search taken from AWE MOD
	placeholder: molotov, mustard gas, blood effects taken from merciless mod
	ElvisTrigger: many weapons from Big Ben's All Weaps are taken from his work
	ChatGPT: for debugging and boilerplate support
	
 (c) 2025 kmstrube
**************************************************************************/

getSpawnSpectator(gt)
{
	switch(gt)
	{
		case "dm": return "mp_deathmatch_intermission";
		case "re": return "mp_retrieval_intermission";
		case "sd": return "mp_teamdeathmatch_intermission";
		case "ctf": return "mp_ctf_intermission";
		case "dom": return "mp_dom_intermission";
		case "bas": return "mp_gmi_bas_intermission";
		case "tdm":
		case "bel":
		case "hq": return "mp_teamdeathmatch_intermission";
		default: return "mp_teamdeathmatch_intermission";
	}
}
/************************************************************************
START CUSTOM CALLBACKS
************************************************************************/
wawStartGametype()
{
	maps\mp\gametypes\_newmenus::precacheNewMenus();
	thread turretStuff();
}

wawSpawnPlayer()
{
	//notify player spawned
	self notify("waw_spawned");
	
	//cleanup hud elements and reset flags
	cleanUpPlayer();
	self.waw_tripwirewarning = undefined;
	self.waw_checkdefusetripwire = undefined;
	self.waw_checkdefusesatchel = undefined;
	self.waw_checkbodysearch = undefined;
	self.waw_usingturret = undefined;
	self.waw_touchingturret = undefined;
	self.waw_placingturret = undefined;
	self.waw_pickingturret = undefined;
	
	//draw perk hud elements
	printDebug("level.allow_perks is set to " + level.allow_perks, "debug", "self");
	if(level.allow_perks)
		drawPerkHUDElements();
	
	//draw killstreak hud elements	
	printDebug("level.allow_killstreaks is set to " + level.allow_killstreaks, "debug", "self");
	if(level.allow_killstreaks)
	{
		drawKsHUDElements();
	
		if(!isDefined(self.killstreakAwarded))
			self thread monitorKillstreak();
	}
	//start perk 1 threads
	
	//start perk 3 threads
	switch(self.pers["perk3_active"])
	{
		case "marathon_perk":
			if(level.allow_marathon == 1) // sprint set to extended
			{
				self thread monitorMarathon();
			}
			break;
		case "medic_perk":
			self thread monitorMedic();
			break;
	}
	//start player threads
	self thread monitorPlayer();
}

wawSpawnSpectator()
{
	//cleanup hud elements
	cleanUpPlayer();
	
	//set default loadout
	self maps\mp\gametypes\_loadout_gmi::updateDefaultLoadout();
	
}

wawPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	
	// Block friendly melee in some cases (body search, etc...)
	if(isdefined(level.waw_teamplay) && isPlayer(self) && isPlayer(eAttacker) && self.sessionteam == eAttacker.sessionteam && sMeansOfDeath == "MOD_MELEE")
	{
		if(isDefined(self.waw_tripwiremessage) || isDefined(self.waw_turretmessage))
			return;
	}
	
	if(isDefined(sWeapon) && sWeapon == "mustardgas_mp" || sWeapon == "cocktail_mp")
	{
		if(sWeapon == "cocktail_mp" && sMeansOfDeath != "MOD_MELEE" && iDamage < 2)
		{
			if(isDefined(level.cocktail) && level.cocktail == vPoint)
				return;
			level.cocktail = vPoint;
			level thread maps\mp\gametypes\_mcFX::MonitorCocktail(eAttacker,vPoint);
			return;

		}
		else if(sWeapon == "mustardgas_mp" && sMeansOfDeath != "MOD_MELEE")
		{	
			if(isDefined(level.mustardgas) && level.mustardgas == vPoint)
				return;
			level.mustardgas = vPoint;
			level thread maps\mp\gametypes\_mcFX::MonitorMustardGas(eAttacker,vPoint);
			return;
		}
	}
	if(sWeapon != "mustardgas_mp" || sWeapon != "cocktail_mp")
		self maps\mp\gametypes\_shellshock_gmi::DoShellShock(sWeapon, sMeansOfDeath, sHitLoc, iDamage);
	
	//don't do team checks for non-team games
	if(!level.waw_teamplay)
	{
		// Make sure at least one point of damage is done
		if(iDamage < 1)
			iDamage = 1;
			
		self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
	}
	else
	{
		if(isPlayer(eAttacker) && (self != eAttacker) && (self.pers["team"] == eAttacker.pers["team"]))
		{
			if(level.friendlyfire == "1")
			{
				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
				self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
			}
			else if(level.friendlyfire == "0" )
			{
				return;
			}
			else if(level.friendlyfire == "2")
			{
				eAttacker.friendlydamage = true;
		
				iDamage = iDamage * .5;

				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
				
				eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker.friendlydamage = undefined;
				
				friendly = true;
			}
			else if(level.friendlyfire == "3")
			{
				eAttacker.friendlydamage = true;

				iDamage = iDamage * .5;

				// Make sure at least one point of damage is done
				if(iDamage < 1)
					iDamage = 1;
				
				self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
				eAttacker.friendlydamage = undefined;
				
				friendly = true;
			}
		}
		else
		{
			// Make sure at least one point of damage is done
			if(iDamage < 1)
				iDamage = 1;
			self finishPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
		}
	}
	
	if(isalive(self))
	{	
		if(level.waw_bleeding && self.pers["perk3_active"] != "medic_perk")
		{
			printDebug("Doing " + level.waw_bleeding + " points of bleedout damage", "debug", "self");
			//do bleedout
			self thread Bleedout(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
		}
	}
	
}

Bleedout(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	self endon("waw_spawned");
	self endon("waw_died");

	self notify("waw_dobleedingpain");	// Kill any previous bleeding
	self endon("waw_dobleedingpain");

	bLoc = getHitLocTag(sHitLoc);

	x = level.waw_bleeding;

	if ((self.health - x) < 1 )
		willdie = 1;
	else
		willdie = 0;
	
	oldhealth = self.health;

	for(i = 0 ; i < x ; i++)
	{
		// Exit if dead or if a healthpack has been used
		if(!isAlive(self) || self.health > oldhealth)
			break;
		
		self.health -- ;
		oldhealth = self.health;

		if (self.health <= 0)
			self finishPlayerDamage(eInflictor, eAttacker, 2 , iDFlags , sMeansOfDeath , sWeapon , (self.origin + (0,0,-300)), vDir, sHitLoc); 			//Kill the player
		
		if (willdie == 1)
		{
			if(self.health < 2)
			{
				self thread DoPainScreen(100); //no pain screen for now
				self setClientCvar("cl_stance", 2);
			}
			else if(self.health < 4 && (self getStance() == "stand" || self getStance() == "sprint"))
			{
				self thread DoPainScreen(75); //no pain screen for now
				self setClientCvar("cl_stance", 1);
			}
		}
			

		team = self.pers["team"];

		if ( (i == 4 || i == 6 || i == 8) && randomInt(4) )
		{
			if(randomInt(3))
				self playsound("awe_" + team + "_bleedpain"); 
			else
				self playsound("fatigue_breath");
		}

		s = 0;
		for(k = 0 ; k < 3 ; k++ )
		{
			p = (randomInt(2) *.1) + (randomInt(5) * .01);
			if(!self isInVehicle())
				playfxontag(level.waw_bleedingfx, self ,bLoc );
			wait p;
			s = s + p;
		}
		wait (.75 - s);
	}
}

///////////////////////////////////////////////////////
// Draws a "pain" flash on the screen.
// The intensity and longevity of the flash is 
// dependant on both the weapon used & damage done.
//////////////////////////////////////////////////////
DoPainScreen(iDamage)
{
	self endon("waw_spawned");
	self notify("waw_dopainscreen");
	self endon("waw_dopainscreen");

	// Wait for any previous painscreen thread to die
	wait 0.05;

	// Remove previous painscreen if present
	if (isDefined(self.waw_painscreen))
		self.waw_painscreen destroy();

	if (!isDefined(self.waw_painscreen))
	{
		self.waw_painscreen = newClientHudElem(self);
		self.waw_painscreen.alignX = "left";
		self.waw_painscreen.alignY = "top";
		self.waw_painscreen.x = 0;
		self.waw_painscreen.y = 0;	
		p = iDamage * .01;
		if (p >= 1 ) 
			P = .9;
		self.waw_painscreen.alpha = p;
		t = self.waw_painscreen.alpha * .1;

		self.waw_painscreen.color = (1,0,0);
		self.waw_painscreen SetShader("white",640,480);	
		
		wait ((p * 10) * .15 );
		for(v = 0; v < 10; v++)
		{
			self.waw_painscreen.alpha = self.waw_painscreen.alpha - t;
			wait (.05);
		}
		// Remove painscreen if present
		if (isDefined(self.waw_painscreen))
			self.waw_painscreen destroy();
	}
}

wawPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	//notify player died
	self notify("waw_died");
	
	//handle dead body
	level thread handleBody(self, sMeansOfDeath);
	
	//Track Killstreak
	self.killstreak = 0;
	if(attacker != self && (attacker.pers["team"] != self.pers["team"] || !level.waw_teamplay))
		attacker.killstreak++;
	attacker printDebug("Current killstreak is " + attacker.killstreak, "debug", "self");
	
	if(attacker.killstreak != 0 && attacker.killstreak % 10 == 0)
	{
		//announce to the server that attacker is on a killstreak
		announceMessage("Someboyd is on a 10 killstreak","server");
	}
}

handleBody(owner, sMod)
{
	// Clone player
	body = owner cloneplayer();
	body setModel(owner.model);
	
	//Drop health and current weapon
	owner dropItem(owner getcurrentweapon());
	owner dropHealth();

	// Burned bodies should burn & smoke
	if(sMod == "MOD_FLAME" && level.waw_burningbodies) 
		body thread burningBody();


	// Only meaningsful to search bodies if there is anything to search for
	if(!level.allow_scavenger)
		return;

	// Build inventory
	body.inventory = [];
	inventorystring = "You died. Dropping active weapon. Body Inventory contains";
	if(owner getWeaponSlotWeapon("primary") != "none")
	{
		temp = owner saveWeaponSlot("primary");
		inventorystring = inventorystring + " " + temp["item"];
		body.inventory[body.inventory.size] = temp;
	}
	if(owner getWeaponSlotWeapon("primaryb") != "none")
	{
		temp = owner saveWeaponSlot("primaryb");
		if(body.inventory.size > 0)
			inventorystring = inventorystring + ", " + temp["item"];
		else
			inventorystring = inventorystring + " " + temp["item"];
		body.inventory[body.inventory.size] = temp;
	}
	if(owner getWeaponSlotWeapon("pistol") != "none")
	{
		temp = owner saveWeaponSlot("pistol");
		if(body.inventory.size > 0)
			inventorystring = inventorystring + ", " + temp["item"];
		else
			inventorystring = inventorystring + " " + temp["item"];
		body.inventory[body.inventory.size] = temp;
	}
	if(owner getWeaponSlotWeapon("grenade") != "none")
	{
		temp = owner saveWeaponSlot("grenade");
		if(body.inventory.size > 0)
			inventorystring = inventorystring + ", " + temp["item"];
		else
			inventorystring = inventorystring + " " + temp["item"];
		body.inventory[body.inventory.size] = temp;
	}
	if(owner getWeaponSlotWeapon("smokegrenade") != "none")
	{
		temp = owner saveWeaponSlot("smokegrenade");
		if(body.inventory.size > 0)
			inventorystring = inventorystring + ", " + temp["item"];
		else
			inventorystring = inventorystring + " " + temp["item"];
		body.inventory[body.inventory.size] = temp;
	}
	if(owner getWeaponSlotWeapon("satchel") != "none")
	{
		temp = owner saveWeaponSlot("satchel");
		if(body.inventory.size > 0)
			inventorystring = inventorystring + ", " + temp["item"];
		else
			inventorystring = inventorystring + " " + temp["item"];
		body.inventory[body.inventory.size] = temp;
	}

	owner printDebug(inventorystring, "debug", "self");

	range = 30;

	// Body search detection
	while(isdefined(body))
	{
		// Loop through players to check if anyone is close enough to serach
		players = getentarray("player", "classname"); 
		for(i = 0; i < players.size; i++)
		{

			// Check that player still exist
			if(isDefined(players[i]))
				player = players[i];
			else
				continue;
			
			// Player? Alive? Playing?
			if(!isPlayer(player) || !isAlive(player) || player.sessionstate != "playing")
				continue;
				
			//is player's active perk scavenger?
			if(player.pers["perk3_active"] != "scavenger_perk")
				continue;
			
			// Within range?
			distance = distance(body.origin, player.origin);
			if(distance>=range)
				continue;

			// Check for body search
			if(!isdefined(player.waw_checkbodysearch))
				player thread checkBodySearch(body);
		}
		wait 0.5;
	}
}

burningBody()
{
	level endon("waw_boot");

	timeElapsed = (float)0;

	self playloopsound("smallfire");

	while(isdefined(self) && timeElapsed<level.waw_burningbodies)
	{
		playfx(level.waw_burningbodies_burnfx,self.origin + (-10 + randomInt(21),-10 + randomInt(21),-27) );
		delay = 0.1 + randomFloat(0.15);
		timeElapsed += delay;
		wait delay;
	}
	for(i=0;i<2 && isdefined(self);i++)
	{
		playfx(level.waw_burningbodies_smokefx,self.origin);
		wait (0.35 + randomFloat(0.4));
	}
	self stoploopsound();
}

dropHealth()
{
	if ( !getcvarint("scr_drophealth") )
		return;
		
	if(isDefined(level.healthqueue[level.healthqueuecurrent]))
		level.healthqueue[level.healthqueuecurrent] delete();
	
	level.healthqueue[level.healthqueuecurrent] = spawn("item_health", self.origin + (0, 0, 1));
	level.healthqueue[level.healthqueuecurrent].angles = (0, randomint(360), 0);

	level.healthqueuecurrent++;
	
	if(level.healthqueuecurrent >= 16)
		level.healthqueuecurrent = 0;
}
/***********************************************************************
END CUSTOM CALLBACKS

START KILLSTREAK FUNCTIONS
************************************************************************/
monitorKillstreak()
{
	self endon("waw_spawned");
	self endon("waw_died");
	
	self.ksHudTicks = [];
	
	notick = "gfx/icons/hud@killtickempty.tga";
	killtick = "gfx/icons/hud@killtickfull.tga";

	//If no stored KS print KS monitor
	if(!isDefined(self.killstreakAwarded))
	{
		//get killstreak award score
		switch(self.pers["killstreak_active"])
		{
			case "artillery":
				killstreakAwardScore = level.kills_artillery;
				break;
			case "mg":
				killstreakAwardScore = level.kills_deployablemg;
				break;
			case "motorcycle":
			case "firebomb":
			default:
				//not defined so return without updating hud
				return;
		}
		printDebug("killstreakAwardScore is set to " + killstreakAwardScore, "debug", "self");
		for(i = 0; i < killstreakAwardScore; i++)
		{
			self.ksHudTicks[i] = newClientHudElem(self);
			self.ksHudTicks[i].x = 208;
			self.ksHudTicks[i].y = 470 - (9*(i+1));
			self.ksHudTicks[i] setShader(notick, 16,8);
		}
	
		//update killstreak ticks
		while(self.killstreak < killstreakAwardScore)
		{
			i = self.killstreak - 1;
			if(i > -1 && i != j)
				self.ksHudTicks[i] setShader(killtick, 16,8);			
			j = i;
			//check if kill requirement has changed
			switch(self.pers["killstreak_active"])
			{
				case "artillery":
					if(killstreakAwardScore != level.kills_artillery)
					{
						//add ticks if greater
						if(level.kills_artillery > killstreakAwardScore)
						{
							for(i = self.ksHudTicks.size; i < level.kills_artillery; i++)
							{
								self.ksHudTicks[i] = newClientHudElem(self);
								self.ksHudTicks[i].x = 208;
								self.ksHudTicks[i].y = 470 - (9*(i+1));
								self.ksHudTicks[i] setShader(notick, 16,8);
							}
						}
						//destroy ticks if lesser
						else if(level.kills_artillery < killstreakAwardScore)
						{
							for (i = self.ksHudTicks.size; i > level.kills_artillery; i--)
								self.ksHudTicks[i - 1] destroy();
						}							
						killstreakAwardScore = level.kills_artillery;
					}
					break;
				case "mg":
					if(killstreakAwardScore != level.kills_deployablemg)
					{
						//add ticks if greater
						if(level.kills_deployablemg > killstreakAwardScore)
						{
							for(i = self.ksHudTicks.size; i < level.kills_deployablemg; i++)
							{
								self.ksHudTicks[i] = newClientHudElem(self);
								self.ksHudTicks[i].x = 208;
								self.ksHudTicks[i].y = 470 - (9*(i+1));
								self.ksHudTicks[i] setShader(notick, 16,8);
							}
						}
						//destroy ticks if lesser
						else if(level.kills_deployablemg < killstreakAwardScore)
						{
							for (i = self.ksHudTicks.size; i > level.kills_deployablemg; i--)
								self.ksHudTicks[i - 1] destroy();
						}							
						killstreakAwardScore = level.kills_deployablemg;
					}
					break;
				case "motorcycle":
				case "firebomb":
				default:
					//not defined so return without updating hud
					return;
			}
			wait(0.25);
		}
		if(self.killstreak > 0)
		{
			//if killstreak requirement changes then you don't need to fill in a tick
			if(self.ksHudTicks.size == self.killstreak)
				self.ksHudTicks[self.killstreak - 1] setShader(killtick, 16,8);				
		}
		self.ksHudDraw.alpha = 1;
		
		//Award Killstreak
		printDebug("Awarding Killstreak: " + self.pers["killstreak_active"],"info","self");
		
		if(isDefined(self.killstreakAwarded))
			return;
		self.killstreakAwarded = self.pers["killstreak_active"];
		printDebug(self.killstreakAwarded + " stored as awarded killstreak", "debug", "self");
		
		switch(self.killstreakAwarded)
		{
			case "artillery":
				printDebug("Playing artillery get sound", "debug", "self");
				// play a vo
				if ( self.pers["team"] == "allies" )
				{
					switch( game["allies"])
					{
					case "british":
						sound = "uk_arty_gtg";
						break;
					case "russian":
						sound = "ru_arty_gtg";
						break;
					default:
						sound = "us_arty_gtg";
					}
				}
				else
				{
					sound = "ge_arty_gtg";
				}
				self playLocalSound(sound);
				//announce that the use unlocked the killstreak
				announceMessage("Artillery is available! Use your binoculars to call it in!","self",true);
				printDebug("Giving artillery killstreak and monitoring usage", "debug", "self");
				self thread monitorArtillery();
				return;
			case "mg":
				printDebug("Playing mg get sound", "debug", "self");
				// play a vo
				if ( self.pers["team"] == "allies" )
				{
					switch( game["allies"])
					{
					case "british":
						sound = "uk_machingun";
						break;
					case "russian":
						sound = "ru_machingun";
						break;
					default:
						sound = "us_machingun";
					}
				}
				else
				{
					sound = "ge_machingun";
				}
				self playLocalSound(sound);
				//announce that the use unlocked the killstreak
				announceMessage("MG42 Turret is available! Find a suitable area and hold [{+melee}] to deploy!","self",true);
				return;
		}	
	}
}

monitorArtillery()
{
	self endon("died");
	self endon("spectate");
	
	self takeweapon("binoculars_mp");
	self setWeaponSlotWeapon("binocular", "binoculars_artillery_mp");
	self setWeaponSlotClipAmmo("binocular", 1);
	
	while( true )
	{
		if(self getWeaponSlotClipAmmo("binocular") < 1)
		{
			if ( self.pers["team"] == "allies" )	
			{
				switch( game["allies"])
				{
				case "british":
					fire_sound = "uk_fire_mission";
					incoming_sound = "uk_incoming";
					break;
				default:
					fire_sound = "us_fire_mission";
					incoming_sound = "us_incoming";
				}
			}
			else
			{
				fire_sound = "ru_fire_mission";
				incoming_sound = "ru_incoming";
			}	
			// play the vo for calling in the artillery strike
			self playLocalSound(fire_sound);
			
			// now play the incoming sound for any teammates in the area
			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
			{
				player = players[i];
			
				if(player != self && player.pers["team"] == self.pers["team"])
				{
					dist = distance( player.origin, strike_point );
					
					// only play the warning if they are close to the strike area
					if ( dist < 1000 )
						player playLocalSound(incoming_sound);
				}
				else if(player != self && player.pers["team"] != self.pers["team"])
					player playLocalSound(incoming_sound);
			}
		
			self.killstreakAwarded = undefined;
			self.killstreak = 0;
			self thread drawKsHUDElements();
			self thread monitorKillstreak();
			return;
		}
		wait(0.25);
	}
}

turretStuff()
{
	level endon("waw_boot");

	// Wait a servercycle to make sure unwanted entities has been removed
	wait .05;

	// Count all turrets
	allent = getentarray();	// Get all entities

	level.numturrets = 0;

	for(i=0;i<allent.size;i++)	// Loop through them
	{
		if(isdefined(allent[i]))		// Exist?
		{
			if(isdefined(allent[i].weaponinfo))		// Weapon?
			{
				switch(allent[i].weaponinfo)
				{
					case "mg42_bipod_prone_mp":
						if(level.waw_debug)
							iprintln("Turret Angles: " + allent[i].angles[0] + " " + allent[i].angles[1] + " " + allent[i].angles[2]);
					case "mg42_bipod_stand_mp":
					case "mg42_bipod_duck_mp":
						level.numturrets++;
						break;

					default:
						break;
				}
			}
		}
	}

	// Build turret array
	level.waw_turrets = [];

	allent = getentarray();	// Get all entities

	for(i=0;i<allent.size;i++)	// Loop through them
	{
		if(isdefined(allent[i]))		// Exist?
		{
			if(isdefined(allent[i].weaponinfo))		// Weapon?
			{
				switch(allent[i].weaponinfo)
				{
					case "mg42_bipod_stand_mp":
					case "mg42_bipod_duck_mp":
					case "mg42_bipod_prone_mp":
						level.waw_turrets[level.waw_turrets.size]["turret"] = allent[i];
						level.waw_turrets[level.waw_turrets.size - 1]["type"] = "misc_mg42";
						level.waw_turrets[level.waw_turrets.size - 1]["original_position"] = allent[i].origin;
						level.waw_turrets[level.waw_turrets.size - 1]["original_angles"] = allent[i].angles;
						level.waw_turrets[level.waw_turrets.size - 1]["original_weaponinfo"]= allent[i].weaponinfo;
						level.waw_turrets[level.waw_turrets.size - 1]["dropped"] = undefined;
						level.waw_turrets[level.waw_turrets.size - 1]["carried"] = undefined;
						break;
					default:
						break;
				}
			}
		}
	}
	//set turretindex
	level.turretIndex = level.numturrets;
}

checkTurretPlacement()
{
	self endon("checkmgplacement");
	self notify("checkmgplacement");
	self endon("spawned");
	self endon("died");
//	self endon("placing_mg");

	//stay here until player lets go of melee button
	//keeps mg from accidently being placed as soon as it is picked up
	while( self meleeButtonPressed() )
		wait( 0.1 );		
	
	while( true )
	{

		//previous position and angles, in case player goes spec or changes team
		oldposition = self.origin;
		oldangles = self.angles;

		// Don't check placement if in a vehicle
		if(self isInVehicle())
		{
			wait 0.2;
			continue;
		}

		stance = self getStance();
		pos = getTurretPlacement(stance);
		//check if player can put down carried mg
		if( isdefined(pos) )
		{
			self showTurretMessage(level.waw_turretplacemessage );

			//wait for melee button, death, or player movement
			while( !self meleeButtonPressed() && isdefined(pos) )
			{
				oldposition = self.origin;
				oldangles = self.angles;
				wait( 0.1 );
				stance = self getStance();
				pos = getTurretPlacement(stance);
			}

			if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
			if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

			if( self meleeButtonPressed() && isdefined(pos) )
				if(self placeTurret(pos,stance))
					return;	// End thread if placing was a success
				
		}
		wait( 0.2 );
	}
}

getTurretPlacement(stance)
{
	if(!isdefined(stance))
		stance = self getStance();
	
	
	notjump = self isOnGround();

//// Temp "fix" ////
//	if( stance == 2 ) 
//		return undefined;
////////////////////
	if(!notjump)
		return undefined;
	if( stance == "stand" || stance == "sprint" )
		startheight = 66;//height from which to bullettrace downwards
	else if( stance == "crouch" )
		startheight = 42;
	else if( stance == "prone" )
		startheight = 18;
	else
		return undefined;//jumping! Don't allow placement. This leads to abuse.


	//find the height of the ceiling
	trace = bulletTrace( self.origin, self.origin + ( 0, 0, 80 ), false, undefined );
	ceiling = trace[ "position" ];
	maxheight = ceiling[2] - self.origin[2];
	if( startheight > maxheight-1 )
		startheight = maxheight-1;//the -1 makes sure we start below the ceiling

	checkstart = self.origin;
	valid = false;

	frontbarrellength=16;		//estimates of the mg's size. Used to make sure mg doesn't stick through something
	rearbarrellength = 58;//actual gun is around 46, the extra inches make sure players don't stick through walls when using mg rotated
	gunheight = 12;

	gunforward = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), frontbarrellength );
	gunbackward = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), -1 * rearbarrellength );

	gunleftforward = ( -1 * gunforward[1], gunforward[0], 0 );//front part of gun when rotated 90 degrees left
	gunleftback = ( -1 * gunbackward[1], gunbackward[0], 0 );//back part of gun when rotated 90 degrees right

	pt1 = gunforward + ( 0, 0, gunheight );//front part point straight
	pt2 = gunbackward + ( 0, 0, gunheight );//back part pointed straight
	pt3 = maps\mp\_utility::vectorScale( gunforward + gunleftforward, 0.7 ) + ( 0, 0, gunheight );//front part 45 deg left
	pt4 = maps\mp\_utility::vectorScale( gunforward - gunleftforward, 0.7 ) + ( 0, 0, gunheight );//front part 45 deg right
	pt5 = maps\mp\_utility::vectorScale( gunbackward + gunleftback, 0.7 ) + ( 0, 0, gunheight );//back part pointed 45 right
	pt6 = maps\mp\_utility::vectorScale( gunbackward - gunleftback, 0.7 ) + ( 0, 0, gunheight );//back part pointed 45 left

	//first trace at 42 inches in front of player
	forward = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), 42 );
	trace = bulletTrace( checkstart + forward + ( 0, 0, startheight ), checkstart + forward + ( 0, 0, -60 ), false, undefined );
	pos = trace["position"];
	height = pos[2] + gunheight - checkstart[2];
	
	if(isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "script_vehicle")
		valid = false;
	else if( (stance=="stand" || stance=="sprint") && height >= 42 && height < startheight )
		valid = true;
	else if( stance == "crouch" && height >= 30 && height < startheight )
		valid = true;
	else if( stance == "prone" && height < startheight && height > 0 )
		valid = true;

	//check if the gun would have enough space in front of bipod, to prevent placement abuse
	if( valid )
	{
		trace = bulletTrace( pos + pt1, pos + pt2, false, undefined );
		if( trace["fraction"] < 1 )
			valid = false;
		trace = bulletTrace( pos + pt3, pos + pt5, false, undefined );
		if( trace["fraction"] < 1 )
			valid = false;
		trace = bulletTrace( pos + pt6, pos + pt4, false, undefined );
		if( trace["fraction"] < 1 )
			valid = false;
		trace = bulletTrace( pos + pt6, pos + pt5, false, undefined );
		if( trace["fraction"] < 1 )
			valid = false;
	}

	if( !valid )
	{
		forward = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), 46 );

		//second trace at 46 inches in front of player
		trace = bulletTrace( checkstart + forward + ( 0, 0, startheight ), checkstart + forward + ( 0, 0, -60 ), false, undefined );
		pos=trace["position"];
   
		height = pos[2] + gunheight - checkstart[2];

		if(isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "script_vehicle")
			valid = false;
		else if( (stance == "stand" || stance == "sprint") && height >= 42 && height < startheight )
			valid = true;
		else if( stance == "crouch" && height >= 30 && height < startheight )
			valid = true;
		else if( stance == "prone" && height< startheight && height > 0 )
			valid = true;

		//check if the gun would have enough space in front of bipod, to prevent placement abuse
		if( valid )
		{
			trace = bulletTrace( pos + pt1, pos + pt2, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
			trace = bulletTrace( pos + pt3, pos + pt5, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
			trace = bulletTrace( pos + pt6, pos + pt4, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
			trace = bulletTrace( pos + pt6, pos + pt5, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
		}
	}
	if( !valid )
	{
		forward = maps\mp\_utility::vectorScale( anglesToForward( self.angles ), 50 );

		//third trace at 50 inches in front of player
		trace = bulletTrace( checkstart + forward + ( 0, 0, startheight ), checkstart + forward + ( 0, 0, -60 ), false, undefined );
		pos = trace["position"];

		height = pos[2] + gunheight - checkstart[2];

		if(isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "script_vehicle")
			valid = false;
		else if( (stance == "stand" || stance == "sprint") && height >= 42 && height < startheight )
			valid = true;
		else if( stance == "crouch" && height >= 30 && height < startheight )
			valid = true;
		else if( stance == "prone" && height < startheight && height > 0 )
			valid = true;

		//check if the gun would have enough space in front of bipod, to prevent placement abuse
		if( valid )
		{
			trace = bulletTrace( pos + pt1, pos + pt2, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
			trace = bulletTrace( pos + pt3, pos + pt5, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
			trace = bulletTrace( pos + pt6, pos + pt4, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
			trace = bulletTrace( pos + pt6, pos + pt5, false, undefined );
			if( trace["fraction"] < 1 )
				valid = false;
		}
	}

	// Make sure turret is not placed below player, autocorrect max 2 units
	if(pos[2] < self.origin[2])
	{
		if( (self.origin[2] - pos[2])>2 )
			valid = false;
		else
			pos = (pos[0], pos[1], self.origin[2]);
	}

	if( valid )
		return pos;

	return undefined;
}

placeTurret(pos, stance)
{
	self endon("spawned");
	self endon("died");
	self endon("placing_mg");

	gw = self getCurrentWeapon();	

	if(!isdefined(stance)) stance = self getStance();  
	
	jump = self isOnGround();
	
	if(!isdefined(pos)) pos = getTurretPlacement(stance);

	if( !isDefined( pos ) )
		return false;

	if( stance == "crouch" || stance == "stand" || stance == "sprint" )
	{
		//do a trace upward to see if we're in a porthole
		trace = bulletTrace( pos + ( 0, 0, 2 ), pos + ( 0, 0, 25 ), false, undefined );
		if( trace["fraction"] < 1 )
			pos = pos + ( 0, 0, -11 );
	}
	origin = self.origin;
	angles = self.angles;

	// Ok to plant, show progress bar

	planttime = 3;

	if(isdefined(planttime))
	{
		self disableWeapon();
		if(!isdefined(self.plantbar))
		{
			barsize = 288;
			// Time for progressbar	
			bartime = (float)planttime;

			// Background
			self.plantbarbackground = newClientHudElem(self);				
			self.plantbarbackground.alignX = "center";
			self.plantbarbackground.alignY = "middle";
			self.plantbarbackground.x = 320;
			self.plantbarbackground.y = 405;
			self.plantbarbackground.alpha = 0.5;
			self.plantbarbackground.color = (0,0,0);
			self.plantbarbackground setShader("white", (barsize + 4), 12);			
			// Progress bar
			self.plantbar = newClientHudElem(self);				
			self.plantbar.alignX = "left";
			self.plantbar.alignY = "middle";
			self.plantbar.x = (320 - (barsize / 2.0));
			self.plantbar.y = 405;
			self.plantbar setShader("white", 0, 8);
			self.plantbar scaleOverTime(bartime , barsize, 8);

			self showTurretMessage(level.waw_turretplacingmessage);

			// Play plant sound
			self playsound("moody_plant");
		}

		for(i=0;i<planttime*20;i++)
		{
			if( !(self meleeButtonPressed() && origin == self.origin) )
				break;
			wait 0.05;
		}

		// Remove hud elements
		if(isdefined(self.plantbarbackground)) self.plantbarbackground destroy();
		if(isdefined(self.plantbar))		 self.plantbar destroy();
		if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
		if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
		self enableWeapon();
		if(i<planttime*20)
			return false;
	}
	self.placing++;

//	placeTurretAt( pos + ( 0, 0, -1 ), angles, stance );
	if(self.placing == 1)
		placeTurretAt( pos + ( 0, 0, 0.5 ), angles, stance );

	self.placing = 0;
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
		if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
	while(self meleeButtonPressed())
		wait(0.05);

	return true;	// return and end thread
}

placeTurretAt( position, angles, stance )
{
	//kill other threads
	self notify("placing_mg");
	self endon("placemg");
	self notify("placemg");
//	iprintlnbold("Stance:" + stance);

	type = "misc_mg42";

	model = "xmodel/mg42_bipod";

	if( stance == "prone" )
		weaponinfo = "mg42_bipod_prone_mp";
	else if( stance == "crouch" )
		weaponinfo = "mg42_bipod_duck_mp";
	else if( stance == "stand" || stance == "sprint" )
		weaponinfo = "mg42_bipod_stand_mp";

	//Add turret to array
	indexToPlace = level.turretIndex;
	
	printDebug("Next available index for turrets is " + indexToPlace, "debug", "self");
	
	if(level.waw_turrets.size < level.allow_deployablemg_ks + level.numturrets)
	{
		printDebug("Adding turret to level at free index" + level.waw_turrets.size, "debug", "self");
		level.waw_turrets[level.waw_turrets.size] = spawnTurret( type, position , weaponinfo );
		level.waw_turrets[level.waw_turrets.size - 1] setmodel( model );
		level.waw_turrets[level.waw_turrets.size - 1].weaponinfo = weaponinfo;
		level.waw_turrets[level.waw_turrets.size - 1].angles = (0,angles[1],0);
		level.waw_turrets[level.waw_turrets.size - 1].origin = position;//do this LAST. It'll move the MG into a usable position
		level.waw_turrets[level.waw_turrets.size - 1] thread maps\mp\_turret_gmi::turret_think();
	}
	else
	{
		printDebug("Too many turrets. Overwriting an existing turret at index" + indexToPlace, "debug", "self"); 
		leve.waw_turrets[indexToPlace] delete();
		level.waw_turrets[indexToPlace] = spawnTurret( type, position , weaponinfo );
		level.waw_turrets[indexToPlace] setmodel( model );
		level.waw_turrets[indexToPlace].weaponinfo = weaponinfo;
		level.waw_turrets[indexToPlace].angles = (0,angles[1],0);
		level.waw_turrets[indexToPlace].origin = position;//do this LAST. It'll move the MG into a usable position
		level.waw_turrets[indexToPlace] thread maps\mp\_turret_gmi::turret_think();
		level.turretIndex++;
		if(level.turretIndex >= level.waw_turrets.size)
			level.turretIndex = level.numturrets;
	}
	self.killstreakAwarded = undefined;
	self.killstreak = 0;
	self thread drawKsHUDElements();
	self thread monitorKillstreak();
	return;
}

showTurretMessage(which_message)
{
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	self.waw_tripwiremessage = newClientHudElem( self );
	self.waw_tripwiremessage.alignX = "center";
	self.waw_tripwiremessage.alignY = "middle";
	self.waw_tripwiremessage.x = 320;
	self.waw_tripwiremessage.y = 404;
	self.waw_tripwiremessage.alpha = 1;
	self.waw_tripwiremessage.fontScale = 0.80;
	self.waw_tripwiremessage.color = (.5,.5,.5);
	self.waw_tripwiremessage setText( which_message );

	self.waw_tripwiremessage2 = newClientHudElem(self);
	self.waw_tripwiremessage2.alignX = "center";
	self.waw_tripwiremessage2.alignY = "top";
	self.waw_tripwiremessage2.x = 320;
	self.waw_tripwiremessage2.y = 415;
	self.waw_tripwiremessage2 setShader("ui_mp/assets/hud@mg42_dep_z.dds",32,32);
}

/***********************************************************************
END KILLSTREAK FUNCTIONS

START PERK FUNCTIONS
************************************************************************/
monitorPlayer()
{
	self endon("waw_spawned");
	self endon("waw_died");
	self endon("disconnect");
	
	//run perk1 threads
	
	//run perk3 threads
	switch(self.pers["perk3_active"])
	{
		case "marathon_perk":
			if(level.allow_marathon == 2) // infinite sprintf
			{
				self setFatigue(1);
			}
			break;		
	}
	
	while(isAlive(self) && self.sessionstate == "playing")
	{
	
		wait 0.05;
		
		// get current weapon
		cw = self getCurrentWeapon();
		attackButton = self attackButtonPressed();
		stance = self getStance();

		meleeButton = self meleeButtonPressed();

		if( self.pers["perk1_active"] == "tripwire_perk" && level.allow_tripwire && isWeaponType("grenade",cw) && stance=="prone" && self isOnGround() && !isDefined(self.waw_turretmessage) && !isDefined(self.waw_tripwiremessage))
			self thread checkTripwirePlacement();

		if( self.pers["perk1_active"] == "tripwire_perk" && level.allow_tripwire && cw == "satchelcharge_mp" && stance=="prone" && self isOnGround() && !isDefined(self.waw_turretmessage) && !isDefined(self.waw_tripwiremessage))
			self thread checkSatchelPlacement();

		if( self.pers["perk1_active"] == "tripwire_perk" && level.allow_tripwire && meleeButton && !isdefined(self.waw_checkstickyplacement) && !isDefined(self.waw_turretmessage) && !isDefined(self.waw_tripwiremessage) && (isWeaponType("grenade",cw) || cw == "satchelcharge_mp") && stance!="prone")
			self thread checkStickyPlacement(cw);
		
		if(isDefined(self.killstreakAwarded) && self.killstreakAwarded == "mg" && !isDefined(self.waw_tripwiremessage) && !isDefined(self.plantbar))
			self thread checkTurretPlacement();
		
	}
}

monitorMarathon()
{
	self endon("waw_spawned");
	self endon("waw_died");

	oldfat = self getFatigue();

	while (isAlive(self) && self.sessionstate == "playing")
	{
		
		wait .05;		// Wait
		newfat = self getFatigue();
		deltafat = newfat - oldfat;

		if(deltafat<0) // Sprinting
		{
			if(!isdefined(self.marathon_sprinting))
			{
				self.maxspeed = 1.9 * level.marathon_sprint_speed * 100;
				self.marathon_sprinting = true;
			}

			newfat = oldfat + deltafat * level.marathon_sprint_time;

			if(newfat<0) newfat = 0;

			self setFatigue(newfat);
		}

		if(deltafat>0) // Recovering
		{
			newfat = oldfat + deltafat * level.marathon_sprint_recovery;

			if(newfat>1) newfat = 1;

			self setFatigue(newfat);
		}

		if(deltafat>=0) // Recovering and/or not sprinting
		{
			if(isdefined(self.marathon_sprinting))
			{
				self.maxspeed = 1.9 * 100;
				self.marathon_sprinting = undefined;
			}
		}

		oldfat = newfat;
	}
}

monitorMedic()
{
	self endon("waw_spawned");
	self endon("waw_died");
	
	for(j=0;j<level.medic_firstaidkits;)
	{
		if(level.waw_gametype == "bel")
		{
			xoff = -80;
			yoff = 0;
		}
		else if(level.waw_gametype == "hq")
		{
			xoff = 0;
			yoff = -18;
		}
		else
		{
			xoff = 0;
			yoff = 0;
		}
		
		self.waw_firstaidicon = newClientHudElem(self);
		self.waw_firstaidicon.alignX = "center";
		self.waw_firstaidicon.alignY = "middle";
		self.waw_firstaidicon.x = 600+xoff;
		self.waw_firstaidicon.y = 381+yoff;
		self.waw_firstaidicon.alpha = 1;
		self.waw_firstaidicon setShader(game["firstaid"], 32, 32);

		if(level.medic_firstaidkits >1 && !isdefined(self.waw_firstaidkits))
		{
			self.waw_firstaidkits = newClientHudElem(self);
			self.waw_firstaidkits.alignX = "center";
			self.waw_firstaidkits.alignY = "middle";
			self.waw_firstaidkits.x = 607+xoff;
			self.waw_firstaidkits.y = 392+yoff;
			self.waw_firstaidkits.alpha = 1;
			self.waw_firstaidkits.color = (1,1,1);
			self.waw_firstaidkits.fontscale = 0.8;
			self.waw_firstaidkits setValue(level.medic_firstaidkits);
		}
		while(isalive(self) && self.sessionstate == "playing" && isdefined(self.waw_firstaidicon))
		{
			wait 0.05;

			// wait for player to press the USE key (while on ground and not sprinting)
			while(isalive(self) && self.sessionstate == "playing")
			{
				if(self useButtonPressed() && self isOnGround())
					break;
				wait 0.05;
			}

			if(!(isalive(self) && self.sessionstate == "playing")) // if they've been killed
				break;

			if(level.waw_teamplay)
			{
				players = getentarray("player", "classname"); 
				for(i = 0; i < players.size; i++)
				{
					if(isdefined(players[i]))
					{
						if(players[i] == self)
							continue;	// can't heal yourself

						if(players[i].pers["team"] == self.pers["team"]			// teammate
							&& isalive(players[i])						// who is playing
							&& players[i].health <= 80					// and is injured
							&& !isdefined(players[i].waw_gettingfirstaid)		// and is not currently being treated
							&& distance(players[i].origin, self.origin) < 48	// and within 4 feet of player
						){
							targetPlayer = players[i];
							break;
						}
					}
				}
			}
			if(!isdefined(targetPlayer))
				targetPlayer = self;  // not in range of any friendlies that need healing, heal self
			if(targetPlayer.health > 80)
				continue;
			// all systems go, commence healing

			// wait 0.5 seconds (make sure they mean it, are holding USE)
			holdtime = 0;
			while(self useButtonPressed() && holdtime < 0.5
				&& self isOnGround()
				&& targetPlayer isOnGround()
			){
				holdtime += 0.05;
				wait 0.05;
			}
			if(holdtime < 0.5)
				continue;

			if(!isalive(self) || !isalive(targetPlayer))
				continue;	

			if(isdefined(self.defuseicon)) // can't heal while defusing a bomb
				continue;

			healamount = level.medic_firstaidhealth;	// (25 to 40 health)
			healtime = (float)healamount * .1;

			// set up the healing icon on the target
			targetPlayer.waw_gettingfirstaid = newClientHudElem(targetPlayer);
			if(targetPlayer != self)
			{
				targetPlayer.waw_gettingfirstaid .alignX = "center";
				targetPlayer.waw_gettingfirstaid.alignY = "middle";
				targetPlayer.waw_gettingfirstaid.x = 320;
				targetPlayer.waw_gettingfirstaid.y = 240;
				targetPlayer.waw_gettingfirstaid.alpha = 0;
				targetPlayer.waw_gettingfirstaid setShader(game["firstaid"], 1, 1);

				targetPlayer.waw_gettingfirstaid scaleOverTime(0.5, 64, 64);
				targetPlayer.waw_gettingfirstaid fadeOverTime(0.5);
				targetPlayer.waw_gettingfirstaid.alpha = 0.5;
			}
			// spawn a script origin, and lock the players in place
			origin = spawn("script_origin", self.origin);
			self linkTo(origin);
			targetPlayer linkTo(origin);

			self.waw_dropfirstaid = newClientHudElem(self);
			self.waw_dropfirstaid.alignX = "center";
			self.waw_dropfirstaid.alignY = "middle";
			self.waw_dropfirstaid.x = 600+xoff;
			self.waw_dropfirstaid.y = 200+yoff;
			self.waw_dropfirstaid.alpha = 0;
			self.waw_dropfirstaid setShader(game["firstaid"], 32, 32);

			self.waw_dropfirstaid fadeOverTime(0.5);
			self.waw_dropfirstaid.alpha = 0.25;
			self.waw_dropfirstaid scaleOverTime(0.5, 64, 64);

			self.waw_firstaidicon moveOverTime(healtime);
			self.waw_firstaidicon.y = 200+yoff;
			self.waw_firstaidicon scaleOverTime(healtime, 64, 64);


			healnow = 0;
			holdtime = 0;
			while(self useButtonPressed()					// still holding the USE key
				&& !(self meleeButtonPressed())			// player hasn't melee'd
				&& !(targetPlayer meleeButtonPressed())		// target hasn't melee'd
				&& !(self attackButtonPressed())			// player hasn't fired
				&& !(targetPlayer attackButtonPressed())		// target hasn't fired
				&& isalive(self) && isalive(targetPlayer) 	// both still alive
				&& targetPlayer.health < 100 				// hasn't filled target's health
				&& healamount > 0						// hasn't run out of healamount
			){
				if(healnow == 1)
				{
					targetPlayer.health++;  // 10 health per second, 1 point every other 1/20th of a second (server frame)
										// had to do that 'cause of integer rounding issues
					healamount--;
					healnow = -1;
				}
				healnow++;

				holdtime += 0.05;
				wait 0.05;
			}

			if((healamount == 0 || targetPlayer.health == 100) && isalive(targetPlayer) && isalive(self))
			{
				if(targetPlayer != self)
					iprintln(self.name + "^7 patched up " + targetPlayer.name);

			}

			// release from script origin, delete script origin
			self unlink();
			targetPlayer unlink();
			origin delete();

			// explode and fade-out firstaid kit (and the drop marker), destroy shader
			if(isdefined(targetPlayer) && isdefined(targetPlayer.waw_gettingfirstaid) && targetPlayer != self)
			{
				targetPlayer.waw_gettingfirstaid scaleOverTime(0.5, 1, 1);
				targetPlayer.waw_gettingfirstaid fadeOverTime(0.5);
				targetPlayer.waw_gettingfirstaid.alpha = 0;
			}

			if(isdefined(self) && isdefined(self.waw_dropfirstaid))
			{
				self.waw_dropfirstaid fadeOverTime(0.5);
				self.waw_dropfirstaid.alpha = 0;
			}

			if(isdefined(self) && isdefined(self.waw_firstaidicon))
			{
				self.waw_firstaidicon scaleOverTime(0.5, 128, 128);
				self.waw_firstaidicon fadeOverTime(0.5);
				self.waw_firstaidicon.alpha = 0;
			}

			wait 0.5;

			if(isdefined(self))
			{
				if(isdefined(self.waw_firstaidicon))
					self.waw_firstaidicon destroy();		
				if(isdefined(self.waw_dropfirstaid))
					self.waw_dropfirstaid destroy();
				if(isdefined(targetPlayer.waw_gettingfirstaid))
					targetPlayer.waw_gettingfirstaid destroy();
			}
		}

		if(isdefined(self.waw_firstaidicon)) // in case they were killed, but not healing a teammate, or got a bomb
			self.waw_firstaidicon destroy();		

		j++;

		if(isdefined(self.waw_firstaidkits)) 
			self.waw_firstaidkits setValue(level.medic_firstaidkits - j);

		if(j<level.medic_firstaidkits)
			wait level.medic_firstaiddelay;
		else
			break;
		

		if(!(isalive(self) && self.sessionstate == "playing")) // if they've been killed
			break;

	}
	if(isdefined(self.waw_firstaidkits)) 
		self.waw_firstaidkits destroy();
}

checkBodySearch(body)
{
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");

	// Make sure to only run one instance
	if(isdefined(self.waw_checkbodysearch))
		return;

	// Make sure we are not in defuse position of a tripwire
	if(isdefined(self.waw_checkdefusetripwire))
		return;

	range = 30;

	// Ok to search, kill checkTripwirePlacement and set up new hud message
	self notify("waw_checktripwireplacement");

	// Ok to search, kill checkSatchelPlacement and set up new hud message
	self notify("waw_checksatchelplacement");

	self.waw_checkbodysearch = true;
	
	printDebug("Within Body Search Range", "debug", "self");

	// Remove hud elements
	if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
	if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
	
	//New scavenger, fall back on old body search after auto scavenge
	if(level.allow_scavenger == 2 && anythingToScavenge(self,body)) //use new scavenger if there is anything to auto scavenge
	{
		printDebug("found items to autoscavenge","debug","self");
		
		showBodysearchMessage(false);
		//play scavenger sound
		self playsound("moody_plant");
		
		//do auto scavenge
		primary = self getWeaponSlotWeapon("primary");
		primaryb = self getWeaponSlotWeapon("primaryb");
		pistol = self getWeaponSlotWeapon("pistol");
		grenade = self getWeaponSlotWeapon("grenade");
		smokegrenade = self getWeaponSlotWeapon("smokegrenade");
		satchel = self getWeaponSlotWeapon("satchel");
		
		itemsToRemove = [];
		
		for(i = 0; i < body.inventory.size; i++)
		{
			autoslot = "";
			item = body.inventory[i]["item"];
			if(item == "")
				continue;
			if (item == primary) autoslot = "primary";
			else if (item == primaryb) autoslot = "primaryb";
			else if (item == pistol) autoslot = "pistol";
			else if (item == grenade) autoslot = "grenade";
			else if (item == smokegrenade) autoslot = "smokegrenade";
			else if (item == satchel) autoslot = "satchel";
			
			if(autoslot != "")
			{
				newammo = body.inventory[i]["ammo"] + body.inventory[i]["clip"];
				printDebug("Found " + body.inventory[i]["item"] + " with " + newammo + " ammo", "debug", "self");
				oldammo = self getWeaponSlotAmmo(autoslot) + self getWeaponSlotClipAmmo(autoslot);
				ammount = newammo + oldammo;
				printDebug("Setting new ammo ammount to " + ammount, "debug", "self");
				self setWeaponSlotAmmo(autoslot, ammount);
				printDebug("Removing weapon from body inventory", "debug", "self");
				itemsToRemove[itemsToRemove.size] = i;
			}
			
		}
		for( i = 0; i < itemsToRemove.size; i++)
		{
			body.inventory = removeFromArray(body.inventory, itemsToRemove[i]);
		}
		// Clean up
		if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
		if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
		if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
		if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
	}
	else //fall back to AWE body search when there is nothing to autoscavenge
	{
		// Set up new
		showBodysearchMessage(true);

		// Loop
		for(;;)
		{
			if( isAlive( self ) && self.sessionstate == "playing" && self meleeButtonPressed() )
			{
				// Ok to plant, show progress bar
				origin = self.origin;
				angles = self.angles;

				planttime = level.scavenger_search_time + randomFloat(1);

				self disableWeapon();
				if(!isdefined(self.waw_plantbar))
				{
					barsize = 288;
					// Time for progressbar	
					bartime = (float)planttime;
					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
					// Background
					self.waw_plantbarbackground = newClientHudElem(self);				
					self.waw_plantbarbackground.alignX = "center";
					self.waw_plantbarbackground.alignY = "middle";
					self.waw_plantbarbackground.x = 320;
					self.waw_plantbarbackground.y = 405;
					self.waw_plantbarbackground.alpha = 0.5;
					self.waw_plantbarbackground.color = (0,0,0);
					self.waw_plantbarbackground setShader("white", (barsize + 4), 12);			
					// Progress bar
					self.waw_plantbar = newClientHudElem(self);				
					self.waw_plantbar.alignX = "left";
					self.waw_plantbar.alignY = "middle";
					self.waw_plantbar.x = (320 - (barsize / 2.0));
					self.waw_plantbar.y = 405;
					self.waw_plantbar setShader("white", 0, 8);
					self.waw_plantbar scaleOverTime(bartime , barsize, 8);
					showBodysearchMessage(false);
					// Play plant sound
					self playsound("moody_plant");
				}
				color = 1;
				for(i = 0; i < planttime * 20 && isdefined(body); i++)
				{
					if( !(self meleeButtonPressed() && origin == self.origin && isAlive(self) && self.sessionstate=="playing") )
						break;

					// Make sure player is in prone or crouch (do after 0.5 second to avoid unwanted crouching while trying to bash someone)
					if(i > 10)
					{
						stance = self getStance();
						if( !self isOnGround() && !(stance == "prone" || stance == "crouch")) self setClientCvar("cl_stance","1");
					}

					self.waw_plantbar.color = (color,color,1);
					color -= 0.05 / planttime;

					wait 0.05;
				}
				// Remove hud elements
				if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
				if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
				if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
				if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
		
				if(i<planttime*20 || !isdefined(body))
				{
					self.waw_checkbodysearch = undefined;
					self enableWeapon();
					return;
				}

				// Is there anything left to find?
				if(body.inventory.size)
				{
					
					found = body.inventory[randomInt(body.inventory.size)];

					// Remove the found item from the inventory
					body.inventory = removeFromArray(body.inventory, found);

					// Found a weapon
					weaponname = maps\mp\gametypes\_teams::getWeaponName(found["item"]);
					self iprintlnbold("You found a " + weaponname + ".");
					// Save old weapon
					temp = self saveWeaponSlot(found["slot"]);
					// Set new
					self restoreWeaponSlot(found);
					// Drop new weapon
					self dropItem(found["item"]);
					// Restore old weapon
					self restoreWeaponSlot(temp);
					
				}
				else
				{
					nothing = [];
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "nothing";
					nothing[nothing.size] = "Deez Nuts";
					nothing[nothing.size] = "Big Dylan's Room";
					nothing[nothing.size] = "some stuff";
					nothing[nothing.size] = "Big D";
					nothing[nothing.size] = "pocket air";
					nothing[nothing.size] = "Chris Taff";
					nothing[nothing.size] = "a deck of cards";
					nothing[nothing.size] = "a hamster";
					nothing[nothing.size] = "a new lifeform";
					nothing[nothing.size] = "Clinton's cigar";
					nothing[nothing.size] = "a beer";
					nothing[nothing.size] = "clean socks";
					nothing[nothing.size] = "something you didn't want";
					nothing[nothing.size] = "the meaning of life";
					self iprintlnbold("You found " + nothing[randomInt(nothing.size)] + ".");
				}

				self enableWeapon();

				break;
			}
			wait .05;

			// Check body
			if(!isdefined(body)) break;

			// Check distance
			distance = distance(body.origin, self.origin);
			if(distance>=range) break;
		}

		// Clean up
		if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
		if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
		if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
		if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

		while(self meleeButtonPressed() && isAlive(self) && self.sessionstate=="playing")
			wait .05;
	}
	self.waw_checkbodysearch = undefined;
}

showBodysearchMessage(which_message)
{
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	self.waw_tripwiremessage = newClientHudElem( self );
	self.waw_tripwiremessage.alignX = "center";
	self.waw_tripwiremessage.alignY = "middle";
	self.waw_tripwiremessage.x = 320;
	self.waw_tripwiremessage.y = 404;
	self.waw_tripwiremessage.alpha = 1;
	self.waw_tripwiremessage.fontScale = 0.80;
	if( which_message )
		self.waw_tripwiremessage.color = (.5,.5,.5);
	self.waw_tripwiremessage setText( level.scavenger_text );

	self.waw_tripwiremessage2 = newClientHudElem(self);
	self.waw_tripwiremessage2.alignX = "center";
	self.waw_tripwiremessage2.alignY = "top";
	self.waw_tripwiremessage2.x = 320;
	self.waw_tripwiremessage2.y = 415;
	self.waw_tripwiremessage2 setShader("gfx/icons/hud@Perk_Scavenger.dds",32,32);
}

anythingToScavenge(player, body)
{
    // get player loadout
    primary       = player getWeaponSlotWeapon("primary");
    primaryb      = player getWeaponSlotWeapon("primaryb");
    pistol        = player getWeaponSlotWeapon("pistol");
    grenade       = player getWeaponSlotWeapon("grenade");
    smokegrenade  = player getWeaponSlotWeapon("smokegrenade");
    satchel       = player getWeaponSlotWeapon("satchel");

    for (i = 0; i < body.inventory.size; i++)
    {
        item = body.inventory[i]["item"];
        if (item == primary ||
            item == primaryb ||
            item == pistol ||
            item == grenade ||
            item == smokegrenade ||
            item == satchel)
        {
            return true;
        }
    }
    return false;
}

checkStickyPlacement(sWeapon)
{
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");

	if(isdefined(self.waw_checkstickyplacement)) return;
	self.waw_checkstickyplacement = true;

	//stay here until player lets go of melee button
	while( isdefined(self) && isAlive( self ) && self.sessionstate=="playing" && self meleeButtonPressed() )
		wait( 0.1 );

	// Check existance and life signs
	if(!isdefined(self) || !isAlive(self) || self.sessionstate!="playing")
	{
		self.waw_checkstickyplacement = undefined;
		return;
	}

	// Make sure player has not gone prone
	stance = self getStance(false);
	if(stance == "prone")
	{
		self.waw_checkstickyplacement = undefined;
		return;
	}

	// Check slot
	if(sWeapon == "satchelcharge_mp")
	{
		model = "xmodel/w_us_grn_satchel_game";
		slot = "satchel";
		aOffset = (90,0,-90);
	}
	else if(sWeapon == "german_smoke_mp")
	{
		model = "xmodel/viewmodel_geballte_ladung";
		slot = "satchel";
		aOffset = (90,0,-90);
	}
	else
	{
		model = getGrenadeModel(sWeapon);
		slot = "grenade";
		aOffset = (0,0,0);
	}

	// Check ammo
	iAmmo = self getWeaponSlotClipAmmo(slot);
	if(!iAmmo)
	{
		self.waw_checkstickyplacement = undefined;
		return;
	}

	switch(stance)
	{
		case "crouch":
			offset = (0,0,40);
			break;
		default:
			offset = (0,0,60);
			break;
	}

	// Get position
	position = self.origin + maps\mp\_utility::vectorScale(anglesToForward(self.angles),50);

	// Check for surface
	roll = 0;
	voffset = 0;
	trace=bulletTrace(self.origin+offset,position+offset,true,self);


	if(trace["fraction"]==1)
	{
		position = self.origin + maps\mp\_utility::vectorScale(anglesToForward(self.angles),35);
		trace=bulletTrace(position+offset, position + offset - (0,0,20),true,self);
		if(trace["fraction"]==1 || (isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "player") )
		{
			self.waw_checkstickyplacement = undefined;
			return;
		}
		voffset = 0;
	}
	else if(level.tripwire_stickynades<2 && isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "player")
	{
		self.waw_checkstickyplacement = undefined;
		return;
	}

	// Decrease grenade ammo
	iAmmo--;
	if(iAmmo)
		self setWeaponSlotClipAmmo(slot, iAmmo);
	else
	{
		self setWeaponSlotClipAmmo(slot, iAmmo);
		self setWeaponSlotWeapon(slot, "none");
		newWeapon = self getWeaponSlotWeapon("primary");
		if(newWeapon=="none") newWeapon = self getWeaponSlotWeapon("primaryb");
		if(newWeapon=="none") newWeapon = self getWeaponSlotWeapon("pistol");
		if(newWeapon!="none") self switchToWeapon(newWeapon);
	}	


	// Spawn grenade/satchel
	stickybomb = spawn("script_model",trace["position"] + (0,0,voffset));
	antinormal = maps\mp\_utility::vectorscale(trace["normal"], -1);
	stickybomb.angles = vectortoangles(antinormal) + aOffset;
	stickybomb setModel(model);

	if(isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "script_vehicle")
	{
		stickybomb linkto(trace["entity"]);
		stickybomb.waw_linked = true;
	}
	else if(level.tripwire_stickynades==2 && isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "player")
	{
		stickybomb linkto(trace["entity"]);
		stickybomb.waw_linked = true;
		stickybomb.waw_linkedto = trace["entity"];
	}

	stickybomb thread monitorSticky(self, sWeapon);

	self.waw_checkstickyplacement = undefined;
}

waitForStickyDamage(maxDamage)
{

	level endon("waw_boot");
	self endon("waw_waitforstickydamage");

	self setTakeDamage(true);
	self.damaged = undefined;

	for(;;)
	{
		self waittill ("damage", dmg, who, dir, point, mod);
		if(dmg>=maxDamage || isdefined(self.damaged)) break;
	}
	self.damaged = true;
}

monitorSticky(owner, sWeapon)
{
	level endon("waw_boot");
	self endon("waw_monitorsticky");

	// Save old team if teamplay
	if(!level.waw_teamplay)
		oldteam = owner.pers["team"];

	if(sWeapon == "satchelcharge_mp")
	{
		delay = 6;
		oDmg = 500;
		iDmg = 20;
		range = 450;
		self thread waitForStickyDamage(150);
	}
	else if(sWeapon == "german_smoke_mp")
	{
		delay = 6;
		oDmg = 500;
		iDmg = 20;
		range = 450;
		self thread waitForStickyDamage(150);
	}
	else
	{
		delay = 4;
		oDmg = 120;
		iDmg = 5;
		range = 350;
		self thread waitForStickyDamage(100);
	}

	wait 0.05;

	self playsound("weap_fraggrenade_pin");

	for(i=1;i<delay*20;i++)
	{
		// Check if linked player has died
		if(isdefined(self.waw_linkedto) && !(isAlive(self.waw_linkedto) && self.waw_linkedto.sessionstate=="playing"))
		{
			self notify("waw_waitforstickydamage");
			if(isdefined(self.waw_linked)) self unlink();
				wait .05;
			self delete();
			return;
		}
		// Check for damage
		if(isdefined(self.damaged)) break;
		wait 0.05;
	}

	self notify("waw_waitforstickydamage");

	// Check that damage owner till exists
	if(isDefined(owner) && isPlayer(owner))
	{
		// I player has switched team and it's teamplay the tripwire is unowned.
		if(isdefined(oldteam) && oldteam == owner.pers["team"])
			eAttacker = owner;
		else if(!isdefined(oldteam))		//Not teamplay
			eAttacker = owner;
		else						//Player has switched team
			eAttacker = self;
	}
	else
		eAttacker = self;

	self setModel("xmodel/weapon_nebelhandgrenate");
	self hide();
	wait .05;
	// play the hit sound
	self playsound("grenade_explode_default");
	// Blow number one
	playfx(level.tripwirefx, self.origin);
	self scriptedRadiusDamage(eAttacker, (0,0,0), sWeapon, range, oDmg, iDmg, false);
	if(isdefined(self.waw_linked)) self unlink();
	wait .05;
	self delete();
}

checkSatchelPlacement()
{
	self notify("waw_checksatchelplacement");
	self endon("waw_checksatchelplacement");
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");

	//stay here until player lets go of melee button
	//keeps mg from accidently being placed as soon as it is picked up
	while( isAlive( self ) && self.sessionstate=="playing" && self meleeButtonPressed() )
		wait( 0.1 );

	showSatchelMessage(level.tripwire_place_string);

	while( isAlive( self ) && self.sessionstate=="playing" && !isdefined(self.waw_turretmessage) )
	{
		sWeapon = self getCurrentWeapon();
		if(sWeapon != "satchelcharge_mp" ) break;

		iAmmo	= self getWeaponSlotClipAmmo("satchel");
		if(iAmmo<1) break;

		stance = self getStance();
		if( !self isOnGround() || !(stance == "prone"))
			break;

		// Get position
		position = self.origin + maps\mp\_utility::vectorScale(anglesToForward(self.angles),15);

		// Check that there is room.
		trace=bulletTrace(self.origin+(0,0,10),position+(0,0,10),false,undefined);
		if(trace["fraction"]!=1) break;
	
		// Find ground
		trace=bulletTrace(position+(0,0,10),position+(0,0,-10),false,undefined);
		if(trace["fraction"]==1) break;
		vPos=trace["position"];

		if( isAlive( self ) && self.sessionstate == "playing" && self meleeButtonPressed() )
		{
			// Check satchel limit
			if(!level.waw_teamplay)
			{
				if(level.tripwire_traps[self.pers["team"]]>=level.tripwire_num_traps)
				{
					self iprintlnbold("Sorry, the maximum number of traps for your team has been reached.");
					// Remove hud elements
					if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
					if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
					return false;
				}
			}
			else
			{
				if(level.tripwire_traps>=level.tripwire_num_traps*2)
				{
					self iprintlnbold("Sorry, the maximum number of traps has been reached.");
					// Remove hud elements
					if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
					if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
					return false;
				}
			}

			// Ok to plant, show progress bar
			origin = self.origin;
			angles = self.angles;

			
			planttime = level.tripwire_plant_time;

			if(isdefined(planttime))
			{
				self disableWeapon();
				if(!isdefined(self.waw_plantbar))
				{
					barsize = 288;
					// Time for progressbar	
					bartime = (float)planttime;

					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

					// Background
					self.waw_plantbarbackground = newClientHudElem(self);				
					self.waw_plantbarbackground.alignX = "center";
					self.waw_plantbarbackground.alignY = "middle";
					self.waw_plantbarbackground.x = 320;
					self.waw_plantbarbackground.y = 405;
					self.waw_plantbarbackground.alpha = 0.5;
					self.waw_plantbarbackground.color = (0,0,0);
					self.waw_plantbarbackground setShader("white", (barsize + 4), 12);			
					// Progress bar
					self.waw_plantbar = newClientHudElem(self);				
					self.waw_plantbar.alignX = "left";
					self.waw_plantbar.alignY = "middle";
					self.waw_plantbar.x = (320 - (barsize / 2.0));
					self.waw_plantbar.y = 405;
					self.waw_plantbar setShader("white", 0, 8);
					self.waw_plantbar scaleOverTime(bartime , barsize, 8);

					showSatchelMessage(level.tripwire_placing_string);

					// Play plant sound
					self playsound("moody_plant");
				}

				color = 1;
				for(i=0;i<planttime*20;i++)
				{
					if( !(self meleeButtonPressed() && origin == self.origin && isAlive(self) && self.sessionstate=="playing") )
						break;
					self.waw_plantbar.color = (1,color,color);
					color -= 0.05 / planttime;
					wait 0.05;
				}

				// Remove hud elements
				if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
				if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
				if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
				if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
		
				self enableWeapon();
				if(i<planttime*20)
					return false;
			}

			// Check tripwire limit
			if(!level.waw_teamplay)
			{
				if(level.tripwire_traps[self.pers["team"]]>=level.tripwire_num_traps)
				{
					self iprintlnbold("Sorry, the maximum number of traps for your team has been reached.");
					return false;
				}
			}
			else
			{
				if(level.tripwire_traps>=level.tripwire_num_traps*2)
				{
					self iprintlnbold("Sorry, the maximum number of tripwires has been reached.");
					return false;
				}
			}

			if(!level.waw_teamplay)
				level.tripwire_traps[self.pers["team"]]++;
			else
				level.tripwire_traps++;

			// Decrease grenade ammo
			iAmmo--;
			if(iAmmo)
				self setWeaponSlotClipAmmo("satchel", iAmmo);
			else
			{
				self setWeaponSlotClipAmmo("satchel", iAmmo);
				self setWeaponSlotWeapon("satchel", "none");
				newWeapon = self getWeaponSlotWeapon("primary");
				if(newWeapon=="none") newWeapon = self getWeaponSlotWeapon("primaryb");
				if(newWeapon=="none") newWeapon = self getWeaponSlotWeapon("pistol");
				if(newWeapon!="none") self switchToWeapon(newWeapon);
			}
	
			// Spawn tripwire
			satchel = spawn("script_model",vPos + (0,0,2.2) );
			satchel.angles = angles + (0,0,-89);
			satchel setModel("xmodel/w_us_grn_satchel_game");

			if(isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "script_vehicle")
			{
				satchel linkto(trace["entity"]);
				satchel.waw_linked = true;
			}

			satchel thread monitorSatchel(self);
			break;
		}
		wait( 0.2 );
	}
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
}

waitForSatchelDamage(maxDamage)
{
	level endon("waw_boot");
	self endon("waw_waitforsatcheldamage");

	self setTakeDamage(true);
	self.damaged = undefined;

	for(;;)
	{
		self waittill ("damage", dmg, who, dir, point, mod);

		if(isdefined(mod))
			printDebug("MOD: " + mod, "debug", "self");

		if(isdefined(who) && isdefined(who.waw_checkdefusesatchel))
			continue;

		if(dmg>=maxDamage || isdefined(self.damaged)  )
			break;
	}
	self.damaged = true;
}

waitForSatchelDetonation(satchel)
{
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");
	satchel endon("waw_waitforsatcheldamage");

	while(isdefined(satchel) && !isdefined(satchel.damaged) && isdefined(self) && isAlive(self) && isPlayer(self))
	{
		if(!self meleeButtonPressed()) break;
		wait 0.05;
	}

	self iprintlnbold("^7Press MELEE and USE to detonate satchel.");
	
	while(isdefined(satchel) && !isdefined(satchel.damaged) && isdefined(self) && isAlive(self) && isPlayer(self))
	{
		if(self meleeButtonPressed() && self useButtonPressed() && !isdefined(self.waw_checkdefusesatchel)) break;
		wait 0.05;
	}
	
	if(isdefined(satchel))
	{
		satchel.damaged = true;
		satchel notify("waw_waitforsatcheldamage");
	}
}

monitorSatchel(owner)
{
	level endon("waw_boot");
	self endon("waw_monitorsatchel");

	wait .05;

	// Save old team if teamplay
	if(!level.waw_teamplay)
		self.oldteam = owner.pers["team"];

	self thread waitForSatchelDamage(150);

	owner thread waitForSatchelDetonation(self);

	range = 20;

	while(isDefined(owner) && isAlive(owner) && owner.sessionstate=="playing")
	{
		blow = undefined;

		// Blow if anyone of the nades has taken enough damage
		if(isdefined(self.damaged))
			blow = true;

		// Loop through players to find out if one has triggered the wire
		players = getentarray("player", "classname"); 
		for(i = 0; i < players.size; i++)
		{
			// Check that player still exist
			if(isDefined(players[i]))
				player = players[i];
			else
				continue;

			// Player? Alive? Playing?
			if(!isPlayer(player) || !isAlive(player) || player.sessionstate != "playing")
				continue;
			
			// Within range?
			distance = distance(self.origin, player.origin);
			if(distance>=range)
				continue;

			// Check for defusal
			if(!isdefined(player.waw_checkdefusetripwire) && !player meleeButtonPressed())
				player thread checkDefuseSatchel(self);

			break;
		}
		// Time to blow?
		if(isdefined(blow)) break;
		wait .05;
	}

	if(!level.waw_teamplay)
		level.waw_satchels[self.oldteam]--;
	else
		level.waw_satchels--;

	self notify("waw_waitforsatcheldamage");

	if(isDefined(owner) && isAlive(owner) && owner.sessionstate=="playing")
	{
		self playsound("weap_fraggrenade_pin");
		wait(.05);

		wait(randomFloat(.5));

		// I player has switched team and it's teamplay the tripwire is unowned.
		if(isdefined(self.oldteam) && self.oldteam == owner.pers["team"])
			eAttacker = owner;
		else if(!isdefined(self.oldteam))		//Not teamplay
			eAttacker = owner;
		else						//Player has switched team
			eAttacker = self;

		self setModel("xmodel/weapon_nebelhandgrenate");
		self hide();
		wait .05;
		// play the hit sound
		self playsound("grenade_explode_default");
		// Blow number one
		playfx(level.tripwirefx, self.origin);
		self scriptedRadiusDamage(eAttacker, (0,0,0), "satchelcharge_mp", 450, 500, 20, false);
	}

	if(isdefined(self.waw_linked)) self unlink();
	wait .05;
	self delete();
}

checkDefuseSatchel(satchel)
{
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");

	// Make sure to only run one instance
	if(isdefined(self.waw_checkdefusesatchel))
		return;

	range = 20;

	stance = self getStance();
	if( !self isOnGround() || !(stance == "prone")) return;
	distance = distance(satchel.origin, self.origin);
	if(distance>=range) return;

	// Ok to defuse, kill checkTripwirePlacement and set up new hud message
	self notify("waw_checktripwireplacement");
	self notify("waw_checksatchelplacement");

	self.waw_checkdefusesatchel = true;

	// Remove hud elements
	if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
	if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waww_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	// Set up new
	showSatchelMessage(level.tripwire_defusing_string);

	// Loop
	for(;;)
	{
		if( isAlive( self ) && self.sessionstate == "playing" && self meleeButtonPressed() )
		{
			// Ok to plant, show progress bar
			origin = self.origin;
			angles = self.angles;

			planttime = level.waw_satchelpicktime;
			

			if(isdefined(planttime))
			{
				self disableWeapon();
				if(!isdefined(self.waw_plantbar))
				{
					barsize = 288;
					// Time for progressbar	
					bartime = (float)planttime;

					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

					// Background
					self.waw_plantbarbackground = newClientHudElem(self);				
					self.waw_plantbarbackground.alignX = "center";
					self.waw_plantbarbackground.alignY = "middle";
					self.waw_plantbarbackground.x = 320;
					self.waw_plantbarbackground.y = 405;
					self.waw_plantbarbackground.alpha = 0.5;
					self.waw_plantbarbackground.color = (0,0,0);
					self.waw_plantbarbackground setShader("white", (barsize + 4), 12);			
					// Progress bar
					self.waw_plantbar = newClientHudElem(self);				
					self.waw_plantbar.alignX = "left";
					self.waw_plantbar.alignY = "middle";
					self.waw_plantbar.x = (320 - (barsize / 2.0));
					self.waw_plantbar.y = 405;
					self.waw_plantbar setShader("white", 0, 8);
					self.waw_plantbar scaleOverTime(bartime , barsize, 8);

					showSatchelMessage(level.tripwire_defusing_string);

					// Play plant sound
					self playsound("moody_plant");
				}

				color = 1;
				for(i=0;i<planttime*20 && isdefined(satchel);i++)
				{
					if( !(self meleeButtonPressed() && origin == self.origin && isAlive(self) && self.sessionstate=="playing") )
						break;

					if(isdefined(self.waw_plantbar))
						self.waw_plantbar.color = (color,1,color);

					color -= 0.05 / planttime;
					wait 0.05;
				}

				// Remove hud elements
				if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
				if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
				if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
				if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
		
				self enableWeapon();
				if(i<planttime*20)
				{
					self.waw_checkdefusesatchel = undefined;
					return;
				}
			}

			if(!level.waw_teamplay)
				level.tripwire_traps[satchel.oldteam]--;
			else
				level.tripwire_traps--;

			// Remove satchel
			satchel notify("waw_monitorsatchel");
			wait .05;
			if(isdefined(satchel))
				satchel delete();

			// Drop current satchel
			if(self getWeaponSlotClipAmmo("satchel"))
				self dropItem("satchelcharge_mp");
	
			// Pick up satchel
			self setWeaponSlotWeapon("satchel","satchelcharge_mp");
			self setWeaponSlotClipAmmo("satchel",1);

			self switchToWeapon("satchelcharge_mp");
			break;
		}
		wait .05;

		// Check prone
		stance = self getStance();
		if( !self isOnGround() || !(stance == "prone")) break;
		// Check nades
		if(!isdefined(satchel))
			break;
		distance = distance(satchel.origin, self.origin);
		if(distance>=range) break;
	}

	// Clean up
	if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
	if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	self.waw_checkdefusesatchel = undefined;
}


//Thread to determine if a player can place grenades
checkTripwirePlacement()
{
	self notify("waw_checktripwireplacement");
	self endon("waw_checktripwireplacement");
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");

	//stay here until player lets go of melee button
	//keeps mg from accidently being placed as soon as it is picked up
	while( isAlive( self ) && self.sessionstate=="playing" && self meleeButtonPressed() )
		wait( 0.1 );

	showTripwireMessage(self getWeaponSlotWeapon("grenade"), level.tripwire_place_string);

	while( isAlive( self ) && self.sessionstate=="playing" && !isdefined(self.waw_turretmessage) )
	{
		sWeapon = self getCurrentWeapon();
		if(!isWeaponType("grenade",sWeapon)) break;

		iAmmo	= self getWeaponSlotClipAmmo("grenade");
		if(iAmmo<2) break;

		stance = self getStance();
		if( !self isOnGround() || !(stance == "prone")) break;

		// Get position
		position = self.origin + maps\mp\_utility::vectorScale(anglesToForward(self.angles),15);

		// Check that there is room.
		trace=bulletTrace(self.origin+(0,0,10),position+(0,0,10),false,undefined);
		if(trace["fraction"]!=1) break;
	
		// Find ground
		trace=bulletTrace(position+(0,0,10),position+(0,0,-10),false,undefined);
		if(trace["fraction"]==1) break;
		if(isdefined(trace["entity"]) && isdefined(trace["entity"].classname) && trace["entity"].classname == "script_vehicle") break;
		position=trace["position"];
		tracestart = position + (0,0,10);

		// Find position1
		traceend = tracestart + maps\mp\_utility::vectorScale(anglesToForward(self.angles + (0,90,0)),50);
		trace=bulletTrace(tracestart,traceend,false,undefined);
		if(trace["fraction"]!="1")
		{
			distance = distance(tracestart,trace["position"]);
			if(distance>5) distance = distance - 2;
			position1=tracestart + maps\mp\_utility::vectorScale(vectorNormalize(trace["position"]-tracestart),distance);
		}
		else
			position1 = trace["position"];

		// Find ground
		trace=bulletTrace(position1,position1+(0,0,-20),false,undefined);
		if(trace["fraction"]==1) break;
		vPos1=trace["position"] + (0,0,3);

		// Find position2
		traceend = tracestart + maps\mp\_utility::vectorScale(anglesToForward(self.angles + (0,-90,0)),50);
		trace=bulletTrace(tracestart,traceend,false,undefined);
		if(trace["fraction"]!="1")
		{
			distance = distance(tracestart,trace["position"]);
			if(distance>5) distance = distance - 2;
			position2=tracestart + maps\mp\_utility::vectorScale(vectorNormalize(trace["position"]-tracestart),distance);
		}
		else
			position2 = trace["position"];

		// Find ground
		trace=bulletTrace(position2,position2+(0,0,-20),false,undefined);
		if(trace["fraction"]==1) break;
		vPos2=trace["position"] + (0,0,3);

		if( isAlive( self ) && self.sessionstate == "playing" && self meleeButtonPressed() )
		{
			// Check tripwire limit
			if(!level.waw_teamplay)
			{
				if(level.tripwire_traps[self.pers["team"]]>=level.tripwire_num_traps)
				{
					self iprintlnbold("Sorry, the maximum number of traps for your team has been reached.");
					// Remove hud elements
					if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
					if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
					return false;
				}
			}
			else
			{
				if(level.tripwire_traps>=level.tripwire_num_traps*2)
				{
					self iprintlnbold("Sorry, the maximum number of tripwires has been reached.");
					// Remove hud elements
					if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
					if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
					return false;
				}
			}

			// Ok to plant, show progress bar
			origin = self.origin;
			angles = self.angles;

			planttime = level.tripwire_plant_time;

			if(isdefined(planttime))
			{
				self disableWeapon();
				if(!isdefined(self.waw_plantbar))
				{
					barsize = 288;
					// Time for progressbar	
					bartime = (float)planttime;

					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

					// Background
					self.waw_plantbarbackground = newClientHudElem(self);				
					self.waw_plantbarbackground.alignX = "center";
					self.waw_plantbarbackground.alignY = "middle";
					self.waw_plantbarbackground.x = 320;
					self.waw_plantbarbackground.y = 405;
					self.waw_plantbarbackground.alpha = 0.5;
					self.waw_plantbarbackground.color = (0,0,0);
					self.waw_plantbarbackground setShader("white", (barsize + 4), 12);			
					// Progress bar
					self.waw_plantbar = newClientHudElem(self);				
					self.waw_plantbar.alignX = "left";
					self.waw_plantbar.alignY = "middle";
					self.waw_plantbar.x = (320 - (barsize / 2.0));
					self.waw_plantbar.y = 405;
					self.waw_plantbar setShader("white", 0, 8);
					self.waw_plantbar scaleOverTime(bartime , barsize, 8);

					showTripwireMessage(self getWeaponSlotWeapon("grenade"), level.tripwire_placing_string);

					// Play plant sound
					self playsound("moody_plant");
				}

				color = 1;
				for(i=0;i<planttime*20;i++)
				{
					if( !(self meleeButtonPressed() && origin == self.origin && isAlive(self) && self.sessionstate=="playing") )
						break;
					self.waw_plantbar.color = (1,color,color);
					color -= 0.05 / planttime;
					wait 0.05;
				}

				// Remove hud elements
				if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
				if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
				if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
				if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
		
				self enableWeapon();
				if(i<planttime*20)
					return false;
			}

			// Check tripwire limit
			if(!level.waw_teamplay)
			{
				if(level.tripwire_traps[self.pers["team"]]>=level.tripwire_num_traps)
				{
					self iprintlnbold("Sorry, the maximum number of traps for your team has been reached.");
					return false;
				}
			}
			else
			{
				if(level.tripwire_traps>=level.tripwire_num_traps*2)
				{
					self iprintlnbold("Sorry, the maximum number of tripwires has been reached.");
					return false;
				}
			}

			if(!level.waw_teamplay)
				level.tripwire_traps[self.pers["team"]]++;
			else
				level.tripwire_traps++;

			// Calc new center
			x = (vPos1[0] + vPos2[0])/2;
			y = (vPos1[1] + vPos2[1])/2;
			z = (vPos1[2] + vPos2[2])/2;
			vPos = (x,y,z);

			// Decrease grenade ammo
			iAmmo--;
			iAmmo--;
			if(iAmmo)
				self setWeaponSlotClipAmmo("grenade", iAmmo);
			else
			{
				self setWeaponSlotClipAmmo("grenade", iAmmo);
				self setWeaponSlotWeapon("grenade", "none");
				newWeapon = self getWeaponSlotWeapon("primary");
				if(newWeapon=="none") newWeapon = self getWeaponSlotWeapon("primaryb");
				if(newWeapon=="none") newWeapon = self getWeaponSlotWeapon("pistol");
				if(newWeapon!="none") self switchToWeapon(newWeapon);
			}
	
			// Spawn tripwire
			tripwire = spawn("script_origin",vPos);
			tripwire.angles = angles;
			tripwire thread monitorTripwire(self, sWeapon, vPos1, vPos2);
			break;
		}
		wait( 0.2 );
	}
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
}

showSatchelMessage(which_message )
{
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	self.waw_tripwiremessage = newClientHudElem( self );
	self.waw_tripwiremessage.alignX = "center";
	self.waw_tripwiremessage.alignY = "middle";
	self.waw_tripwiremessage.x = 320;
	self.waw_tripwiremessage.y = 404;
	self.waw_tripwiremessage.alpha = 1;
	self.waw_tripwiremessage.fontScale = 0.80;
	if( 	(isdefined(level.tripwire_defusing_string) && which_message == level.tripwire_defusing_string) ||
		(isdefined(level.tripwire_placing_string) && which_message == level.tripwire_placing_string) )
		self.waw_tripwiremessage.color = (.5,.5,.5);
	self.waw_tripwiremessage setText( which_message );

	self.waw_tripwiremessage2 = newClientHudElem(self);
	self.waw_tripwiremessage2.alignX = "center";
	self.waw_tripwiremessage2.alignY = "top";
	self.waw_tripwiremessage2.x = 320;
	self.waw_tripwiremessage2.y = 415;
	self.waw_tripwiremessage2 setShader("gfx/icons/hud@satchel.dds",40,40);
}

showTripwireMessage(sWeapon, which_message )
{
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	self.waw_tripwiremessage = newClientHudElem( self );
	self.waw_tripwiremessage.alignX = "center";
	self.waw_tripwiremessage.alignY = "middle";
	self.waw_tripwiremessage.x = 320;
	self.waw_tripwiremessage.y = 404;
	self.waw_tripwiremessage.alpha = 1;
	self.waw_tripwiremessage.fontScale = 0.80;
	if( 	(isdefined(level.tripwire_defusing_string) && which_message == level.tripwire_defusing_string) ||
		(isdefined(level.tripwire_placing_string) && which_message == level.tripwire_placing_string) )
		self.waw_tripwiremessage.color = (.5,.5,.5);
	self.waw_tripwiremessage setText( which_message );

	self.waw_tripwiremessage2 = newClientHudElem(self);
	self.waw_tripwiremessage2.alignX = "center";
	self.waw_tripwiremessage2.alignY = "top";
	self.waw_tripwiremessage2.x = 320;
	self.waw_tripwiremessage2.y = 415;
	self.waw_tripwiremessage2 setShader(getGrenadeHud(sWeapon),40,40);
}

getGrenadeHud(sWeapon)
{
	switch(sWeapon)
	{
		case "fraggrenade_mp":
			model = "gfx/icons/hud@us_grenade.dds";
			break;

		case "mk1britishfrag_mp":
			model = "gfx/icons/hud@british_grenade.dds";
			break;

		case "rgd-33russianfrag_mp":
			model = "gfx/icons/hud@russian_grenade.dds";
			break;	

		default:
			model = "gfx/icons/hud@steilhandgrenate.dds";
			break;
	}
	return model;
}

tripwireWarning()
{
	if(isdefined(self.waw_tripwirewarning))
		return;
	self.waw_tripwirewarning = true;
	self iprintlnbold("^1WARNING! ^7Tripwire!");
	wait 5;
	self.waw_tripwirewarning = undefined;
}

waitForTripwireDamage(maxDamage)
{

	level endon("waw_boot");
	self endon("waw_waitfortripwiredamage");

	self setTakeDamage(true);
	self.damaged = undefined;

	for(;;)
	{
		self waittill ("damage", dmg, who, dir, point, mod);

		if(level.waw_debug && isdefined(mod))
			printDebug("MOD: " + mod,"debug");

		if(dmg>=maxDamage) break;
	}
	self.damaged = true;
}


monitorTripwire(owner, sWeapon, vPos1, vPos2)
{
	level endon("waw_boot");
	self endon("waw_monitortripwire");

	// Save old team if teamplay
	if(!level.waw_teamplay)
		self.oldteam = owner.pers["team"];

	wait .05;

	// Spawn nade one
	self.nade1 = spawn("script_model",vPos1);
	self.nade1 setModel(getGrenadeModel(sWeapon));
	self.nade1.angles = self.angles;
	self.nade1 thread waitForTripwireDamage(100);

	// Spawn nade two
	self.nade2 = spawn("script_model",vPos2);
	self.nade2 setModel(getGrenadeModel(sWeapon));
	self.nade2.angles = self.angles;
	self.nade2 thread waitForTripwireDamage(100);

	// Get detection spots
	vPos3 = self.origin + maps\mp\_utility::vectorScale(anglesToForward(self.angles),50);
	vPos4 = self.origin + maps\mp\_utility::vectorScale(anglesToForward(self.angles + (0,180,0)),50);

	// Get detection ranges
	range = distance(self.origin, vPos1) + 150;
	range2 = distance(vPos3,vPos1) + 2;

	if(isDefined(owner) && isAlive(owner) && owner.sessionstate == "playing")
		owner iprintlnbold("Tripwire activates in ^15 ^7seconds!");

	wait 5;

	for(;;)
	{
		blow = undefined;

		// Blow if anyone of the nades has taken enough damage
		if(isdefined(self.nade1.damaged) || isdefined(self.nade2.damaged))
			blow = true;

		// Loop through players to find out if one has triggered the wire
		players = getentarray("player", "classname"); 
		for(i = 0; i < players.size && !isdefined(blow);i++)
		{
			// Check that player still exist
			if(isDefined(players[i]))
				player = players[i];
			else
				continue;

			// Player? Alive? Playing?
			if(!isPlayer(player) || !isAlive(player) || player.sessionstate != "playing")
				continue;
			
			// Within range?
			distance = distance(self.origin, player.origin);
			if(distance>=range)
				continue;

			// Check for defusal
			if(!isdefined(player.waw_checkdefusetripwire))
				player thread checkDefuseTripwire(self, sWeapon);

			// Stop check if tripwire is safe for teammates.
			if(level.allow_tripwire==3 && (isDefined(self.oldteam) && self.oldteam == player.pers["team"]))
				continue;
			else if(isDefined(self.oldteam) && (self.oldteam != player.pers["team"] || !level.waw_teamplay) && player.pers["perk1_active"] == "bomb_squad_perk")
				player thread tripwireWarning();
			

			// Within sphere one?
			distance = distance(vPos3, player.origin);
			if(distance>=range2)
				continue;

			// Within sphere two?
			distance = distance(vPos4, player.origin);
			if(distance>=range2)
				continue;
			if(player.pers["perk1_active"] == "bomb_squad_perk")
				continue;
			// Time to blow
			blow = true;
			break;
		}
		// Time to blow?
		if(isdefined(blow)) break;
		wait .05;
	}

	if(!level.waw_teamplay)
		level.tripwire_traps[self.oldteam]--;
	else
		level.tripwire_traps--;

	self.nade1 notify("waw_waitfortripwiredamage");
	self.nade2 notify("waw_waitfortripwiredamage");

	if(isdefined(self.nade2.damaged))
	{
		self.nade2 playsound("weap_fraggrenade_pin");
		wait(.05);
		self.nade1 playsound("weap_fraggrenade_pin");
		wait(.05);
	}
	else
	{
		self.nade1 playsound("weap_fraggrenade_pin");
		wait(.05);
		self.nade2 playsound("weap_fraggrenade_pin");
		wait(.05);
	}
	wait(randomFloat(.5));

	// Check that damage owner till exists
	if(isDefined(owner) && isPlayer(owner))
	{
		// I player has switched team and it's teamplay the tripwire is unowned.
		if(isdefined(self.oldteam) && self.oldteam == owner.pers["team"])
			eAttacker = owner;
		else if(!isdefined(self.oldteam))		//Not teamplay
			eAttacker = owner;
		else						//Player has switched team
			eAttacker = self;
	}
	else
		eAttacker = self;

	iMaxdamage = 120;
	iMindamage = 5;

	if(isdefined(self.nade2.damaged))
	{
		// play the hit sound
		self.nade2 playsound("grenade_explode_default");
		// Blow number two
		playfx(level.tripwirefx, self.nade2.origin);
		self.nade2 scriptedRadiusDamage(eAttacker, (0,0,0), sWeapon, 350, iMaxdamage, iMindamage, (level.allow_tripwire>1) );
		wait .05;
		self.nade2 delete();

		// A small, random, delay between the nades
		wait(randomFloat(.25));

		// play the hit sound
		self.nade1 playsound("grenade_explode_default");
		// Blow number one
		playfx(level.tripwirefx, self.nade1.origin);
		self.nade1 scriptedRadiusDamage(eAttacker, (0,0,0), sWeapon, 350, iMaxdamage, iMindamage, (level.allow_tripwire>1) );
		wait .05;
		self.nade1 delete();
	}
	else
	{
		// play the hit sound
		self.nade1 playsound("grenade_explode_default");
		// Blow number one
		playfx(level.tripwirefx, self.nade1.origin);
		self.nade1 scriptedRadiusDamage(eAttacker, (0,0,0), sWeapon, 350, iMaxdamage, iMindamage, (level.allow_tripwire>1) );
		wait .05;
		self.nade1 delete();

		// A small, random, delay between the nades
		wait(randomFloat(.25));

		// play the hit sound
		self.nade2 playsound("grenade_explode_default");
		// Blow number two
		playfx(level.tripwirefx, self.nade2.origin);
		self.nade2 scriptedRadiusDamage(eAttacker, (0,0,0), sWeapon, 350, iMaxdamage, iMindamage, (level.allow_tripwire>1) );
		wait .05;
		self.nade2 delete();
	}
	self delete();
}

checkDefuseTripwire(tripwire, sWeapon)
{
	level endon("waw_boot");
	self endon("waw_spawned");
	self endon("waw_died");

	// Make sure to only run one instance
	if(isdefined(self.waw_checkdefusetripwire))
		return;

	range = 20;

	// Check prone
	stance = self getStance();
		if( !self isOnGround() || !(stance == "prone")) return;
	// Check nades
	distance1 = distance(tripwire.nade1.origin, self.origin);
	distance2 = distance(tripwire.nade2.origin, self.origin);
	if(distance1>=range && distance2>=range) return;

	// Ok to defuse, kill checkTripwirePlacement and set up new hud message
	self notify("waw_checktripwireplacement");
	self notify("waw_checksatchelplacement");

	self.waw_checkdefusetripwire = true;

	// Remove hud elements
	if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
	if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	// Set up new
	showTripwireMessage(sWeapon, level.tripwire_defuse_string);

	// Loop
	for(;;)
	{
		if( isAlive( self ) && self.sessionstate == "playing" && self meleeButtonPressed() )
		{
			// Ok to plant, show progress bar
			origin = self.origin;
			angles = self.angles;

			
			planttime = level.tripwire_defuse_time;

			if(isdefined(planttime))
			{
				self disableWeapon();
				if(!isdefined(self.waw_plantbar))
				{
					barsize = 288;
					// Time for progressbar	
					bartime = (float)planttime;

					if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
					if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

					// Background
					self.waw_plantbarbackground = newClientHudElem(self);				
					self.waw_plantbarbackground.alignX = "center";
					self.waw_plantbarbackground.alignY = "middle";
					self.waw_plantbarbackground.x = 320;
					self.waw_plantbarbackground.y = 405;
					self.waw_plantbarbackground.alpha = 0.5;
					self.waw_plantbarbackground.color = (0,0,0);
					self.waw_plantbarbackground setShader("white", (barsize + 4), 12);			
					// Progress bar
					self.waw_plantbar = newClientHudElem(self);				
					self.waw_plantbar.alignX = "left";
					self.waw_plantbar.alignY = "middle";
					self.waw_plantbar.x = (320 - (barsize / 2.0));
					self.waw_plantbar.y = 405;
					self.waw_plantbar setShader("white", 0, 8);
					self.waw_plantbar scaleOverTime(bartime , barsize, 8);

					showTripwireMessage(sWeapon, level.tripwire_defusing_string);

					// Play plant sound
					self playsound("moody_plant");
				}

				color = 1;
				for(i=0;i<planttime*20 && isdefined(tripwire);i++)
				{
					if( !(self meleeButtonPressed() && origin == self.origin && isAlive(self) && self.sessionstate=="playing") )
						break;

					if(isdefined(self.waw_plantbar))
						self.waw_plantbar.color = (color,1,color);

					color -= 0.05 / planttime;
					wait 0.05;
				}

				// Remove hud elements
				if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
				if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
				if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
				if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
		
				self enableWeapon();
				if(i<planttime*20 || !isdefined(tripwire))
				{
					self.waw_checkdefusetripwire = undefined;
					return;
				}
			}

			if(!level.waw_teamplay)
				level.tripwire_traps[tripwire.oldteam]--;
			else
				level.tripwire_traps--;
			// Remove tripwire
			tripwire notify("waw_monitortripwire");
			wait .05;
			if(isdefined(tripwire.nade1))
				tripwire.nade1 delete();
			if(isdefined(tripwire.nade2))
				tripwire.nade2 delete();
			if(isdefined(tripwire))
				tripwire delete();
			// Pick up grenades
			currentGrenade = self getWeaponSlotWeapon("grenade");
			if(currentGrenade == sWeapon)		// Same type, just increase ammo
			{
				iAmmo = self getWeaponSlotClipAmmo("grenade");
				self setWeaponSlotClipAmmo("grenade",iAmmo + 2);
			}
			else
			{
				// Drop current grenade if it exist and there is ammo
				if(isWeaponType("grenade",currentGrenade) && self getWeaponSlotClipAmmo("grenade") )
					self dropItem(currentGrenade);
				// Pick defused grenades
				self setWeaponSlotWeapon("grenade",sWeapon);
				self setWeaponSlotClipAmmo("grenade",2);
			}
			break;
		}
		wait .05;

		// Check prone
		stance = self getStance();
		if( !self isOnGround() || !(stance == "prone")) break;
		// Check nades
		if(!isdefined(tripwire.nade1) || !isdefined(tripwire.nade2))
			break;
		distance1 = distance(tripwire.nade1.origin, self.origin);
		distance2 = distance(tripwire.nade2.origin, self.origin);
		if(distance1>=range && distance2>=range) break;
	}

	// Clean up
	if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
	if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();

	self.waw_checkdefusetripwire = undefined;
}

getGrenadeModel(sWeapon)
{
	switch(sWeapon)
	{
		case "fraggrenade_mp":
			model = "xmodel/weapon_MK2FragGrenade";
			break;

		case "mk1britishfrag_mp":
			model = "xmodel/weapon_british_handgrenade";
			break;

		case "rgd-33russianfrag_mp":
			model = "xmodel/weapon_russian_handgrenade";
			break;	

		default:
			model = "xmodel/weapon_nebelhandgrenate";
			break;
	}
	return model;
}

scriptedRadiusDamage(eAttacker, vOffset, sWeapon, iRange, iMaxDamage, iMinDamage, ignoreTK)
{
	if(!isdefined(vOffset))
		vOffset = (0,0,0);
	
	if(isdefined(sWeapon) && (isWeaponType("grenade",sWeapon) || sWeapon == "satchelcharge_mp") )
	{
		sMeansOfDeath = "MOD_GRENADE_SPLASH";
		iDFlags = 1;
	}
	else
	{
		sMeansOfDeath = "MOD_EXPLOSIVE";
		iDFlags = 1;
	}

	// Loop through players
	players = getentarray("player", "classname"); 
	for(i = 0; i < players.size; i++)
	{
		if(!isdefined(players[i]))
			continue;

		// Check that player is in range
		distance = distance((self.origin + vOffset), players[i].origin);
		if(distance>=iRange || players[i].sessionstate != "playing" || !isAlive(players[i]) )
			continue;

		if(players[i] != self && !(isdefined(self.waw_linkedto) && self.waw_linkedto == players[i]))
		{
			percent = (iRange-distance)/iRange;
			iDamage = iMinDamage + (iMaxDamage - iMinDamage)*percent;

			stance = players[i] getStance(false);
			switch(stance)
			{
				case "prone":
					offset = (0,0,5);
					break;
				case "crouch":
					offset = (0,0,35);
					break;
				default:
					offset = (0,0,55);
					break;
			}

			traceorigin = players[i].origin + offset;

			trace = bullettrace(self.origin + vOffset, traceorigin, true, self);
			// Damage blocked by entity, remove 40%
			if(isdefined(trace["entity"]) && trace["entity"] != players[i])
				iDamage = iDamage * .6;
			// Damage blocked by other stuff(walls etc...), remove 80%
			else if(!isdefined(trace["entity"]))
				iDamage = iDamage * .2;

			// Reduce damage with 80% if in a vehicle
			if(players[i] IsInVehicle())
				iDamage = iDamage * .2;

			vDir = vectorNormalize(traceorigin - (self.origin + vOffset));
		}
		else
		{
			iDamage = iMaxDamage;
			vDir=(0,0,1);
		}
		if(ignoreTK && isPlayer(eAttacker) && !level.waw_teamplay && isdefined(eAttacker.pers["team"]) && isdefined(players[i].pers["team"]) && eAttacker.pers["team"] == players[i].pers["team"])
			players[i] thread [[level.callbackPlayerDamage]](self, self, iDamage, iDFlags, sMeansOfDeath, sWeapon, undefined, vDir, "none");
		else
			players[i] thread [[level.callbackPlayerDamage]](self, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, undefined, vDir, "none");
	}

	// Loop through all entities and cause damage
	entities = getentarray();
	for(i=0;i<entities.size;i++)
	{
		// Is it defined and not a player?
		if( !isdefined(entities[i]) || isPlayer(entities[i]) )
			continue;

		// Check that entity is in range
		distance = distance((self.origin + vOffset), entities[i].origin);
		if(distance>=iRange)
			continue;

		// Calculate damage
		if(entities[i] != self)
		{
			// bullet trace
			traceorigin = entities[i].origin;
			trace = bullettrace(self.origin + vOffset, traceorigin, true, self);

			// Nothing blocked the damage
			if(isdefined(trace["entity"]) && trace["entity"] == entities[i])
			{
				// get new distance and new damage position if we hit the entity directly
				pos = trace["position"];
				distance = distance((self.origin + vOffset), pos);

				// Calculate damage falloff
				percent = (iRange-distance)/iRange;
				iDamage = iMinDamage + (iMaxDamage - iMinDamage)*percent;

				// Increase damage for vehicles
				if(isdefined(entities[i].classname) && entities[i].classname == "script_vehicle")
					iDamage = iDamage * 2.2;

// For reference: radiusDamage( explosion_origin, 300, 80, 10, attacker, inflictor);

				// Cause a small radiusdamage
				if(iDamage > 0)
				{
					// Do radius damage at traced point
					if(isdefined(entities[i].health))
						oldhealth = entities[i].health;
					radiusDamage(pos, 5, iDamage, iDamage, eAttacker, self);
					// Fallback in case something blocked the damage on a vehicle
					if(isdefined(entities[i].health) && isdefined(entities[i].classname) && entities[i].classname == "script_vehicle" && entities[i].health == oldhealth)
						radiusDamage(entities[i].origin, 5, iDamage, iDamage, eAttacker, self);
				}
			}
			else  // Something blocked the damage
			{
				distance = distance((self.origin + vOffset), entities[i].origin);

				// Calculate damage falloff
				percent = (iRange-distance)/iRange;
				iDamage = iMinDamage + (iMaxDamage - iMinDamage)*percent;

				// Increase damage for vehicles
				if(isdefined(entities[i].classname) && entities[i].classname == "script_vehicle")
					iDamage = iDamage * 2.2;

				// Damage blocked by entity, remove 40%
				if(isdefined(trace["entity"]))
					iDamage = iDamage * .6;
				// Damage blocked by other stuff(walls etc...), remove 80%
				else
					iDamage = iDamage * .2;

				// Cause a small radiusdamage
				if(iDamage > 0)
					radiusDamage(entities[i].origin, 5, iDamage, iDamage, eAttacker, self);
			}
		}
	}
}
/******************************************************************************
END PERK FUNCTIONS

START HUD FUNCTIONS
*******************************************************************************/
cleanUpPlayer()
{
	// destroy any old icons
    if (isDefined(self.perkHudList))
    {
        for (i = 0; i < self.perkHudList.size; i++)
           self.perkHudList[i] destroy();
	    self.perkHudList destroy();
    }
	
	if (isDefined(self.ksHudTicks))
    {
        for (i = 0; i < self.ksHudTicks.size; i++)
           self.ksHudTicks[i] destroy();
	    self.ksHudTicks destroy();
    }
	
	if (isDefined(self.ksHudDraw))
		self.ksHudDraw destroy();
	
	// Remove hud elements
	if (isDefined(self.waw_painscreen))		self.waw_painscreen destroy();
	if(isdefined(self.waw_plantbarbackground)) self.waw_plantbarbackground destroy();
	if(isdefined(self.waw_plantbar))		 self.waw_plantbar destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
	if(isdefined(self.waw_dropfirstaid))	self.waw_dropfirstaid destroy();
	if(isdefined(self.waw_gettingfirstaid))	self.waw_gettingfirstaid destroy();
	if(isdefined(self.waw_firstaidicon))	self.waw_firstaidicon destroy();
	if(isdefined(self.waw_firstaidkits)) 	self.waw_firstaidkits destroy();
	if(isdefined(self.waw_turretmessage))	self.waw_turretmessage destroy();
	if(isdefined(self.waw_turretmessage2))	self.waw_turretmessage2 destroy();
	if(isdefined(self.waw_tripwiremessage))	self.waw_tripwiremessage destroy();
	if(isdefined(self.waw_tripwiremessage2))	self.waw_tripwiremessage2 destroy();
	if(isdefined(self.waw_pickbarbackground))	self.waw_pickbarbackground destroy();
	if(isdefined(self.waw_pickbar))		self.waw_pickbar destroy();
	
	//reset variables
	self.killstreak = 0;
}

// ----------------------------------------------------------------------------------
//	drawPerkHUDElements
//
// 		draws the active perks to the player UI
// ----------------------------------------------------------------------------------
drawPerkHUDElements()
{
	
    self.perkHudList = [];

    // adjust these to taste — baseX should be just to the right of your rank/stance icons
    baseX =  140;    // e.g. rank icon is ~32px wide + 32px padding
    baseY =   436;    // align with bottom of stance icon
    iconSize = 32;  // assuming your DDS is 16×16; change if it’s 24×24 etc.
    padding  =  2;

    // loop through your three perk slots
    for (i = 3; i > 0; i--)
    {
        key = "perk" + i + "_active";
        perk = self.pers[key];

        
		switch (perk)
		{
			//perk 1
			case "extra_equipment_perk":
				shader = "gfx/icons/hud@Perk_Weapon_Satchel.dds";
				break;
			case "tripwire_perk":
				shader = "gfx/icons/hud@Perk_Tripwire.dds";
				break;
			case "bomb_squad_perk":
				shader = "gfx/icons/hud@Perk_Detectexplosives.dds";
				break;
			//perk 2
			case "extra_smoke_perk":
				shader = "gfx/icons/hud@Perk_Specialgrenade.dds";
				break;
			case "extra_grenade_perk":
				shader = "gfx/icons/hud@Perk_ExtraGrenade.dds";
				break;
			case "extra_ammo_perk":
				shader = "gfx/icons/hud@Perk_Extraammo.dds";
				break;
			//perk 3
			case "marathon_perk":
				shader = "gfx/icons/hud@Perk_Longersprint.dds";
				break;
			case "medic_perk":
				shader = "gfx/icons/hud@Perk_Medic.dds";
				break;
			case "scavenger_perk":
				shader = "gfx/icons/hud@Perk_Scavenger.dds";
				break;
			default:
				shader = "";
		}
		if (shader != "")
		{
			// create one new HUD elem for this perk
			hud = newClientHudElem(self);
			hud.alignX   = "left";
			hud.alignY   = "top";
			hud.x           = baseX;
			hud.y           = baseY;
			hud setShader(shader, iconSize, iconSize);

			// save it so we can destroy next time
			self.perkHudList[self.perkHudList.size] = hud;

			// advance X for the next icon
			baseY -= iconSize + padding;
		} 
    }
}

drawKsHUDElements()
{
	//draw kill streak
	if(!isDefined(self.killstreakAwarded))
	{
		printDebug("No Killstreak is Awarded", "info","self");
		switch(self.pers["killstreak_active"])
		{
			case "artillery":
				killstreakIcon = "gfx/icons/hud@Killstreak_Artillery.dds";
				break;
			case "mg":
				killstreakIcon = "ui_mp/assets/hud@mg42_dep_z.dds";
				break;
			case "motorcycle":
			case "firebomb":
			default:
				killstreakIcon = "";
		}
	}
	else
	{
		printDebug(self.killstreakAwarded + " Killstreak is Awarded", "info","self");
		switch(self.killstreakAwarded)
		{
			case "artillery":
				killstreakIcon = "gfx/icons/hud@Killstreak_Artillery.dds";
				break;
			case "mg":
				killstreakIcon = "ui_mp/assets/hud@mg42_dep_z.dds";
				break;
			case "motorcycle":
			case "firebomb":
			default:
				killstreakIcon = "";
		}
	}
	
	printDebug("killstreakIcon is set to " + killstreakIcon, "debug", "self");
	if(!isDefined(self.ksHudDraw))
		self.ksHudDraw = newClientHudElem(self);
	self.ksHudDraw.x = 174;
	self.ksHudDraw.y = 436;
	
	self.ksHudDraw setShader(killstreakIcon, 32,32);
	
	if(isDefined(self.killstreakAwarded))
		self.ksHudDraw.alpha = 1;
	else
		self.ksHudDraw.alpha = 0.75;
	
}
/*********************************************************************************
END HUD FUNCTIONS

START UTIL FUNCTIONS
**********************************************************************************/
// ------------------------------------------------------------------------------------------------------------
//	printDebug
//
// 		message = message to print
//		loglevel = severity level of the message (values = info, warning, error, debug)
//		scope = scope of the message (should it be printed to self or to whole server, values = self, server)
//		
//		if the appropriate debug level is set in server cfg then announces message to appropriate scope
// -----------------------------------------------------------------------------------------------------------
printDebug(message,loglevel,scope)
{
	
	//if debug not enabled do nothing
	if(level.waw_debug == "")
		return;
	
	//check log level against debug level
	switch(level.waw_debug)
	{
		case "debug":
			//print debug msgs ignore everything else
			switch(loglevel)
			{
				case "debug":
					announceMessage("^6DEBUG: " + "^7" + message, scope);
					break;
				default:
					return;
			}
			break;
		case "error":
			//print debug and error msgs, ignore everything else
			switch(loglevel)
			{
				case "debug":
					announceMessage("^6DEBUG: " + "^7" + message, scope);
					break;
				case "error":
					announceMessage("^1ERROR: " + "^7" + message, scope);
					break;
				default:
					return;
			}
			break;
		case "warning":
			//print debug warning and error msgs, ignore info
			switch(loglevel)
			{
				case "debug":
					announceMessage("^6DEBUG: " + "^7" + message, scope);
					break;
				case "warning":
					announceMessage("^3WARNING: " + "^7" + message, scope);
					break;
				case "error":
					announceMessage("^1ERROR: " + "^7" + message, scope);
					break;
				default:
					return;
			}
			break;
		case "info":
			//print everything
			switch(loglevel)
			{
				case "debug":
					announceMessage("^6DEBUG: " + "^7" + message, scope);
					break;
				case "warning":
					announceMessage("^3WARNING: " + "^7" + message, scope);
					break;
				case "error":
					announceMessage("^1ERROR: " + "^7" + message, scope);
					break;
				case "info":
				default:
					announceMessage("^5INFO: " + "^7" + message, scope);
			}
			break;
		default:
			return;
	}
}

// ------------------------------------------------------------------------------------------------------------
//	announceMessage
//
// 		message = message to print
//		scope = scope of the message (should it be printed to self or to whole server, values = self, server)
//		
//		announces message to appropriate scope
// -----------------------------------------------------------------------------------------------------------
announceMessage(message, scope, bold)
{
	if(!isDefined(bold))
		bold = false;
	//if scope is set to self then keep announcement to self, otherwise announce to whole server
	if(isdefined(scope) && scope == "self")
	{
		if(bold)
			self iprintlnbold(message);
		else
			self iprintln(message);
	}
	else
	{
		if(bold)
			iprintlnbold(message);
		else
			iprintln(message);
	}	
}

getHitLocTag(hitloc)
{
	switch(hitloc)
		{
		case "right_hand":
			return "Bip01 R Hand";
			break;

		case "left_hand":
			return "Bip01 L Hand";
			break;
	
		case "right_arm_upper":	
			return "Bip01 R UpperArm";
			break;

		case "right_arm_lower":	
			return "Bip01 R Forearm";
			break;

		case "left_arm_upper":
			return "Bip01 L UpperArm";
			break;

		case "left_arm_lower":
			return "Bip01 L Forearm";
			break;

		case "head":
			return "Bip01 Head";
			break;

		case "neck":
			return "Bip01 Neck";
			break;
	
		
		case "right_foot":
			return "Bip01 R Foot";
			break;

		case "left_foot":
			return "Bip01 L Foot";
			break;

		case "right_leg_lower":
			return "TAG_SHIN_RIGHT";
			break;

		case "left_leg_lower":
			return "TAG_SHIN_left";
			break;

		case "right_leg_upper":
			return "Bip01 R Thigh";
			break;
					
		case "left_leg_upper":
			return "Bip01 L Thigh";
			break;
		case "torso_upper":
			return "TAG_BREASTPOCKET_LEFT";
			break;	
		
		case "torso_lower":
			return "TAG_BELT_FRONT";
			break;

		default:
			return "Bip01 Pelvis";
			break;	
	}
}

getHitLocName(hitloc)
{
	switch(hitloc)
		{
		case "right_hand":	return "Right  Hand";
		case "left_hand":		return "Left Hand";
		case "right_arm_upper":	return "Right Upper Arm";
		case "right_arm_lower":	return "Right Forearm";
		case "left_arm_upper":	return "Left Upper Arm";
		case "left_arm_lower":	return "Left Forearm";
		case "head":		return "Head";
		case "neck":		return "Neck";
		case "right_foot":	return "Right Foot";
		case "left_foot":		return "Left Foot";
		case "right_leg_lower":	return "Right Lower Leg";
		case "left_leg_lower":	return "Left Lower Leg";
		case "right_leg_upper":	return "Right Upper Leg";
		case "left_leg_upper":	return "Left Upper Leg";
		case "torso_upper":	return "Upper Torso";
		case "torso_lower":	return "Lower Torso";
		default:			return hitloc;
	}
}

saveWeaponSlot(slot)
{
	temp["item"] = self getWeaponSlotWeapon(slot);	
	temp["slot"] = slot;
	temp["ammo"] = self getWeaponSlotAmmo(slot);	
	temp["clip"] = self getWeaponSlotClipAmmo(slot);	

	return temp;
}

restoreWeaponSlot(savedslot)
{
	self setWeaponSlotWeapon(savedslot["slot"],savedslot["item"]);
	self setWeaponSlotAmmo(savedslot["slot"],savedslot["ammo"]);
	self setWeaponSlotClipAmmo(savedslot["slot"],savedslot["clip"]);
}

removeFromArray(array, index)
{
	newarray = [];
	for(i=0;i<array.size;i++)
	{
		if(i == index)
			continue;
		newarray[newarray.size] = array[i];
	}
	return newarray;
}

isWeaponType(type,weapon)
{
	switch(type)
	{
		case "turret":
			switch(weapon)
			{
				case "mg42_bipod_duck_mp":
				case "mg42_bipod_prone_mp":
				case "mg42_bipod_stand_mp":
				case "mg42_tank_mp":
				case "mg42_turret_mp":
				case "30cal_tank_mp":
				case "50cal_tank_mp":
				case "mg34_tank_mp":
				case "mg50cal_tripod_stand_mp":
				case "mg_sg43_stand_mp":
				case "sg43_tank_mp":
				case "sg43_turret_mp":
				case "maxim_prone_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		case "rocket":
			switch(weapon)
			{
				case "panzerfaust_mp":
				case "panzerschreck_mp":
				case "bazooka_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;
			
		case "common":
			switch(weapon)
			{
				case "fg42_mp":
				case "panzerfaust_mp":
				case "panzerschreck_mp":
				case "flamethrower_mp":
				case "bazooka_mp":
				case "smokegrenade_mp":
				case "flashgrenade_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is a grenade
		case "grenade":
			switch(weapon)
			{
				case "fraggrenade_mp":
				case "mk1britishfrag_mp":
				case "rgd-33russianfrag_mp":
				case "stielhandgranate_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is smoke/flash grenade
		case "smokegrenade":
			switch(weapon)
			{
				case "smokegrenade_mp":
				case "flashgrenade_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is a rifle
		case "rifle":
			switch(weapon)
			{
				case "m1carbine_mp":
				case "m1garand_mp":
				case "mosin_nagant_mp":
				case "svt40_mp":
				case "kar98k_mp":
				case "gewehr43_mp":
				case "enfield_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is a bolt action rifle
		case "boltrifle":
			switch(weapon)
			{
				case "m1carbine_mp":
				case "mosin_nagant_mp":
				case "kar98k_mp":
				case "enfield_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is a semi automatic rifle
		case "semirifle":
			switch(weapon)
			{
				case "m1garand_mp":
				case "svt40_mp":
				case "gewehr43_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is smg
		case "smg":
			switch(weapon)
			{
				case "mp40_mp":
				case "sten_mp":
				case "thompson_mp":
				case "ppsh_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is assault
		case "assault":
			switch(weapon)
			{
				case "mp44_mp":
				case "bar_mp":
				case "bren_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is sniper
		case "sniper":
			switch(weapon)
			{
				case "mosin_nagant_sniper_mp":
				case "springfield_mp":
				case "kar98k_sniper_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is lmg
		case "lmg":
			switch(weapon)
			{
				case "dp28_mp":
				case "mg34_mp":
				case "mg30cal_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is flamethrower
		case "ft":
			switch(weapon)
			{
				case "flamethrower_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is rocket launcher
		case "rl":
			switch(weapon)
			{
				case "panzerschreck_mp":
				case "bazooka_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is an FG42
		case "fg42":
			switch(weapon)
			{
				case "fg42_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is pistol
		case "pistol":
			switch(weapon)
			{
				case "colt_mp":
				case "luger_mp":
				case "tt33_mp":
				case "webley_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is american
		case "american":
			switch(weapon)
			{
				case "fraggrenade_mp":
				case "colt_mp":
				case "m1carbine_mp":
				case "m1garand_mp":
				case "thompson_mp":
				case "bar_mp":
				case "springfield_mp":
				case "mg30cal_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is british
		case "british":
			switch(weapon)
			{
				case "mk1britishfrag_mp":
				case "webley_mp":
				case "enfield_mp":
				case "sten_mp":
				case "bren_mp":
				case "springfield_mp":
				case "mg30cal_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is russian
		case "russian":
			switch(weapon)
			{
				case "rgd-33russianfrag_mp":
				case "tt33_mp":
				case "mosin_nagant_mp":
				case "svt40_mp":
				case "ppsh_mp":
				case "mosin_nagant_sniper_mp":
				case "dp28_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		// Check if weapon is german
		case "german":
			switch(weapon)
			{
				case "stielhandgranate_mp":
				case "luger_mp":
				case "kar98k_mp":
				case "gewehr43_mp":
				case "mp40_mp":
				case "mp44_mp":
				case "mg34_mp":
				case "kar98k_sniper_mp":
					return true;
					break;
				default:
					return false;
					break;
			}
			break;

		default:
			return false;
			break;
	}
}
