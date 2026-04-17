local class = {}
class.__index = class

function class.new(platform)
	local self = setmetatable(platform:GetAttributes(), class)
	self.AssignedPlayers = {}
	self.Platform = platform
	self.Connections = {}
	self:Initialize()

	return self
end

function  class:Initialize()
	self.Connections["PlatformTouched"] = self.Platform.Touched:Connect(function(Part)
		if not Part.Parent:FindFirstChild("Humanoid") then return end
		local characterName = Part.Parent.Name

		if self:IsPlayerAssigned(characterName) == true then print("Player assigned") return end
		self:AssignPlayerSpawn(characterName)
		self:SetPlayerSpawnPoint(self.AssignedPlayers[characterName])
	end)
end

function class:IsPlayerAssigned(name)
	if self.AssignedPlayers[name] then return true end
	return false
end

function  class:AssignPlayerSpawn(name)
	local playerObject = shared.Player.Players[name]
	self.AssignedPlayers[name] = playerObject
end

function class:SetPlayerSpawnPoint(playerObject)
	playerObject:SetSpawn(self.SpawnPoint)
end

return class
