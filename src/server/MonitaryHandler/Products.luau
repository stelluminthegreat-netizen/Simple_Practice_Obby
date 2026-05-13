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
	track:GetMarkerReachedSignal("Hit"):Connect(function()
		targetHRP.Anchored = false
		task.wait(0.1)
		linearVelocity:Destroy()
		hrp.Anchored = false
		shared.Task:Wait(48)
		player:Teleport(originalCFrame)
	end)
	track:Play()

	return true
end

return products