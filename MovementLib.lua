local MovementLib = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local noclipEnabled = false
local TpWalkSpeed = 0.1

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
    humanoid = newCharacter:WaitForChild("Humanoid")
end)

local function updateNoclip()
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipEnabled
            end
        end
    end
end

RunService.Stepped:Connect(function()
    if character and noclipEnabled then
        updateNoclip()
    end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    if character and humanoidRootPart and humanoid then
        local moveDirection = humanoid.MoveDirection
        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
            local newPos = humanoidRootPart.Position + moveDirection * TpWalkSpeed
            humanoidRootPart.CFrame = CFrame.new(newPos, newPos + moveDirection)
        end
    end
end)

function MovementLib.SetNoclip(state)
    noclipEnabled = state
    if not noclipEnabled then
        if humanoidRootPart then
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end

function MovementLib.SetTpWalkSpeed(speed)
    TpWalkSpeed = speed * 0.1
end

function MovementLib.GetNoclip()
    return noclipEnabled
end

function MovementLib.GetTpWalkSpeed()
    return TpWalkSpeed
end

return MovementLib
