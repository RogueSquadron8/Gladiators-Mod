Prime_Jab = Skill:new{
	Name = "Jab",
	Class = "Prime",
	Description = "Damage up to two adjacent enemies in a line and push the furthest.",
	Icon = "weapons/prime_jab.png",
	LaunchSound = "/weapons/sword",
	Range = 2, 
	PathSize = 2,
	Damage = 2,
	Safety = false,
	Push = 1,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {1, 2},
	UpgradeList = {"Safety", "+1 Range"},
	TipImage = {
		Unit = Point(2,3),
		CustomPawn = "SpearMech",
		Enemy = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1)
	}
}

function Prime_Jab:GetTargetArea(point)
	local ret = PointList()
	for i = DIR_START, DIR_END do
		for k = 1, self.PathSize do
			local curr = DIR_VECTORS[i]*k + point
			ret:push_back(curr)
			if not Board:IsValid(curr) or Board:GetTerrain(curr) == TERRAIN_MOUNTAIN then
				break
			end
		end
	end
	
	return ret
end

function Prime_Jab:GetSkillEffect(p1, p2)
	local ret = SkillEffect()
	local direction = GetDirection(p2 - p1)
	local distance = p1:Manhattan(p2)
	for i = 1, distance do
		local push = (i == distance) and direction*self.Push or DIR_NONE
		local damage
		if not self.Safety then
			damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i, self.Damage, push)
		elseif Board:IsBuilding(p1 + DIR_VECTORS[direction]*i) then
			damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i, 0)
		elseif not Board:IsPawnSpace(p1 + DIR_VECTORS[direction]*i) then
			damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i,self.Damage, push)
		elseif not (Board:GetPawn(p1 + DIR_VECTORS[direction]*i):GetTeam() == TEAM_PLAYER) then
			damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i,self.Damage, push)
		else 
			damage = SpaceDamage(p1 + DIR_VECTORS[direction]*i, 0)
		end
		if i == 1 then
			damage.sAnimation = "explospear"..distance.."_"..direction
		end
		ret:AddDamage(damage)
	end

	return ret
end	

Prime_Jab_A = Prime_Jab:new{
	Safety = true,
	UpgradeDescription = "Avoids damaging allies and buildings.",
	TipImage = {
		Unit = Point(2,3),
		Building = Point(2,2),
		Enemy2 = Point(2,1),
		Target = Point(2,1)
	},
}

Prime_Jab_B = Prime_Jab:new{
	Range = 3, 
	PathSize = 3,
	UpgradeDescription = "Reaches up to one tile further.",
	TipImage = {
		Unit = Point(2,4),
		Building = Point(2,2),
		Enemy = Point(2,3),
		Enemy2 = Point(2,1),
		Target = Point(2,1)
	},
}

Prime_Jab_AB = Prime_Jab:new{
	Safety = true,
	Range = 3, 
	PathSize = 3,
	TipImage = Prime_Jab_B.TipImage,
}