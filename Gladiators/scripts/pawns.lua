SpearMech = {
	Name = "Spear Mech",
	Class = "Prime",
	Image = "SpearMech",
	ImageOffset = FURL_COLORS.GladiatorColors,
	Health = 3,
	MoveSpeed = 4,
	SkillList = { "Prime_Jab", "Prime_Spearthrow" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Flying = false,
}
AddPawn("SpearMech")

SawMech = {
	Name = "Saw Mech",
	Class = "Prime",
	Image = "SawMech",
	ImageOffset = FURL_COLORS.GladiatorColors,
	Health = 4,
	MoveSpeed = 4,
	SkillList = { "Prime_Swipe" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Flying = false,
}
AddPawn("SawMech")

RamMech = {
	Name = "Ram Mech",
	Class = "Prime",
	Image = "RamMech",
	ImageOffset = FURL_COLORS.GladiatorColors,
	Health = 4,
	MoveSpeed = 3,
	SkillList = { "Prime_Ram" },
	SoundLocation = "/mech/prime/punch_mech/",
	DefaultTeam = TEAM_PLAYER,
	ImpactMaterial = IMPACT_METAL,
	Massive = true,
	Flying = false,
}
AddPawn("RamMech")