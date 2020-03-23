Localization = {}

Necrosis = {
	Config = {},
	CurrentEnv = {
		ChatPrefix = "necrosis-cre",
		PlayerGuid = UnitGUID("player"),
		PlayerName = UnitName("player"),
		PlayerFullName = nil,
		InParty = false,
		InRaid = false,
		SpellCast = {}
	},
	Gui = {},
	Speech = {},
	Translation = {},
	Unit = {}
}

Necrosis.Data = {
	Version = GetAddOnMetadata("Necrosis-Classic", "Version"),
	AppName = "Necrosis LdC",
	LastConfig = 20191125
}
Necrosis.Data.Label = Necrosis.Data.AppName.." "..Necrosis.Data.Version


-- Global variables || Variables globales
NecrosisConfig = {}
