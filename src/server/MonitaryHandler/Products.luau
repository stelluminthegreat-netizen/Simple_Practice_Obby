local products = {}

products[3590489186] = function(receipt, plr)
    shared.Task:Wait(24)
    local targetName = plr.KillPlayerTarget.Value
    local targetPlayerObj = shared.Player.Players[targetName]
    local targetCharacterObj = targetPlayerObj.Character 
    local targetCharacter = targetCharacterObj.Character
    local targetHRP = targetCharacter.HumanoidRootPart

    local rootAtt = targetHRP.RootAttachment
	targetHRP.Anchored = true
	local linearVelocity = Instance.new("LinearVelocity", rootAtt)
	linearVelocity.Enabled = false
	linearVelocity.MaxForce = 100_000
	linearVelocity.VectorVelocity = targetHRP.CFrame.LookVector * -100_000
	linearVelocity.Attachment0 = rootAtt
	linearVelocity.Enabled = true
	task.wait(2)
	targetHRP.Anchored = false
	task.wait(0.1)
	linearVelocity:Destroy()

	return true
end

return products