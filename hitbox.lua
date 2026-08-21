-- Güzel Roblox GUI Scripti (Hitbox + Touch Fling Entegreli)
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Eski GUI varsa temizle
if CoreGui:FindFirstChild("GuzelGui") then
    CoreGui.GuzelGui:Destroy()
end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GuzelGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = CoreGui

-- Ana Çerçeve (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(80, 80, 90)
mainStroke.Thickness = 1.5
mainStroke.Parent = mainFrame

-- Gölge efekti
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.5
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(10, 10, 118, 118)
shadow.Size = UDim2.new(1, 30, 1, 30)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.ZIndex = -1
shadow.Parent = mainFrame

-- Başlık Çubuğu (Title Bar)
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 15)
titleFix.Position = UDim2.new(0, 0, 1, -15)
titleFix.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleFix.BorderSizePixel = 0
titleFix.ZIndex = 0
titleFix.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "✨ Hitbox & Fling Menü"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

-- Kapat Butonu
local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -38, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 14
closeButton.BorderSizePixel = 0
closeButton.Parent = titleBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

-- İçerik Alanı (ScrollingFrame for clean layout)
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 55)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 260)
contentFrame.ScrollBarThickness = 3
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = contentFrame


-- --- ÖZELLİK ELEMANLARI ---

-- 1. Hitbox Toggle Butonu
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Name = "HitboxButton"
HitboxToggle.Size = UDim2.new(1, 0, 0, 45)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
HitboxToggle.Text = "  HitBox: OFF"
HitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxToggle.Font = Enum.Font.GothamMedium
HitboxToggle.TextSize = 15
HitboxToggle.TextXAlignment = Enum.TextXAlignment.Left
HitboxToggle.BorderSizePixel = 0
HitboxToggle.LayoutOrder = 1
HitboxToggle.AutoButtonColor = false
HitboxToggle.Parent = contentFrame

local hbCorner = Instance.new("UICorner")
hbCorner.CornerRadius = UDim.new(0, 8)
hbCorner.Parent = HitboxToggle

-- 2. Slider Paneli (Hitbox Boyutu için)
local SliderContainer = Instance.new("Frame")
SliderContainer.Name = "SliderContainer"
SliderContainer.Size = UDim2.new(1, 0, 0, 55)
SliderContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
SliderContainer.BorderSizePixel = 0
SliderContainer.LayoutOrder = 2
SliderContainer.Parent = contentFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 8)
SliderCorner.Parent = SliderContainer

local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(1, -16, 0, 22)
ValueLabel.Position = UDim2.new(0, 10, 0, 6)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Hitbox Boyutu: 2"
ValueLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
ValueLabel.TextSize = 13
ValueLabel.Font = Enum.Font.GothamMedium
ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
ValueLabel.Parent = SliderContainer

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(1, -20, 0, 6)
SliderBar.Position = UDim2.new(0, 10, 0, 36)
SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
SliderBar.Parent = SliderContainer

local SliderBarCorner = Instance.new("UICorner")
SliderBarCorner.CornerRadius = UDim.new(0, 3)
SliderBarCorner.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.01, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(90, 110, 220)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 3)
SliderFillCorner.Parent = SliderFill


-- 3. Touch Fling Toggle Butonu
local FlingToggle = Instance.new("TextButton")
FlingToggle.Name = "FlingButton"
FlingToggle.Size = UDim2.new(1, 0, 0, 45)
FlingToggle.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
FlingToggle.Text = "  Touch Fling: OFF"
FlingToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingToggle.Font = Enum.Font.GothamMedium
FlingToggle.TextSize = 15
FlingToggle.TextXAlignment = Enum.TextXAlignment.Left
FlingToggle.BorderSizePixel = 0
FlingToggle.LayoutOrder = 3
FlingToggle.AutoButtonColor = false
FlingToggle.Parent = contentFrame

local flingCorner = Instance.new("UICorner")
flingCorner.CornerRadius = UDim.new(0, 8)
flingCorner.Parent = FlingToggle


-- 4. Unload Butonu
local UnloadButton = Instance.new("TextButton")
UnloadButton.Name = "UnloadButton"
UnloadButton.Size = UDim2.new(1, 0, 0, 45)
UnloadButton.BackgroundColor3 = Color3.fromRGB(65, 30, 35)
UnloadButton.Text = "  Scripti Kapat (Unload)"
UnloadButton.TextColor3 = Color3.fromRGB(255, 120, 120)
UnloadButton.Font = Enum.Font.GothamMedium
UnloadButton.TextSize = 15
UnloadButton.TextXAlignment = Enum.TextXAlignment.Left
UnloadButton.BorderSizePixel = 0
UnloadButton.LayoutOrder = 4
UnloadButton.AutoButtonColor = false
UnloadButton.Parent = contentFrame

local unloadCorner = Instance.new("UICorner")
unloadCorner.CornerRadius = UDim.new(0, 8)
unloadCorner.Parent = UnloadButton


-- --- SCRIPT MANTIKLARI ---

local hbEnabled = false
local hitboxSize = 2
local originalSizes = {}

local flingEnabled = false
local flingThread = nil

if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
    local detection = Instance.new("Decal")
    detection.Name = "juisdfj0i32i0eidsuf0iok"
    detection.Parent = ReplicatedStorage
end

-- Hitbox Döngüsü
local hbConnection = RunService.RenderStepped:Connect(function()
    if hbEnabled then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = p.Character:FindFirstChild("Humanoid")
                if hrp and humanoid and humanoid.Health > 0 then
                    if not originalSizes[p] then
                        originalSizes[p] = hrp.Size
                    end
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.65
                    hrp.CanCollide = false
                    hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
                end
            end
        end
    end
end)

-- Hitbox Toggle İşlevi
HitboxToggle.MouseButton1Click:Connect(function()
    hbEnabled = not hbEnabled
    if hbEnabled then
        HitboxToggle.Text = "  HitBox: ON"
        TweenService:Create(HitboxToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 110, 220)}):Play()
    else
        HitboxToggle.Text = "  HitBox: OFF"
        TweenService:Create(HitboxToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 65)}):Play()
        
        for p, size in pairs(originalSizes) do
            if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size = size
                p.Character.HumanoidRootPart.Transparency = 1
                p.Character.HumanoidRootPart.CustomPhysicalProperties = nil
            end
        end
        originalSizes = {}
    end
end)

-- Slider Kontrolü (1 - 100)
local draggingSlider = false
SliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local mousePos = UserInputService:GetMouseLocation()
        local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        
        hitboxSize = math.floor(1 + (relativeX * 99))
        ValueLabel.Text = "Hitbox Boyutu: " .. hitboxSize
    end
end)

-- Touch Fling Mantığı
local function flingLoop()
    local lp = player
    local c, hrp, vel, movel = nil, nil, nil, 0.1

    while flingEnabled do
        RunService.Heartbeat:Wait()
        c = lp.Character
        hrp = c and c:FindFirstChild("HumanoidRootPart")

        if hrp then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= lp and p.Character then
                    local targetHrp = p.Character:FindFirstChild("HumanoidRootPart")
                    if targetHrp then
                        local distance = (hrp.Position - targetHrp.Position).Magnitude
                        if distance <= (hitboxSize / 1.5) then
                            vel = hrp.Velocity
                            hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                            RunService.RenderStepped:Wait()
                            hrp.Velocity = vel
                            RunService.Stepped:Wait()
                            hrp.Velocity = vel + Vector3.new(0, movel, 0)
                            movel = -movel
                            break
                        end
                    end
                end
            end
        end
    end
end

-- Fling Toggle İşlevi
FlingToggle.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        FlingToggle.Text = "  Touch Fling: ON"
        TweenService:Create(FlingToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 110, 220)}):Play()
        
        flingThread = coroutine.create(flingLoop)
        coroutine.resume(flingThread)
    else
        FlingToggle.Text = "  Touch Fling: OFF"
        TweenService:Create(FlingToggle, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(55, 55, 65)}):Play()
    end
end)

-- Menüyü açmak için küçük bir buton (menü gizlendiğinde görünür)
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.Position = UDim2.new(0, 20, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(90, 110, 220)
toggleButton.Text = "☰"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 22
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 25)
toggleCorner.Parent = toggleButton

toggleButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Unload Butonu İşlevi
UnloadButton.MouseButton1Click:Connect(function()
    hbEnabled = false
    flingEnabled = false
    if hbConnection then hbConnection:Disconnect() end
    
    for p, size in pairs(originalSizes) do
        if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            p.Character.HumanoidRootPart.Size = size
            p.Character.HumanoidRootPart.Transparency = 1
            p.Character.HumanoidRootPart.CustomPhysicalProperties = nil
        end
    end
    
    screenGui:Destroy()
end)

-- ==== SÜRÜKLEME ÖZELLİĞİ ====
local dragging = false
local dragInput, dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- Açılış animasyonu
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 320, 0, 420),
    Position = UDim2.new(0.5, -160, 0.5, -210)
}):Play()
