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

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/haxer19/hihihihi/main/game/i/isp"))()
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Shonen Piece", 
    Icon = icon.ccc,
    Author = ".C4F", 
    Folder = "SynHaX_sp", 
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

Window:SelectTab(1)

Tabs.Main:Section({ Title = "Tool Equip" })
lib.WatchToolList(function(list)
	Tabs.Main:Dropdown({
		Title = "Tools",
		Values = list,
		Value = "",
		Callback = function(opt)
			local cat, item = opt:match("^(%w+)%s*%-%s*(.+)$")
			if cat and item then
				lib.CreateTool(item, cat)
			end
		end
	})
end)
Tabs.Main:Button({
    Title = "Rs bp",
    Desc = "làm mới túi đồ",
    Callback = function()
        for _, item in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren()) do item:Destroy() end
    end
})   