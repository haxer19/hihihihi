function getopsize()
    local screenSize = workspace.CurrentCamera.ViewportSize
    if screenSize.X <= 720 then
        return UDim2.fromOffset(240, 180) 
    elseif screenSize.X <= 1080 then
        return UDim2.fromOffset(360, 280)
    else
        return UDim2.fromOffset(480, 360) 
    end
end

local icon = {
    ccc = "rbxassetid://74835846528618",
}


local username = game:GetService("Players").LocalPlayer.Name
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
local ESP_P = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/ESPLibrary.lua"))()
local ESP_N = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/ESPLibrary_NPCs.lua"))()
local MovementLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/MovementLib.lua"))()

local Window = WindUI:CreateWindow({
    Title = "SPECTER | Username: " .. username, 
    Icon = icon.ccc,
    Author = ".C4F", 
    Folder = "SynHaX_SPECTER", 
    Size = getopsize(), 
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,    
})

Window:EditOpenButton({
    Title = "Open",
    Icon = icon.ccc, 
    CornerRadius = UDim.new(0,10),
    StrokeThickness = 3,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    )
})

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "rbxassetid://7733960981" }),
}

Tabs.Main:Section({ Title = "Esp - Players" })
Tabs.Main:Dropdown({
    Title = "Esp Aura",
    Values = { "Green", "Blue", "Red", "Yellow", "Orange", "Purple" },
    Value = "Green",
    Callback = function(option)
        ESP_P:SetColor(ESP.Colors[option])
    end
})

Tabs.Main:Toggle({
    Title = "Enable Esp",
    Default = false,
    Callback = function(state)
        if state then
            ESP_P:Enable()
        else
            ESP_P:Disable()
        end
    end
})

Tabs.Main:Section({ Title = "Esp - NPC" })
Tabs.Main:Dropdown({
    Title = "Esp Aura",
    Values = { "Green", "Blue", "Red", "Yellow", "Orange", "Purple" },
    Value = "Green",
    Callback = function(option)
        ESP_N:SetColor(ESP_N.Colors[option])
    end
})

Tabs.Main:Toggle({
    Title = "Enable Esp",
    Default = false,
    Callback = function(state)
        if state then
            ESP_N:Enable()
        else
            ESP_N:Disable()
        end
    end
})

Tabs.Main:Section({ Title = "Others" })

Tabs.Main:Toggle({
    Title = "Enable Noclip",
    Default = false,
    Callback = function(state)
        MovementLib.SetNoclip(state)
    end
})

Tabs.SliderTab:Slider({
    Title = "Tpwalk",
    Value = {
        Min = 0,
        Max = 10,
        Default = 1,
    },
    Callback = function(value)
        MovementLib.SetTpWalkSpeed(value)
    end
})
