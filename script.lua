--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "ScriptFinder"
gui.ResetOnSpawn = false

----------------------------------------------------------
-- PRIMARY GUI
----------------------------------------------------------
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 240)
main.Position = UDim2.new(0.7, 0, -1, 0) -- start off-screen
main.BackgroundColor3 = Color3.fromRGB(35,35,35)
main.Active = true
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- Shadow
local shadow = Instance.new("ImageLabel")
shadow.Parent = main
shadow.AnchorPoint = Vector2.new(0.5,0.5)
shadow.Position = UDim2.new(0.5,0,0.5,0)
shadow.Size = UDim2.new(1,40,1,40)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6015897843"
shadow.ImageColor3 = Color3.new(0,0,0)
shadow.ImageTransparency = 0.75
shadow.ZIndex = 1

-- Loading Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-50,0,40)
title.Position = UDim2.new(0,10,0,10)
title.BackgroundTransparency = 1
title.Text = "Loading..."
title.TextColor3 = Color3.fromRGB(0,255,0)
title.Font = Enum.Font.Code
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 5
title.Parent = main

-- Icon
local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0,32,0,32)
icon.BackgroundColor3 = main.BackgroundColor3
icon.BackgroundTransparency = 0
icon.Image = "rbxassetid://127710884562854"
icon.ZIndex = 6
icon.Parent = main

-- Update icon next to title
local function updateIcon()
    task.wait()
    local textWidth = title.TextBounds.X
    local iconX = 10 + textWidth + 5
    local iconY = 10 + (title.AbsoluteSize.Y - icon.Size.Y.Offset)/2
    icon.Position = UDim2.new(0, iconX, 0, iconY)
end
task.defer(updateIcon)
main:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateIcon)

-- Search Bar
local searchBar = Instance.new("TextBox")
searchBar.PlaceholderText = "Search..."
searchBar.Size = UDim2.new(1,-20,0,35)
searchBar.Position = UDim2.new(0,10,0,60)
searchBar.BackgroundColor3 = Color3.fromRGB(55,55,55)
searchBar.Text = ""
searchBar.TextColor3 = Color3.fromRGB(255,255,255)
searchBar.Font = Enum.Font.Gotham
searchBar.TextSize = 16
searchBar.Parent = main
Instance.new("UICorner", searchBar).CornerRadius = UDim.new(0,8)

-- Open SAB Script Hub Button
local openHub = Instance.new("TextButton")
openHub.Size = UDim2.new(1,-20,0,35)
openHub.Position = UDim2.new(0,10,0,105)
openHub.Text = "Open SAB Script Hub"
openHub.TextColor3 = Color3.fromRGB(255,255,255)
openHub.Font = Enum.Font.GothamBold
openHub.TextScaled = true
openHub.BackgroundColor3 = Color3.fromRGB(80,80,80)
openHub.Parent = main
Instance.new("UICorner", openHub).CornerRadius = UDim.new(0,8)

-- Credits
local creditsLabel = Instance.new("TextLabel")
creditsLabel.Size = UDim2.new(1, -20, 0, 25)
creditsLabel.Position = UDim2.new(0, 10, 0, 150)
creditsLabel.BackgroundTransparency = 1
creditsLabel.Text = "Coded & Made by Carrot/Isox"
creditsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
creditsLabel.Font = Enum.Font.Code
creditsLabel.TextScaled = true
creditsLabel.TextXAlignment = Enum.TextXAlignment.Left
creditsLabel.Parent = main

-- Discord link
local discordButton = Instance.new("TextButton")
discordButton.Size = UDim2.new(1, -20, 0, 25)
discordButton.Position = UDim2.new(0, 10, 0, 180)
discordButton.BackgroundTransparency = 1
discordButton.Text = "https://discord.gg/62NbruZyz"
discordButton.TextColor3 = Color3.fromRGB(0, 170, 255)
discordButton.Font = Enum.Font.Code
discordButton.TextScaled = true
discordButton.TextXAlignment = Enum.TextXAlignment.Left
discordButton.Parent = main
discordButton.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/62NbruZyz") end)
    discordButton.Text = "Copied to clipboard!"
    task.delay(2, function()
        discordButton.Text = "https://discord.gg/62NbruZyz"
    end)
end)

----------------------------------------------------------
-- SLIDE IN ANIMATION (LOADING EFFECT)
----------------------------------------------------------
TweenService:Create(main, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position=UDim2.new(0.7,0,0.1,0)}):Play()
task.delay(1.3, function()
    title.Text = "ScriptFinder"
    updateIcon()
end)

----------------------------------------------------------
-- DRAGGING & RESIZE
----------------------------------------------------------
local dragging = false
local dragStart
local startPos

local function startDrag(input)
    dragging = true
    dragStart = input.Position
    startPos = main.Position
end

local function updateDrag(input)
    if dragging then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
        updateIcon()
    end
end

main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        startDrag(input)
    end
end)
main.InputEnded:Connect(function() dragging = false end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

local resize = Instance.new("Frame", main)
resize.Size = UDim2.new(0,20,0,20)
resize.Position = UDim2.new(1,-20,1,-20)
resize.BackgroundColor3 = Color3.fromRGB(100,100,100)
resize.Active = true
Instance.new("UICorner", resize).CornerRadius = UDim.new(0,6)

local resizing = false
local resizeStart
resize.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then
        resizing = true
        resizeStart = input.Position
    end
end)
resize.InputEnded:Connect(function() resizing=false end)
UserInputService.InputChanged:Connect(function(input)
    if resizing then
        local delta = input.Position - resizeStart
        main.Size = UDim2.new(0, math.max(240, main.Size.X.Offset + delta.X), 0, math.max(150, main.Size.Y.Offset + delta.Y))
        resizeStart = input.Position
        updateIcon()
    end
end)

----------------------------------------------------------
-- HUB GUI
----------------------------------------------------------
local hub = Instance.new("Frame")
hub.Size = UDim2.new(0,370,0,400)
hub.Position = UDim2.new(1,400,0,10)
hub.BackgroundColor3 = Color3.fromRGB(25,25,25)
hub.Visible = false
hub.Parent = gui
Instance.new("UICorner", hub).CornerRadius = UDim.new(0,16)

local hubTitle = Instance.new("TextLabel")
hubTitle.Size = UDim2.new(1,0,0,40)
hubTitle.BackgroundTransparency = 1
hubTitle.Text = "SAB Script Hub"
hubTitle.TextColor3 = Color3.fromRGB(255,255,255)
hubTitle.Font = Enum.Font.GothamBold
hubTitle.TextScaled = true
hubTitle.Parent = hub

local backBtn = Instance.new("TextButton")
backBtn.Size = UDim2.new(0,120,0,35)
backBtn.Position = UDim2.new(0,10,0,45)
backBtn.Text = "Back"
backBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
backBtn.TextColor3 = Color3.fromRGB(255,255,255)
backBtn.Font = Enum.Font.GothamBold
backBtn.TextScaled = true
backBtn.Parent = hub
Instance.new("UICorner", backBtn).CornerRadius = UDim.new(0,10)

-- Scroll Frame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1,-20,1,-90)
scrollFrame.Position = UDim2.new(0,10,0,90)
scrollFrame.BackgroundTransparency = 1
scrollFrame.CanvasSize = UDim2.new(0,0,0,0)
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = hub

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.FillDirection = Enum.FillDirection.Vertical
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0,10)
uiListLayout.Parent = scrollFrame

-- Buttons
local buttonData = {}
for i=1,10 do
    table.insert(buttonData,{name="Button "..i,text="Panel text "..i})
end

local panels = {}

for i,data in ipairs(buttonData) do
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,0,0,40)
    container.BackgroundTransparency = 1
    container.Parent = scrollFrame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,40)
    btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.GothamBold
    btn.TextScaled = true
    btn.Text = data.name
    btn.Parent = container
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

    local panel = Instance.new("TextLabel")
    panel.Size = UDim2.new(1,0,0,0)
    panel.Position = UDim2.new(0,0,0,40)
    panel.BackgroundColor3 = btn.BackgroundColor3
    panel.TextColor3 = Color3.fromRGB(255,255,255)
    panel.Font = Enum.Font.Gotham
    panel.Text = data.text
    panel.TextWrapped = true
    panel.TextScaled = true
    panel.TextXAlignment = Enum.TextXAlignment.Left
    panel.TextYAlignment = Enum.TextYAlignment.Top
    panel.Parent = container
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0,8)

    panels[i] = {panel=panel, container=container}

    btn.MouseButton1Click:Connect(function()
        local expanded = panel.Size.Y.Offset>0
        local targetHeight = expanded and 0 or 80
        TweenService:Create(panel,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{Size=UDim2.new(1,0,0,targetHeight)}):Play()
        TweenService:Create(container,TweenInfo.new(0.3,Enum.EasingStyle.Quint),{Size=UDim2.new(1,0,0,40+targetHeight)}):Play()
        if not expanded then pcall(function() setclipboard(panel.Text) end) end
        task.delay(0.35,function() scrollFrame.CanvasSize = UDim2.new(0,0,0,uiListLayout.AbsoluteContentSize.Y + 10) end)
    end)
end

-- Open/Hide Hub
openHub.MouseButton1Click:Connect(function()
    main.Visible = false
    hub.Visible = true
    hub.Position = UDim2.new(1,400,0,10)
    TweenService:Create(hub,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(1,-380,0,10)}):Play()
end)

backBtn.MouseButton1Click:Connect(function()
    TweenService:Create(hub,TweenInfo.new(0.4,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,400,0,10)}):Play()
    task.delay(0.4,function()
        hub.Visible=false
        main.Visible=true
    end)
end)
