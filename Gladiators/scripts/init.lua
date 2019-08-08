local description = "A squad of mechs that specialize in melee engagements."
local modApiExt

local Mechs = {
	{
		Type = "mech",
		Name = "SpearMech",
        Filename = "mech_spear",
  		Path = "img/units/player", 
  		ResourcePath = "units/player",
		Default =           { PosX = -16, PosY = -4 },
        Animated =          { PosX = -16, PosY = -4, NumFrames = 4 },
        Submerged =         { PosX = -16, PosY = 6 },
        Broken =            { PosX = -14, PosY = -2 },
        SubmergedBroken =   { PosX = -18, PosY = 8 },
		Icon =		    {},
	},
	{
		Type = "mech",
		Name = "SawMech",
        Filename = "mech_saw",
  		Path = "img/units/player", 
  		ResourcePath = "units/player",
		Default =           { PosX = -16, PosY = -4 },
        Animated =          { PosX = -16, PosY = -2, NumFrames = 4 },
        Submerged =         { PosX = -18, PosY = 6 },
        Broken =            { PosX = -18, PosY = -2 },
        SubmergedBroken =   { PosX = -18, PosY = 8 },
		Icon =		    {},
	},
	{
		Type = "mech",
		Name = "RamMech",
        Filename = "mech_ram",
  		Path = "img/units/player", 
  		ResourcePath = "units/player",
		Default =           { PosX = -16, PosY = -4 },
        Animated =          { PosX = -18, PosY = -9, NumFrames = 10 },
        Submerged =         { PosX = -24, PosY = -1 },
        Broken =            { PosX = -20, PosY = -14 },
        SubmergedBroken =   { PosX = -18, PosY = 0 },
		Icon =		    	{ PosX = -16, PosY = -4 },
	},
}

local function init(self)
	local extDir = self.scriptPath .."modApiExt/"
	modApiExt = require(extDir .."modApiExt")
	modApiExt:init(extDir)
	
	modApi:appendAsset("img/icons/gladiators_icon.png",self.resourcePath.."img/icons/gladiators_icon.png")
	modApi:appendAsset("img/icons/squad_icon.png",self.resourcePath.."img/icons/squad_icon.png")
	modApi:appendAsset("img/weapons/prime_jab.png",self.resourcePath.."img/weapons/prime_jab.png")
	modApi:appendAsset("img/weapons/prime_spearthrow.png",self.resourcePath.."img/weapons/prime_spearthrow.png")
	modApi:appendAsset("img/weapons/prime_swipe.png",self.resourcePath.."img/weapons/prime_swipe.png")
	modApi:appendAsset("img/weapons/prime_ram.png",self.resourcePath.."img/weapons/prime_ram.png")
	modApi:appendAsset("img/effects/shot_spear_R.png",self.resourcePath.."img/effects/shot_spear_R.png")
	modApi:appendAsset("img/effects/shot_spear_U.png",self.resourcePath.."img/effects/shot_spear_U.png")
	
	--armorDetection library
	local armorDetection = require(self.scriptPath ..'armorDetection')
	
	require(self.scriptPath.."FURL")(self, {
		{
			Type = "color",
			Name = "GladiatorColors",
			PawnLocation = self.scriptPath.."pawns",
			PlateHighlight = {220,207,81},
			PlateLight = {255,255,248},
			PlateMid = {173,173,167},
			PlateDark = {61,61,57},
			PlateOutline = {15,22,16},
			PlateShadow = {34,36,34},
			BodyColor = {67,72,68},
			BodyHighlight = {134,146,120},
		},
		{
			Type = "anim",
			Filename = "swipe_UR",
			Path = "img/effects",
			ResourcePath = "effects",
			Name = "swipe_UR",
			NumFrames = 7,
			Loop = false,
			PosX = -40,
			PosY = 5,
			Time = 0.025,
		},
		{
			Type = "anim",
			Filename = "swipe_DL",
			Path = "img/effects",
			ResourcePath = "effects",
			Name = "swipe_DL",
			Base = "swipe_UR",
			PosX = -60,
			PosY = -30,
		},
		{
			Type = "anim",
			Filename = "swipe_UL",
			Path = "img/effects",
			ResourcePath = "effects",
			Name = "swipe_UL",
			Base = "swipe_UR",
			PosX = -35,
			PosY = -35,
		},
		{
			Type = "anim",
			Filename = "swipe_DR",
			Path = "img/effects",
			ResourcePath = "effects",
			Name = "swipe_DR",
			Base = "swipe_UR",
			PosX = -65,
			PosY = -20,
		},
	});
	

	require(self.scriptPath.."squad_sprite_loader")(self, Mechs)
	require(self.scriptPath.."pawns")
	
	prime_jab = require(self.scriptPath.."prime_jab")
	prime_spearthrow = require(self.scriptPath.."prime_spearthrow")
	prime_swipe = require(self.scriptPath.."prime_swipe")
	prime_ram = require(self.scriptPath.."prime_ram")
	
	
end

local function load(self, options, version)
	modApiExt:load(self, options, version)
	
	modApi:addSquadTrue({"Gladiators", "SpearMech", "SawMech", "RamMech"}, "Gladiators", description, self.resourcePath .. "img/icons/squad_icon.png")
end

return {
	id = "Gladiators",
	name = "Gladiators",
	version = "1.0",
	requirements = {},
	icon = "img/icons/gladiators_icon.png",
	init = init,
	load = load,
}