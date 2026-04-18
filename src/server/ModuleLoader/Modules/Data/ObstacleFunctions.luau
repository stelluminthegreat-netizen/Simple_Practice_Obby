return {
    ["Damage"] = function(obstacle)
        for index, part in obstacle.Model:GetDescendants() do
            if part.Name ~= "DamagePart" then continue end
            obstacle.Connections[part] = part.Touched:Connect(function(Part)
                if not Part.Parent:FindFirstChild("Humanoid") then print(Part.Parent:GetChildren()) return end
                if obstacle.DamagingList[part.Parent.Name] then print(obstacle.DamagingList) return end
                
                print(obstacle.DamagingList)
                local name = Part.Parent.Name
                local character = shared.Character.Characters[name]
                obstacle.DamagingList[name] = character
                character:IncrementHealth(-obstacle.Damage)
                obstacle.DamagingList[name] = nil
                print(character)
            end)
        end
    end,

    ["Reposition"] = function(obstacle)
        
    end,

    ["Reorient"] = function(obstacle)
        
    end
}