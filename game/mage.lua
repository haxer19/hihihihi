local function getopsize()
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
    ImaginaryPurple = false,
    Purple = false,
    Red = false,
    Red2 = false,
    Blue = false,
    Blue2 = false,
    Beatdown = false,
    HoraHora = false,
    UnlimitedVoid = false,
    Domainthing = false,
    MahoSummon = false,
    SukunaSkills = {
        DomainVar1 = false,
        DomainVar2 = false,
        FireArrow = false,
        Dismantle = false,
        Rush = false,
    },
}

local icon = {
    openm = "rbxassetid://74835846528618",
    gojo = "rbxassetid://105162796813125",
    sukuna = "rbxassetid://122037496339878",
    hakari = "rbxassetid://103960505289441",
    mahito = "rbxassetid://77341163529273",
}


local username = game:GetService("Players").LocalPlayer.Name

local Window = WindUI:CreateWindow({
    Title = "Mage Battlegrounds | Username: " .. username, 
    Icon = "rbxassetid://74835846528618", 
    Author = ".tienthanh", 
    Folder = "SynHaX_Mage", 
    Size = getopsize(), 
    Transparent = true,
    Theme = "Dark", 
    SideBarWidth = 200, 
    HasOutline = false,
})

WindUI:SetNotificationLower(false)

Window:EditOpenButton({
    Title = "Open",
    Icon = icon.openm, 
    CornerRadius = UDim.new(0,10),
    StrokeThickness = 3,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    )
})

WindUI.TransparencyValue = .1

local Tabs = {
    Gojo = Window:Tab({ Title = "Gojo", Icon = icon.gojo }),
    Sukuna = Window:Tab({ Title = "Sukuna", Icon = icon.sukuna }),
    Mahito = Window:Tab({ Title = "Sukuna", Icon = icon.mahito }),
    Hakari = Window:Tab({ Title = "Hakari", Icon = icon.hakari }),
    Other = Window:Tab({ Title = "Other", Icon = "users" }),
}

Window:SelectTab(1)

Tabs.Gojo:Section({ Title = "Gojo", TextXAlignment = "Center" })
Tabs.Gojo:Toggle({
    Title = "Gojo Imaginary Purple",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ImaginaryPurple = value 
        if config.ImaginaryPurple then
            while config.ImaginaryPurple do
                game:GetService("ReplicatedStorage").Remotess.ImaginaryPurple:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Purple",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Purple = value 
        if config.Purple then
            while config.Purple do
                game:GetService("ReplicatedStorage").Remotess.Purple:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Red Varient 1",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Red = value 
        if config.Red then
            while config.Red do
                game:GetService("ReplicatedStorage").Remotess.Red:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Red Varient 2",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Red2 = value 
        if config.Red2 then
            while config.Red2 do
                game:GetService("ReplicatedStorage").Remotess.Red2:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Blue Varient 1",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Blue = value 
        if config.Blue then
            while config.Blue do
                game:GetService("ReplicatedStorage").Remotess.Blue:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Blue Varient 2",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Blue2 = value 
        if config.Blue2 then
            while config.Blue2 do
                game:GetService("ReplicatedStorage").Remotess.Blue2:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Beatdown",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Beatdown = value 
        if config.Beatdown then
            while config.Beatdown do
                game:GetService("ReplicatedStorage").Remotess.Beatdown:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Counter",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.HoraHora = value 
        if config.HoraHora then
            while config.HoraHora do
                game:GetService("ReplicatedStorage").Remotess.HoraHora:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Gojo Domain Expansion",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.UnlimitedVoid = value 
        if config.UnlimitedVoid then
            while config.UnlimitedVoid do
                game:GetService("ReplicatedStorage").EventsAllDomain.UnlimitedVoid:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Hakari:Section({ Title = "Hakari", TextXAlignment = "Center" })
Tabs.Hakari:Toggle({
    Title = "Hakari Domain Expansion",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Domainthing = value 
        if config.Domainthing then
            while config.Domainthing do
                game:GetService("ReplicatedStorage").Domainthing:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Section({ Title = "Sukuna", TextXAlignment = "Center" })
Tabs.Sukuna:Toggle({
    Title = "Sukuna Domain Expansion Variant 1",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.SukunaSkills.DomainVar1 = value 
        if config.SukunaSkills.DomainVar1 then
            while config.SukunaSkills.DomainVar1 do
                game:GetService("ReplicatedStorage").MalevolentShrine:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Sukuna Domain Expansion Variant 2",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.SukunaSkills.DomainVar2 = value 
        if config.SukunaSkills.DomainVar2 then
            while config.SukunaSkills.DomainVar2 do
                game:GetService("ReplicatedStorage").MalevolentShrinese:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Sukuna Fire Arrow",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.SukunaSkills.FireArrow = value 
        if config.SukunaSkills.FireArrow then
            while config.SukunaSkills.FireArrow do
                game:GetService("ReplicatedStorage").sukuna.remotes["fire arrow"]:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Sukuna Dismantle",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.SukunaSkills.Dismantle = value 
        if config.SukunaSkills.Dismantle then
            while config.SukunaSkills.Dismantle do
                game:GetService("ReplicatedStorage").sukuna.remotes.dismantle:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Sukuna Rush",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.SukunaSkills.Rush = value 
        if config.SukunaSkills.Rush then
            while config.SukunaSkills.Rush do
                game:GetService("ReplicatedStorage").sukuna.remotes.rush:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Other:Section({ Title = "Summon", TextXAlignment = "Center" })
Tabs.Other:Toggle({
    Title = "Mahoraga Summon",
    Desc = "Mahoraga help me",
    Value = false,
    Callback = function(value)
        config.MahoSummon = value 
        if config.MahoSummon then
            while config.MahoSummon do
                game:GetService("ReplicatedStorage").MahoSummon:FireServer()
                wait(1)
            end
        end
    end
})