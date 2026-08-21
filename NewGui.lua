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
mainFrame.Size = UDim2.new(0, 320, 0, 500) -- Boyut biraz uzatıldı
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -250)
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
titleText.Size = UDim2.new(1, -50, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "✨ Advanced Menu"
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.TextSize = 16
titleText.Font = Enum.Font.GothamBold
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -38, 0.5, -15)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Parent = titleBar
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0, 8)

-- İçerik Alanı
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, -20, 1, -60)
contentFrame.Position = UDim2.new(0, 10, 0, 55)
contentFrame.BackgroundTransparency = 1
contentFrame.ScrollBarThickness = 3
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 400)
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.Parent = contentFrame

-- --- ÖZELLİKLER ---

-- Hitbox
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(1, 0, 0, 45)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
HitboxToggle.Text = "  HitBox: OFF"
HitboxToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxToggle.Font = Enum.Font.GothamMedium
HitboxToggle.Parent = contentFrame
Instance.new("UICorner", HitboxToggle).CornerRadius = UDim.new(0, 8)

-- Teleport Bölümü
local TPContainer = Instance.new("Frame")
TPContainer.Size = UDim2.new(1, 0, 0, 100)
TPContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
TPContainer.Parent = contentFrame
Instance.new("UICorner", TPContainer).CornerRadius = UDim.new(0, 8)

local coordLabel = Instance.new("TextLabel")
coordLabel.Size = UDim2.new(1, 0, 0, 30)
coordLabel.BackgroundTransparency = 1
coordLabel.Text = "X: 0 | Y: 0 | Z: 0"
coordLabel.TextColor3 = Color3.fromRGB(0, 255, 128)
coordLabel.Parent = TPContainer

local boxX = Instance.new("TextBox", TPContainer)
boxX.Size = UDim2.new(0.3, 0, 0, 30); boxX.Position = UDim2.new(0, 5, 0, 35)
boxX.PlaceholderText = "X"; boxX.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
boxX.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", boxX)

local boxY = Instance.new("TextBox", TPContainer)
boxY.Size = UDim2.new(0.3, 0, 0, 30); boxY.Position = UDim2.new(0.35, 0, 0, 35)
boxY.PlaceholderText = "Y"; boxY.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
boxY.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", boxY)

local boxZ = Instance.new("TextBox", TPContainer)
boxZ.Size = UDim2.new(0.3, 0, 0, 30); boxZ.Position = UDim2.new(0.68, 0, 0, 35)
boxZ.PlaceholderText = "Z"; boxZ.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
boxZ.TextColor3 = Color3.fromRGB(255,255,255); Instance.new("UICorner", boxZ)

local teleportBtn = Instance.new("TextButton", TPContainer)
teleportBtn.Size = UDim2.new(1, -10, 0, 25); teleportBtn.Position = UDim2.new(0, 5, 0, 70)
teleportBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255); teleportBtn.Text = "Teleport"
teleportBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", teleportBtn)

-- Fonksiyonlar (Logic)
local hbEnabled = false
RunService.RenderStepped:Connect(function()
    pcall(function()
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local pos = character.HumanoidRootPart.Position
            coordLabel.Text = string.format("X: %.0f | Y: %.0f | Z: %.0f", pos.X, pos.Y, pos.Z)
        end
    end)
end)

teleportBtn.MouseButton1Click:Connect(function()
    local x, y, z = tonumber(boxX.Text), tonumber(boxY.Text), tonumber(boxZ.Text)
    if x and y and z and player.Character then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    end
end)

HitboxToggle.MouseButton1Click:Connect(function()
    hbEnabled = not hbEnabled
    HitboxToggle.Text = hbEnabled and "  HitBox: ON" or "  HitBox: OFF"
    HitboxToggle.BackgroundColor3 = hbEnabled and Color3.fromRGB(90, 110, 220) or Color3.fromRGB(55, 55, 65)
end)

closeButton.MouseButton1Click:Connect(function() mainFrame.Visible = false end)