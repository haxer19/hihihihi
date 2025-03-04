local ModernGuiEditor = {}

function ModernGuiEditor.Create()
    local TweenService = game:GetService("TweenService")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "CodeEditorGui"
    screenGui.ResetOnSpawn = false

    local openButton = Instance.new("TextButton")
    openButton.Name = "OpenButton"
    openButton.Text = "Open Code Editor"
    openButton.Size = UDim2.new(0, 150, 0, 50)
    openButton.Position = UDim2.new(0.5, -75, 0.9, -25)
    openButton.BackgroundColor3 = Color3.fromRGB(75, 150, 200)
    openButton.TextColor3 = Color3.new(1, 1, 1)
    openButton.Font = Enum.Font.GothamSemibold
    openButton.TextSize = 18
    openButton.Parent = screenGui

    local openButtonCorner = Instance.new("UICorner")
    openButtonCorner.CornerRadius = UDim.new(0, 10)
    openButtonCorner.Parent = openButton

    local draggingButton = false
    local dragStartButton, startPosButton
    openButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingButton = true
            dragStartButton = input.Position
            startPosButton = openButton.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingButton = false
                end
            end)
        end
    end)
    openButton.InputChanged:Connect(function(input)
        if draggingButton and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartButton
            openButton.Position = UDim2.new(startPosButton.X.Scale, startPosButton.X.Offset + delta.X, startPosButton.Y.Scale, startPosButton.Y.Offset + delta.Y)
        end
    end)

    local editorWindow = Instance.new("Frame")
    editorWindow.Name = "EditorWindow"
    editorWindow.Size = UDim2.new(0.8, 0, 0.7, 0)
    editorWindow.Position = UDim2.new(0.1, 0, -1, 0) 
    editorWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    editorWindow.Visible = false
    editorWindow.Parent = screenGui

    local editorWindowCorner = Instance.new("UICorner")
    editorWindowCorner.CornerRadius = UDim.new(0, 12)
    editorWindowCorner.Parent = editorWindow

    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0.1, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    topBar.Parent = editorWindow

    local topBarCorner = Instance.new("UICorner")
    topBarCorner.CornerRadius = UDim.new(0, 12)
    topBarCorner.Parent = topBar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Text = "Code Editor"
    titleLabel.Size = UDim2.new(1, -50, 1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 20
    titleLabel.Parent = topBar

    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 50, 1, 0)
    closeButton.Position = UDim2.new(1, -50, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.GothamSemibold
    closeButton.TextSize = 18
    closeButton.Parent = topBar

    local closeButtonCorner = Instance.new("UICorner")
    closeButtonCorner.CornerRadius = UDim.new(0, 10)
    closeButtonCorner.Parent = closeButton

    local draggingWindow = false
    local dragStartWindow, startPosWindow
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingWindow = true
            dragStartWindow = input.Position
            startPosWindow = editorWindow.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    draggingWindow = false
                end
            end)
        end
    end)
    topBar.InputChanged:Connect(function(input)
        if draggingWindow and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartWindow
            editorWindow.Position = UDim2.new(startPosWindow.X.Scale, startPosWindow.X.Offset + delta.X, startPosWindow.Y.Scale, startPosWindow.Y.Offset + delta.Y)
        end
    end)

    local codeEditorFrame = Instance.new("ScrollingFrame")
    codeEditorFrame.Name = "CodeEditorFrame"
    codeEditorFrame.Size = UDim2.new(0.95, 0, 0.75, 0)
    codeEditorFrame.Position = UDim2.new(0.025, 0, 0.15, 0)
    codeEditorFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    codeEditorFrame.ScrollBarThickness = 8
    codeEditorFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    codeEditorFrame.Parent = editorWindow

    local codeEditorCorner = Instance.new("UICorner")
    codeEditorCorner.CornerRadius = UDim.new(0, 8)
    codeEditorCorner.Parent = codeEditorFrame

    local codeEditor = Instance.new("TextBox")
    codeEditor.Name = "CodeEditor"
    codeEditor.Size = UDim2.new(1, -10, 1, -10)
    codeEditor.Position = UDim2.new(0, 5, 0, 5)
    codeEditor.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    codeEditor.TextColor3 = Color3.fromRGB(240, 240, 240)
    codeEditor.ClearTextOnFocus = false
    codeEditor.Font = Enum.Font.Code
    codeEditor.TextWrapped = false
    codeEditor.TextXAlignment = Enum.TextXAlignment.Left
    codeEditor.TextYAlignment = Enum.TextYAlignment.Top
    codeEditor.MultiLine = true
    codeEditor.Text = ""
    codeEditor.RichText = true  
    codeEditor.Parent = codeEditorFrame

    local suggestionFrame = Instance.new("ScrollingFrame")
    suggestionFrame.Name = "SuggestionFrame"
    suggestionFrame.Size = UDim2.new(0.95, 0, 0.1, 0)
    suggestionFrame.Position = UDim2.new(0.025, 0, 0.9, 0)
    suggestionFrame.BackgroundTransparency = 0.5
    suggestionFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    suggestionFrame.Visible = false
    suggestionFrame.ScrollBarThickness = 4
    suggestionFrame.Parent = editorWindow

    local suggestionCorner = Instance.new("UICorner")
    suggestionCorner.CornerRadius = UDim.new(0, 8)
    suggestionCorner.Parent = suggestionFrame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = suggestionFrame
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local luaKeywords = {
        "and", "break", "do", "else", "elseif", "end", "false",
        "for", "function", "if", "in", "local", "nil", "not",
        "or", "repeat", "return", "then", "true", "until", "while",
        "print", "pairs", "ipairs", "table", "string", "math", "coroutine"
    }

    codeEditor:GetPropertyChangedSignal("Text"):Connect(function()
        local text = codeEditor.Text
        local currentWord = string.match(text, "([^%s]+)$") or ""
        if #currentWord > 0 then
            local suggestions = {}
            for _, keyword in ipairs(luaKeywords) do
                if keyword:sub(1, #currentWord):lower() == currentWord:lower() then
                    table.insert(suggestions, keyword)
                end
            end
            if #suggestions > 0 then
                suggestionFrame.Visible = true
                for _, child in ipairs(suggestionFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                for _, suggestion in ipairs(suggestions) do
                    local suggestionButton = Instance.new("TextButton")
                    suggestionButton.Text = suggestion
                    suggestionButton.Size = UDim2.new(1, 0, 0, 20)
                    suggestionButton.BackgroundTransparency = 0.5
                    suggestionButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    suggestionButton.TextColor3 = Color3.new(1, 1, 1)
                    suggestionButton.Font = Enum.Font.Gotham
                    suggestionButton.TextSize = 16
                    suggestionButton.Parent = suggestionFrame
                    suggestionButton.MouseButton1Click:Connect(function()
                        local newText = string.gsub(text, "([^%s]+)$", suggestion)
                        codeEditor.Text = newText
                        suggestionFrame.Visible = false
                    end)
                end
                local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                TweenService:Create(suggestionFrame, tweenInfo, {BackgroundTransparency = 0.2}):Play()
            else
                suggestionFrame.Visible = false
            end
        else
            suggestionFrame.Visible = false
        end
    end)

    local runButton = Instance.new("TextButton")
    runButton.Name = "RunButton"
    runButton.Text = "Run Code"
    runButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    runButton.Position = UDim2.new(0.35, 0, 0.85, 0)
    runButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    runButton.TextColor3 = Color3.new(1, 1, 1)
    runButton.Font = Enum.Font.GothamBold
    runButton.TextSize = 18
    runButton.Parent = editorWindow

    local runButtonCorner = Instance.new("UICorner")
    runButtonCorner.CornerRadius = UDim.new(0, 10)
    runButtonCorner.Parent = runButton

    runButton.MouseButton1Click:Connect(function()
        local code = codeEditor.Text
        local func, err = loadstring(code)
        if not func then
            warn("Error in code: ", err)
        else
            local success, result = pcall(func)
            if not success then
                warn("Runtime error: ", result)
            else
                print("Code executed successfully")
            end
        end
    end)

    openButton.MouseButton1Click:Connect(function()
        editorWindow.Visible = true
        openButton.Visible = false
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(editorWindow, tweenInfo, {Position = UDim2.new(0.1, 0, 0.1, 0)})
        tween:Play()
    end)
    closeButton.MouseButton1Click:Connect(function()
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local tween = TweenService:Create(editorWindow, tweenInfo, {Position = UDim2.new(0.1, 0, -1, 0)})
        tween:Play()
        tween.Completed:Connect(function()
            editorWindow.Visible = false
            openButton.Visible = true
        end)
    end)

    screenGui.Parent = game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return ModernGuiEditor
end

return ModernGuiEditor
