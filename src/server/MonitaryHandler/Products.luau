local products = {}

products[3590489186] = function(receipt, plr)
    shared.Task:Wait(24)
    local targetName = plr.KillPlayerTarget.Value
    local targetPlayerObj = shared.Player.Players[targetName]
    local targetCharacterObj = targetPlayerObj.Character 
    local targetCharacter = targetCharacterObj.Character

    local targetHRP = targetCharacter.HumanoidRootPart
    targetHRP.Anchored = true
end

return products