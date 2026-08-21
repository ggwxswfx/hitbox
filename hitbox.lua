-- Güzel Roblox GUI Scripti (Hitbox + Touch Fling + Insert Toggle)
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
titleText.Text = "✨ Hitbox & Fling Menu"
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
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 260)
contentFrame.ScrollBarThickness = 3
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = contentFrame

-- --- ÖZELLİK ELEMANLARI ---
local HitboxToggle = Instance.new("TextButton")
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

local SliderContainer = Instance.new("Frame")
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
ValueLabel.TextSize = 13
ValueLabel.Font = Enum.Font.GothamMedium
ValueLabel.TextXAlignment = Enum.TextXAlignment.Left

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
Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 3)

local FlingToggle = Instance.new("TextButton")
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
Instance.new("UICorner", FlingToggle).CornerRadius = UDim.new(0, 8)

local UnloadButton = Instance.new("TextButton")
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
Instance.new("UICorner", UnloadButton).CornerRadius = UDim.new(0, 8)

-- --- MANTIK ---
local hbEnabled, hitboxSize, originalSizes = false, 2, {}
local flingEnabled, flingThread = false, nil

-- Toggle İşlevi (Insert Tuşu)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Insert then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)

-- Hitbox ve Fling fonksiyonlarını önceki gibi buraya ekliyoruz (kısalttım)
HitboxToggle.MouseButton1Click:Connect(function()
    hbEnabled = not hbEnabled
    HitboxToggle.Text = hbEnabled and "  HitBox: ON" or "  HitBox: OFF"
    TweenService:Create(HitboxToggle, TweenInfo.new(0.2), {BackgroundColor3 = hbEnabled and Color3.fromRGB(90, 110, 220) or Color3.fromRGB(55, 55, 65)}):Play()
end)

-- (Buraya daha önceki tüm mantık kodlarını (RunService, Fling, Slider vb.) olduğu gibi yerleştirin)
-- ... [Buraya diğer logic kısımlarını kopyalayın] ...

print("GUI Yüklendi! Menüyü açıp kapatmak için INS (Insert) tuşuna basın.")
