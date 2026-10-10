-- This file includes all the available Eras, Factions and Maps.
-- Faction names have to match with the ones in the gunlists.

local Factions = {
	{"Republic", "CIS"},
	{"Rebellion", "Empire"},
	{"Resistance", "FO"}
}

local Maps = {
	{
		"S5_1/Levels/MP/Geonosis_01/Geonosis_01",
		"Levels/MP/Kamino_01/Kamino_01",
		"Levels/MP/Naboo_01/Naboo_01",
		"Levels/MP/Kashyyyk_01/Kashyyyk_01"
	},
	{
		"Levels/MP/Tatooine_01/Tatooine_01",
		"Levels/MP/Yavin_01/Yavin_01",
		"Levels/MP/Hoth_01/Hoth_01",
		"Levels/MP/Endor_01/Endor_01",
		"Levels/MP/DeathStar02_01/DeathStar02_01"
	},
	{
		"Levels/MP/Jakku_01/Jakku_01",
		"Levels/MP/Takodana_01/Takodana_01",
		"Levels/MP/StarKiller_01/StarKiller_01",
		"S1/Levels/Crait_01/Crait_01"
	}
}

return {
	Factions = Factions,
	Maps = Maps
}