-- Modern HitBox GUI (Roblox Luau - Full Rewrite)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Eski GUI varsa temizle
if CoreGui:FindFirstChild("LiquidHitboxGui") then
    CoreGui.LiquidHitboxGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LiquidHitboxGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 240)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -120)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Üst Başlık Çubuğu
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Combat / HitBoxes"
Title.TextColor3 = Color3.fromRGB(235, 235, 245)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Ana Özellik Toggle Butonu
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 250, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -125, 0, 55)
ToggleButton.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
ToggleButton.Text = "HitBoxes: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(160, 160, 175)
ToggleButton.TextSize = 14
ToggleButton.Font = Enum.Font.GothamMedium
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 8)
ToggleCorner.Parent = ToggleButton

-- Slider Alanı
local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(1, -30, 0, 20)
ValueLabel.Position = UDim2.new(0, 15, 0, 110)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Size: 2"
ValueLabel.TextColor3 = Color3.fromRGB(180, 180, 195)
ValueLabel.TextSize = 13
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
ValueLabel.Parent = MainFrame

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(0, 250, 0, 10)
SliderBar.Position = UDim2.new(0.5, -125, 0, 138)
SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
SliderBar.Parent = MainFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 5)
SliderCorner.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.01, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(110, 80, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 5)
SliderFillCorner.Parent = SliderFill

-- Unload Butonu
local UnloadButton = Instance.new("TextButton")
UnloadButton.Size = UDim2.new(0, 250, 0, 35)
UnloadButton.Position = UDim2.new(0.5, -125, 0, 180)
UnloadButton.BackgroundColor3 = Color3.fromRGB(55, 25, 30)
UnloadButton.Text = "Unload Script"
UnloadButton.TextColor3 = Color3.fromRGB(255, 100, 100)
UnloadButton.TextSize = 13
UnloadButton.Font = Enum.Font.GothamMedium
UnloadButton.Parent = MainFrame

local UnloadCorner = Instance.new("UICorner")
UnloadCorner.CornerRadius = UDim.new(0, 8)
UnloadCorner.Parent = UnloadButton

-- Değişkenler ve Mantık
local enabled = false
local hitboxSize = 2
local originalSizes = {}
local runConnection = nil

-- Hitbox Güncelleme Döngüsü
runConnection = game:GetService("RunService").RenderStepped:Connect(function()
    if enabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if hrp and humanoid and humanoid.Health > 0 then
                    if not originalSizes[player] then
                        originalSizes[player] = hrp.Size
                    end
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.6
                    hrp.CanCollide = false
                end
            end
        end
    end
end)

-- Toggle İşlemi
ToggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleButton.Text = "HitBoxes: ON"
        ToggleButton.TextColor3 = Color3.fromRGB(100, 255, 100)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 50, 35)
    else
        ToggleButton.Text = "HitBoxes: OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(160, 160, 175)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        
        -- Kapatıldığında eski boyutlara döndür
        for player, size in pairs(originalSizes) do
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = size
                player.Character.HumanoidRootPart.Transparency = 1
            end
        end
        originalSizes = {}
    end
end)

-- Slider Kontrolü
local dragging = false
SliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        
        hitboxSize = math.floor(1 + (relativeX * 99))
        ValueLabel.Text = "Size: " .. hitboxSize
    end
end)

-- Sağ Shift ile Arayüzü Gizleme / Gösterme
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Kökten Kapanış (Unload)
UnloadButton.MouseButton1Click:Connect(function()
    if runConnection then
        runConnection:Disconnect()
    end
    -- Eski boyutları geri yükle
    for player, size in pairs(originalSizes) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Size = size
            player.Character.HumanoidRootPart.Transparency = 1
        end
    end
    ScreenGui:Destroy()
end)
