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
	self.Health = 100
	self.Speed = 16
	self.JumpHeight = 7.2
end

return class
