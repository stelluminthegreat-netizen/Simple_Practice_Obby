local self = {}

function self.initialize()
	
end

function self.start()
	local Obby = game.Workspace.Obby:GetChildren()
    for index, obby in Obby do
        if not obby:HasTag("Obby") then continue end
        local spawnPoint = shared.SpawnPoint.new(obby.MainPlatform)
    end
end

return self
