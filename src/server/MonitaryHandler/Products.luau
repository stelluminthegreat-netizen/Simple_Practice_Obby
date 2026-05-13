local products = {}

products[3590489186] = function(receipt, plr)
    shared.Task:Wait(24)
	local player = shared.Player.Players[plr.Name]
	local character = player.Character
	local char = character.Character
	local anim = game.ReplicatedStorage.Animations.KillPlayer
	local track = char.Humanoid.Animator:LoadAnimation(anim)
	local hrp = char.HumanoidRootPart
	local originalCFrame = hrp.CFrame
	hrp.Anchored = true

    local targetName = plr.KillPlayerTarget.Value
    local targetPlayerObj = shared.Player.Players[targetName]
    local targetCharacterObj = targetPlayerObj.Character 
    local targetCharacter = targetCharacterObj.Character
    local targetHRP = targetCharacter.HumanoidRootPart

	local rootAtt = targetHRP.RootAttachment
	targetHRP.Anchored = true
	local linearVelocity = Instance.new("LinearVelocity", rootAtt)
	linearVelocity.MaxForce = 500_000
	linearVelocity.VectorVelocity = targetHRP.CFrame.LookVector * -500_000
	linearVelocity.Attachment0 = rootAtt
	player:Teleport(targetHRP.CFrame * CFrame.new(0, 0, -10) * CFrame.Angles(0, math.rad(180), 0))

	local phase1 = game.ReplicatedStorage.Particles.Phase1:Clone()
	local phase2 = game.ReplicatedStorage.Particles.Phase2:Clone()

	track:GetMarkerReachedSignal("Charge"):Connect(function()
		for _, child in phase1:GetChildren() do
			child:Emit(10)
			print("emit")
		end
		phase1.Parent = char.RightHand
	end)

	track:GetMarkerReachedSignal("FinishCharge"):Connect(function()
		phase1:Destroy()
		phase2.Parent = char.RightHand
		for _, child in phase2:GetChildren() do
			child:Emit(5)
		end
	end)

	track:GetMarkerReachedSignal("Hit"):Connect(function()
		targetHRP.Anchored = false
		task.wait(0.1)
		linearVelocity:Destroy()
		hrp.Anchored = false
		shared.Task:Wait(48)
		player:Teleport(originalCFrame)
		phase2:Destroy()
	end)
	track:Play()

	return true
end

return products