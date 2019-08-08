local armorDetection = require(mod_loader.mods[modApi.currentMod].scriptPath.."armorDetection")

Prime_Spearthrow = TankDefault:new{
	Name = "Throw",
	Class = "Prime",
	Icon = "weapons/prime_spearthrow.png",
	Description = "Hurl a spear that deals heavy damage.",
	ProjectileArt = "effects/shot_spear",
	Damage = 2,
	Push = 0,
	Pierce = false,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {2, 2},
	UpgradeList = {"Sharpened", "+1 Damage"},
	TipImage = {
		Unit = Point(2,1),
		CustomPawn = "SpearMech",
		Enemy = Point(2,3),
		Target = Point(2,3)
	},
}

function Prime_Spearthrow:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = self.Damage
	local pathing = PATH_PROJECTILE
	local target = GetProjectileEnd(p1,p2,pathing) 
	
	if Board:IsPawnSpace(target) then
		local targetPawn = Board:GetPawn(target)
		if self.Pierce and armorDetection.IsArmor(targetPawn) and not targetPawn:IsAcid() then
			damage = damage + 1
		end
	end
	 
	ret:AddProjectile(SpaceDamage(target, damage), self.ProjectileArt, NO_DELAY)
	return ret
end

Prime_Spearthrow_A = Prime_Spearthrow:new{
	Damage = 3,
	Pierce = true,
	UpgradeDescription = "Deals 1 extra damage and can pierce 1 layer of armor.",
}

Prime_Spearthrow_B = Prime_Spearthrow:new{
	Damage = 3,
	UpgradeDescription = "Deals 1 extra damage.",
}

Prime_Spearthrow_AB = Prime_Spearthrow:new{
	Damage = 4,
	Pierce = true,
}
