// This file will randomly select a character model from the ones listed
main()
{

	switch(randomint(1))
	{
	case 0:
		character\mp_american_airborne01_winter::main();
		break;
	}
}

precache()
{
	character\mp_american_airborne01_winter::precache();
}
