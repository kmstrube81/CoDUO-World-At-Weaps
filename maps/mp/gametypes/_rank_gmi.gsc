// ----------------------------------------------------------------------------------
//	InitializeBattleRank
//	19 ranks
// 	Sets up defaults for all of the values
// ----------------------------------------------------------------------------------
InitializeBattleRank()
	{
		game["br_artillery_ready"] = "gfx/hud/hud@fire_ready_shell.dds";

		// set up the hudicons
		game["br_hudicons_allies_0"] = "gfx/hud/hud@us_rank1.dds";
		game["br_hudicons_allies_1"] = "gfx/hud/hud@us_rank2.dds";
		game["br_hudicons_allies_2"] = "gfx/hud/hud@us_rank3.dds";
		game["br_hudicons_allies_3"] = "gfx/hud/hud@us_rank4.dds";
		game["br_hudicons_allies_4"] = "gfx/hud/hud@us_rank5.dds";
		game["br_hudicons_allies_5"] = "gfx/hud/hud@us_rank6.dds";
		game["br_hudicons_allies_6"] = "gfx/hud/hud@us_rank7.dds";
		game["br_hudicons_allies_7"] = "gfx/hud/hud@us_rank8.dds";
		game["br_hudicons_allies_8"] = "gfx/hud/hud@us_rank9.dds";
		game["br_hudicons_allies_9"] = "gfx/hud/hud@us_rank10.dds";
		game["br_hudicons_allies_10"] = "gfx/hud/hud@us_rank11.dds";
		game["br_hudicons_allies_11"] = "gfx/hud/hud@us_rank12.dds";
		game["br_hudicons_allies_12"] = "gfx/hud/hud@us_rank13.dds";
		game["br_hudicons_allies_13"] = "gfx/hud/hud@us_rank14.dds";
		game["br_hudicons_allies_14"] = "gfx/hud/hud@us_rank15.dds";
		game["br_hudicons_allies_15"] = "gfx/hud/hud@us_rank16.dds";
		game["br_hudicons_allies_16"] = "gfx/hud/hud@us_rank17.dds";
		game["br_hudicons_allies_17"] = "gfx/hud/hud@us_rank18.dds";
		game["br_hudicons_allies_18"] = "gfx/hud/hud@us_rank19.dds";

		//set up the point system
		if(!isdefined(game["br_points_objective"]))	// Achieving an objective
		game["br_points_objective"] = 5;

		if(!isdefined(game["br_points_teamcap"]))	// How many points to the team if objective secured
		game["br_points_teamcap"] = 1;

		if(!isdefined(game["br_points_cap"]))		// Capturing a flag or domination point
		game["br_points_cap"] = 3;

		if(!isdefined(game["br_points_assist"]))	// Assisting in the capture of a flag or domination point
		game["br_points_assist"] = 1;

		if(!isdefined(game["br_points_defense"]))	// Killing enemy in flag zone
		game["br_points_defense"] = 2;

		if(!isdefined(game["br_points_kill"]))		// Getting a kill
		game["br_points_kill"] = 1;

		if(!isdefined(game["br_points_teamkill"]))	// Killing someone on your own team
		game["br_points_teamkill"] = -1;

		if(!isdefined(game["br_points_suicide"]))	// Killing yourself
		game["br_points_suicide"] = -1;

		if(!isdefined(game["br_points_dying"]))		// Getting killed
		game["br_points_dying"] = 0;

		if(!isdefined(game["br_points_reversal"]))	// Other team taking a flag or domination point
		game["br_points_reversal"] = 0;

		if(getCvar("scr_rank_ppr") == "")			// points per rank
		setCvar("scr_rank_ppr", "5");
		game["br_ppr"] = getCvarInt("scr_rank_ppr");


		//set up the points required for each rank

		if(!isdefined(game["br_rank_1"]))		// points to achieve rank 1
		game["br_rank_1"] = game["br_ppr"] * 1;

		if(!isdefined(game["br_rank_2"]))		// points to achieve rank 2
		game["br_rank_2"] = game["br_ppr"] * 2;

		if(!isdefined(game["br_rank_3"]))		//points to achieve rank 3, etc.
		game["br_rank_3"] = game["br_ppr"] * 3;

		if(!isdefined(game["br_rank_4"]))		
		game["br_rank_4"] = game["br_ppr"] * 4;

		if(!isdefined(game["br_rank_5"]))		
		game["br_rank_5"] = game["br_ppr"] * 5;

		if(!isdefined(game["br_rank_6"]))		
		game["br_rank_6"] = game["br_ppr"] * 6;

		if(!isdefined(game["br_rank_7"]))		
		game["br_rank_7"] = game["br_ppr"] * 7;

		if(!isdefined(game["br_rank_8"]))		
		game["br_rank_8"] = game["br_ppr"] * 8;

		if(!isdefined(game["br_rank_9"]))		
		game["br_rank_9"] = game["br_ppr"] * 9;

		if(!isdefined(game["br_rank_10"]))
		game["br_rank_10"] = game["br_ppr"] * 10;

		if(!isdefined(game["br_rank_11"]))	
		game["br_rank_11"] = game["br_ppr"] * 11;

		if(!isdefined(game["br_rank_12"]))	
		game["br_rank_12"] = game["br_ppr"] * 12;

		if(!isdefined(game["br_rank_13"]))	
		game["br_rank_13"] = game["br_ppr"] * 13;

		if(!isdefined(game["br_rank_14"]))
		game["br_rank_14"] = game["br_ppr"] * 14;

		if(!isdefined(game["br_rank_15"]))	
		game["br_rank_15"] = game["br_ppr"] * 15;

		if(!isdefined(game["br_rank_16"]))	
		game["br_rank_16"] = game["br_ppr"] * 16;

		if(!isdefined(game["br_rank_17"]))		
		game["br_rank_17"] = game["br_ppr"] * 17;

		if(!isdefined(game["br_rank_18"]))	
		game["br_rank_18"] = game["br_ppr"] * 18;

		if(!isdefined(game["br_rank_19"]))	
		game["br_rank_19"] = game["br_ppr"] * 19;

		//set up the number of "clips" of ammo for the each rank
		//remember that they will already have one clip in the gun
		
		game["br_ammo_gunclips_0"] = 2;
		game["br_ammo_gunclips_1"] = 3;
		game["br_ammo_gunclips_2"] = 3;
		game["br_ammo_gunclips_3"] = 3;
		game["br_ammo_gunclips_4"] = 3;
		game["br_ammo_gunclips_5"] = 3;
		game["br_ammo_gunclips_6"] = 3;
		game["br_ammo_gunclips_7"] = 4;
		game["br_ammo_gunclips_8"] = 4;
		game["br_ammo_gunclips_9"] = 4;
		game["br_ammo_gunclips_10"] = 4;
		game["br_ammo_gunclips_11"] = 5;
		game["br_ammo_gunclips_12"] = 5;
		game["br_ammo_gunclips_13"] = 5;
		game["br_ammo_gunclips_14"] = 6;
		game["br_ammo_gunclips_15"] = 6;
		game["br_ammo_gunclips_16"] = 6;
		game["br_ammo_gunclips_17"] = 6;
		game["br_ammo_gunclips_18"] = 6;
		
		game["br_ammo_pistolclips_0"] = 2;
		game["br_ammo_pistolclips_1"] = 2;
		game["br_ammo_pistolclips_2"] = 2;
		game["br_ammo_pistolclips_3"] = 2;
		game["br_ammo_pistolclips_4"] = 2;
		game["br_ammo_pistolclips_5"] = 2;
		game["br_ammo_pistolclips_6"] = 2;
		game["br_ammo_pistolclips_7"] = 2;
		game["br_ammo_pistolclips_8"] = 3;
		game["br_ammo_pistolclips_9"] = 3;
		game["br_ammo_pistolclips_10"] = 3;
		game["br_ammo_pistolclips_11"] = 3;
		game["br_ammo_pistolclips_12"] = 3;
		game["br_ammo_pistolclips_13"] = 4;
		game["br_ammo_pistolclips_14"] = 4;
		game["br_ammo_pistolclips_15"] = 4;
		game["br_ammo_pistolclips_16"] = 4;
		game["br_ammo_pistolclips_17"] = 4;
		game["br_ammo_pistolclips_18"] = 4;

		game["br_ammo_grenades_0"] = 1;
		game["br_ammo_grenades_1"] = 1;
		game["br_ammo_grenades_2"] = 1;
		game["br_ammo_grenades_3"] = 1;
		game["br_ammo_grenades_4"] = 2;
		game["br_ammo_grenades_5"] = 2;
		game["br_ammo_grenades_6"] = 2;
		game["br_ammo_grenades_7"] = 2;
		game["br_ammo_grenades_8"] = 2;
		game["br_ammo_grenades_9"] = 2;
		game["br_ammo_grenades_10"] = 3;
		game["br_ammo_grenades_11"] = 3;
		game["br_ammo_grenades_12"] = 3;
		game["br_ammo_grenades_13"] = 3;
		game["br_ammo_grenades_14"] = 3;
		game["br_ammo_grenades_15"] = 3;
		game["br_ammo_grenades_16"] = 3;
		game["br_ammo_grenades_17"] = 3;
		game["br_ammo_grenades_18"] = 3;

		game["br_ammo_smoke_grenades_0"] = 0;
		game["br_ammo_smoke_grenades_1"] = 0;
		game["br_ammo_smoke_grenades_2"] = 1;
		game["br_ammo_smoke_grenades_3"] = 1;
		game["br_ammo_smoke_grenades_4"] = 1;
		game["br_ammo_smoke_grenades_5"] = 1;
		game["br_ammo_smoke_grenades_6"] = 1;
		game["br_ammo_smoke_grenades_7"] = 1;
		game["br_ammo_smoke_grenades_8"] = 1;
		game["br_ammo_smoke_grenades_9"] = 2;
		game["br_ammo_smoke_grenades_10"] = 2;
		game["br_ammo_smoke_grenades_11"] = 2;
		game["br_ammo_smoke_grenades_12"] = 2;
		game["br_ammo_smoke_grenades_13"] = 2;
		game["br_ammo_smoke_grenades_14"] = 2;
		game["br_ammo_smoke_grenades_15"] = 3;
		game["br_ammo_smoke_grenades_16"] = 3;
		game["br_ammo_smoke_grenades_17"] = 3;
		game["br_ammo_smoke_grenades_18"] = 3;

		game["br_ammo_satchel_charge_0"] = 0;
		game["br_ammo_satchel_charge_1"] = 0;
		game["br_ammo_satchel_charge_2"] = 0;
		game["br_ammo_satchel_charge_3"] = 0.5;
		game["br_ammo_satchel_charge_4"] = 0.5;
		game["br_ammo_satchel_charge_5"] = 0.5;
		game["br_ammo_satchel_charge_6"] = 1;
		game["br_ammo_satchel_charge_7"] = 1;
		game["br_ammo_satchel_charge_8"] = 1;
		game["br_ammo_satchel_charge_9"] = 1.5;
		game["br_ammo_satchel_charge_10"] = 1.5;
		game["br_ammo_satchel_charge_11"] = 1.5;
		game["br_ammo_satchel_charge_12"] = 1.5;
		game["br_ammo_satchel_charge_13"] = 2;
		game["br_ammo_satchel_charge_14"] = 2;
		game["br_ammo_satchel_charge_15"] = 2;
		game["br_ammo_satchel_charge_16"] = 2;
		game["br_ammo_satchel_charge_17"] = 2.5;
		game["br_ammo_satchel_charge_18"] = 2.5;

		if( GetCvar("scr_artillery_first_interval") == "" )
			setCvar("scr_artillery_first_interval", "45"); 	//time until the first artillery strike becomes available

		if( GetCvar("scr_artillery_interval") == "" )
			setCvar("scr_artillery_interval", "120"); 	//time after the first artillery strike until the next becomes available

		if( GetCvar("scr_artillery_interval_range") == "" )
			setCvar("scr_artillery_interval_range", "15"); //range in distance between where artillery "shells" drop??

		if(getCvar("scr_forcerank") == "")
			setCvar("scr_forcerank", "0");
	}

// ----------------------------------------------------------------------------------
//	UpdateBattleRank
//
// 		Monitors throughout length of the game for changes in rank
// ----------------------------------------------------------------------------------
UpdateBattleRank()
	{
		for(;;)
		{
			//
			// DEBUG
			//

			wait 5;
		}
	}	

// ----------------------------------------------------------------------------------
//	ResetPlayerRank
//
// 		Resets both the player rank and score for all players
// ----------------------------------------------------------------------------------
ResetPlayerRank()
	{
		players = getentarray("player", "classname");

		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			player.pers["rank"] = 0;
			player.pers["score"] = 0;
			player.score = 0;
			player.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(player);
			if ( level.drawfriend )
			{
				player.headicon = maps\mp\gametypes\_rank_gmi::GetRankHeadIcon(player);
			}
			else
			{
				player.headicon = "";
			}

			if ( player.pers["team"] == "allies" )
				player.headiconteam = "allies";
			else if (player.pers["team"] == "axis")
				player.headiconteam = "axis";
			else
				player.headiconteam = "none";
		}
	}

// ----------------------------------------------------------------------------------
//	PrecacheBattleRank
//
// 		Precaches anything needed for battle rank
// ----------------------------------------------------------------------------------
PrecacheBattleRank()
	{
		//Precache headicons for each rank
		precacheHeadIcon(game["br_headicons_allies_0"]);
		precacheHeadIcon(game["br_headicons_allies_1"]);
		precacheHeadIcon(game["br_headicons_allies_2"]);
		precacheHeadIcon(game["br_headicons_allies_3"]);
		precacheHeadIcon(game["br_headicons_allies_4"]);
		precacheHeadIcon(game["br_headicons_allies_5"]);
		precacheHeadIcon(game["br_headicons_allies_6"]);
		precacheHeadIcon(game["br_headicons_allies_7"]);
		precacheHeadIcon(game["br_headicons_allies_8"]);
		precacheHeadIcon(game["br_headicons_allies_9"]);
		precacheHeadIcon(game["br_headicons_allies_10"]);
		precacheHeadIcon(game["br_headicons_allies_11"]);
		precacheHeadIcon(game["br_headicons_allies_12"]);
		precacheHeadIcon(game["br_headicons_allies_13"]);
		precacheHeadIcon(game["br_headicons_allies_14"]);
		precacheHeadIcon(game["br_headicons_allies_15"]);
		precacheHeadIcon(game["br_headicons_allies_16"]);
		precacheHeadIcon(game["br_headicons_allies_17"]);
		precacheHeadIcon(game["br_headicons_allies_18"]);

		//precache status icons for each rank
		precacheStatusIcon(game["br_hudicons_allies_0"]);
		precacheStatusIcon(game["br_hudicons_allies_1"]);
		precacheStatusIcon(game["br_hudicons_allies_2"]);
		precacheStatusIcon(game["br_hudicons_allies_3"]);
		precacheStatusIcon(game["br_hudicons_allies_4"]);
		precacheStatusIcon(game["br_hudicons_allies_5"]);
		precacheStatusIcon(game["br_hudicons_allies_6"]);
		precacheStatusIcon(game["br_hudicons_allies_7"]);
		precacheStatusIcon(game["br_hudicons_allies_8"]);
		precacheStatusIcon(game["br_hudicons_allies_9"]);
		precacheStatusIcon(game["br_hudicons_allies_10"]);
		precacheStatusIcon(game["br_hudicons_allies_11"]);
		precacheStatusIcon(game["br_hudicons_allies_12"]);
		precacheStatusIcon(game["br_hudicons_allies_13"]);
		precacheStatusIcon(game["br_hudicons_allies_14"]);
		precacheStatusIcon(game["br_hudicons_allies_15"]);
		precacheStatusIcon(game["br_hudicons_allies_16"]);
		precacheStatusIcon(game["br_hudicons_allies_17"]);
		precacheStatusIcon(game["br_hudicons_allies_18"]);

		//Precache the shaders to be used for hudicons
		precacheShader(game["br_artillery_ready"]);
		precacheShader(game["br_hudicons_allies_0"]);
		precacheShader(game["br_hudicons_allies_1"]);
		precacheShader(game["br_hudicons_allies_2"]);
		precacheShader(game["br_hudicons_allies_3"]);
		precacheShader(game["br_hudicons_allies_4"]);
		precacheShader(game["br_hudicons_allies_5"]);
		precacheShader(game["br_hudicons_allies_6"]);
		precacheShader(game["br_hudicons_allies_7"]);
		precacheShader(game["br_hudicons_allies_8"]);
		precacheShader(game["br_hudicons_allies_9"]);
		precacheShader(game["br_hudicons_allies_10"]);
		precacheShader(game["br_hudicons_allies_11"]);
		precacheShader(game["br_hudicons_allies_12"]);
		precacheShader(game["br_hudicons_allies_13"]);
		precacheShader(game["br_hudicons_allies_14"]);
		precacheShader(game["br_hudicons_allies_15"]);
		precacheShader(game["br_hudicons_allies_16"]);
		precacheShader(game["br_hudicons_allies_17"]);
		precacheShader(game["br_hudicons_allies_18"]);
		
		//Precache the promotion and demotion strings
		precacheString(&"GMI_RANK_PROMOTION");
		precacheString(&"GMI_RANK_DEMOTION");
		
		//Precache the rank messages
		precacheString(game["br_rank_message_2"]);
		precacheString(game["br_rank_message_3"]);
		precacheString(game["br_rank_message_4"]);
		precacheString(game["br_rank_message_5"]);
		precacheString(game["br_rank_message_6"]);
		precacheString(game["br_rank_message_7"]);
		precacheString(game["br_rank_message_8"]);
		precacheString(game["br_rank_message_9"]);
		precacheString(game["br_rank_message_10"]);
		precacheString(game["br_rank_message_11"]);
		precacheString(game["br_rank_message_12"]);
		precacheString(game["br_rank_message_13"]);
		precacheString(game["br_rank_message_14"]);
		precacheString(game["br_rank_message_15"]);
		precacheString(game["br_rank_message_16"]);
		precacheString(game["br_rank_message_17"]);
		precacheString(game["br_rank_message_18"]);
		precacheString(game["br_rank_message_19"]);
		
		//Define each rank message
		game["br_rank_message_2"] = "You earned a loadout point!";
		game["br_rank_message_3"] = "You earned a loadout point!";
		game["br_rank_message_4"] = "You earned a loadout point!";
		game["br_rank_message_5"] = "You earned a loadout point!";
		game["br_rank_message_6"] = "You earned a loadout point!";
		game["br_rank_message_7"] = "You earned a loadout point!";
		game["br_rank_message_8"] = "You earned a loadout point!";
		game["br_rank_message_9"] = "You earned a loadout point!";
		game["br_rank_message_10"] = "You earned a loadout point!";
		game["br_rank_message_11"] = "You earned a loadout point!";
		game["br_rank_message_12"] = "You earned a loadout point!";
		game["br_rank_message_13"] = "You earned a loadout point!";
		game["br_rank_message_14"] = "You earned a loadout point!";
		game["br_rank_message_15"] = "You earned a loadout point!";
		game["br_rank_message_16"] = "You earned a loadout point!";
		game["br_rank_message_17"] = "You earned a loadout point!";
		game["br_rank_message_18"] = "You earned a loadout point!";
		game["br_rank_message_19"] = "^3Congratulations! You've reached the top rank!!";
	}



// ----------------------------------------------------------------------------------
//	DetermineBattleRank
//
// 		Returns a level 0 - 19 that the player is currently at.
// ----------------------------------------------------------------------------------

DetermineBattleRank(player)
	{
		if ( getCvarInt("scr_forcerank") != 0 )
		{
			rank  =  getCvarInt("scr_forcerank");
			if ( rank > 19 )
				rank = 19;
			return rank - 1;
		}
		else if ( player.score >= game["br_rank_18"] )
		{
			return 18;
		}
		else if ( player.score >= game["br_rank_17"] )
		{
			return 17;
		}
		else if ( player.score >= game["br_rank_16"] )
		{
			return 16;
		}
		else if ( player.score >= game["br_rank_15"] )
		{
			return 15;
		}
		else if ( player.score >= game["br_rank_14"] )
		{
			return 14;
		}
		else if ( player.score >= game["br_rank_13"] )
		{
			return 13;
		}
		else if ( player.score >= game["br_rank_12"] )
		{
			return 12;
		}
		else if ( player.score >= game["br_rank_11"] )
		{
			return 11;
		}
		else if ( player.score >= game["br_rank_10"] )
		{
			return 10;
		}
		else if ( player.score >= game["br_rank_9"] )
		{
			return 9;
		}
		else if ( player.score >= game["br_rank_8"] )
		{
			return 8;
		}
		else if ( player.score >= game["br_rank_7"] )
		{
			return 7;
		}
		else if ( player.score >= game["br_rank_6"] )
		{
			return 6;
		}
		else if ( player.score >= game["br_rank_5"] )
		{
			return 5;
		}
		else if ( player.score >= game["br_rank_4"] )
		{
			return 4;
		}
		else if ( player.score >= game["br_rank_3"] )
		{
			return 3;
		}
		else if ( player.score >= game["br_rank_2"] )
		{
			return 2;
		}
		else if ( player.score >= game["br_rank_1"] )
		{
			return 1;
		}

		return 0;
	}


// ----------------------------------------------------------------------------------
//	CheckPlayersForRankChanges
//
// 		Checks all of the players for a change from their previous rank.
//		This function will update the rank value of all players.
//		This function will play sounds when the player changes rank.
//		THIS FUNCTION ASSUMES THAT THE .rank VARIABLE IS DEFINED.
// ----------------------------------------------------------------------------------
CheckPlayersForRankChanges()
{
	players = getentarray("player", "classname");

	// count up the people in the flag area
	for(i = 0; i < players.size; i++)
	{
		player = players[i];

		if(isalive(player))
		{
			old_rank = player.pers["rank"];
			new_rank = DetermineBattleRank(player);

			if ( old_rank != new_rank )
			{
				// did they get promoted?
				if ( old_rank < new_rank )
				{
					player notify("rank changed");
					PlayPromotionSound(player);
					player iprintln(&"GMI_RANK_PROMOTION");
				}
				// or demoted?
				else
				{
					player notify("rank changed");
					PlayDemotionSound(player);
					player iprintln(&"GMI_RANK_DEMOTION");
				}

				player.pers["loadout_points"] = level.default_loadout_points + new_rank;
				player setClientCvar("player_loadout_points_string", player.pers["loadout_score"] + " of " + player.pers["loadout_points"] + " loadout points used!");
				player.pers["rank"] = new_rank;

				if (!isdefined(player.hasflag))	// during CTF statusicon is used to identify the flag carrier
					player.statusicon = maps\mp\gametypes\_rank_gmi::GetRankStatusIcon(player);

				if ( level.drawfriend )
				{
					player.headicon = maps\mp\gametypes\_rank_gmi::GetRankHeadIcon(player);
				}
				else
				{
					player.headicon = "";
				}

				if ( player.pers["team"] == "allies" )
					player.headiconteam = "allies";
				else if (player.pers["team"] == "axis")
					player.headiconteam = "axis";
				else
					player.headiconteam = "none";

				// print the rank message
				if (new_rank > 0 && old_rank < new_rank )
					player iprintln(game[ ("br_rank_message_" + (new_rank + 1) ) ]);
			}

		}
	}


}


// ----------------------------------------------------------------------------------
//	PlayPromotionSound
//
//		Plays the appropriate promotion sound
// ----------------------------------------------------------------------------------
PlayPromotionSound(player)
{
	if ( player.pers["team"] == "allies" )
	{
		player playLocalSound("mp_promotion" );
	}
	else
	{
		player playLocalSound("mp_promotion");
	}
}

// ----------------------------------------------------------------------------------
//	PlayDemotionSound
//
//		Plays the appropriate demotion sound
// ----------------------------------------------------------------------------------
PlayDemotionSound(player)
{
	if ( player.pers["team"] == "allies" )
	{
		player playLocalSound("mp_demotion" );
	}
	else
	{
		player playLocalSound("mp_demotion");
	}
}

// ----------------------------------------------------------------------------------
//	GetRankHeadIcon
//
//		Returns the appropriate head rank icon
// ----------------------------------------------------------------------------------
GetRankHeadIcon(player)
{
	if ( player.pers["team"] == "spectator" )
		return "";

	icon_name = "br_headicons_allies_" + player.pers["rank"];
	return game[icon_name];
}

// ----------------------------------------------------------------------------------
//	GetRankStatusIcon
//
//		Returns the appropriate status rank icon
// ----------------------------------------------------------------------------------
GetRankStatusIcon(player)
{
	if ( player.pers["team"] == "spectator" )
		return "";

	icon_name = "br_hudicons_allies_" + player.pers["rank"];

	return game[icon_name];
}

// ----------------------------------------------------------------------------------
//	GetGunAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------

GetGunAmmo(weapon)
{
	clip_count = game["br_ammo_gunclips_" + self.pers["rank"]];

	clip_size = getfullclipammo(weapon);

	switch(weapon)
	{
		// projectile weapons need to have default ammo returned
		case "trenchgun_mp":
			return 64;

		//Most weapons recieve one extra clip at base rank (level 1)
		case "fg42_mp":
		case "fg42_semi_mp":
		case "fg42_scoped_mp":
		case "fg42_scoped_semi_mp":
		case "thompson_mp":
		case "thompson_semi_mp":
		case "bar_mp":
		case "bar_slow_mp":
		case "bar2_mp":
		case "bar2_slow_mp":
		case "greasegun_mp":
		case "mg30cal_mp":
		case "mg30cal_de_mp":
		case "mp18_mp":
		case "mp18_silenced_mp":
		case "scopedmp44_mp":
		case "scopedmp44_semi_mp":
		case "pps43_mp":
		case "pps43_semi_mp":
		case "tommy_mp":
		case "tommy_semi_mp":
		case "tommy2_mp":
		case "ppshstick_mp":
		case "silencedsten_mp":
		case "ud42_mp":
		case "stenmk5_mp":
		case "m712_mp":
		case "piat_mp":
		case "mg42_mp":
		case "mg42_de_mp":
		case "sten_mp":
		case "bren_mp":
		case "ppsh_mp":
		case "ppsh_semi_mp":
		case "mp40_mp":
		case "mp40_silenced_mp":
		case "mp44_semi_mp":
		case "mp44_mp":
		case "mg34_mp":
		case "mg34_de_mp":
		case "dp28_mp":
		case "dp28_de_mp":
		case "m2_mp":
		case "m2_semi_mp":

		return clip_count * clip_size;

		// Semi-automatic rifles get 1 extra clip

		case "m1carbine_mp":
		case "m3_mp":
		case "m1garand_mp":
		case "m1garand_g_mp":
		case "m1garand_grenade_mp":
		case "scopedm1garand_mp":
		case "scopedm1garand_iron_mp":
		case "gewehr43_scoped_mp":
		case "gewehr43_scoped2_mp":
		case "gewehr43_scoped3_mp":
		case "svt40_scoped_mp":
		case "svt40_scoped_iron_mp":
		case "svt40_mp":
		case "gewehr43_g_mp":
		case "gewehr43_grenade_mp":
		case "ptrs_mp":

		return (clip_count + 1) * clip_size;

		// Bolt action rifles get 2 extra clips

		case "springfield_mp":
		case "springfield2_mp":
		case "springfield3_mp":
		case "delisle_mp":
		case "m1903a3_mp":
		case "enfield_mp":
		case "mosin_nagant_mp":
		case "mosin_nagant_sniper_mp":
		case "mosin_nagant_sniper2_mp":
		case "mosin_nagant_sniper3_mp":
		case "kar98k_mp":
		case "kar98k_sniper_mp":
		case "kar98k_sniper2_mp":
		case "kar98k_sniper3_mp":
		case "enfieldscoped_mp":
		case "enfieldscoped2_mp":
		case "enfieldscoped3_mp":

		return (clip_count + 2) * clip_size;

		default:
		   	return 90;
		}

	return 0;
}


// ----------------------------------------------------------------------------------
//	GetPistolAmmo
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
GetPistolAmmo(weapon)
{
	clip_count = game["br_ammo_pistolclips_" + self.pers["rank"]];

	clip_size = getfullclipammo(weapon);

	return clip_count * clip_size;
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedSmokeGrenadeCount
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
getWeaponBasedSmokeGrenadeCount(weapon)
{
	rank_count = game["br_ammo_smoke_grenades_" + self.pers["rank"]];

	return rank_count;
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedSatchelChargeCount
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
getWeaponBasedSatchelChargeCount(weapon)
{

	rank_count = game["br_ammo_satchel_charge_" + self.pers["rank"]];

	switch(weapon){
		case "satchelcharge_mp":
		case "german_smoke_mp":
		  if(rank_count > 0.5)
		  {
			rank_count = 1;
		  }
		  break;
		case "panzerfaust_equip_mp":
		case "panzerschreck_equip_mp":
		case "bazooka_equip_mp":
		case "piat_equip_mp":
			if(rank_count == 0.5)
			{
				rank_count = 1;
			}
			else if( rank_count == 1.5)
			{
					rank_count = 2;
			}
			else if( rank_count == 2.5)
			{
				rank_count = 3;
			}
			break;
		case "flamethrower_equip_mp":
			rank_count = rank_count * 10;
			break;
		}

	return rank_count;
}

// ----------------------------------------------------------------------------------
//	getWeaponBasedGrenadeCount
//
// 		returns the ammo count that the player will get for the weapon
// ----------------------------------------------------------------------------------
getWeaponBasedGrenadeCount(weapon)
{
	rank_count = game["br_ammo_grenades_" + self.pers["rank"]];

	return rank_count;
}

giveBinoculars(spawnweapon)
{
	binoctype = "binoculars_mp";

	self takeWeapon("binoculars_mp");
	self takeWeapon("binoculars_artillery_mp");

	// if they are a high enough rank then they get the artillery strike binoculars
	if ( self.pers["rank"] >= 14 && level.allow_artillery)
	{

		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])
			{
			case "american":
				binoctype = "binoculars_artillery_mp";
				break;

			case "british":
				binoctype = "binoculars_artillery_mp";
				break;

			case "russian":
				binoctype = "binoculars_artillery_mp";
				break;
			}
		}
		else if(self.pers["team"] == "axis")
		{
			switch(game["axis"])
			{
			case "german":
				binoctype = "binoculars_artillery_mp";
				break;
			}
		}

		self setWeaponSlotWeapon("binocular", binoctype);

		// They do not start with any ammo
		self setWeaponSlotClipAmmo("binocular", 0);

		// give them ammo regularly
		self thread dispense_artillery_strike();
		self thread artillery_strike_sounds();

	}
	else if ( self.pers["rank"] >= 2 && level.allow_binoculars )
	{
		if(self.pers["team"] == "allies")
		{
			switch(game["allies"])
			{
			case "american":
				binoctype = "binoculars_mp";
				break;

			case "british":
				binoctype = "binoculars_mp";
				break;

			case "russian":
				binoctype = "binoculars_mp";
				break;
			}
		}
		else if(self.pers["team"] == "axis")
		{
			switch(game["axis"])
			{
			case "german":
				binoctype = "binoculars_mp";
				break;
			}
		}

		self setWeaponSlotWeapon("binocular", binoctype);
	}
}
// ----------------------------------------------------------------------------------
//	artillery_strike_sounds
//
// 		Will play all the apropriate sounds whenever an artillery strike gets called
// ----------------------------------------------------------------------------------
artillery_strike_sounds()
{
	self endon("death");

	if ( self.pers["team"] == "allies" )
	{
		switch( game["allies"])
		{
		case "british":
			fire_sound = "uk_fire_mission";
			incoming_sound = "uk_incoming";
			break;
		case "russian":
			fire_sound = "ru_fire_mission";
			incoming_sound = "ru_incoming";
			break;
		default:
			fire_sound = "us_fire_mission";
			incoming_sound = "us_incoming";
		}
	}
	else
	{
		fire_sound = "ge_fire_mission";
		incoming_sound = "ge_incoming";
	}

	while (1)
	{
		self waittill( "artillery", strike_point );

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
		}

		wait(0.1);
	}
}

// ----------------------------------------------------------------------------------
//	dispense_artillery_strike
//
// 		thinks while player is alive and gives an artillery strike after timed
//		intervals
// ----------------------------------------------------------------------------------
dispense_artillery_strike()
{
	first_interval = GetCvarInt("scr_artillery_first_interval");
	interval = GetCvarInt("scr_artillery_interval");
	interval_range = GetCvarInt("scr_artillery_interval_range");

	if ( interval_range < 1 )
		interval_range = 1;

	self endon("death");

	// kill any currently running dispense_artillery_strike functions
	self notify("end dispense_artillery_strike");
	wait(0.1);
	self endon("end dispense_artillery_strike");

	// wait the first
	wait(first_interval);

	while (1)
	{
		// go ahead and give them one ammo if they do not have any
		if ( self getWeaponSlotClipAmmo( "binocular" ) == 0 )
		{
			// let them know the artillery strike is available
			clientAnnouncement(self,&"GMI_RANK_ARTILLERY_IN_PLACE");

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

			// give them one
			self setWeaponSlotClipAmmo("binocular", 1);

			//set up the on screen icon
			artillery_available_hud();
		}

		// wait until they use artillery
		self waittill("artillery");

		// now wait for one interval
		wait(interval + randomint(interval_range));
	}
}

// ----------------------------------------------------------------------------------
//	artillery_available_hud
//
// 		puts an icon on the screen when artillery is available
// ----------------------------------------------------------------------------------
artillery_available_hud()
{
	self endon("death");
	self notify("artillery available hud");

	if ( isdefined(self.artillery_available_icon))
		self.artillery_available_icon destroy();

	self.artillery_available_icon = newClientHudElem(self);
	self.artillery_available_icon.alignX = "center";
	self.artillery_available_icon.alignY = "middle";
	self.artillery_available_icon.x = 160;
	self.artillery_available_icon.y = 455;
	self.artillery_available_icon.alpha = 1.0;
	self.artillery_available_icon setShader(game["br_artillery_ready"], 32, 32);

	self thread artillery_available_hud_destroy();
}

// ----------------------------------------------------------------------------------
//	artillery_available_hud_destroy
//
// 		Cleans up the artillery availble icon
// ----------------------------------------------------------------------------------
artillery_available_hud_destroy()
{
	self thread artillery_available_hud_destroy2();
	self endon("artillery available hud");
	self waittill("death");

	if ( isdefined(self.artillery_available_icon))
		self.artillery_available_icon destroy();
}

// ----------------------------------------------------------------------------------
//	artillery_available_hud_destroy
//
// 		Cleans up the artillery availble icon
// ----------------------------------------------------------------------------------
artillery_available_hud_destroy2()
{
	self endon("death");
	self endon("artillery available hud");

	// wait until they use artillery
	self waittill("artillery");

	if ( isdefined(self.artillery_available_icon))
		self.artillery_available_icon destroy();
}

// ----------------------------------------------------------------------------------
//	RankHudInit
//
// 		Sets up the rank hud icon
// ----------------------------------------------------------------------------------
RankHudInit()
{
	if ( !getcvarint("scr_battlerank") )
		return;

	self endon("death");
	self notify("rank RankHudInit");

	wait (0.01);
	self endon("rank RankHudInit");

	if (isDefined(self.rank_hud_icon))
	{
		self.rank_hud_icon destroy();
	}


	self.rank_hud_icon = newClientHudElem(self);
	self.rank_hud_icon.alignX = "center";
	self.rank_hud_icon.alignY = "middle";
	self.rank_hud_icon.x = 119;
	self.rank_hud_icon.y = 405;
	self.rank_hud_icon.alpha = 0.7;

	self thread RankHudSetShader();
	self thread RankHudMonitor();
	self thread RankHudDestroy();
}

// ----------------------------------------------------------------------------------
//	RankHudSetShader
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudSetShader(rank_change)
{
	self endon("death");
	self endon("rank RankHudInit");

	if ( isDefined(rank_change) && rank_change )
	{
		self.rank_hud_icon setShader(GetRankStatusIcon(self), 78, 96);
		self.rank_hud_icon scaleOverTime(3, 26, 32);
	}
	else
	{
		self.rank_hud_icon setShader(GetRankStatusIcon(self), 26, 32);
	}
}

// ----------------------------------------------------------------------------------
//	RankHudDestroy
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudDestroy()
{
	self thread rankHudDestroy2();
	self endon("rank RankHudInit");
	self waittill("death");

	if ( isdefined(self.rank_hud_icon))
		self.rank_hud_icon destroy();
}

// ----------------------------------------------------------------------------------
//	RankHudDestroy
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudDestroy2()
{
	self endon("death");
	self endon("rank RankHudInit");

	while ( level.battlerank )
	 	wait (0.01);

	if ( isdefined(self.rank_hud_icon))
		self.rank_hud_icon destroy();
}

// ----------------------------------------------------------------------------------
//	RankHudSetShader
//
// 		Sets up the rank hud icon to the appropriate shader for the rank
// ----------------------------------------------------------------------------------
RankHudMonitor()
{
	self endon("death");
	self endon("rank RankHudInit");

	while ( level.battlerank )
	{
		self waittill("rank changed");

		self thread RankHudSetShader(true);
		wait (0.01);
	}

	if (isDefined(self.rank_hud_icon))
	{
		self.rank_hud_icon destroy();
	}
}
