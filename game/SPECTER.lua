function BlockOutput()
    print = function(...) end
    warn = function(...) end
    error = function(...) end
end

BlockOutput()

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
local fb = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/FullBrightLib.lua"))()


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
    Info = Window:Tab({ Title = "Info", Icon = "info" }),
    Main = Window:Tab({ Title = "Main", Icon = "rbxassetid://7733960981" }),
    Other = Window:Tab({ Title = "Other", Icon = "rbxassetid://7743876054" }),
}

Window:SelectTab(1)

Tabs.Info:Paragraph({
    Title = "V1.1.0",
    Desc = "Đang phát triển.",
})

Tabs.Main:Section({ Title = "Esp - Players" })
Tabs.Main:Dropdown({
    Title = "Aura Color",
    Values = { "White", "Green", "Blue", "Red", "Yellow", "Orange", "Purple" },
    Value = "",
    Callback = function(option)
        ESP_P:SetColor(option)
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
    Title = "Aura Color",
    Values = { "White", "Green", "Blue", "Red", "Yellow", "Orange", "Purple" },
    Value = "",
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

Tabs.Other:Section({ Title = "Detected" })
Tabs.Other:Button({
    Title = "Enable Detected",
    Desc = "Thông báo",
    Callback = function()
        WindUI:Notify({
            Title = "Trạng thái",
            Content = "Thông báo đã bật.",
            Duration = 5,
        })
        while wait(5) do
            local EMF = workspace.Dynamic.Evidence.EMF
            local GOrbs = workspace.Dynamic.Evidence.Orbs
            local Fingerprint = workspace.Dynamic.Evidence.Fingerprints
        
            if EMF:FindFirstChild("EMF5") then
                WindUI:Notify({
                    Title = "Thông Báo",
                    Content = "EMF 5 Detected",
                    Duration = 5,
                })
            elseif GOrbs:FindFirstChild("Orb") then
                WindUI:Notify({
                    Title = "Thông Báo",
                    Content = "Ghost Orbs Detected",
                    Duration = 5,
                })
            elseif Fingerprint:FindFirstChild("Fingerprint") then
                WindUI:Notify({
                    Title = "Thông Báo",
                    Content = "Fingerprints Detected",
                    Duration = 5,
                })
            end
        end        
    end
})
Tabs.Other:Section({ Title = "FullBright" })
Tabs.Other:Toggle({
    Title = "Enable FullBright",
    Default = false,
    Callback = function(state)
        if state then
            fb.enable()
        else
            fb.disable()
        end
    end
})

Tabs.Other:Section({ Title = "Noclip" })
local nc = false
local ncCon

Tabs.Other:Toggle({
    Title = "Enable Noclip", 
    Default = false,
    Callback = function(state)
        nc = state
        if nc then
            ncCon = game:GetService("RunService").Stepped:Connect(function()
                local pl = game.Players.LocalPlayer
                local ch = pl.Character or pl.CharacterAdded:Wait()
                for _, p in ipairs(ch:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.CanCollide = false
                    end
                end
            end)
        else
            if ncCon then
                ncCon:Disconnect()
                ncCon = nil
            end
            local pl = game.Players.LocalPlayer
            local ch = pl.Character or pl.CharacterAdded:Wait()
            for _, p in ipairs(ch:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = true
                end
            end
        end
    end
})
Tabs.Other:Section({ Title = "Tpwalk" })
local tpwalking = false
local tpwalkspeed = 10

Tabs.Other:Toggle({
    Title = "Enable Tpwalk",
    Default = false,
    Callback = function(state)
        tpwalking = state
        if not state then return end
        local RunService = game:GetService("RunService")
        local player = game.Players.LocalPlayer
        local chr = player.Character or player.CharacterAdded:Wait()
        local hum = chr:FindFirstChildWhichIsA("Humanoid")
        while tpwalking and chr and hum and hum.Parent do
            local delta = RunService.Heartbeat:Wait()
            if hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection * delta * tpwalkspeed)
            end
        end
    end
})

Tabs.Other:Slider({
    Title = "Tpwalk Speed",
    Value = {
        Min = 0,
        Max = 200,
        Default = 1, 
    },
    Callback = function(value)
        tpwalkspeed = value
    end
})
