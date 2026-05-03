local tweenService = game:GetService("TweenService")

return {
    ["Damage"] = function(obstacle)
        for index, part in obstacle.Model:GetDescendants() do
            if part.Name ~= "DamagePart" then continue end
            local size = Vector3.new(0.2, 0.2, 0.2)
            shared.Threads:Spawn(function()
                while true do
                    shared.Task:Wait(48 / 24)
                    local inRange = workspace:GetPartBoundsInBox(part.CFrame, part.Size + size)
                    for _, Part in inRange do
                        if not Part.Parent:FindFirstChild("Humanoid") then continue end
                        if obstacle.DamagingList[part.Parent.Name] then continue end
                        
                        local name = Part.Parent.Name
                        local character = shared.Character.Characters[name]
                        obstacle.DamagingList[name] = character
                        character:Kill()
                        obstacle.DamagingList[name] = nil 
                    end
                end
            end)
        end
    end,

    ["Reposition"] = function(obstacle) 
        -- TESTED
        obstacle.OriginalPosition = obstacle.Model.Reference.Position
        local reference = obstacle.Model.Reference

        local pos1 = obstacle.OriginalPosition - obstacle.TargetPos
        local pos2 = pos1 + obstacle.TargetPos

        local x1 = pos1.X
        local y1 = pos1.Y
        local z1 = pos1.Z

        local x2 =  pos2.X
        local y2 = pos2.Y
        local z2 = pos2.Z

        local incrementX = obstacle.RepositionIncrementSpeed.X
        local incrementY = obstacle.RepositionIncrementSpeed.Y
        local incrementZ = obstacle.RepositionIncrementSpeed.Z

        shared.Threads:Spawn(function()
            local running = obstacle.RepositionStart
            if running == true then return end
            if not running then obstacle.RepositionStart = true end
            shared.Task:Wait((obstacle.PreRunWait or 1/48) * 48)   
            while true do
                while reference.Position ~= pos1 do
                    shared.Task:Wait(obstacle.RepositionWait * 48)
                    local referenceX = reference.Position.X
                    local referenceY = reference.Position.Y
                    local referenceZ = reference.Position.Z

                    
                    local newX = referenceX
                    local newY = referenceY
                    local newZ = referenceZ

                    if referenceX ~= x1 then newX = reference.Position.X - incrementX end
                    if referenceY ~= y1 then newY = reference.Position.Y - incrementY end
                    if referenceZ ~= z1 then newZ = reference.Position.Z - incrementZ end

                    reference.Position = Vector3.new(newX, newY, newZ)
                end

                shared.Task:Wait((obstacle.WaitPerReposition or 1/48)* 48)

                while reference.Position ~= pos2 do
                    shared.Task:Wait(obstacle.RepositionWait * 48)
                    local referenceX = reference.Position.X
                    local referenceY = reference.Position.Y
                    local referenceZ = reference.Position.Z
                    
                    local newX = referenceX
                    local newY = referenceY
                    local newZ = referenceZ

                    if referenceX ~= x2 then newX = reference.Position.X + incrementX end
                    if referenceY ~= y2 then newY = reference.Position.Y + incrementY end
                    if referenceX ~= z2 then newZ = reference.Position.Z + incrementZ end

                    reference.Position = Vector3.new(newX, newY, newZ)
                end
                
                shared.Task:Wait((obstacle.WaitPerReposition or 1/48) * 48)
                
            end
        end)
    end,

    ["Reorient"] = function(obstacle)
        shared.Threads:Spawn(function()
            shared.Task:Wait((obstacle.PreRunWait or 1/48)  * 48)   
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