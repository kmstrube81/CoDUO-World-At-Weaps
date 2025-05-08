precacheNewMenus()
{
	//Precache Added Menus
	game["menu_pause"] = "pause";
	game["team_alliesaxis"] = "team_alliesaxis";
	game["menu_weapon_all"] = "weapon_loadout";
	game["menu_weapon_allies"] = "weapon_loadout";
	game["menu_weapon_axis"] = "weapon_loadout";
	game["menu_weapon_allies_only"] = "weapon_loadout";
	game["menu_weapon_axis_only"] = "weapon_loadout";
	game["menu_loadout"] = "weapon_loadout";
	game["weapon_class"] = "weapon_class";
	game["weapon_rifleclass"] = "weapon_rifleclass";
	game["weapon_lightclass"] = "weapon_lightclass";
	game["weapon_mgclass"] = "weapon_mgclass";
	game["weapon_heavyclass"] = "weapon_heavyclass";
	game["weapon_sniperclass"] = "weapon_sniperclass";
	game["weapon_secondary"] = "weapon_secondary";
	game["weapon_grenade"] = "weapon_grenade";
	game["weapon_smoke"] = "weapon_smoke";
	game["weapon_satchel"] = "weapon_satchel";
	game["weapon_perks"] = "weapon_perks";
	game["weapon_killstreak"] = "weapon_killstreak";
	precacheMenu(game["menu_pause"]);
	precacheMenu(game["team_alliesaxis"]);
	precacheMenu(game["weapon_loadout"]);
	precacheMenu(game["weapon_class"]);
	precacheMenu(game["weapon_rifleclass"]);
	precacheMenu(game["weapon_lightclass"]);
	precacheMenu(game["weapon_mgclass"]);
	precacheMenu(game["weapon_heavyclass"]);
	precacheMenu(game["weapon_sniperclass"]);
	precacheMenu(game["weapon_secondary"]);
	precacheMenu(game["weapon_grenade"]);
	precacheMenu(game["weapon_smoke"]);
	precacheMenu(game["weapon_satchel"]);
	precacheMenu(game["weapon_perks"]);
	precacheMenu(game["weapon_killstreak"]);
	precacheShader("white");
	precachePerkIcons();
	precacheKillstreakIcons();

}

// ----------------------------------------------------------------------------------
//	isWeaponMenu
//
// 		returns true if the current menu is a weapon menu otherwise returns false
// ----------------------------------------------------------------------------------
isWeaponMenu(menu)
{
	switch(menu) {
		case "weapon_loadout":
		case "weapon_class":
		case "weapon_rifleclass":
		case "weapon_lightclass":
		case "weapon_mgclass":
		case "weapon_heavyclass":
		case "weapon_sniperclass":
		case "weapon_secondary":
		case "weapon_grenade":
		case "weapon_smoke":
		case "weapon_satchel":
		case "weapon_perks":
		case "weapon_killstreak":
			return true;
		default:
			return false;
	}
	return false;
}

//--------------------------------------------------------------------------------------
// precachePerkShaders
//
//		precaches the perk DDS
// -------------------------------------------------------------------------------------
precachePerkIcons()
{
    // these should match whatever DDS files you have for each perk
    precacheShader("gfx/icons/hud@Perk_Weapon_Satchel.dds");
    precacheShader("gfx/icons/hud@Perk_Tripwire.dds");
    precacheShader("gfx/icons/hud@Perk_Detectexplosives.dds");
    precacheShader("gfx/icons/hud@perk_Specialgrenade.dds");
    precacheShader("gfx/icons/hud@Perk_ExtraGrenade.dds");
    precacheShader("gfx/icons/hud@Perk_Extraammo.dds");
    precacheShader("gfx/icons/hud@Perk_Longersprint.dds");
    precacheShader("gfx/icons/hud@Perk_Medic.dds");
    precacheShader("gfx/icons/hud@Perk_Scavenger.dds");
	
	//precache perk texts
	level.scavenger_string = &"^7Hold [{+melee}] to scavenge body...";
	precacheString(level.scavenger_string);
	level.tripwire_place_string = &"^7Hold [{+melee}] to place...";
	precacheString(level.tripwire_place_string);
	level.tripwire_defuse_string = &"^7Hold [{+melee}] to defuse...";
	precacheString(level.tripwire_defuse_string);
	level.tripwire_placing_string = &"^7Placing...";
	precacheString(level.tripwire_placing_string);
	level.tripwire_defusing_string = &"^7Picking up...";
	precacheString(level.tripwire_defusing_string);
	
	level.tripwirefx = loadfx("fx/weapon/explosions/grenade_generic.efx");
	
	precacheShader("gfx/icons/hud@us_grenade.dds");
	precacheShader("gfx/icons/hud@british_grenade.dds");
	precacheShader("gfx/icons/hud@russian_grenade.dds");
	precacheShader("gfx/icons/hud@steilhandgrenate.dds");
	precacheShader("gfx/icons/hud@satchel.dds");
	
	game["firstaid"] = "gfx/icons/hint_health.tga";
	precacheShader(game["firstaid"]);
}
//--------------------------------------------------------------------------------------
// precachePerkShaders
//
//		precaches the perk DDS
// -------------------------------------------------------------------------------------
precacheKillstreakIcons()
{
    // these should match whatever DDS files you have for each killstreak
    precacheShader("gfx/icons/hud@Killstreak_Artillery.dds");
    precacheShader("gfx/icons/hud@killtickempty.tga");
    precacheShader("gfx/icons/hud@killtickfull.tga");
	
	level.waw_turretpickupmessage	= &"^7Hold [{+melee}] to pick up...";
	level.waw_turretplacemessage	= &"^7Hold [{+melee}] to place...";	
	level.waw_turretpickingmessage	= &"^7Picking up...";
	level.waw_turretplacingmessage	= &"^7Placing...";
	
	precacheString( level.waw_turretpickupmessage );
	precacheString( level.waw_turretplacemessage );
	precacheString( level.waw_turretpickingmessage );
	precacheString( level.waw_turretplacingmessage );
	
	precacheModel("xmodel/mg42_bipod");
	precacheItem("mg42_bipod_stand_mp");
	precacheItem("mg42_bipod_prone_mp");
	precacheItem("mg42_bipod_duck_mp");
	precacheTurret("mg42_bipod_duck_mp");
	precacheTurret("mg42_bipod_prone_mp");
	precacheTurret("mg42_bipod_stand_mp");
	precacheShader("ui_mp/assets/hud@mg42_dep_z.dds");
}