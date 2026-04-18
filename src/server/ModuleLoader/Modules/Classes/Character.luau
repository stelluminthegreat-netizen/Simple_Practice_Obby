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
	self.Humanoid = self.Character.Humanoid
	self.MaxHealth = 100
	self.WalkSpeed = 16
	self.NormalJumpHeight = 7.2
end

function  class:IncrementHealth(value)
	if self.Humanoid.Health <= 0 then return false end
	self.Humanoid.Health += value
	return self.Humanoid.Health
end

function class:IncrementSpeed(value)
end

function class:IncrementJumpHeight(value)
	self.JumpHeight += value
end

return class
