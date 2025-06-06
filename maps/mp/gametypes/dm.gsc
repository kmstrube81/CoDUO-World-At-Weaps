/*
	Deathmatch
	Objective: 	Score points by eliminating other players
	Map ends:	When one player reaches the score limit, or time limit is reached
	Respawning:	No wait / Away from other players

	Level requirements
	------------------
		Spawnpoints:
			classname		mp_deathmatch_spawn
			All players spawn from these. The spawnpoint chosen is dependent on the current locations of enemies at the time of spawn.
			Players generally spawn away from enemies.

		Spectator Spawnpoints:
			classname		mp_deathmatch_intermission
			Spectators spawn from these and intermission is viewed from these positions.
			Atleast one is required, any more and they are randomly chosen between.

	Level script requirements
	-------------------------
		Team Definitions:
			game["allies"] = "american";
			game["axis"] = "german";
			Because Deathmatch doesn't have teams with regard to gameplay or scoring, this effectively sets the available weapons.
	
		If using minefields or exploders:
			maps\mp\_load::main();
		
	Optional level script settings
	------------------------------
		Soldier Type and Variation:
			game["american_soldiertype"] = "airborne";
			game["american_soldiervariation"] = "normal";
			game["german_soldiertype"] = "wehrmacht";
			game["german_soldiervariation"] = "normal";
			This sets what models are used for each nationality on a particular map.
			
			Valid settings:
				american_soldiertype		airborne
				american_soldiervariation	normal, winter
				
				british_soldiertype		airborne, commando
				british_soldiervariation	normal, winter
				
				russian_soldiertype		conscript, veteran
				russian_soldiervariation	normal, winter
				
				german_soldiertype		waffen, wehrmacht, fallschirmjagercamo, fallschirmjagergrey, kriegsmarine
				german_soldiervariation		normal, winter

		Layout Image:
			game["layoutimage"] = "yourlevelname";
			This sets the image that is displayed when players use the "View Map" button in game.
			Create an overhead image of your map and name it "hud@layout_yourlevelname".
			Then move it to main\levelshots\layouts. This is generally done by taking a screenshot in the game.
			Use the outsideMapEnts console command to keep models such as trees from vanishing when noclipping outside of the map.
*/

/*QUAKED mp_deathmatch_spawn (1.0 0.5 0.0) (-16 -16 0) (16 16 72)
Players spawn away from enemies at one of these positions.
*/

/*QUAKED mp_deathmatch_intermission (1.0 0.0 1.0) (-16 -16 -16) (16 16 16)
Intermission is randomly viewed from one of these positions.
Spectators spawn randomly at one of these positions.
*/
/*
//////////////////////////////////////////////////////////////
// FOR FUTURE REFERENCE
// THIS IS WHAT NEEDS TO HAPPEN TO PORT THE NEW MENUS
//	IN MAIN FUNCTION-
	maps\mp\gametypes\_cvars::initServerCvars();
// IN START GAME TYPE FUNCTION-
//		ADD weapon cvar init
  maps\mp\gametypes\_cvars::initWeaponCvars();
  thread maps\mp\gametypes\_cvars::updateWeaponCvars();
//		ADD NEW MENU PRECACHE
//CUSTOM MENU LOAD//////////////////////////////////////////////////////////
	maps\mp\gametypes\_newmenus::precacheNewMenus(game["allies"],game["axis"]);	
////////////////////////////////////////////////////////////////////////////
// IN PLAYER CONNECT FUNCTION-
// init primary selected cvar
	self setClientCvar("ui_primary_selected", "0");
self.pers["firstspawn"] = false;
//		COMMENT OUT LOADOUT CLEAR LINE ON TEAM CHANGE
//		ADD FOLOWING LINE AFTER COMMENTING LOAD OUT CLEAR ON SPECTATE
self.pers["firstspawn"] = false;
//set default loadout to allies
self maps\mp\gametypes\_loadout_gmi::updateDefaultLoadout(game["allies"]);

//set default loadout to axis
self maps\mp\gametypes\_loadout_gmi::updateDefaultLoadout(game["axis"]);

//change new weapon menu handling
else if( maps\mp\gametypes\_newmenus::isWeaponMenu(menu) )

//add confirm spawn and update attachment
			if(response == "confirm"){
				menu_spawn(weapon);
			}
			
//			//updateAttachment
			response = self maps\mp\gametypes\_loadout_gmi::updateAttachment(response);
//updateLoadout
			self maps\mp\gametypes\_loadout_gmi::updateLoadout(weapon);
			//menu_spawn(weapon);

////////////////////////////////////////////////
// CUSTOM MENU ACTIONS
////////////////////////////////////////////////		
		else if(menu == game["menu_pause"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;
			}
	}	
////////////////////////////////////////////////
// End Custom Menus
///////////////////////////////////////////////
// IN PLAYER DAMAGE AFTER iDAMAGE but BEFORE FINISH PLAYER DAMAGE
 maps\mp\gametypes\_waw::wawPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
// IN PLAYER KILLED TOWARD BEGINING
 maps\mp\gametypes\_waw::wawPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc);
// IN MENU_SPAWN FUNCTION-
//		REPLACE WEAPON CHECK WITH THIS
if(!self.pers["firstspawn"])
{
	self.pers["firstspawn"] = true;
	spawnPlayer();
}
// In END OF SPAWNPLAYER
maps\mp\gametypes\_waw::wawSpawnPlayer();
//IN SPAWNSPECTATOR
maps\mp\gametypes\_waw::wawSpawnSpectator();
// IN END MAP FIRST LINE
maps\mp\gametypes\_mapvote::Initialize();

//ADD 4-22
//	IN MAIN FUNCTION-
	maps\mp\gametypes\_cvars::initServerCvars();
// IN PLAYER DAMAGE AFTER iDAMAGE but BEFORE FINISH PLAYER DAMAGE
 maps\mp\gametypes\_waw::wawPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);
// IN PLAYER KILLED TOWARD BEGINING
 maps\mp\gametypes\_waw::wawPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc);
// In END OF SPAWNPLAYER
maps\mp\gametypes\_waw::wawSpawnPlayer();
//IN SPAWNSPECTATOR
maps\mp\gametypes\_waw::wawSpawnSpectator();
*/
main()
{
	spawnpointname = "mp_deathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	
	if(!spawnpoints.size)
	{
		maps\mp\gametypes\_callbacksetup::AbortLevel();
		return;
	}

	for(i = 0; i < spawnpoints.size; i++)
		spawnpoints[i] placeSpawnpoint();

	level.callbackStartGameType = ::Callback_StartGameType;
	level.callbackPlayerConnect = ::Callback_PlayerConnect;
	level.callbackPlayerDisconnect = ::Callback_PlayerDisconnect;
	level.callbackPlayerDamage = ::Callback_PlayerDamage;
	level.callbackPlayerKilled = ::Callback_PlayerKilled;

	maps\mp\gametypes\_callbacksetup::SetupCallbacks();

	allowed[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(allowed);
	
	maps\mp\gametypes\_rank_gmi::InitializeBattleRank();
	maps\mp\gametypes\_secondary_gmi::Initialize();
	
	maps\mp\gametypes\_cvars::initServerCvars();
	
	if(getCvar("scr_dm_timelimit") == "")		// Time limit per map
		setCvar("scr_dm_timelimit", "30");
	else if(getCvarFloat("scr_dm_timelimit") > 1440)
		setCvar("scr_dm_timelimit", "1440");
	level.timelimit = getCvarFloat("scr_dm_timelimit");
	setCvar("ui_dm_timelimit", level.timelimit);
	makeCvarServerInfo("ui_dm_timelimit", "30");

	if(getCvar("scr_dm_scorelimit") == "")		// Score limit per map
		setCvar("scr_dm_scorelimit", "50");
	level.scorelimit = getCvarInt("scr_dm_scorelimit");
	setCvar("ui_dm_scorelimit", level.scorelimit);
	makeCvarServerInfo("ui_dm_scorelimit", "50");

	if(getCvar("scr_forcerespawn") == "")		// Force respawning
		setCvar("scr_forcerespawn", "0");

	if(getCvar("scr_battlerank") == "")		
		setCvar("scr_battlerank", "1");	//default is ON
	level.battlerank = getCvarint("scr_battlerank");
	setCvar("ui_battlerank", level.battlerank);
	makeCvarServerInfo("ui_battlerank", "0");
	
	if(getCvar("scr_default_loadout_points") == "")		
		setCvar("scr_default_loadout_points", "3");	//default is ON
	level.default_loadout_points = getCvarint("scr_default_loadout_points");
	setCvar("ui_default_loadout_points", level.default_loadout_points);
	makeCvarServerInfo("ui_default_loadout_points", "0");

	if(getCvar("scr_shellshock") == "")		// controls whether or not players get shellshocked from grenades or rockets
		setCvar("scr_shellshock", "1");
	setCvar("ui_shellshock", getCvar("scr_shellshock"));
	makeCvarServerInfo("ui_shellshock", "0");
			
	if(!isDefined(game["compass_range"]))		// set up the compass range.
		game["compass_range"] = 1024;		
	setCvar("cg_hudcompassMaxRange", game["compass_range"]);
	makeCvarServerInfo("cg_hudcompassMaxRange", "0");

	if(getCvar("scr_drophealth") == "")		// Free look spectator
		setCvar("scr_drophealth", "1");

	// turn off ceasefire
	level.ceasefire = 0;
	setCvar("scr_ceasefire", "0");

	killcam = getCvar("scr_killcam");
	if(killcam == "")				// Kill cam
		killcam = "1";
	setCvar("scr_killcam", killcam, true);
	level.killcam = getCvarInt("scr_killcam");
	
	if(!isDefined(game["state"]))
		game["state"] = "playing";

	// this is just to define this variable to other scripts that use it dont crash
	level.drawfriend = 0;
	
	level.QuickMessageToAll = true;
	level.mapended = false;
	level.healthqueue = [];
	level.healthqueuecurrent = 0;
	
	if(level.killcam >= 1)
		setarchive(true);
}

Callback_StartGameType()
{
	// defaults if not defined in level script
	if(!isDefined(game["allies"]))
		game["allies"] = "american";
	if(!isDefined(game["axis"]))
		game["axis"] = "german";

	if(!isDefined(game["layoutimage"]))
		game["layoutimage"] = "default";
	layoutname = "levelshots/layouts/hud@layout_" + game["layoutimage"];
	precacheShader(layoutname);
	setCvar("scr_layoutimage", layoutname);
	makeCvarServerInfo("scr_layoutimage", "");

	// server cvar overrides
	if(getCvar("scr_allies") != "")
		game["allies"] = getCvar("scr_allies");
	if(getCvar("scr_axis") != "")
		game["axis"] = getCvar("scr_axis");

	game["menu_serverinfo"] = "serverinfo_" + getCvar("g_gametype");
	game["menu_team"] = "team_" + game["allies"] + game["axis"];
	game["menu_weapon_allies"] = "weapon_" + game["allies"];
	game["menu_weapon_axis"] = "weapon_" + game["axis"];
	game["menu_viewmap"] = "viewmap";
	game["menu_callvote"] = "callvote";
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	game["menu_quickvehicles"] = "quickvehicles";
	game["menu_quickrequests"] = "quickrequests";
	
	//CUSTOM MENU LOAD//////////////////////////////////////////////////////////	
	maps\mp\gametypes\_waw::wawStartGametype();
	////////////////////////////////////////////////////////////////////////////

	precacheString(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	precacheString(&"MPSCRIPT_KILLCAM");
	precacheString(&"GMI_MP_CEASEFIRE");

	precacheMenu(game["menu_serverinfo"]);
	precacheMenu(game["menu_team"]);
	precacheMenu(game["menu_weapon_allies"]);
	precacheMenu(game["menu_weapon_axis"]);
	precacheMenu(game["menu_viewmap"]);
	precacheMenu(game["menu_callvote"]);
	precacheMenu(game["menu_quickcommands"]);
	precacheMenu(game["menu_quickstatements"]);
	precacheMenu(game["menu_quickresponses"]);
	precacheMenu(game["menu_quickvehicles"]);
	precacheMenu(game["menu_quickrequests"]);

	precacheShader("black");
	precacheShader("hudScoreboard_mp");
	precacheShader("gfx/hud/hud@mpflag_none.tga");
	precacheShader("gfx/hud/hud@mpflag_spectator.tga");
	precacheStatusIcon("gfx/hud/hud@status_dead.tga");
	precacheStatusIcon("gfx/hud/hud@status_connecting.tga");
	precacheItem("item_health");

	maps\mp\gametypes\_teams::modeltype();
	maps\mp\gametypes\_teams::precache();
	maps\mp\gametypes\_teams::initGlobalCvars();
	maps\mp\gametypes\_cvars::initWeaponCvars();
	maps\mp\gametypes\_teams::restrictPlacedWeapons();
	thread maps\mp\gametypes\_teams::updateGlobalCvars();
	thread maps\mp\gametypes\_cvars::updateWeaponCvars();

	setClientNameMode("auto_change");

	thread startGame();
	thread addBotClients(); // For development testing
	thread updateGametypeCvars();
}

Callback_PlayerConnect()
{
	self.statusicon = "gfx/hud/hud@status_connecting.tga";
	self waittill("begin");
	self.statusicon = "";

	iprintln(&"MPSCRIPT_CONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpselfguid = self getGuid();
	logPrint("J;" + lpselfguid + ";" + lpselfnum + ";" + self.name + "\n");
	
	// set the cvar for the map quick bind
	self setClientCvar("g_scriptQuickMap", game["menu_viewmap"]);
	// init primary selected cvar
	self setClientCvar("ui_primary_selected", "0");
	self.pers["firstspawn"] = false;
	
	self.pers["loadout_score"] = 0;
	self.pers["loadout_points"] = level.default_loadout_points;
	self setClientCvar("player_loadout_points_string", self.pers["loadout_score"] + " of " + self.pers["loadout_points"] + " loadout points used!");
	
	if(game["state"] == "intermission")
	{
		spawnIntermission();
		return;
	}

	level endon("intermission");

	// start the vsay thread
	self thread maps\mp\gametypes\_teams::vsay_monitor();

	if(isDefined(self.pers["team"]) && self.pers["team"] != "spectator")
	{
		self setClientCvar("ui_weapontab", "1");
		self.sessionteam = "none";

		if(self.pers["team"] == "allies")
			self setClientCvar("g_scriptMainMenu", game["menu_pause"]);
		else
			self setClientCvar("g_scriptMainMenu", game["menu_pause"]);

		if(isDefined(self.pers["weapon"]))
			spawnPlayer();
		else
		{
			spawnSpectator();

			if(self.pers["team"] == "allies")
				self openMenu(game["menu_weapon_allies"]);
			else
				self openMenu(game["menu_weapon_axis"]);
		}
	}
	else
	{
		self setClientCvar("g_scriptMainMenu", game["menu_pause"]);
		self setClientCvar("ui_weapontab", "0");

		if(!isDefined(self.pers["skipserverinfo"]))
			self openMenu(game["menu_serverinfo"]);

		self.pers["team"] = "spectator";
		self.sessionteam = "spectator";

		spawnSpectator();
	}

	for(;;)
	{
		self waittill("menuresponse", menu, response);

		if(menu == game["menu_serverinfo"] && response == "close")
		{
			self.pers["skipserverinfo"] = true;
			self openMenu(game["menu_team"]);
		}

		if(response == "open" || response == "close")
			continue;

		if(menu == game["menu_team"])
		{
			switch(response)
			{
			case "allies":
			case "axis":
			case "autoassign":
				if(response == "autoassign")
				{
					teams[0] = "allies";
					teams[1] = "axis";
					response = teams[randomInt(2)];
				}

				if(response == self.pers["team"] && self.sessionstate == "playing")
					break;

				if(response != self.pers["team"] && self.sessionstate == "playing")
				{
					self.pers["firstspawn"] = false; //potential fix for team swapping bug
					self suicide();
				}
				self notify("end_respawn");

				self.pers["team"] = response;
				//self.pers["weapon"] = undefined; SAVE LOADOUT, DON'T RESET
				self.pers["savedmodel"] = undefined;

				// if there are weapons the user can select then open the weapon menu
				if ( maps\mp\gametypes\_teams::isweaponavailable(self.pers["team"]) )
				{
					if(self.pers["team"] == "allies")
					{
						menu = game["menu_weapon_allies"];
						//set default loadout to allies
						self maps\mp\gametypes\_loadout_gmi::updateDefaultLoadout(game["allies"]);
					}
					else
					{
						menu = game["menu_weapon_axis"];
						//set default loadout to axis
						self maps\mp\gametypes\_loadout_gmi::updateDefaultLoadout(game["axis"]);
					}
				
					self setClientCvar("ui_weapontab", "1");
					self openMenu(menu);
				}
				else
				{
					self setClientCvar("ui_weapontab", "0");
					self menu_spawn("none");
				}
		
				self setClientCvar("g_scriptMainMenu", menu["menu_pause"]);
				break;

			case "spectator":
				if(self.pers["team"] != "spectator")
				{
					self.pers["team"] = "spectator";
					self.pers["firstspawn"] = false;
					//self.pers["weapon"] = undefined;
					self.pers["savedmodel"] = undefined;
					
					self.sessionteam = "spectator";
					self setClientCvar("g_scriptMainMenu", game["menu_pause"]);
					self setClientCvar("ui_weapontab", "0");
					spawnSpectator();
				}
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;

			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}
		///////////////////////////////////////
		// NEW LOADOUT HANDLING CODE GOES HERE
		///////////////////////////////////////
		else if( maps\mp\gametypes\_newmenus::isWeaponMenu(menu) )
		{
			if(response == "team")
			{
				self openMenu(game["menu_team"]);
				continue;
			}
			else if(response == "viewmap")
			{
				self openMenu(game["menu_viewmap"]);
				continue;
			}
			else if(response == "callvote")
			{
				self openMenu(game["menu_callvote"]);
				continue;
			}

			if(!isDefined(self.pers["team"]) || (self.pers["team"] != "allies" && self.pers["team"] != "axis"))
				continue;
			
			if(response == "confirm"){
				menu_spawn(weapon);
				continue;
			}
			
			//updateAttachment
			response = self maps\mp\gametypes\_loadout_gmi::updateAttachment(response);
			
			weapon = self maps\mp\gametypes\_teams::restrict(response);

			if(weapon == "restricted")
			{
				self openMenu(menu);
				continue;
			}

		//	if(isDefined(self.pers["weapon"]) && self.pers["weapon"] == weapon)
		//		continue;
			
			//updateLoadout
			self maps\mp\gametypes\_loadout_gmi::updateLoadout(weapon);
			//menu_spawn(weapon);
		}
		else if(menu == game["menu_viewmap"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}
		else if(menu == game["menu_callvote"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;
			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}
		////////////////////////////////////////////////
		// CUSTOM MENU ACTIONS
		////////////////////////////////////////////////
		
		else if(menu == game["menu_pause"])
		{
			switch(response)
			{
			case "team":
				self openMenu(game["menu_team"]);
				break;

			case "weapon":
				if(self.pers["team"] == "allies")
					self openMenu(game["menu_weapon_allies"]);
				else if(self.pers["team"] == "axis")
					self openMenu(game["menu_weapon_axis"]);
				break;

			case "viewmap":
				self openMenu(game["menu_viewmap"]);
				break;
			
			case "callvote":
				self openMenu(game["menu_callvote"]);
				break;
			}
		}
		
		////////////////////////////////////////////////
		// End Custom Menus
		///////////////////////////////////////////////
		else if(menu == game["menu_quickcommands"])
			maps\mp\gametypes\_teams::quickcommands(response);
		else if(menu == game["menu_quickstatements"])
			maps\mp\gametypes\_teams::quickstatements(response);
		else if(menu == game["menu_quickresponses"])
			maps\mp\gametypes\_teams::quickresponses(response);
		else if(menu == game["menu_quickvehicles"])
			maps\mp\gametypes\_teams::quickvehicles(response);
		else if(menu == game["menu_quickrequests"])
			maps\mp\gametypes\_teams::quickrequests(response);
	}
}

Callback_PlayerDisconnect()
{
	iprintln(&"MPSCRIPT_DISCONNECTED", self);

	lpselfnum = self getEntityNumber();
	lpselfguid = self getGuid();
	logPrint("Q;" + lpselfguid + ";" + lpselfnum + ";" + self.name + "\n");
}

Callback_PlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc)
{
	if(self.sessionteam == "spectator")
		return;

	// dont take damage during ceasefire mode
	// but still take damage from ambient damage (water, minefields, fire)
	if(level.ceasefire && sMeansOfDeath != "MOD_EXPLOSIVE" && sMeansOfDeath != "MOD_WATER" && sMeansOfDeath != "MOD_TRIGGER_HURT")
		return;

	// Don't do knockback if the damage direction was not specified
	if(!isDefined(vDir))
		iDFlags |= level.iDFLAGS_NO_KNOCKBACK;

	maps\mp\gametypes\_waw::wawPlayerDamage(eInflictor, eAttacker, iDamage, iDFlags, sMeansOfDeath, sWeapon, vPoint, vDir, sHitLoc);

	// Do debug print if it's enabled
	if(getCvarInt("g_debugDamage"))
	{
		println("client:" + self getEntityNumber() + " health:" + self.health +
			" damage:" + iDamage + " hitLoc:" + sHitLoc);
	}

	if(self.sessionstate != "dead")
	{
		lpselfnum = self getEntityNumber();
		lpselfname = self.name;
		lpselfteam = self.pers["team"];
		lpselfGuid = self getGuid();
		lpattackerteam = "";

		if(isPlayer(eAttacker))
		{
			lpattacknum = eAttacker getEntityNumber();
			lpattackGuid = eAttacker getGuid();
			lpattackname = eAttacker.name;
			lpattackerteam = eAttacker.pers["team"];
		}
		else
		{
			lpattacknum = -1;
			lpattackGuid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}

		logPrint("D;" + lpselfGuid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackGuid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");
	}
}

Callback_PlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc)
{
	self endon("spawned");

	if(self.sessionteam == "spectator")
		return;

	maps\mp\gametypes\_waw::wawPlayerKilled(eInflictor, attacker, iDamage, sMeansOfDeath, sWeapon, vDir, sHitLoc);

	// If the player was killed by a head shot, let players know it was a head shot kill
	if(sHitLoc == "head" && sMeansOfDeath != "MOD_MELEE")
		sMeansOfDeath = "MOD_HEAD_SHOT";

	// if this is a melee kill from a binocular then make sure they know that they are a loser
	if(sMeansOfDeath == "MOD_MELEE" && (sWeapon == "binoculars_artillery_mp" || sWeapon == "binoculars_mp") )
	{
		sMeansOfDeath = "MOD_MELEE_BINOCULARS";
	}
	
	// if this is a kill from the artillery binocs change the icon
	if(sMeansOfDeath != "MOD_MELEE_BINOCULARS" && sWeapon == "binoculars_artillery_mp" )
		sMeansOfDeath = "MOD_ARTILLERY";

	// send out an obituary message to all clients about the kill
	obituary(self, attacker, sWeapon, sMeansOfDeath);

	self.sessionstate = "dead";
	self.statusicon = "gfx/hud/hud@status_dead.tga";
	self.deaths++;

	lpselfnum = self getEntityNumber();
	lpselfname = self.name;
	lpselfteam = "";
	lpselfguid = self getGuid();
	lpattackerteam = "";

	attackerNum = -1;
	if(isPlayer(attacker))
	{
		if(attacker == self) // killed himself
		{
			doKillcam = false;

			attacker.score--;
		}
		else
		{
			attackerNum = attacker getEntityNumber();
			doKillcam = true;

			attacker.score++;
			attacker checkScoreLimit();
		}

		lpattacknum = attacker getEntityNumber();
		lpattackguid = attacker getGuid();
		lpattackname = attacker.name;
	}
	else // If you weren't killed by a player, you were in the wrong place at the wrong time
	{
		doKillcam = false;

		self.score--;

		lpattacknum = -1;
		lpattackguid = "";
		lpattackname = "";
	}
	
	logPrint("K;" + lpselfguid + ";" + lpselfnum + ";" + lpselfteam + ";" + lpselfname + ";" + lpattackguid + ";" + lpattacknum + ";" + lpattackerteam + ";" + lpattackname + ";" + sWeapon + ";" + iDamage + ";" + sMeansOfDeath + ";" + sHitLoc + "\n");

	// Stop thread if map ended on this death
	if(level.mapended)
		return;
		
	delay = 2;	// Delay the player becoming a spectator till after he's done dying
	wait delay;	// ?? Also required for Callback_PlayerKilled to complete before respawn/killcam can execute
	
	if((getCvarInt("scr_killcam") <= 0) || (getCvarInt("scr_forcerespawn") > 0))
		doKillcam = false;
	
	if(doKillcam)
		self thread killcam(attackerNum, delay);
	else
		self thread respawn();
}

// ----------------------------------------------------------------------------------
//	menu_spawn
//
// 		called from the player connect to spawn the player
// ----------------------------------------------------------------------------------
menu_spawn(weapon)
{
	if(!self.pers["firstspawn"])
	{
		self.pers["firstspawn"] = true;
		spawnPlayer();
	}
	else
	{
		weaponname = maps\mp\gametypes\_teams::getWeaponName(self.pers["weapon"]);
		
		if(maps\mp\gametypes\_teams::useAn(self.pers["weapon"]))
			self iprintln(&"MPSCRIPT_YOU_WILL_RESPAWN_WITH_AN", weaponname);
		else
			self iprintln(&"MPSCRIPT_YOU_WILL_RESPAWN_WITH_A", weaponname);
	}
}

updateDeathArray()
{
	if(!isDefined(level.deatharray))
	{
		level.deatharray[0] = self.origin;
		level.deatharraycurrent = 1;
		return;
	}

	if(level.deatharraycurrent < 31)
		level.deatharray[level.deatharraycurrent] = self.origin;
	else
	{
		level.deatharray[0] = self.origin;
		level.deatharraycurrent = 1;
		return;
	}

	level.deatharraycurrent++;
}

spawnPlayer()
{
	self notify("spawned");
	self notify("end_respawn");

	resettimeout();

//	if(isDefined(self.shocked))
//	{
//		self stopShellshock();
//		self.shocked = undefined;
//	}

	self.sessionteam = "none";
	self.sessionstate = "playing";
	self.spectatorclient = -1;
	self.archivetime = 0;
		
	// make sure that the client compass is at the correct zoom specified by the level
	self setClientCvar("cg_hudcompassMaxRange", game["compass_range"]);

	spawnpointname = "mp_deathmatch_spawn";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_DM(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");

	self.statusicon = "";
	self.maxhealth = 100;
	self.health = self.maxhealth;

	self.pers["rank"] = maps\mp\gametypes\_rank_gmi::DetermineBattleRank(self);
	self.rank = self.pers["rank"];
	
	if(!isDefined(self.pers["savedmodel"]))
		maps\mp\gametypes\_teams::model();
	else
		maps\mp\_utility::loadModel(self.pers["savedmodel"]);

	// setup all the weapons
	self maps\mp\gametypes\_loadout_gmi::PlayerSpawnLoadout();
	
	self setClientCvar("cg_objectiveText", &"DM_KILL_OTHER_PLAYERS");

	// set the status icon if battlerank is turned on
	if(level.battlerank)
	{
		self.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(self);
	}	

	// setup the hud rank indicator
	self thread maps\mp\gametypes\_rank_gmi::RankHudInit();
	
	maps\mp\gametypes\_waw::wawSpawnPlayer();
}

spawnSpectator(origin, angles)
{
	self notify("spawned");
	self notify("end_respawn");
	
	resettimeout();

//	if(isDefined(self.shocked))
//	{
//		self stopShellshock();
//		self.shocked = undefined;
//	}

	self.sessionstate = "spectator";
	self.spectatorclient = -1;
	self.archivetime = 0;

	if(self.pers["team"] == "spectator")
		self.statusicon = "";
	
	if(isDefined(origin) && isDefined(angles))
		self spawn(origin, angles);
	else
	{
		spawnpointname = "mp_deathmatch_intermission";
		spawnpoints = getentarray(spawnpointname, "classname");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

		if(isDefined(spawnpoint))
			self spawn(spawnpoint.origin, spawnpoint.angles);
		else
			maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
	}

	self setClientCvar("cg_objectiveText", &"DM_KILL_OTHER_PLAYERS");
	
	maps\mp\gametypes\_waw::wawSpawnSpectator(origin, angles);
}

spawnIntermission()
{
	self notify("spawned");
	self notify("end_respawn");
	
	resettimeout();

//	if(isDefined(self.shocked))
//	{
//		self stopShellshock();
//		self.shocked = undefined;
//	}

	self.sessionstate = "intermission";
	self.spectatorclient = -1;
	self.archivetime = 0;

	spawnpointname = "mp_deathmatch_intermission";
	spawnpoints = getentarray(spawnpointname, "classname");
	spawnpoint = maps\mp\gametypes\_spawnlogic::getSpawnpoint_Random(spawnpoints);

	if(isDefined(spawnpoint))
		self spawn(spawnpoint.origin, spawnpoint.angles);
	else
		maps\mp\_utility::error("NO " + spawnpointname + " SPAWNPOINTS IN MAP");
}

respawn()
{
	self endon("end_respawn");
	
	firsttime = 0;
	while(!isDefined(self.pers["weapon"])) {
		
		wait 3;
		
		//self iprintln(&"");	// TODO: tell them they need to select a weapon in order to spawn
		
		if (isDefined(self.pers["weapon"]))
			break;
		
		if (firsttime < 3)
		{
			if(self.pers["team"] == "allies")
				self openMenu(game["menu_weapon_allies"]);
			else
				self openMenu(game["menu_weapon_axis"]);
		}
		firsttime++;
	
		self waittill("menuresponse");
		
		wait 0.2;
	}

	if(getCvarInt("scr_forcerespawn") > 0)
	{
		self thread waitForceRespawnTime();
		self thread waitRespawnButton();
		self waittill("respawn");
	}
	else
	{
		self thread waitRespawnButton();
		self waittill("respawn");
	}

	self thread spawnPlayer();
}

waitForceRespawnTime()
{
	self endon("end_respawn");
	self endon("respawn");

	wait getCvarInt("scr_forcerespawn");
	self notify("respawn");
}

waitRespawnButton()
{
	self endon("end_respawn");
	self endon("respawn");

	wait 0; // Required or the "respawn" notify could happen before it's waittill has begun

	if ( getcvar("scr_forcerespawn") == "1" )
		return;
		
	self.respawntext = newClientHudElem(self);
	self.respawntext.alignX = "center";
	self.respawntext.alignY = "middle";
	self.respawntext.x = 320;
	self.respawntext.y = 70;
	self.respawntext.archived = false;
	self.respawntext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");

	thread removeRespawnText();
	thread waitRemoveRespawnText("end_respawn");
	thread waitRemoveRespawnText("respawn");

	while(self useButtonPressed() != true)
		wait .05;

	self notify("remove_respawntext");

	self notify("respawn");
}

removeRespawnText()
{
	self waittill("remove_respawntext");

	if(isDefined(self.respawntext))
		self.respawntext destroy();
}

waitRemoveRespawnText(message)
{
	self endon("remove_respawntext");

	self waittill(message);
	self notify("remove_respawntext");
}

killcam(attackerNum, delay)
{
	self endon("spawned");

//	previousorigin = self.origin;
//	previousangles = self.angles;

	// killcam
	if(attackerNum < 0)
		return;

	self.sessionstate = "spectator";
	self.spectatorclient = attackerNum;
	self.archivetime = delay + 7;
	
	// wait till the next server frame to allow code a chance to update archivetime if it needs trimming
	wait 0.05;

	if(self.archivetime <= delay)
	{
		self.spectatorclient = -1;
		self.archivetime = 0;
		self.sessionstate = "dead";
		
		self thread respawn();
		return;
	}

	if(!isDefined(self.kc_topbar))
	{
		self.kc_topbar = newClientHudElem(self);
		self.kc_topbar.archived = false;
		self.kc_topbar.x = 0;
		self.kc_topbar.y = 0;
		self.kc_topbar.alpha = 0.5;
		self.kc_topbar setShader("black", 640, 112);
	}

	if(!isDefined(self.kc_bottombar))
	{
		self.kc_bottombar = newClientHudElem(self);
		self.kc_bottombar.archived = false;
		self.kc_bottombar.x = 0;
		self.kc_bottombar.y = 368;
		self.kc_bottombar.alpha = 0.5;
		self.kc_bottombar setShader("black", 640, 112);
	}

	if(!isDefined(self.kc_title))
	{
		self.kc_title = newClientHudElem(self);
		self.kc_title.archived = false;
		self.kc_title.x = 320;
		self.kc_title.y = 40;
		self.kc_title.alignX = "center";
		self.kc_title.alignY = "middle";
		self.kc_title.sort = 1; // force to draw after the bars
		self.kc_title.fontScale = 3.5;
	}
	self.kc_title setText(&"MPSCRIPT_KILLCAM");

	if ( getcvar("scr_forcerespawn") != "1" )
	{
		if(!isDefined(self.kc_skiptext))
		{
			self.kc_skiptext = newClientHudElem(self);
			self.kc_skiptext.archived = false;
			self.kc_skiptext.x = 320;
			self.kc_skiptext.y = 70;
			self.kc_skiptext.alignX = "center";
			self.kc_skiptext.alignY = "middle";
			self.kc_skiptext.sort = 1; // force to draw after the bars
		}
		self.kc_skiptext setText(&"MPSCRIPT_PRESS_ACTIVATE_TO_RESPAWN");
	}
	
	if(!isDefined(self.kc_timer))
	{
		self.kc_timer = newClientHudElem(self);
		self.kc_timer.archived = false;
		self.kc_timer.x = 320;
		self.kc_timer.y = 428;
		self.kc_timer.alignX = "center";
		self.kc_timer.alignY = "middle";
		self.kc_timer.fontScale = 3.5;
		self.kc_timer.sort = 1;
	}
	self.kc_timer setTenthsTimer(self.archivetime - delay);

	self thread spawnedKillcamCleanup();
	self thread waitSkipKillcamButton();
	self thread waitKillcamTime();
	self waittill("end_killcam");

	self removeKillcamElements();

	self.spectatorclient = -1;
	self.archivetime = 0;
	self.sessionstate = "dead";
	
	//self thread spawnSpectator(previousorigin + (0, 0, 60), previousangles);
	self thread respawn();
}

waitKillcamTime()
{
	self endon("end_killcam");

	wait(self.archivetime - 0.05);
	self notify("end_killcam");
}

waitSkipKillcamButton()
{
	self endon("end_killcam");

	while(self useButtonPressed())
		wait .05;

	while(!(self useButtonPressed()))
		wait .05;

	self notify("end_killcam");
}

removeKillcamElements()
{
	if(isDefined(self.kc_topbar))
		self.kc_topbar destroy();
	if(isDefined(self.kc_bottombar))
		self.kc_bottombar destroy();
	if(isDefined(self.kc_title))
		self.kc_title destroy();
	if(isDefined(self.kc_skiptext))
		self.kc_skiptext destroy();
	if(isDefined(self.kc_timer))
		self.kc_timer destroy();
}

spawnedKillcamCleanup()
{
	self endon("end_killcam");

	self waittill("spawned");
	self removeKillcamElements();
}

startGame()
{
	level.starttime = getTime();

	if(level.timelimit > 0)
	{
		level.clock = newHudElem();
		level.clock.x = 320;
		level.clock.y = 460;
		level.clock.alignX = "center";
		level.clock.alignY = "middle";
		level.clock.font = "bigfixed";
		level.clock setTimer(level.timelimit * 60);
	}

	for(;;)
	{
		checkTimeLimit();
		wait 1;
	}
}

endMap()
{
	
	maps\mp\gametypes\_mapvote::Initialize();
	
	game["state"] = "intermission";
	level notify("intermission");

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isDefined(player.pers["team"]) && player.pers["team"] == "spectator")
			continue;

		if(!isDefined(highscore))
		{
			highscore = player.score;
			playername = player;
			name = player.name;
			guid = player getGuid();
			continue;
		}

		if(player.score == highscore)
			tied = true;
		else if(player.score > highscore)
		{
			tied = false;
			highscore = player.score;
			playername = player;
			name = player.name;
			guid = player getGuid();
		}
	}

	players = getentarray("player", "classname");
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		player closeMenu();
		player setClientCvar("g_scriptMainMenu", "main");

		if(isDefined(tied) && tied == true)
			player setClientCvar("cg_objectiveText", &"MPSCRIPT_THE_GAME_IS_A_TIE");
		else if(isDefined(playername))
			player setClientCvar("cg_objectiveText", &"MPSCRIPT_WINS", playername);
		
		player spawnIntermission();
	}
	if(isDefined(name))
		logPrint("W;;" + guid + ";" + name + "\n");
	wait 10;
	exitLevel(false);
}

checkTimeLimit()
{
	if(level.timelimit <= 0)
		return;

	timepassed = (getTime() - level.starttime) / 1000;
	timepassed = timepassed / 60.0;

	if(timepassed < level.timelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_TIME_LIMIT_REACHED");
	level thread endMap();
}

checkScoreLimit()
{
	if(level.scorelimit <= 0)
		return;

	if(self.score < level.scorelimit)
		return;

	if(level.mapended)
		return;
	level.mapended = true;

	iprintln(&"MPSCRIPT_SCORE_LIMIT_REACHED");
	level thread endMap();
}

updateGametypeCvars()
{
	for(;;)
	{
		ceasefire = getCvarint("scr_ceasefire");

		// if we are in cease fire mode display it on the screen
		if (ceasefire != level.ceasefire)
		{
			level.ceasefire = ceasefire;
			if ( ceasefire )
			{
				level thread maps\mp\_util_mp_gmi::make_permanent_announcement(&"GMI_MP_CEASEFIRE", "end ceasefire", 220, (1.0,0.0,0.0));			
			}
			else
			{
				level notify("end ceasefire");
			}
		}

		// check all the players for rank changes
		if ( getCvarint("scr_battlerank") )
			maps\mp\gametypes\_rank_gmi::CheckPlayersForRankChanges();

		timelimit = getCvarFloat("scr_dm_timelimit");
		if(level.timelimit != timelimit)
		{
			if(timelimit > 1440)
			{
				timelimit = 1440;
				setCvar("scr_dm_timelimit", "1440");
			}

			level.timelimit = timelimit;
			setCvar("ui_dm_timelimit", level.timelimit);
			level.starttime = getTime();

			if(level.timelimit > 0)
			{
				if(!isDefined(level.clock))
				{
					level.clock = newHudElem();
					level.clock.x = 320;
					level.clock.y = 440;
					level.clock.alignX = "center";
					level.clock.alignY = "middle";
					level.clock.font = "bigfixed";
				}
				level.clock setTimer(level.timelimit * 60);
			}
			else
			{
				if(isDefined(level.clock))
					level.clock destroy();
			}

			checkTimeLimit();
		}

		scorelimit = getCvarInt("scr_dm_scorelimit");
		if(level.scorelimit != scorelimit)
		{
			level.scorelimit = scorelimit;
			setCvar("ui_dm_scorelimit", level.scorelimit);

			players = getentarray("player", "classname");
			for(i = 0; i < players.size; i++)
				players[i] checkScoreLimit();
		}

		killcam = getCvarInt("scr_killcam");
		if (level.killcam != killcam)
		{
			level.killcam = getCvarInt("scr_killcam");
			if(level.killcam >= 1)
				setarchive(true);
			else
				setarchive(false);
		}
		
		battlerank = getCvarInt("scr_battlerank");
		if(level.battlerank != battlerank)
		{
			level.battlerank = battlerank;
			
			// battle rank has precidence over draw friend
			if(level.battlerank)
			{
				// for all living players, show the appropriate headicon
				players = getentarray("player", "classname");
				for(i = 0; i < players.size; i++)
			{
					// setup the hud rank indicator
					player thread maps\mp\gametypes\_rank_gmi::RankHudInit();

					player = players[i];
					
					if(isDefined(player.pers["team"]) && player.pers["team"] != "spectator" && player.sessionstate == "playing")
					{
						player.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(player);
					}
				}
			}
		}
		
		default_loadout_points = getCvarInt("scr_default_loadout_points");
		if(level.default_loadout_points != default_loadout_points)
		{
			//change the battle rank default for all players
			players = getentarray("player", "classname"); 
			for(i=0;i<players.size;i++) 
			{
					i.pers["loadout_points"] = default_loadout_points + i.pers["rank"];
					i setClientCvar("player_loadout_points_string", i.pers["loadout_score"] + " of " + i.pers["loadout_points"] + " loadout points used!");
			}
		}
		wait 1;
	}
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

addBotClients()
{
	wait 5;

	for(;;)
	{
		if(getCvarInt("scr_numbots") > 0)
			break;
		wait 1;
	}

	iNumBots = getCvarInt("scr_numbots");
	for(i = 0; i < iNumBots; i++)
	{
		ent[i] = addtestclient();
		wait 0.5;

		if(isPlayer(ent[i]))
		{
			if(i & 1)
			{
				ent[i] notify("menuresponse", game["menu_team"], "axis");
				wait 0.5;
				ent[i].pers["weapon"] = "kar98k_mp";
				ent[i] notify("menuresponse", game["menu_weapon_axis"], "confirm");
			}
			else
			{
				ent[i] notify("menuresponse", game["menu_team"], "allies");
				wait 0.5;
				ent[i].pers["weapon"] = "springfield_mp";
				ent[i] notify("menuresponse", game["menu_weapon_allies"], "confirm");
			}
		}
	}
}
