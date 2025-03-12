local RemoteEventTool = {}
RemoteEventTool.__index = RemoteEventTool

function RemoteEventTool.new(eventName, eventCategory)
	local self = setmetatable({}, RemoteEventTool)
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local eventsFolder = ReplicatedStorage:WaitForChild("Events")
	local categoryFolder = eventsFolder:FindFirstChild(eventCategory)
	if not categoryFolder then
		error("Event category '" .. eventCategory .. "' not found.")
	end
	local remoteEvent = categoryFolder:FindFirstChild(eventName)
	if not remoteEvent then
		error("Remote event '" .. eventName .. "' not found in category '" .. eventCategory .. "'.")
	end
	self.remoteEvent = remoteEvent

	local tool = Instance.new("Tool")
	tool.Name = eventName .. " (" .. eventCategory .. ")"
	tool.RequiresHandle = false
	tool.CanBeDropped = false
	self.tool = tool

	local player = game.Players.LocalPlayer

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MobileControlGui"
	screenGui.ResetOnSpawn = false
	screenGui.Enabled = false
	screenGui.Parent = player:WaitForChild("PlayerGui")
	self.screenGui = screenGui

	local frame = Instance.new("Frame")
	frame.Name = "ControlFrame"
	frame.Size = UDim2.new(0, 80, 0, 230)
	frame.Position = UDim2.new(1, -90, 0.5, -115)
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.BackgroundTransparency = 0.5
	frame.Parent = screenGui
	self.controlFrame = frame

	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 20)
	uiCorner.Parent = frame

	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 10)
	listLayout.FillDirection = Enum.FillDirection.Vertical
	listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	listLayout.Parent = frame

	local keys = {"Z", "X", "C", "V"}
	self.buttons = {}
	for i, key in ipairs(keys) do
		local button = Instance.new("TextButton")
		button.Name = "Button_" .. key
		button.Text = key
		button.Size = UDim2.new(0, 50, 0, 50)
		button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
		button.TextColor3 = Color3.new(1, 1, 1)
		button.Font = Enum.Font.SourceSansBold
		button.TextSize = 18
		button.Parent = frame
		local btnCorner = Instance.new("UICorner")
		btnCorner.CornerRadius = UDim.new(1, 0)
		btnCorner.Parent = button
		button.MouseButton1Click:Connect(function()
			self.remoteEvent:FireServer(key)
		end)
		table.insert(self.buttons, button)
	end

	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	local UIS = game:GetService("UserInputService")
	local keyMap = {
		[Enum.KeyCode.Z] = "Z",
		[Enum.KeyCode.X] = "X",
		[Enum.KeyCode.C] = "C",
		[Enum.KeyCode.V] = "V"
	}
	tool.Equipped:Connect(function()
		screenGui.Enabled = true
		local inputConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			local key = keyMap[input.KeyCode]
			if key then
				self.remoteEvent:FireServer(key)
			end
		end)
		tool.Unequipped:Connect(function()
			inputConnection:Disconnect()
			screenGui.Enabled = false
		end)
	end)

	tool.AncestryChanged:Connect(function(_, parent)
		if parent ~= player.Backpack and (not player.Character or parent ~= player.Character) then
			wait(0.1)
			tool.Parent = player.Backpack
		end
	end)

	tool.Parent = player.Backpack

	return self
end

return RemoteEventTool
