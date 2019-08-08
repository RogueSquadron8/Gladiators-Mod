Prime_Ram = Skill:new{
	Name = "Pneumatic Ram",
	Class = "Prime",
	Icon = "weapons/prime_ram.png",
	Description = "Ram an adjacent unit, pushing it backwards.",
	LaunchSound = "/weapons/shield_bash",
	Damage = 2,
	SideSmoke = false,
	FullPush = false,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {1, 2},
	UpgradeList = {"Smoke", "Full Push"},
	TipImage = StandardTips.Melee,
}

function Prime_Ram:GetTargetArea(point)
	local ret = PointList()
	for dir = DIR_START, DIR_END do
		local curr = point + DIR_VECTORS[dir]
		if Board:IsValid(curr) then
			ret:push_back(curr)
		end
	end
	return ret
end

function Prime_Ram:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = self.Damage
	local dir = GetDirection(p2 - p1)
	
	if self.FullPush then
		ret:AddDamage(SpaceDamage(p2, damage))
		local chargeEnd = p2 + DIR_VECTORS[dir]
		while not Board:IsBlocked(chargeEnd, PATH_PROJECTILE) do
			chargeEnd = chargeEnd + DIR_VECTORS[dir]
		end
		chargeEnd = chargeEnd - DIR_VECTORS[dir]
		ret:AddCharge(Board:GetSimplePath(p2, chargeEnd), NO_DELAY)
	else
		local dam = SpaceDamage(p2, damage, dir)
		ret:AddDamage(dam)
	end
	
	if self.SideSmoke then
		local smokeSpace = p1 + DIR_VECTORS[(dir+1)%4]
		local smokeDamage = SpaceDamage(p1 + DIR_VECTORS[(dir+1)%4], 0)
		smokeDamage.iSmoke = 1
		smokeDamage.sAnimation = "exploout0_"..GetDirection((p1 + DIR_VECTORS[(dir+1)%4]) - p1)
		ret:AddDamage(smokeDamage)
		local smokeDamage2 = SpaceDamage(p1 + DIR_VECTORS[(dir-1)%4], 0)
		smokeDamage2.iSmoke = 1
		smokeDamage2.sAnimation = "exploout0_"..GetDirection((p1 + DIR_VECTORS[(dir-1)%4]) - p1)
		ret:AddDamage(smokeDamage2)
	end
	
	return ret
end

Prime_Ram_A = Prime_Ram:new{
	SideSmoke = true,
	UpgradeDescription = "Ejects smoke on adjacent tiles.",
}

Prime_Ram_B = Prime_Ram:new{
	FullPush = true,
	UpgradeDescription = "Pushes targets as far as possible.",
	TipImage = {
		Unit = Point(2,3),
		Enemy = Point(2,2),
		Target = Point(2,2)
	},
}

Prime_Ram_AB = Prime_Ram:new{
	SideSmoke = true,
	FullPush = true,
	TipImage = Prime_Ram_B.TipImage,
}