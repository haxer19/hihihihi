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
    Gojo02DomainExpansionType1 = false,
    Gojo02DomainExpansionType2 = false,
    GojoDomainExpansion = false,
    GojoTrueDomainExpansion = false,
    HollowPurple = false,
    HollowPurple200 = false,
    maxred = false,
    maxblue = false,
    nuke = false,
    MalevolentShrine5 = false,
    shrine = false,
    Gaymalev = false,
    Malclash = false,
    Domainthing = false,
    MahitoDomainExpansion = false,
    CollaretalRuin = false,
    DropKick2 = false,
    Yutalove = false,
    Yutaytd = false,
    allskill = false,
}

-- rbxassetid://

local icon = {
    openm = "rbxassetid://74835846528618",
    gojo = "rbxassetid://105162796813125",
    sukuna = "rbxassetid://122037496339878",
    kj = "rbxassetid://78252154683435",
    hakari = "rbxassetid://103960505289441",
    mahito = "rbxassetid://77341163529273",
    megumi = "rbxassetid://119073986869850",
    yuta = "rbxassetid://84831465183744",
}

local username = game:GetService("Players").LocalPlayer.Name

local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()
local info = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/info/s_anm"))()

local Window = WindUI:CreateWindow({
    Title = "AnM Battlegrounds | Username: " .. username, 
    Icon = "rbxassetid://74835846528618", 
    Author = ".tienthanh", 
    Folder = "SynHaX_AnM", 
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
    Info = Window:Tab({ Title = "Info", Icon = "info" }),
    Gojo = Window:Tab({ Title = "Gojo", Icon = icon.gojo }),
    Sukuna = Window:Tab({ Title = "Sukuna", Icon = icon.sukuna }),
    Hakari = Window:Tab({ Title = "Hakari", Icon = icon.hakari }),
    Mahito = Window:Tab({ Title = "Mahito", Icon = icon.mahito }),
    KJ = Window:Tab({ Title = "KJ", Icon = icon.kj }),
    Yuta = Window:Tab({ Title = "Yuta", Icon = icon.yuta }),
    Other = Window:Tab({ Title = "Other", Icon = "users" }),
}

Window:SelectTab(1)

Tabs.Info:Paragraph({
    Title = info.Title,
    Desc = info.Desc,
})

Tabs.Gojo:Section({ Title = "Gojo", TextXAlignment = "Center" })
Tabs.Gojo:Toggle({
    Title = "Domain Expansion",
    Desc = "Gojo 0,2 Domain Expansion Type 1",
    Value = false,
    Callback = function(value)
        config.Gojo02DomainExpansionType1 = value 
        if config.Gojo02DomainExpansionType1 then
            while config.Gojo02DomainExpansionType1 do
                game:GetService("ReplicatedStorage").Events["Domain0.2"]:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Domain Expansion",
    Desc = "Gojo 0,2 Domain Expansion Type 2",
    Value = false,
    Callback = function(value)
        config.Gojo02DomainExpansionType2 = value 
        if config.Gojo02DomainExpansionType2 then
            while config.Gojo02DomainExpansionType2 do
                game:GetService("ReplicatedStorage").Events["UnlimitedVoid0.2"]:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Domain Expansion",
    Desc = "Gojo Domain Expansion",
    Value = false,
    Callback = function(value)
        config.GojoDomainExpansion = value 
        if config.GojoDomainExpansion then
            while config.GojoDomainExpansion do
                game:GetService("ReplicatedStorage").Events.UnlimitedVoid:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Domain Expansion",
    Desc = "Gojo True Domain Expansion",
    Value = false,
    Callback = function(value)
        config.GojoTrueDomainExpansion = value 
        if config.GojoTrueDomainExpansion then
            while config.GojoTrueDomainExpansion do
                game:GetService("ReplicatedStorage").Gogay:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Hollow Purple",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.HollowPurple = value 
        if config.HollowPurple then
            while config.HollowPurple do
                game:GetService("ReplicatedStorage").Remotes.Purple:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "200% Hollow Purple",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.HollowPurple200 = value 
        if config.HollowPurple200 then
            while config.HollowPurple200 do
                game:GetService("ReplicatedStorage").GojoV3.haitram:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Max Red",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.maxred = value 
        if config.maxred then
            while config.maxred do
                game:GetService("ReplicatedStorage").GojoV3.maxred:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Max Blue",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.maxblue = value 
        if config.maxblue then
            while config.maxblue do
                game:GetService("ReplicatedStorage").GojoV3.maxblue:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Gojo:Toggle({
    Title = "Hollow Purple Nuke",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.nuke = value 
        if config.nuke then
            while config.nuke do
                game:GetService("ReplicatedStorage").GojoV3.nuke:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Section({ Title = "Sukuna", TextXAlignment = "Center" })
Tabs.Sukuna:Toggle({
    Title = "Domain Expansion",
    Desc = "Sukuna Domain Expansion(Varient 1)",
    Value = false,
    Callback = function(value)
        config.MalevolentShrine5 = value 
        if config.MalevolentShrine5 then
            while config.MalevolentShrine5 do
                game:GetService("ReplicatedStorage").Events.MalevolentShrine5:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Domain Expansion",
    Desc = "Sukuna Domain Expansion(Varient 2)",
    Value = false,
    Callback = function(value)
        config.shrine = value 
        if config.shrine then
            while config.shrine do
                game:GetService("ReplicatedStorage").Events.shrine:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Domain Expansion",
    Desc = "Sukuna Domain Expansion(Varient 3)",
    Value = false,
    Callback = function(value)
        config.Gaymalev = value 
        if config.Gaymalev then
            while config.Gaymalev do
                game:GetService("ReplicatedStorage").RyomenSukuna.MalevolentShrine.Gaymalev:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Sukuna:Toggle({
    Title = "Domain Expansion",
    Desc = "Sukuna True Domain Expansion",
    Value = false,
    Callback = function(value)
        config.Malclash = value 
        if config.Malclash then
            while config.Malclash do
                game:GetService("ReplicatedStorage").Events.Malclash:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Hakari:Section({ Title = "Hakari", TextXAlignment = "Center" })
Tabs.Hakari:Toggle({
    Title = "Domain Expansion",
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

Tabs.Mahito:Section({ Title = "Mahito", TextXAlignment = "Center" })
Tabs.Mahito:Toggle({
    Title = "Domain Expansion",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.MahitoDomainExpansion = value 
        if config.MahitoDomainExpansion then
            while config.MahitoDomainExpansion do
                game:GetService("ReplicatedStorage").MahitoDomainExpansion.MahitoDomainEvent:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.KJ:Section({ Title = "KJ", TextXAlignment = "Center" })
Tabs.KJ:Toggle({
    Title = "Collateral Ruin",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.CollaretalRuin = value 
        if config.CollaretalRuin then
            while config.CollaretalRuin do
                game:GetService("ReplicatedStorage").Kj.Remotes["Collaretal Ruin"]:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.KJ:Toggle({
    Title = "Dropkick",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.DropKick2 = value 
        if config.DropKick2 then
            while config.DropKick2 do
                game:GetService("ReplicatedStorage").KJ.Remote.DropKick2:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Yuta:Section({ Title = "Yuta", TextXAlignment = "Center" })
Tabs.Yuta:Toggle({
    Title = "Pure Love",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Yutalove = value 
        if config.Yutalove then
            while config.Yutalove do
                game:GetService("ReplicatedStorage").Yuta.love:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Yuta:Toggle({
    Title = "Domain Expansion",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.Yutaytd = value 
        if config.Yutaytd then
            while config.Yutaytd do
                game:GetService("ReplicatedStorage").Yuta.ytd:FireServer()
                wait(1)
            end
        end
    end
})

Tabs.Other:Section({ Title = "All in 1", TextXAlignment = "Center" })
Tabs.Other:Toggle({
    Title = "All Skill",
    Desc = "Máy yếu hạn chế spam !!",
    Value = false,
    Callback = function(value)
        config.allskill = value 
        if config.allskill then
            while config.allskill do
                loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/game/anm_allskill"))()
                wait(1)
            end
        end
    end
})