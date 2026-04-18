local class = {}
class.__index = class
class.Characters = {}

function class.new(plr)
	local self = setmetatable({}, class)
	self:Initialize(plr)
	self.Connections = {}
	class.Characters[plr.Name] = self
	return self
end

function  class:Initialize(plr)
	self.Player = plr
	self.Character = plr.Character or plr.CharacterAdded:Wait()
	self.Health = self.Character.Humanoid.Health
	self.Speed = self.Character.Humanoid.WalkSpeed
	self.JumpHeight = self.Character.Humanoid.JumpHeight
	self.MaxHealth = 100
	self.WalkSpeed = 16
	self.NormalJumpHeight = 7.2
	local connection = self.Connections["HealthIncrement"]
	if connection then connection:Disconnect() connection = nil end
	self.Connections["HealthIncrement"] = self.Health.Changed:Connect(function()
		if self.Health <=0 then self:Initialize(plr) end
	end)
end

function  class:IncrementHealth(value)
	if self.Health <= 0 then return false end
	self.Health += value
	return self.Health
end

function class:IncrementSpeed(value)
	self.WalkSpeed += value
end

function class:IncrementJumpHeight(value)
	self.JumpHeight += value
end

return class
