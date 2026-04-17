local class = {}
class.__index = class
class.Players = {}

function class.new(player)
	local self = setmetatable({}, class)
	self:Initialize(player)
	class.Players[player.Name] = self
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

	local spawnPoints = game.Workspace.Obby.SpawnPoints
	self.Connections["SetSpawn"] = self.Player.CharacterAdded:Connect(function(character)
		shared.Task:Wait(48 / 4)
		character:SetPrimaryPartCFrame(spawnPoints[tostring(spawnPoint)].CFrame)
	end)
end

return class
