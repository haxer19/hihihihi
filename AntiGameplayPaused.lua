local AntiLib = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local antiLimit = 5
local triggered = false
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local savedPos = hrp.Position

local heartbeatConnection, characterAddedConnection, descendantAddedConnection, updatePosThread
local origLoadCharacter = LocalPlayer.LoadCharacter
local origDestroy = Instance.Destroy

local function startAnti()
	triggered = false
	local startTime = tick()
	updatePosThread = coroutine.create(function()
		while AntiLib.Enabled do
			if character and character:FindFirstChild("HumanoidRootPart") then
				savedPos = character.HumanoidRootPart.Position
			end
			wait(1)
		end
	end)
	coroutine.resume(updatePosThread)
	
	local function removePaused(gui)
		for _, v in ipairs(gui:GetDescendants()) do
			if v:IsA("TextLabel") and v.Text and v.Text:find("Paused") then
				v:Destroy()
			end
		end
	end
	removePaused(PlayerGui)
	descendantAddedConnection = PlayerGui.DescendantAdded:Connect(function(child)
		if child:IsA("TextLabel") and child.Text and child.Text:find("Paused") then
			child:Destroy()
		end
	end)
	characterAddedConnection = LocalPlayer.CharacterAdded:Connect(function(char)
		character = char
		local newHRP = char:WaitForChild("HumanoidRootPart")
		newHRP.CFrame = CFrame.new(savedPos)
	end)
	heartbeatConnection = RunService.Heartbeat:Connect(function()
		if not triggered and tick() - startTime > antiLimit then
			triggered = true
			LocalPlayer:LoadCharacter()
		end
	end)
end

local function stopAnti()
	if heartbeatConnection then heartbeatConnection:Disconnect() end
	if characterAddedConnection then characterAddedConnection:Disconnect() end
	if descendantAddedConnection then descendantAddedConnection:Disconnect() end
	LocalPlayer.LoadCharacter = function() end
	function Instance:Destroy()
		if self:IsA("TextLabel") and self.Text and self.Text:find("Paused") then
			return
		end
		return origDestroy(self)
	end
end

function AntiLib.SetEnabled(state)
	if state then
		AntiLib.Enabled = true
		LocalPlayer.LoadCharacter = origLoadCharacter
		Instance.Destroy = origDestroy
		startAnti()
	else
		AntiLib.Enabled = false
		stopAnti()
	end
end

return AntiLib