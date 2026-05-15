local class = {}
class.__index = class
class.Players = {}

local customTween = require(game.ReplicatedStorage.Shared.Libraries.CustomTween)
local minorTaskRequest = game.ReplicatedStorage.Remotes.Events.MinorTaskRequest 

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
	local DiedConn = self.Connections["Died"]
	if DiedConn then DiedConn:Disconnect() end
	local spawnPoints = game.Workspace.Obby.SpawnPoints
	local character = self.Character.Character

	self.Connections["Died"] = self.Character.Died:Connect(function()
		self:Teleport(spawnPoints[tostring(spawnPoint)].CFrame)
		if self.DeathFunctionsRunning == false then self.Died(self, character) end
	end)

end

function class:Teleport(cframe)
	shared.Threads:Spawn(function()
		local character = self.Character.Character
		local hrp = character.HumanoidRootPart
		hrp.AssemblyLinearVelocity = Vector3.zero
		character:SetPrimaryPartCFrame(cframe)
	end)
end

function class.Died(Character, character)
	shared.Threads:Spawn(function()
		minorTaskRequest:FireClient(game.Players[character.Name], "PlaySound","Revive")
	end)

	shared.Threads:Spawn(function()
		Character.DeathFunctionsRunning = true
		local player = game.Players[character.Name]
		local mainGui = player.PlayerGui.Main
		local guiFolder = player.PlayerGui.Guis
		local stareGui = guiFolder.Image.Death:Clone()

		stareGui.Parent = mainGui
		stareGui.ImageTransparency = 0
		shared.Task:Wait(12)
		local tween = customTween.TweenUITransparency(stareGui, 1, 2)
		tween:Play()
		tween.Completed:Wait()
		stareGui:Destroy()
		Character.DeathFunctionsRunning = false
	end)
end

return class
