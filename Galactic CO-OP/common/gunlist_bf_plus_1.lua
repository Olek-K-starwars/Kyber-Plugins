-- Credit to https://github.com/ArmchairDevelopers/PluginExamples/blob/main/GunGame/server/bfplus_gun_list.lua, I got some weapon names from there.

-- As I mentioned before, gun lists are no possible yet.


local Republic = {
	{ -- Assault
		{
			"Gameplay/Equipment/Rifles/DC15A/U_BlasterRifle_DC15A"
		},
		{},
		{
			"_Expanded_Arsenal/Assault/GALAAR15/U_GALAAR15", "_Expanded_Arsenal/Assault/EE3/U_EE3", "Gameplay/Equipment/Rifles/CR2/U_BlasterRifle_CR2"
		}
	},
	{ -- Heavy
		{
			"Gameplay/Equipment/Heavy/DC15/U_HeavyBlaster_DC15", "Gameplay/Equipment/Heavy/DC15/U_HeavyBlaster_DC15_LE" -- Common
		},
		{
			"_Expanded_Arsenal/Heavy/DP23/U_DP23", "_expanded_arsenal/heavy/DC12U/U_Heavy_DC12U" -- Rare
		},
		{
			"_Expanded_Arsenal/heavy/V6D/U_Heavy_V6D", "_Expanded_Arsenal/Heavy/T7/U_T7", "_Expanded_Arsenal/Heavy/Baragwin/U_Baragwin" -- Very Rare (epic)
		}
	},
	{ -- Officer
		{
			"Gameplay/Equipment/Pistols/DC17/U_Pistol_DC17"
		},
		{
			"_Expanded_Arsenal/Officer/DC15S/U_DC15S", "_Expanded_Arsenal/Officer/DC17-Silenced/U_Pistol_DC17-Silenced"
		},
		{
			"_Expanded_Arsenal/Officer/LL30/U_Pistol_LL30", "_Expanded_Arsenal/Officer/LL30_Navy/U_Pistol_LL30_Navy", "_Expanded_Arsenal/Officer/Q2/U_Pistol_Q2", "Gameplay/Equipment/Pistols/S5/U_Pistol_S5", "_Expanded_Arsenal/Officer/Westar35/U_Pistol_Westar35"
		}
	},
	{ -- Specialist
		{
			"Gameplay/Equipment/LongRange/Valken38x/U_LongRange_Valken38x"
		},
		{
			"_Expanded_Arsenal/Specialist/Firepuncher/U_Firepuncher", "_Expanded_Arsenal/Specialist/DC17M-Sniper/U_DC17M-Sniper"
		},
		{
			"_Expanded_Arsenal/Specialist/Bowcaster/U_Bowcaster", "_Expanded_Arsenal/Specialist/Relby/U_Relby", "Gameplay/Equipment/LongRange/E5S/U_LongRange_E5S"
		}
	},	
}

local CIS = {
	{ -- Assault
		{
			"Gameplay/Equipment/Rifles/E5/U_BlasterRifle_E5"
		},
		{},
		{}
		
	},
	{ -- Heavy
		{
			"Gameplay/Equipment/Heavy/E5C/U_HeavyBlaster_E5C"
		},
		{},
		{}
		
	},
	{ -- Officer
		{
			"Gameplay/Equipment/Pistols/RG4D/U_Pistol_RG4D"
		},
		{},
		{
			"_Expanded_Arsenal/Officer/Westar35/U_Pistol_Westar35"
		}
		
	},
	{ -- Specialist
		{
			"Gameplay/Equipment/LongRange/E5S/U_LongRange_E5S"
		},
		{},
		{
			"_Expanded_Arsenal/Specialist/Bowcaster/U_Bowcaster"
		}
		
	}
}

local Rebellion = {
	{ -- Assault
		{
			"Gameplay/Equipment/Rifles/A280/U_BlasterRifle_A280", "Gameplay/Equipment/Rifles/A280C/U_BlasterRifle_A280C"
		},
		{
			"_Expanded_Arsenal/Assault/CA87/U_ShortRange_CA87", "_Expanded_Arsenal/Assault/EE4/U_EE4", "_Expanded_Arsenal/Assault/EE3/U_EE3", "_Expanded_Arsenal/Assault/NeoCrusader/U_Rifle_NeoCrusader", "_Expanded_Arsenal/Assault/DH17Rifle/U_Rifle_DH17Rifle", "_Expanded_Arsenal/Assault/SpaceSten/U_SpaceSten", "_Expanded_Arsenal/Assault/DoubleBarrel/U_ShortRange_DoubleBarrel"
		},
		{
			"_Expanded_Arsenal/Assault/E10/U_Rifle_E10", "Gameplay/Equipment/Rifles/E11/U_BlasterRifle_E11", "Gameplay/Equipment/Rifles/E11DMod/U_BlasterRifle_E11DMod", "_Expanded_Arsenal/Assault/ZersiumRifle/U_Rifle_ZersiumRifle" 
		}
	},
	{ -- Heavy
		{
			"Gameplay/Equipment/Heavy/RT97C/U_HeavyBlaster_RT97C"
		},
		{
			"Gameplay/Equipment/Heavy/T21Mod/U_HeavyBlaster_T21Mod", "Gameplay/Equipment/Heavy/M45/U_HeavyBlaster_M45", "_Expanded_Arsenal/Heavy/ABR2/U_Heavy_ABR2"
		},
		{
			"_Expanded_Arsenal/Heavy/T7/U_T7", "_Expanded_Arsenal/heavy/V6D/U_Heavy_V6D", "_expanded_arsenal/heavy/tl40/U_Heavy_TL40", "Gameplay/Equipment/Heavy/TL50/U_HeavyBlaster_TL50", "_Expanded_Arsenal/Heavy/E22/U_E22", "Gameplay/Equipment/Heavy/DLT19/U_HeavyBlaster_DLT19", "_Expanded_Arsenal/Heavy/DF95/U_Heavy_DF95"
		}
	},
	{ -- Officer
		{
			"Gameplay/Equipment/Pistols/DH17/U_Pistol_DH17"
		},
		{
			"Gameplay/Equipment/Pistols/Blurrg1120/U_Pistol_Blurrg1120", "_Expanded_Arsenal/Officer/BG38/U_Pistol_BG38", "_Expanded_Arsenal/Officer/DL21/U_Pistol_DL21", "Gameplay/Equipment/Pistols/DL18Mod/U_Pistol_DL18Mod", "_Expanded_Arsenal/Officer/DL44/U_Pistol_DL44_ScopeMod", "_Expanded_Arsenal/Officer/DT12/U_DT12", "_Expanded_Arsenal/Officer/Turgle/U_Pistol_Turgle", "_Expanded_Arsenal/Officer/X8/U_X8"
		},
		{
			"_Expanded_Arsenal/Officer/DT29/U_DT29", "_Expanded_Arsenal/Officer/EC17/U_EC17", "_Expanded_Arsenal/Officer/BryarPistol/U_BryarPistol_a1", "_Expanded_Arsenal/Officer/LL30/U_Pistol_LL30", "Gameplay/Equipment/Pistols/RK3/U_Pistol_RK3", "_Expanded_Arsenal/Officer/SE14r/U_Pistol_SE14r", "_Expanded_Arsenal/Officer/SE14C/U_Pistol_SE14C_v2"
		}
	},
	{ -- Specialist
		{
			"Gameplay/Equipment/LongRange/DLT20A/U_LongRange_DLT20A", "Gameplay/Equipment/LongRange/A180/U_LongRange_A180"
		},
		{
			"Gameplay/Equipment/LongRange/IQA11/U_LongRange_IQA11", "_Expanded_Arsenal/Specialist/PK23/U_Specialist_PK23", "_Expanded_Arsenal/Specialist/T21B/U_T21B", "Gameplay/Equipment/LongRange/NT242/U_LongRange_NT242", "Gameplay/Equipment/LongRange/CyclerRifleMod/U_LongRange_CyclerRifleMod"
		},
		{
			"_Expanded_Arsenal/Specialist/Relby/U_Relby", "Gameplay/Equipment/LongRange/DLT19X/U_LongRange_DLT19X", "Gameplay/Equipment/LongRange/DLT19D/U_LongRange_DLT19D"
		}
	}
}

local Empire = {
	{ -- Assault
		{
			"Gameplay/Equipment/Rifles/E11/U_BlasterRifle_E11"
		},
		{
			"_Expanded_Arsenal/Assault/E10/U_Rifle_E10"
		},
		{
			"_Expanded_Arsenal/Assault/EE4/U_EE4", "Gameplay/Equipment/Rifles/E11DMod/U_BlasterRifle_E11DMod", "Gameplay/Equipment/Rifles/A280/U_BlasterRifle_A280", "Gameplay/Equipment/Rifles/A280C/U_BlasterRifle_A280C", "_Expanded_Arsenal/Assault/DH17Rifle/U_Rifle_DH17Rifle"
		}
	},
	{ -- Heavy
		{
			"Gameplay/Equipment/Heavy/DLT19/U_HeavyBlaster_DLT19"
		},
		{
			"Gameplay/Equipment/Heavy/TL50/U_HeavyBlaster_TL50","_expanded_arsenal/heavy/tl40/U_Heavy_TL40", "_Expanded_Arsenal/Heavy/DF95/U_Heavy_DF95", "_Expanded_Arsenal/Heavy/E22/U_E22", "Gameplay/Equipment/Heavy/T21Mod/U_HeavyBlaster_T21Mod", "Gameplay/Equipment/Heavy/RT97C/U_HeavyBlaster_RT97C"
		},
		{
			"Gameplay/Equipment/Heavy/M45/U_HeavyBlaster_M45"
		}
	},
	{ -- Officer
		{
			"Gameplay/Equipment/Pistols/RK3/U_Pistol_RK3", "_Expanded_Arsenal/Officer/SE14r/U_Pistol_SE14r"
		},
		{
			"_Expanded_Arsenal/Officer/SE14C/U_Pistol_SE14C_v2"
		},
		{
			"Gameplay/Equipment/Pistols/DH17/U_Pistol_DH17", "Gameplay/Equipment/Pistols/Blurrg1120/U_Pistol_Blurrg1120"
		}
	},
	{ -- Specialist
		{
			"Gameplay/Equipment/LongRange/DLT19X/U_LongRange_DLT19X"
		},
		{
			"Gameplay/Equipment/LongRange/DLT19D/U_LongRange_DLT19D"
		},
		{
			"Gameplay/Equipment/LongRange/DLT20A/U_LongRange_DLT20A", "Gameplay/Equipment/LongRange/A180/U_LongRange_A180"
		}
	}
}

local Resistance = {
	{ -- Assault
		{
			"Gameplay/Equipment/Rifles/EL16HFE/U_BlasterRifle_EL16HFE"
		},
		{
			"_Expanded_Arsenal/Assault/DH17Rifle/U_Rifle_DH17Rifle", "_Expanded_Arsenal/Assault/SpaceSten/U_SpaceSten", "_Expanded_Arsenal/Assault/VT33D/U_VT33D", "_Expanded_Arsenal/Assault/NeoCrusader/U_Rifle_NeoCrusader"
		},
		{
			"Gameplay/Equipment/Rifles/F11D/U_BlasterRifle_F11D", "_Expanded_Arsenal/Assault/STW48/U_STW48", "_Expanded_Arsenal/Assault/CA87/U_ShortRange_CA87", "_Expanded_Arsenal/Assault/ZersiumRifle/U_Rifle_ZersiumRifle"
		}
	},
	{ -- Heavy
		{
			"Gameplay/Equipment/Heavy/M45/U_HeavyBlaster_M45"
		},
		{},
		{
			"Gameplay/Equipment/Heavy/FWMB10/U_HeavyBlaster_FWMB10Mod"
		}
	},
	{ -- Officer
		{
			"Gameplay/Equipment/Pistols/Glie44/U_Pistol_GlieE44"
		},
		{
			"Gameplay/Equipment/Pistols/Blurrg1120/U_Pistol_Blurrg1120", "_Expanded_Arsenal/Officer/BG38/U_Pistol_BG38", "_Expanded_Arsenal/Officer/DT29/U_DT29", "Gameplay/Equipment/Pistols/DL18Mod/U_Pistol_DL18Mod"
		},
		{
			"Gameplay/Equipment/Pistols/DH17/U_Pistol_DH17", "Gameplay/Equipment/Pistols/SE44C/U_Pistol_SE44C"
		}
	},
	{ -- Specialist
		{
			"Gameplay/Equipment/LongRange/A180/U_LongRange_A180"
		},
		{
			"Gameplay/Equipment/LongRange/A280CFE/U_LongRange_A280CFE"
		},
		{
			"Gameplay/Equipment/LongRange/DLT19D/U_LongRange_DLT19D"
		}
	}
}

local FO = {
	{ -- Assault
		{
			"Gameplay/Equipment/Rifles/F11D/U_BlasterRifle_F11D"
		},
		{},
		{
			"Gameplay/Equipment/Rifles/EL16HFE/U_BlasterRifle_EL16HFE"
		}
	},
	{ -- Heavy
		{
			"Gameplay/Equipment/Heavy/FWMB10/U_HeavyBlaster_FWMB10Mod"
		},
		{},
		{
			"Gameplay/Equipment/Heavy/M45/U_HeavyBlaster_M45"
		}
	},
	{ -- Officer
		{
			"Gameplay/Equipment/Pistols/SE44C/U_Pistol_SE44C"
		},
		{},
		{
			"Gameplay/Equipment/Pistols/Glie44/U_Pistol_GlieE44"
		}
	},
	{ -- Specialist
		{
			"Gameplay/Equipment/LongRange/A280CFE/U_LongRange_A280CFE", "Gameplay/Equipment/LongRange/A180/U_LongRange_A180"
		},
		{},
		{
			"Gameplay/Equipment/LongRange/DLT19D/U_LongRange_DLT19D"
		}
	}
}

-- Enables bots to be able to pick the Sonic Blaster on Geonosis
-- Only enable if using Battlefront Plus
local hardcodedSonicBlaster = true

-- Returning
return {
	Republic = Republic,
	CIS = CIS,
	Rebellion = Rebellion,
	Empire = Empire,
	Resistance = Resistance,
	FO = FO,
	hardcodedSonicBlaster = hardcodedSonicBlaster
}