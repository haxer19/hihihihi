local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

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

local Window = WindUI:CreateWindow({
    Title = "Emotes | SynHaX", 
    Icon = "rbxassetid://74835846528618", 
    Author = "Tien Thanh",
    Folder = "emotes", 
    Size = getopsize(), 
    Transparent = true, 
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false, 
})

Window:EditOpenButton({
    Title = "Open", 
    Icon = "rbxassetid://74835846528618", 
    CornerRadius = UDim.new(0,10),
    StrokeThickness = 2, 
    Color = ColorSequence.new( 
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    ),
    Draggable = false, 
})

local Tabs = {
    Info = Window:Tab({ Title = "Info", Icon = "info", Desc = "Cập nhất mới nhất." }), 
    t1 = Window:Divider(), 
    Home = Window:Tab({ Title = "Home", Icon = "book-user", Desc = "Chứa các emote." }), 
}

Window:SelectTab(1)

Tabs.Info:Paragraph({
    Title = "Animation | Sưu tầm", 
    Desc = "28/03/2025", -
})

local function playAnimation(animationId)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local animator = humanoid:FindFirstChild("Animator") or Instance.new("Animator", humanoid)
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://" .. animationId
    local animationTrack = animator:LoadAnimation(animation)
    animationTrack:Play()
end

Tabs.Home:Button({
    Title = "KJSeries", 
    Desc = "Animation KJSeries", 
    Callback = function()
        playAnimation("76915411506160") 
    end
})

Tabs.Home:Button({
    Title = "Garou",
    Desc = "Animation Garou",
    Callback = function()
        playAnimation("112898609361903")
    end
})

Tabs.Home:Button({
    Title = "Wukong",
    Desc = "Animation Wukong",
    Callback = function()
        playAnimation("80612888507109")
    end
})

Tabs.Home:Button({
    Title = "Thinking With Portals",
    Desc = "Animation Thinking With Portals",
    Callback = function()
        playAnimation("80699965016614")
    end
})

Tabs.Home:Button({
    Title = "Nah, I'd win",
    Desc = "Animation Nah, I'd win",
    Callback = function()
        playAnimation("106526408873385")
    end
})
