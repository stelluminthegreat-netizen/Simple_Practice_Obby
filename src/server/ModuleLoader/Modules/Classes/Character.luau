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
	self.JumpHeight = self.Character.Humanoid.JumpHeight
	self.Health = self.Character.Humanoid.Health
	self.MaxHealth = 100
	self.WalkSpeed = 16
	self.NormalJumpHeight = 7.2
end

function  class:IncrementHealth(value)
	if self.Health <= 0 then return false end
	self.Health += value
	self.Character.Humanoid.Health += value
	return self.Health
end

function class:IncrementSpeed(value)
end

function class:IncrementJumpHeight(value)
	self.JumpHeight += value
end

return class
