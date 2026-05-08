local ticksPerSecond = 48
local connection = nil
local taskLists = {}

local self = {}

function self.initialize()
	self.Tick = 0
	self.OnTick = shared.Event.new()
	self.PostTicks = shared.Event.new()
	self:Start(workspace:GetServerTimeNow())
end

function self:Start(startTime)
	if connection ~= nil then return false end
	self.StartTime = startTime
	connection = game:GetService("RunService").Heartbeat:Connect(Loop)
	return true
end

function self:Stop()
	if connection == nil then return false end
	connection:Disconnect()
	connection = nil
	table.clear(taskLists)
	self.Tick = 0
	return true
end

function self:Wait(amount)
	local scheduledTick = self.Tick + math.max(amount, 1)
	local taskList = taskLists[scheduledTick]
	if taskList == nil then taskList = shared.LinkedList.new() taskLists[scheduledTick] = taskList end
	taskList:InsertBack({Thread = coroutine.running()})
	return coroutine.yield()
end

function self:Delay(amount, func, ...)
	local scheduledTick = self.Tick + math.max(amount, 1)
	local taskList = taskLists[scheduledTick]
	if taskList == nil then taskList = shared.LinkedList.new() taskLists[scheduledTick] = taskList end
	return taskList:InsertBack({Function = func, Parameters = {...}})
end

function Loop()
	local currentTick = math.round((workspace:GetServerTimeNow() - self.StartTime) * ticksPerSecond)
	if self.Tick >= currentTick then return end
	while self.Tick < currentTick do
		self.Tick += 1
		self.OnTick:Fire(self.Tick)
		local taskList = taskLists[self.Tick]
		if taskList == nil then continue end
		local scheduledTask = taskList.Next
		while scheduledTask ~= taskList do
			if scheduledTask.Thread  then
				task.spawn(scheduledTask.Thread, self.Tick)
			else
				shared.Threads:Spawn(scheduledTask.Function, table.unpack(scheduledTask.Parameters))
			end
			
			scheduledTask = scheduledTask.Next
		end
		taskLists[self.Tick] = nil
	end
	self.PostTicks:Fire(self.Tick)
end

return self
