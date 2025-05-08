/* -----------------------------------------------------
SHELLSHOCK OF VARIOUS TYPES
sLoc = hit location | determines type of shellshock
sWPN = NotUSed
sDMG = Damage Amount
sMOD = Means of Death 	
---------------------------------------------------- */
shockFX(sLOC, sWPN, sDMG , sMOD)
{		
	if(getCvarint("scr_shellshock") < 1 )
		return;
	if (sMOD != "MOD_EXPLOSIVE")
	{

		if(sDMG > 100)
			sDMG = 100;

		switch(sLOC)		
		{		
		case "head": case "neck": case "helmet":
			type = "mc_default";
			break;	
		case "torso_lower":
			type = "mc_mustard";
			break;
		case "torso_upper": 
			type = "mc_hit6";
			break;
		case "none":
			type = "mc_hit6";
			break;
		default: 
			type = "mc_mustard";
			break;
		}
		if(sLOC == "head" || sLOC == "none")
		{
			if(sDMG > 100)
				self viewkick(96, self.origin);
			else if(sDMG > 75 && sDMG <= 100)
				self viewkick(40,self.origin);
			else if(sDMG > 50 && sDMG <= 75)
				self viewkick(20,self.origin);
			else 
				self viewkick(5,self.origin);
		}
		self shellshock(type, (sDMG * .025) );
		wait(sDMG * .025);
	}
}




/* ----------------------------------------------------- 
   CREATE THE AREA EFFECT 
   AND DAMAGE FOR THE MUSTARD GAS 
   eAttacker = owner of damage 
   vPoint = mustard gas grenade coords 
---------------------------------------------------- */ 
MonitorMustardGas(eAttacker,vPoint) 
{ 
   //PLAY EFFECT FOR 15 SECONDS 
   gastime = level.mustardgas_linger_time - 1;     

   for(j = 0;j <= gastime;j++) 
   { 

   //LOOP THROUGH PLAYERS AND DETERMINE WHO IS IN RANGE 
      players = getentarray("player", "classname"); 
      for(i=0;i<players.size;i++) 
      { 
         dst = distance(vPoint, players[i].origin); 
          
      //AREA WHICH PLAYER WILL BE AFFECTED EXPANDS 
      //ALONG WITH THE GAS/SMOKE (~2ft per sec)
	
        if( dst > 200 + (j * 20) || players[i].sessionstate != "playing" || !isAlive(players[i]) || isDefined(players[i].protected) ) 
            continue; 
		
		players[i] maps\mp\gametypes\_waw::printDebug("Player in range. Determining Gas Effect", "debug", "self");
      //DAMAGE THE PLAYER
		
		pcnt = 200 + (j * 20);
		if(dst > pcnt * .75 ) 					// 0-25% dmg
			iDamage = randomint(5);
		else if(dst > pcnt * .5 && dst < pcnt * .75) 	// 25-50 % dmg
			iDamage = 15 + randomint(5);
		else if(dst > pcnt *.25 && dst < pcnt * .5) 	// 59-75% dmg
			 iDamage = 30 + randomint(5);
		else if(dst < pcnt * .25)				// 100% dmg
			iDamage = 45 + randomint(5);
		
		players[i] maps\mp\gametypes\_waw::printDebug("Gas Effect Intensity is " + iDamage, "debug", "self");
		
         //vDir = undefined; 
      	//SET THE MOD 
         sMeansOfDeath = "MOD_UNKNOWN"; 
      	// SET THE WEAPON TO "NONE" SO THE DAMAGE CALLBACK 
      	// DOESNT PICK IT BACK UP AND RESTART THE THREAD 
         //sWeapon = "none";
		sWeapon = "mustardgas_mp";
        iDFlags = 1; 
        players[i] thread GasPlayer(eAttacker, iDamage, iDFlags , sMeansOfDeath , sWeapon, vPoint , undefined,"none"); 
      } 

      wait(1); 
   } 
    
} 


/* ----------------------------------------------------- 
   CAUSE THE DAMAGE & EFFECT 
   eAttacker = owner of damage 
   vPoint = mustard gas grenade coords 

   TODO: 

      -make a custom HUD shader to go along with 
      the custom shellshock. 
---------------------------------------------------- */ 
GasPlayer(eAttacker, iDamage, iDFlags , sMeansOfDeath , sWeapon, vPoint , vDir, sHitLoc) 
{ 
	self endon("waw_died");
	
	if(!isDefined(self.gassed)) 
	{
		if(iDamage <= 5)
			len = .25;
		else if(iDamage >=5 && iDamage < 10)
			len = .45;
		else if(iDamage >= 10 && iDamage < 15)
			len = .75;
		else if(iDamage >= 15)
			len = 1;
		
		self maps\mp\gametypes\_waw::printDebug("You are being gassed. Shellshock will last " + len + "s", "debug", "self");
		
		self shellshock("mc_mustard",len);
		self.gassed = 1;
	}
	/* DONT DAMAGE PLAYER, JUST STUNN
	if(self.health - iDamage <= 0)
	{
		if( !isPlayer(eAttacker) || !isDefined(eAttacker.pers["team"]) || (isDefined(eAttacker.pers["team"]) && eAttacker.pers["team"] == "spectator"))
			eAttacker = self;
		
		self thread [[level.callbackPlayerDamage]](eAttacker, eAttacker, iDamage, iDFlags , sMeansOfDeath , sWeapon, vPoint , vDir, sHitLoc); 
	
	}
	else
		self.health = self.health - iDamage;
	
	if(isAlive(self))
	{ 
		if(isDefined(self.gassed))
			self.gassed = undefined;		
	} */
	
	if(isDefined(self.gassed))
		self.gassed = undefined;

}




/* ----------------------------------------------------- 
   CREATE THE AREA EFFECT 
   AND DAMAGE FOR THE COCKTAIL 
   eAttacker = owner of damage 
   vPoint = cocktail explosion coords 
---------------------------------------------------- */ 
MonitorCocktail(eAttacker,vPoint) 
{ 
	
   //PLAY EFFECT FOR 12 SECONDS 
   burntime = level.molotov_burn_time - 1;     
  
   for(j = 0;j < burntime ;j++) 
   { 
   	//LOOP THROUGH PLAYERS AND DETERMINE WHO IS IN RANGE 
      players = getentarray("player", "classname"); 
      for(i=0;i<players.size;i++) 
      { 
         	dst = distance(vPoint, players[i].origin); 
		
        	if( dst > 240 || players[i].sessionstate != "playing" || !isAlive(players[i]) || isDefined(players[i].protected) ) 
            	continue; 
		
		players[i] maps\mp\gametypes\_waw::printDebug("Player in range. Doing fire damage", "debug", "self");
		if(dst < 5 && j == 0)
		{
			players[i] maps\mp\gametypes\_waw::printDebug("Molotov direct hit! Doing 90 damage", "debug", "self");
			iDamage = 90;
		}
		
		if(dst < 240 )
		{
			iDamage = (int)(70 * (1 - (dst / 240)) );
			players[i] maps\mp\gametypes\_waw::printDebug("Fire damage == " + iDamage, "debug", "self");
		}
		
		if(!isDefined(self.isonfire))
			players[i] thread playerburn();
		
     	 	sMeansOfDeath = "MOD_FLAME";
      		sWeapon = "cocktail_mp";
      		iDFlags = 1; 
		if(iDamage < players[i].health )
		{
		/*	if(!isDefined(players[i].scr))
			{
				if(players[i].painsound == "nikita_pain" )
					players[i] thread scream("f"); 
				else
					players[i] thread scream("m");
			} */
			players[i].health = players[i].health - iDamage;
			players[i] maps\mp\gametypes\_waw::printDebug("Applying Damage. New Health is " + players[i].health, "debug", "self");
		} 
		else
		{
			if( !isPlayer(eAttacker) || !isDefined(eAttacker.pers["team"]) || (isDefined(eAttacker.pers["team"]) && eAttacker.pers["team"] == "spectator"))
				eAttacker = players[i];

		/*	if(!isDefined(players[i].scr))	
				players[i] playsound(players[i].painsound); */
				players[i] maps\mp\gametypes\_waw::printDebug("You should die now. Doing Player Damage callback", "debug", "self");
				//iDamage should be at least 2 so that we know to apply damage in the callback
				if(iDamage < 2) iDamage = 2;
		      	players[i] thread [[level.callbackPlayerDamage]](eAttacker, eAttacker, iDamage, iDFlags , sMeansOfDeath , sWeapon, vPoint , undefined,"none"); 		
   		}
	 } 

      wait(1); 
   } 
    
} 

scream(t)
{

	self endon("TimeToDie");
	self.scr = 1;
	if( randomint(100) > 40 || t == "mc" || t == "fc" || t == "p" || t == "h")
	{
		if(t == "f")
			self playsound("nikita_scream");
		else if(t == "m")
			self playsound("mc_scream");
		else if(t == "mc")
			self playsound("mchoke");
		else if(t == "fc")
			self playsound("fchoke");
		else if(t == "p")
			self playsound("puker");
		else if(t == "h")
			self playsound("heave");
		else if(t == "n")
			self playsound("pain");
	}
	else
	{
		self playsound (self.painsound);
	}
	wait 2;
	if(isAlive(self))
		self.scr = undefined;
}

PlayerBurn()
{
	self endon("TimeToDie");

	if(isDefined(self.isonfire))
		return;	

	self shellshock("mc_mustard", .5);
	self.isonfire = 1;
	for(i =0;i<2;i++)
	{
		
		switch(randomint(9))
		{
		

		case 0: tag = "TAG_BELT_FRONT";break;
		case 1: tag = "TAG_SHIN_LEFT";break;
		case 2: tag = "TAG_SHIN_RIGHT";break;
		case 3: tag = "Bip01 L Thigh";break;
		case 4: tag = "Bip01 R Thigh";break;
		case 5: tag = "Bip01 Pelvis";break;
		case 6: //tag = "TAG_BREASTPOCKET_LEFT";break;
		case 7:	//tag = "TAG_BREASTPOCKET_RIGHT";break;
		case 8:tag = "Bip01 L Foot";break;
		case 9:tag = "Bip01 R Foot";break;
		}

		if(isDefined(self) && isAlive(self) )
			playfxontag( level._effect["playerburn"], self, tag);
		wait .5;
	}
		if(isAlive(self))
			self.isonfire = undefined;
}
