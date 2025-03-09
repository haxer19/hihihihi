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

local config = {
    ps = {
        cds = false,
        heal = false,
        damage = false,
        health = false,
    }
}

local icon = {
    ccc = "rbxassetid://74835846528618",
}


local username = game:GetService("Players").LocalPlayer.Name
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Universal Battlegrounds | Username: " .. username, 
    Icon = "rbxassetid://74835846528618", 
    Author = ".C4F", 
    Folder = "SynHaX_universal", 
    Size = getopsize(), 
    Transparent = true,
    Theme = "Dark", 
    SideBarWidth = 200, 
    HasOutline = false,
})

WindUI:SetNotificationLower(false)

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

WindUI.TransparencyValue = .1

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "home" }),
}

Window:SelectTab(1)

Tabs.Main:Section({ Title = "Cooldown", TextXAlignment = "Center" })
Tabs.Main:Toggle({
    Title = "Cooldown",
    Desc = "Bật/Tắt Cooldown",
    Value = false,
    Callback = function(value)
        config.ps.cds = value 
        if config.ps.cds then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].NoCDS:FireServer()
        else
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DisableNoCDS:FireServer()
        end
    end
})
Tabs.Main:Toggle({
    Title = "Heal",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ps.heal = value 
        if config.ps.heal then
            while config.ps.heal do
                game:GetService("ReplicatedStorage")["PS+ Remotes"].Heal:FireServer()
                wait()
            end
        end
    end
})
Tabs.Main:Button({
    Title = "Give Ultimate",
    Desc = " ",
    Callback = function() 
        game:GetService("ReplicatedStorage")["PS+ Remotes"].GiveUlt:FireServer()
    end
})

Tabs.Main:Button({
    Title = "Admin Tool",
    Desc = "lấy các chiêu của admin",
    Callback = function()
        local bp = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
        for _, item in ipairs(bp:GetChildren()) do item:Destroy() end
        for _, tool in ipairs(game:GetService("ReplicatedStorage"):WaitForChild("exe_storage"):WaitForChild("tools"):GetChildren()) do
            tool:Clone().Parent = bp
        end
    end
})
Tabs.Main:Dropdown({
    Title = "Spawn",
    Values = { "AttackingDummy", "BlockingDummy", "CounteringDummy", "Dummy", "LowHPDummy" },
    Value = "Dummy",
    Callback = function(option)
        if option == "AttackingDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnAttackingDummy:FireServer()
        elseif option == "BlockingDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnBlockingDummy:FireServer()
        elseif option == "CounteringDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnCounteringDummy:FireServer()
        elseif option == "Dummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnDummy:FireServer()
        elseif option == "LowHPDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnLowHPDummy:FireServer()
        end
    end
})
Tabs.Main:Toggle({
    Title = "Double Damage",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ps.damage = value 
        if config.ps.damage then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DoubleDamage:FireServer()
        else
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DisableDoubleDamage:FireServer()
        end
    end
})
Tabs.Main:Toggle({
    Title = "Double Health",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ps.health = value 
        if config.ps.health then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DoubleHealth:FireServer()
        else
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})
