// This is an american winter character with the first gear loadout
main()
{
	self setModel("xmodel/playerbody_american_airborne_winter");
	character\_utility_mp::attachFromArray(xmodelalias\head_allied::main());
	self.hatModel = character\_utility::randomElement(xmodelalias\helmet_us_airborne::main());
	self attach(self.hatModel, "", true);
	self setViewmodel("xmodel/viewmodel_hands_uswinter");
	if (character\_utility::useOptionalModels())
	{
		character\_utility_mp::attachFromArray(xmodelalias\gear_airborne::main());
	}
}

precache()
{
	precacheModel("xmodel/playerbody_american_airborne_winter");
	character\_utility::precacheModelArray(xmodelalias\head_allied::main());

	character\_utility::precacheModelArray(xmodelalias\helmet_us_airborne::main());
	precacheModel("xmodel/viewmodel_hands_uswinter");
	if (character\_utility::useOptionalModels())
	{
		character\_utility::precacheModelArray(xmodelalias\gear_airborne::main());
	}
}
