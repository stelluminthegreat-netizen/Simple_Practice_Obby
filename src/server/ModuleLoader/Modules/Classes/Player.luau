local class = {}
class.__index = class

function class.new(player)
	local self = setmetatable({}, class)
	self:Initialize(player)
	return self
end

function class:Initialize(player)
	self.Player = player
	self.Character = shared.Character.new(player)
	self.CurrentSpawn = 0
	self.Connections = {}
	self:SetSpawn(self.CurrentSpawn)
end

function class:SetSpawn(spawnPoint)
	local Connection = self.Connections["SetSpawn"]
	if Connection then Connection:Disconnect() Connection = nil end

	local spawnPoints = game.Workspace.Obby.SpawnPoints:GetChildren()
	self.Connections["SetSpawn"] = self.Player.CharacterAdded:Connect(function(character)
		character:SetPrimaryPartCFrame(spawnPoints[tostring(self.CurrentSpawn)])
	end)
end

return class
