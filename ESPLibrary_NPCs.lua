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

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer
local NPCsFolder = Workspace:WaitForChild("NPCs")

local function getAdorneeForNPC(npc)
    if npc.PrimaryPart then
        return npc.PrimaryPart
    elseif npc:FindFirstChild("Head") then
        return npc.Head
    else
        return npc:FindFirstChildWhichIsA("BasePart")
    end
end

local function addHighlightToNPC(npc)
    if not npc or not npc:IsA("Model") then return end
    if npc:FindFirstChild("HighlightESP") then return end  

    local highlight = Instance.new("Highlight")
    highlight.Name = "HighlightESP"
    highlight.Adornee = npc
    highlight.Parent = npc
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillColor = ESP.Color
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
end

local function removeHighlightFromNPC(npc)
    if not npc or not npc:IsA("Model") then return end
    local highlight = npc:FindFirstChild("HighlightESP")
    if highlight then
        highlight:Destroy()
    end
end

local function addESPTextToNPC(npc)
    if not npc or not npc:IsA("Model") then return end
    if npc:FindFirstChild("ESPText") then return end

    local adornee = getAdorneeForNPC(npc)
    if not adornee then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPText"
    billboard.Adornee = adornee
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 200, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.Parent = npc

    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "ESPLabel"
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = ESP.Color
    textLabel.TextStrokeTransparency = 0
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.Parent = billboard
end

local function removeESPTextFromNPC(npc)
    if not npc or not npc:IsA("Model") then return end
    local billboard = npc:FindFirstChild("ESPText")
    if billboard then
        billboard:Destroy()
    end
end

local function updateESPText(npc)
    if not npc or not npc:IsA("Model") then return end
    local billboard = npc:FindFirstChild("ESPText")
    if billboard then
        local textLabel = billboard:FindFirstChild("ESPLabel")
        if textLabel then
            local adornee = getAdorneeForNPC(npc)
            if adornee and localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local distance = (adornee.Position - localPlayer.Character.HumanoidRootPart.Position).Magnitude
                textLabel.Text = npc.Name .. " - " .. math.floor(distance) .. "m"
            else
                textLabel.Text = npc.Name
            end
            textLabel.TextColor3 = ESP.Color
        end
    end
end

local function updateHighlights()
    for _, npc in pairs(NPCsFolder:GetChildren()) do
        if npc:IsA("Model") then
            if ESP.Enabled then
                addHighlightToNPC(npc)
                addESPTextToNPC(npc)
                updateESPText(npc)
                local highlight = npc:FindFirstChild("HighlightESP")
                if highlight then
                    highlight.FillColor = ESP.Color
                end
            else
                removeHighlightFromNPC(npc)
                removeESPTextFromNPC(npc)
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    if ESP.Enabled then
        updateHighlights()
    end
end)

NPCsFolder.ChildAdded:Connect(function(child)
    if child:IsA("Model") and ESP.Enabled then
        addHighlightToNPC(child)
        addESPTextToNPC(child)
    end
end)

NPCsFolder.ChildRemoved:Connect(function(child)
    if child:IsA("Model") then
        removeHighlightFromNPC(child)
        removeESPTextFromNPC(child)
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