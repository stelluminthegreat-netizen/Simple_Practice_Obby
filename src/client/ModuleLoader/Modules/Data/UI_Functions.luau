local functions = {}

function functions.Open(UI_Obj)
    local UIs = game.ReplicatedStorage.UIs
    local UI = UI_Obj.UI
    local conn = UI_Obj.Connections["Open"]
    if conn then conn:Disconnect() end
    conn = UI.MouseButton1Click:Connect(function()
        for _, attribute in UI_Obj do
            local ui = UIs:FindFirstChild(attribute, true)
            if not ui  then continue end
            shared.UI.new(ui)
        end
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

return functions