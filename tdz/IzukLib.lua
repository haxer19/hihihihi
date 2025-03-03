local IzukLib = {}
IzukLib.__index = IzukLib

IzukLib.Themes = {
    Default = {
        BackgroundColor = Color3.fromRGB(24, 15, 42),
        AccentColor = Color3.fromRGB(100, 50, 160),   
        TextColor = Color3.fromRGB(240, 240, 240)      
    },    
    White = {
        BackgroundColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(0, 0, 0)
    },
    Black = {
        BackgroundColor = Color3.fromRGB(0, 0, 0),
        AccentColor = Color3.fromRGB(255, 255, 255),
        TextColor = Color3.fromRGB(255, 255, 255)
    },
    Professional = {
        BackgroundColor = Color3.fromRGB(240, 240, 240),
        AccentColor = Color3.fromRGB(0, 128, 0),
        TextColor = Color3.fromRGB(0, 0, 0)
    },
    Gaming = {
        BackgroundColor = Color3.fromRGB(25, 25, 25),
        AccentColor = Color3.fromRGB(255, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255)
    },
    Secret = {
        BackgroundColor = Color3.fromRGB(0, 0, 0),
        AccentColor = Color3.fromRGB(0, 0, 255),
        TextColor = Color3.fromRGB(255, 255, 255)
    }
}

function IzukLib:LoadWindow()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "IzukLib"
    screenGui.Parent = game:GetService("CoreGui")
    self.ScreenGui = screenGui
    return screenGui
end

function IzukLib:CreateWindow(params)
    params = params or {}
    local window = Instance.new("Frame")
    window.Name = params.Title or "Window"
    window.Size = UDim2.new(0, 400, 0, 300)
    window.Position = params.Position or UDim2.new(0.5, -200, 0.5, -150)
    window.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.BackgroundColor
    window.Parent = self.ScreenGui or self:LoadWindow()

    self:EnableDrag(window)

    self.Window = window
    return window
end

function IzukLib:CustomOpenButton(params)
    params = params or {}
    local button = Instance.new("TextButton")
    button.Name = "OpenButton"
    button.Size = UDim2.new(0, 100, 0, 50)
    button.Position = params.Position or UDim2.new(0, 10, 0, 10)
    button.Text = params.Text or "Open"
    button.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.AccentColor
    button.TextColor3 = params.TextColor or IzukLib.Themes.Default.TextColor
    button.Parent = self.ScreenGui or self:LoadWindow()

    button.MouseButton1Click:Connect(function()
        if self.Window then
            self.Window.Visible = not self.Window.Visible
        end
    end)

    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    local dragStart, startPos

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    button.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    return button
end

function IzukLib:DefaultNotification(options)
    options = options or {}
    local title = options.Title or "Notification"
    local text = options.Text or "This is a notification."
    local icon = options.Icon or ""
    local duration = options.Duration or 5

    local TweenService = game:GetService("TweenService")

    local notif = Instance.new("Frame")
    notif.Name = "Notification"
    notif.Size = UDim2.new(0, 320, 0, 80)
    notif.AnchorPoint = Vector2.new(1, 0)
    notif.Position = UDim2.new(1, 10, 0, 10)
    notif.BackgroundColor3 = IzukLib.Themes.Default.AccentColor
    notif.BackgroundTransparency = 0.2
    notif.BorderSizePixel = 0
    notif.Parent = self.ScreenGui or self:LoadWindow()

    local uicorner = Instance.new("UICorner")
    uicorner.CornerRadius = UDim.new(0, 8)
    uicorner.Parent = notif

    if icon ~= "" then
        local iconLabel = Instance.new("ImageLabel")
        iconLabel.Name = "Icon"
        iconLabel.Size = UDim2.new(0, 80, 0, 80)
        iconLabel.Position = UDim2.new(0, 0, 0, 0)
        iconLabel.Image = icon
        iconLabel.BackgroundTransparency = 1
        iconLabel.Parent = notif
    end

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0.65, 0, 0.4, 0)
    titleLabel.Position = UDim2.new(0.35, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = IzukLib.Themes.Default.TextColor
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = notif

    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "ContentLabel"
    contentLabel.Size = UDim2.new(0.65, 0, 0.6, 0)
    contentLabel.Position = UDim2.new(0.35, 0, 0.4, 0)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = text
    contentLabel.TextColor3 = IzukLib.Themes.Default.TextColor
    contentLabel.TextScaled = true
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextWrapped = true
    contentLabel.Parent = notif

    local targetPosition = UDim2.new(1, -10, 0, 10)
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(notif, tweenInfo, {Position = targetPosition})
    tween:Play()

    delay(duration, function()
        local tweenOut = TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 10, 0, 10)})
        tweenOut:Play()
        tweenOut.Completed:Connect(function()
            notif:Destroy()
        end)
    end)

    return notif
end

function IzukLib:CreateTab(tabName)
    local tab = Instance.new("Frame")
    tab.Name = tabName or "Tab"
    tab.Size = UDim2.new(0, 380, 0, 260)
    tab.Position = UDim2.new(0, 10, 0, 40)
    tab.BackgroundColor3 = IzukLib.Themes.Default.BackgroundColor
    tab.Visible = true
    tab.Parent = self.Window

    if not self.Tabs then
        self.Tabs = {}
    end
    table.insert(self.Tabs, tab)
    return tab
end

function IzukLib:CreateButton(tab, params)
    params = params or {}
    local button = Instance.new("TextButton")
    button.Name = params.Name or "Button"
    button.Size = UDim2.new(0, params.Width or 100, 0, params.Height or 30)
    button.Position = params.Position or UDim2.new(0, 10, 0, 10)
    button.Text = params.Text or "Button"
    button.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.AccentColor
    button.TextColor3 = params.TextColor or IzukLib.Themes.Default.TextColor
    button.Parent = tab
    if params.Callback then
        button.MouseButton1Click:Connect(params.Callback)
    end
    return button
end

function IzukLib:CreateDropdown(tab, params)
    params = params or {}
    local dropdown = Instance.new("Frame")
    dropdown.Name = params.Name or "Dropdown"
    dropdown.Size = UDim2.new(0, params.Width or 150, 0, params.Height or 30)
    dropdown.Position = params.Position or UDim2.new(0, 10, 0, 10)
    dropdown.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.AccentColor
    dropdown.Parent = tab

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Text = params.Title or "Select"
    title.TextColor3 = params.TextColor or IzukLib.Themes.Default.TextColor
    title.BackgroundTransparency = 1
    title.Parent = dropdown

    dropdown.Items = params.Items or {}
    dropdown.IsOpen = false

    return dropdown
end

function IzukLib:EditDropdown(dropdown, action, ...)
    local args = {...}
    if action == "SetTitle" then
        local newTitle = args[1]
        if dropdown:FindFirstChild("Title") then
            dropdown.Title.Text = newTitle
        end
    elseif action == "Refresh" then
        -- lammoi
    elseif action == "Select" then
        local selection = args[1]
        if dropdown:FindFirstChild("Title") then
            dropdown.Title.Text = tostring(selection)
        end
    elseif action == "Multi" then
        local selections = args[1] 
        if dropdown:FindFirstChild("Title") then
            dropdown.Title.Text = table.concat(selections, ", ")
        end
    end
end

function IzukLib:CreateInput(tab, params)
    params = params or {}
    local input = Instance.new("TextBox")
    input.Name = params.Name or "Input"
    input.Size = UDim2.new(0, params.Width or 150, 0, params.Height or 30)
    input.Position = params.Position or UDim2.new(0, 10, 0, 10)
    input.Text = params.Placeholder or ""
    input.PlaceholderText = params.Placeholder or "Enter text..."
    input.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.AccentColor
    input.TextColor3 = params.TextColor or IzukLib.Themes.Default.TextColor
    input.Parent = tab
    if params.Callback then
        input.FocusLost:Connect(function(enterPressed)
            params.Callback(input.Text)
        end)
    end
    return input
end

function IzukLib:CreateSection(tab, params)
    params = params or {}
    local section = Instance.new("Frame")
    section.Name = params.Name or "Section"
    section.Size = UDim2.new(0, params.Width or 360, 0, params.Height or 40)
    section.Position = params.Position or UDim2.new(0, 10, 0, 10)
    section.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.BackgroundColor
    section.Parent = tab

    local label = Instance.new("TextLabel")
    label.Name = "SectionLabel"
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.Text = params.Title or "Section"
    label.TextColor3 = params.TextColor or IzukLib.Themes.Default.TextColor
    label.BackgroundTransparency = 1
    label.Parent = section

    return section
end

function IzukLib:CreateToggle(tab, params)
    params = params or {}
    local toggle = Instance.new("Frame")
    toggle.Name = params.Name or "Toggle"
    toggle.Size = UDim2.new(0, params.Width or 150, 0, params.Height or 30)
    toggle.Position = params.Position or UDim2.new(0, 10, 0, 10)
    toggle.BackgroundColor3 = params.BackgroundColor or IzukLib.Themes.Default.AccentColor
    toggle.Parent = tab

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(0.7, 0, 1, 0)
    title.Position = UDim2.new(0, 5, 0, 0)
    title.Text = params.Title or "Toggle"
    title.TextColor3 = params.TextColor or IzukLib.Themes.Default.TextColor
    title.BackgroundTransparency = 1
    title.Parent = toggle

    local button = Instance.new("TextButton")
    button.Name = "ToggleButton"
    button.Size = UDim2.new(0.3, 0, 1, 0)
    button.Position = UDim2.new(0.7, 0, 0, 0)
    button.Text = params.Value and "On" or "Off"
    button.BackgroundColor3 = params.ButtonColor or Color3.new(1, 1, 1)
    button.Parent = toggle

    button.MouseButton1Click:Connect(function()
        params.Value = not params.Value
        button.Text = params.Value and "On" or "Off"
        if params.Callback then
            params.Callback(params.Value)
        end
    end)

    toggle.TitleLabel = title
    toggle.ToggleButton = button

    return toggle
end

function IzukLib:EditToggle(toggle, action, value)
    if action == "SetTitle" then
        if toggle:FindFirstChild("Title") then
            toggle.Title.Text = value
        end
    elseif action == "SetValue" then
        if toggle:FindFirstChild("ToggleButton") then
            toggle.ToggleButton.Text = value and "On" or "Off"
            if toggle.Callback then
                toggle.Callback(value)
            end
        end
    end
end

function IzukLib:EnableDrag(guiObject)
    local UserInputService = game:GetService("UserInputService")
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        guiObject.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    guiObject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = guiObject.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    guiObject.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            dragInput = input
            update(dragInput)
        end
    end)
end

function IzukLib:KillGUI()
    if self.ScreenGui then
        self.ScreenGui:Destroy()
    end
end

return IzukLib

