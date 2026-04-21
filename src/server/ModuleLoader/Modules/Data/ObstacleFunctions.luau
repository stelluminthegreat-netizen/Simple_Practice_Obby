local tweenService = game:GetService("TweenService")

return {
    ["Damage"] = function(obstacle)
        for index, part in obstacle.Model:GetDescendants() do
            if part.Name ~= "DamagePart" then continue end
            local size = Vector3.new(1, 1, 1)
            shared.Threads:Spawn(function()
                while true do
                    shared.Task:Wait(48 / 12)
                    local inRange = workspace:GetPartBoundsInBox(part.CFrame, part.Size + size)
                    for _, Part in inRange do
                        if not Part.Parent:FindFirstChild("Humanoid") then continue end
                        if obstacle.DamagingList[part.Parent.Name] then continue end
                        
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
        obstacle.OriginalPosition = obstacle.Model.Reference.Position
        local reference = obstacle.Model.Reference

        local pos1 = obstacle.OriginalPosition - obstacle.TargetPos
        local pos2 = obstacle.OriginalPosition + obstacle.TargetPos

        shared.Threads:Spawn(function()
            shared.Task:Wait(obstacle.RepositionWait * 48)   
            while true do
                while reference.Position ~= pos1 do
                    shared.Task:Wait(obstacle.RepositionWait * 48)
                    reference.Position -= obstacle.RepositionIncrementSpeed
                end

                shared.Task:Wait((obstacle.WaitPerReposition or 1/48)* 48)

                while reference.Position ~= pos2 do
                    shared.Task:Wait(obstacle.RepositionWait * 48)
                    reference.Position += obstacle.RepositionIncrementSpeed
                end

                shared.Task:Wait((obstacle.WaitPerReposition or 1/48) * 48)
            end
        end)
    end,

    ["Reorient"] = function(obstacle)
        shared.Threads:Spawn(function()
            shared.Task:Wait(obstacle.ReorientWait * 48)   
            obstacle.Orientation = obstacle.Model.Reference.Orientation
            local reference = obstacle.Model.Reference
            local currentOrientation = reference.Orientation

            while true do
                shared.Task:Wait(1)

                currentOrientation += (obstacle.TargetOrientation * Vector3.new(obstacle.OrientationSpeed, obstacle.OrientationSpeed, obstacle.OrientationSpeed))
                reference.Orientation = currentOrientation
            end
        end)
    end
}