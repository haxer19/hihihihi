game:GetService("StarterGui"):SetCore("SendNotification", {Title = "SynHaX", Text = "Script activated!", Duration = 4})

local SG = Instance.new("ScreenGui")
SG.Name = "SynHaX_GUI"
SG.Parent = game.CoreGui

local TS = game:GetService("TweenService")
local MI = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local MF = Instance.new("Frame")
MF.Parent = SG
MF.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
MF.BorderSizePixel = 2
MF.BorderColor3 = Color3.fromRGB(128, 0, 128)
MF.Size = UDim2.new(0, 150, 0, 80)
MF.Position = UDim2.new(0, 10, 0.5, -40)
MF.Visible = false
MF.Active = true
MF.Draggable = true

local TL = Instance.new("TextLabel")
TL.Parent = MF
TL.Text = "SynHaX (troll)"
TL.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
TL.BorderSizePixel = 0
TL.Size = UDim2.new(1, 0, 0, 30)
TL.TextColor3 = Color3.fromRGB(255, 255, 255)
TL.TextScaled = true
TL.Font = Enum.Font.Gotham

local TB = Instance.new("TextButton")
TB.Parent = SG
TB.Text = "+"
TB.Size = UDim2.new(0, 25, 0, 25)
TB.Position = UDim2.new(0, 10, 0.5, -70)
TB.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
TB.BorderSizePixel = 2
TB.BorderColor3 = Color3.fromRGB(128, 0, 128)
TB.TextColor3 = Color3.fromRGB(255, 255, 255)
TB.TextScaled = true
TB.Font = Enum.Font.Gotham

local EB = Instance.new("TextButton")
EB.Parent = MF
EB.Text = "Enable"
EB.BackgroundColor3 = Color3.fromRGB(40, 0, 40)
EB.BorderSizePixel = 2
EB.BorderColor3 = Color3.fromRGB(128, 0, 128)
EB.Size = UDim2.new(1, -10, 0, 30)
EB.Position = UDim2.new(0, 5, 0, 40)
EB.TextColor3 = Color3.fromRGB(255, 255, 255)
EB.TextScaled = true
EB.Font = Enum.Font.Gotham

local function toggleGUI()
    if MF.Visible then
        local tw = TS:Create(MF, MI, {Position = UDim2.new(0, -200, 0.5, -40)})
        tw:Play()
        tw.Completed:Wait()
        MF.Visible = false
        TB.Text = "+"
    else
        MF.Visible = true
        MF.Position = UDim2.new(0, -200, 0.5, -40)
        local tw = TS:Create(MF, MI, {Position = UDim2.new(0, 10, 0.5, -40)})
        tw:Play()
        TB.Text = "-"
    end
end

TB.MouseButton1Click:Connect(toggleGUI)

local se = false
local lp = game.Players.LocalPlayer
local vp = CFrame.new(1e6, 1e6, 1e6)
local dt = 10

local function ds()
    se = false
    EB.Text = "Enable"
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = "SynHaX", Text = "Script disabled", Duration = 3})
end

local function rsl()
    spawn(function()
        while se do
            local ch = lp.Character
            if ch and ch:FindFirstChild("Humanoid") and ch:FindFirstChild("HumanoidRootPart") then
                local a = ch.Humanoid:FindFirstChild("Animator")
                if a then
                    for _, t in pairs(a:GetPlayingAnimationTracks()) do
                        if t.Animation and (t.Animation.AnimationId == "rbxassetid://12273188754" or t.Animation.AnimationId == "rbxassetid://12296113986") then
                            task.wait(0.1)
                            workspace.Camera.CameraType = Enum.CameraType.Scriptable
                            ch.HumanoidRootPart.CFrame = vp
                            ch.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
                            ch.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
                            task.wait(0.1)
                            workspace.Camera.CameraType = Enum.CameraType.Custom
                            workspace.Camera.CameraSubject = ch.Humanoid
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

local function rpl()
    spawn(function()
        while se do
            wait(0.5)
            local ch = lp.Character
            if ch and ch:FindFirstChild("HumanoidRootPart") then
                local mp = ch.HumanoidRootPart.Position
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local op = p.Character.HumanoidRootPart.Position
                        if (mp - op).Magnitude < dt then
                            pcall(function() p.Character.HumanoidRootPart.CFrame = vp end)
                            game:GetService("StarterGui"):SetCore("SendNotification", {Title = "SynHaX", Text = p.Name.." kicked", Duration = 3})
                        end
                    end
                end
            end
        end
    end)
end

EB.MouseButton1Click:Connect(function()
    if not se then
        se = true
        rsl()
        rpl()
        EB.Text = "Disable"
    else
        ds()
    end
end)
