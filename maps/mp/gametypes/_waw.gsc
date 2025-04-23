/************************************************************************
Big Ben's World at Weaps by kmstrube

extending UO to support features of various mods and later titles

acknowledgements:
	Big Ben: for original Big Ben's All Weapons
	placeholder: Tripwires, bleedout, cavity search taken from AWE MOD
	placeholder: molotov, mustard gas, blood effects taken from merciless mod
	Elvis: many weapons from Big Ben's All Weaps are taken from his work
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

wawSpawnPlayer()
{
	//cleanup hud elements
	cleanUpPlayer();
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
	
	if(isDefined(sWeapon) && sWeapon == "mustardgas_mp" || sWeapon == "cocktail_mp")
	{
		if(sWeapon == "cocktail_mp" && sMeansOfDeath != "MOD_MELEE")
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
	if(sWeapon != "mp_mustardgas" || sWeapon != "cocktail_mp")
		self maps\mp\gametypes\_shellshock_gmi::DoShellShock(sWeapon, sMeansOfDeath, sHitLoc, iDamage);
	
}

wawPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	//Track Killstreak
	self.killstreak = 0;
	attacker.killstreak++;
	attacker printDebug("Current killstreak is " + attacker.killstreak, "debug", "self");
	
	if(attacker.killstreak != 0 && attacker.killstreak % 10 == 0)
	{
		//announce to the server that attacker is on a killstreak
		announceMessage("Someboyd is on a 10 killstreak","server");
	}
}

monitorKillstreak()
{
	self endon("spawned");
	self endon("died");
	
	self.ksHudTicks = [];
	
	notick = "gfx/icons/hud@killtickempty.tga";
	killtick = "gfx/icons/hud@killtickfull.tga";

	//If not print KS moniter
	if(!isDefined(self.killstreakAwarded))
	{
		//get killstreak award score
		switch(self.pers["killstreak_active"])
		{
			case "artillery":
				killstreakAwardScore = level.kills_artillery;
				break;
			case "motorcycle":
			case "mg":
			case "firebomb":
			default:
				killstreakAwardScore = 5; //level.killstreak_numkills; //default 5
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
				case "motorcycle":
				case "mg":
				case "firebomb":
				default:
					killstreakAwardScore = 5; //level.killstreak_numkills; //default 5
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
				break;
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
			case "bombsquad_perk":
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
			case "motorcycle":
			case "mg":
			case "firebomb":
			default:
				killstreakIcon = "gfx/icons/hud@Killstreak_Artillery.dds";
		}
	}
	else
	{
		printDebug(self.killstreakAwarded + " Killstreak is Awarded", "info","self");
		switch(self.killstreakAwarded)
		{
			case "artillery":
			case "motorcycle":
			case "mg":
			case "firebomb":
			default:
				killstreakIcon = "gfx/icons/hud@Killstreak_Artillery.dds";
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
	if(scope == "self")
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