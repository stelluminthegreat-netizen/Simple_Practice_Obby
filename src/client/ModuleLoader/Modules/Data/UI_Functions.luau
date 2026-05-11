local functions = {}
local player = game.Players.LocalPlayer
local DataManager = require(player.PlayerScripts.Client.Data.DataManager)
local data = DataManager.Profiles[player]
------------------------ [[ UNIVERSAL FUNCTIONS ]] ------------------------

-- GENERAL RULES
--[[
    1. Folders must have unique names. 
    2. Objects used in Open and Close must have an attribute called
        -> CloseLowestPrio: Num
        -> OpenLowestPrio: Num

    3. UIs must have tag "UI_Obj"
    4. UIs must have
        -> OpenPrioNum
        -> ClosePrioNum
    5. UI must have string attribute for it's target parent name
--]]

-- ACTION RULES
--[[
    1. UI must have a string attribute that holds the function name of it's action
--]]

function functions.Open(UI_Obj)
    local UI = UI_Obj.UI
    local conn = UI_Obj.Connections["Open"]
    if conn then conn:Disconnect() end
    conn = UI.MouseButton1Click:Connect(function()
        Open(UI_Obj)
    end)
end

function functions.Close(UI_Obj)
    local UI = UI_Obj.UI
    local conns = UI_Obj.Connections
    if conns["Close"] then conns["Close"]:Disconnect() end
    conns["Close"] = UI.MouseButton1Click:Connect(function()
        Close(UI_Obj)
    end)
end

function functions.TextInput(UI_Obj)
   local UI = UI_Obj.UI 
   local conn = UI_Obj.Connections["FocusLost"]
   if conn then conn:Disconnect() end
   conn = UI.FocusLost:Connect(function(enterPressed)
        UI_Obj.Text = UI.Text
   end)
end

function Open(UI_Obj)
    for index, folder in UI_Obj.Attributes do
        local UI_Folder = game.ReplicatedStorage.UIs:FindFirstChild(folder)
        if not UI_Folder then continue end

        local Prios = {}
        local UIs = {}
        
        -- Create the UI objects and store in UIs table
        for _, ui in UI_Folder:GetChildren() do
            if not ui:HasTag("UI_Obj") then continue end
            if shared.UI.UIs[ui.Name] then return end
            local ui_Obj = shared.UI.new(ui)
            UIs[ui.Name] = ui_Obj
        end

        -- Segregrate different priorities
        for _, ui in UIs do
            local PrioNum = ui.OpenPrio
            if not Prios[PrioNum] then Prios[PrioNum] = {} end
            Prios[PrioNum][ui.UI.Name] = ui 
        end

        -- Initialize highest priority to lowest priority UI
        for i = 0, UI_Obj.OpenLowestPrio, 1 do
            for _, ui in Prios[i] do
                ui:Initialize()
            end
        end
    end    
end

function Close(UI_Obj)
    local shared_UIs = shared.UI.UIs
    local Prios = {}
    local UIs = {}

    for _, uiName in UI_Obj.Attributes do
        local ui = shared_UIs[uiName]
        if not ui then continue end
        UIs[uiName] = ui
    end

    for _, ui in UIs do
        local PrioNum = ui.ClosePrio
        if not Prios[PrioNum] then Prios[PrioNum] = {} end
        Prios[PrioNum][ui.UI.Name] = ui 
    end

    for i = 0, UI_Obj.CloseLowestPrio, 1 do
        for _, ui in Prios[i] do
            ui:Destroy()
        end
    end
end

------------------------ [[ GAME SPECIFIC FUNCTIONS ]] ------------------------

function functions.KillPlayer(UI_Obj)
    local players = game.Players
    local conns = UI_Obj.Connections
    local MarketplaceService = game:GetService("MarketplaceService")

    if conns["KillPlayer"] then conns["KillPlayer"]:Disconnect() end
    conns["KillPlayer"] = UI_Obj.UI.MouseButton1Click:Connect(function()
        local remoteEvent = game.ReplicatedStorage.Remotes.Events.UpdateKillPlrTarget
        local textBoxName = UI_Obj.TextBoxName
        local textBox = shared.UI.UIs[textBoxName]
        local playerName = textBox.Text
        
        if (not playerName or not players:FindFirstChild(playerName)) then textBox.UI.Text = "Invalid Player" return end
        -- if playerName == player.Name then textBox.UI.Text = "Give value to your own life dude" end
        local productID = UI_Obj.ProductID
        remoteEvent:FireServer(playerName)
        MarketplaceService:PromptProductPurchase(player, productID)
        Close(UI_Obj)
        conns["KillPlayer"]:Disconnect()
    end)
end






return functions