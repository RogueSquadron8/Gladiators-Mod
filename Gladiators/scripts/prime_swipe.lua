Prime_Swipe = Skill:new{
	Name = "Saw Swipe",
	Class = "Prime",
	Icon = "weapons/prime_swipe.png",
	Description = "Swipe at a corner tile, damaging it and two adjacent tiles. Pushes units in the clockwise direction.",
	LaunchSound = "/weapons/charge",
	Damage = 1,
	Daze = false,
	PowerCost = 1,
	Upgrades = 2,
	UpgradeCost = {2, 3},
	UpgradeList = {"Daze", "+2 Damage"},
	TipImage = {
		Unit = Point(2,2),
		CustomPawn = "SawMech",
		Target = Point(3,3),
		Enemy = Point(3,3),
		Enemy2 = Point(2,3),
		Enemy3 = Point (3,2),
	},
}

function Prime_Swipe:GetSkillEffect(p1,p2)
	local ret = SkillEffect()
	local damage = self.Damage
	local targetPawn = Board:GetPawn(p2)
	local targetPoint
	local targetYGreater = p1.y < p2.y
	local targetXGreater = p1.x < p2.x
		
	local dir = Prime_Swipe:GetCornerPushDirection(targetYGreater, targetXGreater)
	dam = SpaceDamage(p2, damage, dir)
	dam.sAnimation = Prime_Swipe:GetAnim(targetYGreater, targetXGreater)
	ret:AddDamage(dam)
	if targetPawn and self.Daze then 
			ret:AddScript("Board:GetPawn(Point("..p2.x..","..p2.y..")):ClearQueued()")
	end

	if not targetXGreater then
		ret:AddDamage(SpaceDamage(p1 + VEC_LEFT, damage, 0))
		targetPawn = Board:GetPawn(p1 + VEC_LEFT)
		targetPoint = (p1 + VEC_LEFT)
	else
		ret:AddDamage(SpaceDamage(p1 + VEC_RIGHT, damage, 2))
		targetPawn = Board:GetPawn(p1 + VEC_RIGHT)
		targetPoint = (p1 + VEC_RIGHT)
	end
	
	if targetPawn and self.Daze then 
			ret:AddScript("Board:GetPawn(Point("..targetPoint.x..","..targetPoint.y..")):ClearQueued()")
	end

	if targetYGreater then
		ret:AddDamage(SpaceDamage(p1 + VEC_DOWN, damage, 3))
		targetPawn = Board:GetPawn(p1 + VEC_DOWN)
		targetPoint = (p1 + VEC_DOWN)
	else
		ret:AddDamage(SpaceDamage(p1 + VEC_UP, damage, 1))
		targetPawn = Board:GetPawn(p1 + VEC_UP)
		targetPoint = (p1 + VEC_UP)
	end
	
	if targetPawn and self.Daze then 
			ret:AddScript("Board:GetPawn(Point("..targetPoint.x..","..targetPoint.y..")):ClearQueued()")
	end
	
	return ret
end

function Prime_Swipe:GetCornerPushDirection(targetYGreater, targetXGreater)
	local dir
	if targetYGreater then
		if targetXGreater then
			dir = 3
		else
			dir = 0
		end
	else
		if targetXGreater then
			dir = 2
		else
			dir = 1
		end
	end
	return dir
end

function Prime_Swipe:GetAnim(targetYGreater, targetXGreater)
	local animName
	if targetYGreater then
		if targetXGreater then
			animName = "swipe_DL"
		else
			animName = "swipe_UL"
		end
	else
		if targetXGreater then
			animName = "swipe_DR"
		else
			animName = "swipe_UR"
		end
	end
	return animName
end

function Prime_Swipe:GetTargetArea(point)
	local ret = PointList()
	ret:push_back(point + VEC_UP + VEC_RIGHT)
	ret:push_back(point + VEC_UP + VEC_LEFT)
	ret:push_back(point + VEC_DOWN + VEC_RIGHT)
	ret:push_back(point + VEC_DOWN + VEC_LEFT)
	return ret
end

Prime_Swipe_A = Prime_Swipe:new{
	Daze = true,
	UpgradeDescription = "Affected enemies have their attacks cancelled.",
}

Prime_Swipe_B = Prime_Swipe:new{
	Damage = 3,
	UpgradeDescription = "Increases damage to 3.",
}

Prime_Swipe_AB = Prime_Swipe:new{
	Daze = true,
	Damage = 3,
}