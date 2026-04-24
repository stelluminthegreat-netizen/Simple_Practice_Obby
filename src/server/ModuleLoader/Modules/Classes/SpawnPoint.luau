local dataManager = require(game.ServerScriptService.Server.Data.DataManager)

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
		self:UpdatePlayerHighestStage(self.AssignedPlayers[characterName])
		if self.Platform.Parent:HasTag("Final") then self:Win(shared.Player.Players[characterName]) end
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
	playerObject.CurrentSpawn = self.SpawnPoint
	playerObject:SetSpawn(self.SpawnPoint)
end

function class:UpdatePlayerHighestStage(playerObject)
	local data = dataManager.profiles[playerObject.Player].Data
	if data.HighestStage >= tonumber(self.SpawnPoint) then return end
	data.HighestStage += 1
	print(data)
	dataManager.UpdateLeaderstats(
		playerObject.Player.Name,
		"HighestStage", 
		function(player, stats)
			stats.Value += 1
		end
	)
end

function class:Win(playerObject)
	-- Special Effects or whatever the hel
	self:UpdatePlayerWins(playerObject)
end

function class:UpdatePlayerWins(playerObject)
	local data = dataManager.profiles[playerObject.Player].Data
	data.Wins += 1
	dataManager.UpdateLeaderstats(
		playerObject.Player.Name,
		"Wins", 
		function(player, stats)
			stats.Value += 1
		end
	)
end

return class
