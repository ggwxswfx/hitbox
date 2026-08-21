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

-- Başlık Çubuğu
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleBar

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

-- İçerik Alanı
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 55)
contentFrame.BackgroundTransparency = 1
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 450)
contentFrame.ScrollBarThickness = 3
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = contentFrame

-- --- ÖZELLİK ELEMANLARI ---

-- 1. Hitbox Toggle
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
Instance.new("UICorner", HitboxToggle).CornerRadius = UDim.new(0, 8)

-- 2. Slider
local SliderContainer = Instance.new("Frame")
SliderContainer.Name = "SliderContainer"
SliderContainer.Size = UDim2.new(1, 0, 0, 55)
SliderContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
SliderContainer.BorderSizePixel = 0
SliderContainer.LayoutOrder = 2
SliderContainer.Parent = contentFrame
Instance.new("UICorner", SliderContainer).CornerRadius = UDim.new(0, 8)

local ValueLabel = Instance.new("TextLabel", SliderContainer)
ValueLabel.Size = UDim2.new(1, -16, 0, 22)
ValueLabel.Position = UDim2.new(0, 10, 0, 6)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Hitbox Boyutu: 2"
ValueLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
ValueLabel.Font = Enum.Font.GothamMedium

local SliderBar = Instance.new("TextButton", SliderContainer)
SliderBar.Size = UDim2.new(1, -20, 0, 6)
SliderBar.Position = UDim2.new(0, 10, 0, 36)
SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 75)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
Instance.new("UICorner", SliderBar).CornerRadius = UDim.new(0, 3)

local SliderFill = Instance.new("Frame", SliderBar)
SliderFill.Size = UDim2.new(0.01, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(90, 110, 220)
SliderFill.BorderSizePixel = 0
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 3)

-- 3. Touch Fling
local FlingToggle = Instance.new("TextButton")
FlingToggle.Name = "FlingButton"
FlingToggle.Size = UDim2.new(1, 0, 0, 45)
FlingToggle.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
FlingToggle.Text = "  Touch Fling: OFF"
FlingToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingToggle.Font = Enum.Font.GothamMedium
FlingToggle.LayoutOrder = 3
FlingToggle.AutoButtonColor = false
FlingToggle.Parent = contentFrame
Instance.new("UICorner", FlingToggle).CornerRadius = UDim.new(0, 8)

-- --- YENİ EKLENEN TELEPORT BÖLÜMÜ ---
local TPContainer = Instance.new("Frame")
TPContainer.Name = "TPContainer"
TPContainer.Size = UDim2.new(1, 0, 0, 100)
TPContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
TPContainer.BorderSizePixel = 0
TPContainer.LayoutOrder = 4
TPContainer.Parent = contentFrame
Instance.new("UICorner", TPContainer).CornerRadius = UDim.new(0, 8)

local coordLabel = Instance.new("TextLabel", TPContainer)
coordLabel.Size = UDim2.new(1, 0, 0, 25)
coordLabel.BackgroundTransparency = 1
coordLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
coordLabel.Text = "X: 0 | Y: 0 | Z: 0"
coordLabel.Font = Enum.Font.Code

local boxX = Instance.new("TextBox", TPContainer)
boxX.Size = UDim2.new(0.3, -5, 0, 25); boxX.Position = UDim2.new(0, 5, 0, 30)
boxX.BackgroundColor3 = Color3.fromRGB(55, 55, 65); boxX.PlaceholderText = "X"; boxX.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", boxX).CornerRadius = UDim.new(0, 4)

local boxY = Instance.new("TextBox", TPContainer)
boxY.Size = UDim2.new(0.3, -5, 0, 25); boxY.Position = UDim2.new(0.35, 0, 0, 30)
boxY.BackgroundColor3 = Color3.fromRGB(55, 55, 65); boxY.PlaceholderText = "Y"; boxY.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", boxY).CornerRadius = UDim.new(0, 4)

local boxZ = Instance.new("TextBox", TPContainer)
boxZ.Size = UDim2.new(0.3, -5, 0, 25); boxZ.Position = UDim2.new(0.7, 0, 0, 30)
boxZ.BackgroundColor3 = Color3.fromRGB(55, 55, 65); boxZ.PlaceholderText = "Z"; boxZ.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", boxZ).CornerRadius = UDim.new(0, 4)

local teleportBtn = Instance.new("TextButton", TPContainer)
teleportBtn.Size = UDim2.new(1, -10, 0, 30); teleportBtn.Position = UDim2.new(0, 5, 0, 60)
teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255); teleportBtn.Text = "Teleport"
teleportBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", teleportBtn)

-- 4. Unload
local UnloadButton = Instance.new("TextButton")
UnloadButton.Name = "UnloadButton"
UnloadButton.Size = UDim2.new(1, 0, 0, 45)
UnloadButton.BackgroundColor3 = Color3.fromRGB(65, 30, 35)
UnloadButton.Text = "  Scripti Kapat (Unload)"
UnloadButton.TextColor3 = Color3.fromRGB(255, 120, 120)
UnloadButton.Font = Enum.Font.GothamMedium
UnloadButton.LayoutOrder = 5
UnloadButton.AutoButtonColor = false
UnloadButton.Parent = contentFrame
Instance.new("UICorner", UnloadButton).CornerRadius = UDim.new(0, 8)

-- --- MANTIKLAR ---
local hbEnabled, flingEnabled, hitboxSize = false, false, 2
local originalSizes = {}

RunService.RenderStepped:Connect(function()
    -- Hitbox & Koordinat Güncelleme
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local pos = char.HumanoidRootPart.Position
        coordLabel.Text = string.format("X: %.0f | Y: %.0f | Z: %.0f", pos.X, pos.Y, pos.Z)
        
        if hbEnabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hrp = p.Character.HumanoidRootPart
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.6
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

teleportBtn.MouseButton1Click:Connect(function()
    local x, y, z = tonumber(boxX.Text), tonumber(boxY.Text), tonumber(boxZ.Text)
    if x and y and z and player.Character then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end)

-- (Diğer buton mantıkların aynı şekilde devam ediyor...)
HitboxToggle.MouseButton1Click:Connect(function() hbEnabled = not hbEnabled; HitboxToggle.Text = hbEnabled and "  HitBox: ON" or "  HitBox: OFF" end)
FlingToggle.MouseButton1Click:Connect(function() flingEnabled = not flingEnabled; FlingToggle.Text = flingEnabled and "  Touch Fling: ON" or "  Touch Fling: OFF" end)
closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)
UnloadButton.MouseButton1Click:Connect(function() screenGui:Destroy() end)
