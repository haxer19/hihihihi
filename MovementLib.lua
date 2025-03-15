local MovementLib = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local noclipEnabled = false
local TpWalkSpeed = 1  

local moving = {
    W = false,
    A = false,
    S = false,
    D = false,
}

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoidRootPart = newCharacter:WaitForChild("HumanoidRootPart")
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
    if noclipEnabled and character then
        updateNoclip()
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then moving.W = true end
    if input.KeyCode == Enum.KeyCode.A then moving.A = true end
    if input.KeyCode == Enum.KeyCode.S then moving.S = true end
    if input.KeyCode == Enum.KeyCode.D then moving.D = true end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.W then moving.W = false end
    if input.KeyCode == Enum.KeyCode.A then moving.A = false end
    if input.KeyCode == Enum.KeyCode.S then moving.S = false end
    if input.KeyCode == Enum.KeyCode.D then moving.D = false end
end)

RunService.Heartbeat:Connect(function(deltaTime)
    if character and humanoidRootPart then
        local moveDirection = Vector3.new(0, 0, 0)
        local camCF = workspace.CurrentCamera.CFrame

        if moving.W then moveDirection = moveDirection + camCF.LookVector end
        if moving.S then moveDirection = moveDirection - camCF.LookVector end
        if moving.A then moveDirection = moveDirection - camCF.RightVector end
        if moving.D then moveDirection = moveDirection + camCF.RightVector end

        if moveDirection.Magnitude > 0 then
            moveDirection = moveDirection.Unit
            local newPos = humanoidRootPart.Position + moveDirection * TpWalkSpeed
            humanoidRootPart.CFrame = CFrame.new(newPos, newPos + moveDirection)
        end
    end
end)

function MovementLib.SetNoclip(state)
    noclipEnabled = state
end

function MovementLib.SetTpWalkSpeed(speed)
    TpWalkSpeed = speed
end

function MovementLib.GetNoclip()
    return noclipEnabled
end

function MovementLib.GetTpWalkSpeed()
    return TpWalkSpeed
end

return MovementLib
