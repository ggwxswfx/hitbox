-- LiquidBounce Tarzı Modern HitBox GUI (Roblox Luau)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomClientGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Name = "CombatCategory"
MainFrame.Size = UDim2.new(0, 260, 0, 180)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Combat / HitBoxes"
Title.TextColor3 = Color3.fromRGB(220, 220, 225)
Title.TextSize = 15
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 220, 0, 36)
ToggleButton.Position = UDim2.new(0.5, -110, 0, 45)
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
ToggleButton.Text = "HitBoxes: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(150, 150, 160)
ToggleButton.TextSize = 13
ToggleButton.Font = Enum.Font.GothamMedium
ToggleButton.Parent = MainFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 6)
ToggleCorner.Parent = ToggleButton

local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(1, 0, 0, 25)
ValueLabel.Position = UDim2.new(0, 0, 0, 90)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Size: 2"
ValueLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
ValueLabel.TextSize = 12
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.Parent = MainFrame

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(0, 220, 0, 8)
SliderBar.Position = UDim2.new(0.5, -110, 0, 125)
SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
SliderBar.Parent = MainFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 4)
SliderCorner.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.02, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(120, 90, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 4)
SliderFillCorner.Parent = SliderFill

-- Mantık ve Fonksiyonlar
local enabled = false
local hitboxSize = 2
local originalSizes = {}

ToggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    if enabled then
        ToggleButton.Text = "HitBoxes: ON"
        ToggleButton.TextColor3 = Color3.fromRGB(120, 255, 120)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 35, 55)
    else
        ToggleButton.Text = "HitBoxes: OFF"
        ToggleButton.TextColor3 = Color3.fromRGB(150, 150, 160)
        ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        -- Kapatıldığında eski boyutlarına döndür
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = player.Character.HumanoidRootPart
                if originalSizes[player] then
                    hrp.Size = originalSizes[player]
                    hrp.Transparency = 1
                end
            end
        end
    end
end)

local dragging = false
SliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = game:GetService("UserInputService"):GetMouseLocation()
        local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        
        -- Min 1, Max 100 hesaplaması
        hitboxSize = math.floor(1 + (relativeX * 99))
        ValueLabel.Text = "Size: " .. hitboxSize
    end
end)

-- Sürekli Güncelleme Döngüsü
task.spawn(function()
    while true do
        task.wait(0.5)
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
                        hrp.Transparency = 0.7
                        hrp.CanCollide = false
                    end
                end
            end
        end
    end
end)