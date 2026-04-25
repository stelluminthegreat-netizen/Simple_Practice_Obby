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
	local spawnPoints = game.Workspace.Obby.SpawnPoints 
	local character = self.Character.Character
	
	print(spawnPoint)
	self.Character.Died:Connect(function()
		character:SetPrimaryPartCFrame(spawnPoints[tostring(spawnPoint)].CFrame)
		local audio = game.ReplicatedStorage.Audios.Revive:Clone()
		audio.Parent = character
		audio:Play()
		audio.Ended:Wait()
		audio:Destroy()
	end)

end

return class
