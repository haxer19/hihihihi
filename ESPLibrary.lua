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

ESP.Color = ESP.Colors.White

ESP.Enabled = false

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local function getCharacter(player)
    return Workspace:FindFirstChild(player.Name)
end

local function addBoxToCharacter(player, character)
    if player == Players.LocalPlayer then return end  
    if character:FindFirstChild("ESP_Box") then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = "ESP_Box"
    box.Adornee = hrp
    box.Parent = hrp
    box.Color3 = Color3.fromRGB(0, 255, 0)
    box.Transparency = 0  
    box.AlwaysOnTop = true

    local cframe, size = character:GetBoundingBox()
    box.CFrame = cframe
    box.Size = size
end

local function updateBoxToCharacter(player, character)
    if player == Players.LocalPlayer then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local box = hrp:FindFirstChild("ESP_Box")
    if box and box:IsA("BoxHandleAdornment") then
        local cframe, size = character:GetBoundingBox()
        box.CFrame = cframe
        box.Size = size
    end
end

local function removeBoxFromCharacter(character)
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local box = hrp:FindFirstChild("ESP_Box")
        if box then
            box:Destroy()
        end
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
        billboard.Size = UDim2.new(0, 150, 0, 30)
        billboard.StudsOffset = Vector3.new(0, 2, 0)
        billboard.AlwaysOnTop = true

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "ESP_TextLabel"
        textLabel.BackgroundTransparency = 1
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.TextColor3 = ESP.Color
        textLabel.TextStrokeTransparency = 0
        textLabel.TextScaled = false
        textLabel.TextSize = 13  
        textLabel.Font = Enum.Font.SourceSans
        textLabel.Parent = billboard
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
                    local localHRP = localCharacter:FindFirstChild("HumanoidRootPart")
                    local targetHRP = character:FindFirstChild("HumanoidRootPart")
                    if localHRP and targetHRP then
                        distance = (localHRP.Position - targetHRP.Position).Magnitude
                    end
                end
                textLabel.Text = string.format("%s - %.1f studs", displayName, distance)
                textLabel.TextColor3 = ESP.Color
            end
        end
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

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        local character = getCharacter(player)
        if character then
            if ESP.Enabled then
                addBoxToCharacter(player, character)
                addBillboardToCharacter(player, character)
                updateBoxToCharacter(player, character)
                updateBillboard(player, character)
            else
                removeBoxFromCharacter(character)
                removeBillboardFromCharacter(character)
            end
        end
    end
end

RunService.RenderStepped:Connect(function()
    updateESP()
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if ESP.Enabled then
            addBoxToCharacter(player, character)
            addBillboardToCharacter(player, character)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        removeBoxFromCharacter(character)
        removeBillboardFromCharacter(character)
    end
end)

function ESP:Toggle()
    self.Enabled = not self.Enabled
    updateESP()
end

function ESP:Enable()
    self.Enabled = true
    updateESP()
end

function ESP:Disable()
    self.Enabled = false
    updateESP()
end

function ESP:SetColor(newColor)
    self.Color = newColor
    updateESP()
end

return ESP