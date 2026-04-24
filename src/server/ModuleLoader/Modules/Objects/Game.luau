local self = {}

function self.initialize()
	
end

function self.start()
	local Obby = game.Workspace.Obby:GetChildren()
    for index, obby in Obby do
        if not obby:HasTag("Obby") then continue end
        local spawnPoint = shared.SpawnPoint.new(obby.Model.MainPlatform)
    end

    for index, obby in Obby do
         if not obby:HasTag("Obby") then continue end
         for _, obstacle in obby:GetDescendants() do
            if not obstacle:HasTag("Obstacle") then continue end
            local Obstacle = shared.Obstacle.new(obstacle)
         end
    end
end

return self
