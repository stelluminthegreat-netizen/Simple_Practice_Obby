local tweenService = game:GetService("TweenService")

return {
    ["Damage"] = function(obstacle)
        for index, part in obstacle.Model:GetDescendants() do
            if part.Name ~= "DamagePart" then continue end
            local size = Vector3.new(1, 1, 1)
            shared.Threads:Spawn(function()
                while true do
                    shared.Task:Wait(48 / 8)
                    warn("Running")
                    local inRange = workspace:GetPartBoundsInBox(part.CFrame, part.Size + size)
                    for _, Part in inRange do
                        if not Part.Parent:FindFirstChild("Humanoid") then print(Part.Parent:GetChildren()) continue end
                        if obstacle.DamagingList[part.Parent.Name] then print(obstacle.DamagingList) continue end
                        
                        local name = Part.Parent.Name
                        local character = shared.Character.Characters[name]
                        obstacle.DamagingList[name] = character
                        character:IncrementHealth(-obstacle.Damage)
                        obstacle.DamagingList[name] = nil
                    end
                end
            end)
        end
    end,

    ["Reposition"] = function(obstacle)     
        
        -- USE ALIGN POSITION.

        obstacle.OriginalPosition = obstacle.Model.Reference.Position
        local reference = obstacle.Model.Reference

        local goal1 = { CFrame = CFrame.new(obstacle.OriginalPosition - obstacle.TargetPos) }
        local tweenInfo1 = TweenInfo.new(obstacle.RepositionSpeed)
        local tween1 = tweenService:Create(reference, tweenInfo1, goal1)

        local goal2 = { CFrame = CFrame.new(obstacle.OriginalPosition + obstacle.TargetPos) }
        local tweenInfo2 = TweenInfo.new(obstacle.RepositionSpeed)
        local tween2 = tweenService:Create(reference, tweenInfo2, goal2)
        
        shared.Threads:Spawn(function()
            while true do
                tween1:Play()
                tween1.Completed:Wait()

                shared.Task:Wait(24)

                tween2:Play()
                tween2.Completed:Wait()
            end
        end)
    end,

    ["Reorient"] = function(obstacle)
        -- USE ALIGN ORIENTATION
    end
}