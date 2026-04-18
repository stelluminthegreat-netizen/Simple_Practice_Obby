return {
    ["Damage"] = function(obstacle)
        for index, part in obstacle.Model:GetDescendants() do
            if part.Name ~= "DamagePart" then continue end
            obstacle.Connections[part] = part.Touched:Connect(function(Part)
                if not part.Parent:FindFirstChild("Humanoid") then return end
                if obstacle.DamagingList[part.Parent.Name] then return end
                
                local name = part.Parent.Name
                local character = shared.Character.Characters[name]
                obstacle.DamagingList[name] = character
                character:IncrementHealth(obstacle.Damage)
                obstacle.DamagingList[name] = nil
            end)
        end
    end,

    ["Reposition"] = function(obstacle)
        
    end,

    ["Reorient"] = function(obstacle)
        
    end
}