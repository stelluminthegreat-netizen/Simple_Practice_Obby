local functions = {}

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
    local conn = UI_Obj.Connections["Close"]
    if conn then conn:Disconnect() end
    conn = UI.MouseButton1Click:Connect(function()
        for _, attribute in UI_Obj do
            local ui = shared.UI.UIs[attribute]
            if not ui  then continue end
            ui:Destroy()
        end
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
        for i = 0, UI_Folder.LowestPrio.Value, 1 do
            for _, ui in Prios[i] do
                ui:Initialize()
            end
        end
    end    
end

return functions