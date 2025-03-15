local ESP = {}

ESP.Colors = {
    White = Color3.fromRGB(255, 255, 255),
    Green = Color3.fromRGB(0, 255, 0),
    Blue = Color3.fromRGB(0, 0, 255),
    Red = Color3.fromRGB(255, 0, 0),
    Yellow = Color3.fromRGB(255, 255, 0),
    Orange = Color3.fromRGB(255, 165, 0),
    Purple = Color3.fromRGB(128, 0, 128)
}
ESP.Color = ESP.Colors.Purple
ESP.Enabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function getCharacter(player)
    return Workspace:FindFirstChild(player.Name)
end

local function addHighlightToCharacter(player, character)
    if player == Players.LocalPlayer then return end
    if character:FindFirstChild("Highlight") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.Adornee = character
    highlight.Parent = character
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = ESP.Color
    highlight.OutlineColor = ESP.Color
    highlight.FillTransparency = 0.7
    highlight.OutlineTransparency = 0
end

local function removeHighlightFromCharacter(character)
    local highlight = character:FindFirstChild("Highlight")
    if highlight then
        highlight:Destroy()
    end
end

local function addBillboardToCharacter(player, character)
    if player == Players.LocalPlayer then return end
    local head = character:FindFirstChild("Head")
    if head and not head:FindFirstChild("ESP_Billboard") then
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP_Billboard"
        billboard.Adornee = head
        billboard.Parent = head
        billboard.Size = UDim2.new(0, 100, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "ESP_TextLabel"
        textLabel.BackgroundTransparency = 1
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.TextColor3 = ESP.Color
        textLabel.TextStrokeTransparency = 0
        textLabel.TextScaled = false
        textLabel.TextSize = 14
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.Parent = billboard
    end
end

local function removeBillboardFromCharacter(character)
    local head = character:FindFirstChild("Head")
    if head then
        local billboard = head:FindFirstChild("ESP_Billboard")
        if billboard then
            billboard:Destroy()
        end
    end
end

local function updateBillboard(player, character)
    if player == Players.LocalPlayer then return end
    local head = character:FindFirstChild("Head")
    if head then
        local billboard = head:FindFirstChild("ESP_Billboard")
        if billboard then
            local textLabel = billboard:FindFirstChild("ESP_TextLabel")
            if textLabel then
                local displayName = player.DisplayName or player.Name
                local distance = 0
                local localCharacter = getCharacter(Players.LocalPlayer)
                if localCharacter then
                    local localHumanoidRoot = localCharacter:FindFirstChild("HumanoidRootPart")
                    local targetHumanoidRoot = character:FindFirstChild("HumanoidRootPart")
                    if localHumanoidRoot and targetHumanoidRoot then
                        distance = (localHumanoidRoot.Position - targetHumanoidRoot.Position).Magnitude
                    end
                end
                textLabel.Text = string.format("%s - %.1f studs", displayName, distance)
                textLabel.TextColor3 = ESP.Color
            end
        end
    end
end

local function updateHighlights()
    for _, player in pairs(Players:GetPlayers()) do
        local character = getCharacter(player)
        if character then
            if ESP.Enabled then
                addHighlightToCharacter(player, character)
                addBillboardToCharacter(player, character)
                updateBillboard(player, character)
            else
                removeHighlightFromCharacter(character)
                removeBillboardFromCharacter(character)
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
            addBillboardToCharacter(player, character)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        removeHighlightFromCharacter(character)
        removeBillboardFromCharacter(character)
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
