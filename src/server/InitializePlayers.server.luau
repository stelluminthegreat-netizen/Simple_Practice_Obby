game.Players.PlayerAdded:Connect(function(plr)
    local player = shared.Player.new(plr)
    local killPlrTarget = Instance.new("StringValue", plr)
    killPlrTarget.Name = "KillPlayerTarget"
end)