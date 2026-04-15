local class = {}
class.__index = class

function class.new(plr)
	local self = setmetatable({}, class)
	self:Initialize(plr)
	return self
end

function  class:Initialize(plr)
	self.Player = plr
	self.Character = plr.Character or plr.CharacterAdded:Wait()
	self.Health = self.Character.Humanoid.Health
	self.Speed = self.Character.Humanoid.Speed
	self.JumpHeight = self.Character.Humanoid.JumpHeight
	self.MaxHealth = 100
	self.NormalSpeed = 16
	self.NormalJumpHeight = 7.2
end

function  class:IncrementHealth(value)
	if self.Health <= 0 then return false end
	self.Health += value
	return self.Health
end

function class:IncrementSpeed(value)
	self.Speed += value
end

function class:IncrementJumpHeight(value)
	self.JumpHeight += value
end

return class
