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
	self.Died = shared.Event.new()
	self.MaxHealth = 100
	self.WalkSpeed = 16
	self.NormalJumpHeight = 7.2
end

function class:Kill()
	self.Died:Fire()
end




return class
