-- Services
local players = game:GetService("Players")
local runService = game:GetService("RunService")
local serverScriptService = game:GetService("ServerScriptService")

-- Profile store
local profileStore = require(game.ServerScriptService.Server.Data.ProfileStore)

function getStoreName()
	return runService:IsStudio() and "test" or "live"
end

local template = require(serverScriptService.Server.Data.DataTemplate)
local dataManager = require(serverScriptService.Server.Data.DataManager)

-- Access profile store
local playerStore = profileStore.New(getStoreName(), template)

function Initializer(player: Player, profile: typeof(playerStore:StartSessionAsync()))
	-- Leaderstats
	local leaderstats = Instance.new("Folder", player)
	leaderstats.Name = "leaderstats"
	
	local highestStage = Instance.new("NumberValue", leaderstats)
	highestStage.Name = "HighestStage"
	highestStage.Value = profile.Data.HighestStage
	print(profile.Data)
end

function playerAdded(player: Player)
	-- Start new profile session
	local profile = playerStore:StartSessionAsync("player_" .. player.UserId, {
		Cancel = function()
			return player.Parent ~= players
		end,
	})	
	
	-- Ensure profile exists
	if profile ~= nil then
		profile:AddUserId(player.UserId)
		profile:Reconcile() -- Fill in missing data variables from the template
		
		--if player.Name == "ebrocz2019"  then
		--	profile.Data.tycoons.aheehee = nil 
		--	profile.Data.tycoons.Joseph_S_001 = {}
		--	profile.Data.fenoy = 9999999999
		--end
		
		profile.OnSessionEnd:Connect(function()
			dataManager.profiles[player] = nil
			player:Kick("Data error occured, Please rejoin.")
		end)
		
		if player.Parent == players  then
			dataManager.profiles[player] = profile
		else
			profile:EndSession()
		end
	else
		player:Kick("Data error occured. Please rejoin.")
	end
	
	Initializer(player, profile)
end

for _, player in players:GetPlayers()  do
	task.spawn(playerAdded, player)
end

players.PlayerAdded:Connect(playerAdded)

players.PlayerRemoving:Connect(function(player)
	local profile = dataManager.profiles[player]
	if not profile then return end
	profile:EndSession()
	dataManager.profiles[player] = nil
end)