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
	self.DeathFunctionsRunning = false
	self:SetSpawn(self.CurrentSpawn)
end

function class:SetSpawn(spawnPoint)
	local spawnPoints = game.Workspace.Obby.SpawnPoints 
	local character = self.Character.Character
	
	print(spawnPoint)
	self.Character.Died:Connect(function()
		character:SetPrimaryPartCFrame(spawnPoints[tostring(spawnPoint)].CFrame)
		if self.DeathFunctionsRunning == false then self.Died(self, character) end
	end)

end

function class.Died(Character, character)
	shared.Threads:Spawn(function()
		local audio = game.ReplicatedStorage.Audios.Revive:Clone()
		audio.Parent = character
		audio:Play()
		audio.Ended:Wait()
		audio:Destroy()
	end)

	shared.Threads:Spawn(function()
		Character.DeathFunctionsRunning = true
		local player = game.Players[character.Name]
		local mainGui = player.PlayerGui.ScreenGui
		local guiFolder = player.PlayerGui.Guis
		local stareGui = guiFolder.Image.Death:Clone()

		stareGui.Parent = mainGui
		while stareGui.ImageTransparency ~= 0.3999999165534973 do
			shared.Task:Wait(4)
			stareGui.ImageTransparency -= 0.1
		end

		while stareGui.ImageTransparency ~= 1 do
			shared.Task:Wait(4)
			stareGui.ImageTransparency += 0.1
		end

		stareGui:Destroy()
		Character.DeathFunctionsRunning = false
	end)
end

return class
