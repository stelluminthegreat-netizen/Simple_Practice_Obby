local products = {}
local tweenServ = require(game.ReplicatedStorage.Shared.Libraries.CustomTween)

products[3590489186] = function(receipt, plr)
    shared.Task:Wait(24)
	local player = shared.Player.Players[plr.Name]
	local char = player.Character.Character
	local anim = game.ReplicatedStorage.Animations.KillPlayer
	local track = char.Humanoid.Animator:LoadAnimation(anim)
	local hrp = char.HumanoidRootPart
	local originalCFrame = hrp.CFrame
	hrp.Anchored = true

    local targetName = plr.KillPlayerTarget.Value
    local targetPlayerObj = shared.Player.Players[targetName]
    local targetCharacter = targetPlayerObj.Character.Character
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
	local hit = game.ReplicatedStorage.MeshVFX.Hit:Clone()
	hit.Parent = workspace

	local tweens = {}

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
		hit:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0, 0, 1))
		for _, effect in pairs(hit:GetChildren()) do
			if effect:IsA("Script") then continue end
			if effect.Name == "Main" then continue end
			effect.Transparency = 0
			local tween = tweenServ.TweenTransparency(effect, 1, 2)
			tweens[tween] = tween
		end
		
		local tween = tweenServ.ScaleModel(hit, 0, 3, 2)
		tweens[tween] = tween
		
		for _, tween in pairs(tweens) do
			tween:Play()
		end
		targetHRP.Anchored = false
		task.wait(0.1)
		linearVelocity:Destroy()
		hrp.Anchored = false
		shared.Task:Wait(48)
		player:Teleport(originalCFrame)
		phase2:Destroy()
		shared.Task:Wait(48 * 2)
		hit:Destroy()
	end)
	track:Play()

	return true
end

return products