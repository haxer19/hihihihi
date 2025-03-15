local ESP = {}

ESP.Colors = {
    Green = Color3.fromRGB(0, 255, 0),
    Blue = Color3.fromRGB(0, 0, 255),
    Red = Color3.fromRGB(255, 0, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Orange = Color3.fromRGB(255, 165, 0),
    Purple = Color3.fromRGB(128, 0, 128)
}

ESP.Color = ESP.Colors.Red

ESP.Enabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function getCharacter(player)
    return Workspace:FindFirstChild(player.Name)
end

local function addHighlightToCharacter(player, character)
    if player == Players.LocalPlayer then return end  
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart and not humanoidRootPart:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "Highlight"
        highlight.Adornee = character
        highlight.Parent = humanoidRootPart
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = ESP.Color
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.FillTransparency = 0.5
    end
end

local function removeHighlightFromCharacter(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        local highlight = humanoidRootPart:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
    end
end

local function updateHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        local character = getCharacter(player)
        if character then
            if ESP.Enabled then
                addHighlightToCharacter(player, character)
            else
                removeHighlightFromCharacter(character)
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    updateHighlights()
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if ESP.Enabled then
            addHighlightToCharacter(player, character)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        removeHighlightFromCharacter(character)
    end
end)

function ESP:Toggle()
    self.Enabled = not self.Enabled
    updateHighlights()
end

function ESP:Enable()
    self.Enabled = true
    updateHighlights()
end

function ESP:Disable()
    self.Enabled = false
    updateHighlights()
end

function ESP:SetColor(newColor)
    self.Color = newColor
    updateHighlights()
end

return ESP