-- Modern Combat Client GUI (Hitbox + Touch Fling Entegre)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Eski GUI kalıntısını temizle
if CoreGui:FindFirstChild("LiquidCombatGui") then
    CoreGui.LiquidCombatGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LiquidCombatGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 310)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -155)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Başlık
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Combat / Modules"
Title.TextColor3 = Color3.fromRGB(235, 235, 245)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- 1. Modül: HitBox Toggle Butonu
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(0, 250, 0, 38)
HitboxToggle.Position = UDim2.new(0.5, -125, 0, 50)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
HitboxToggle.Text = "HitBoxes: OFF"
HitboxToggle.TextColor3 = Color3.fromRGB(160, 160, 175)
HitboxToggle.TextSize = 13
HitboxToggle.Font = Enum.Font.GothamMedium
HitboxToggle.Parent = MainFrame

local HBCorner = Instance.new("UICorner")
HBCorner.CornerRadius = UDim.new(0, 8)
HBCorner.Parent = HitboxToggle

-- Hitbox Slider Alanı
local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(1, -30, 0, 20)
ValueLabel.Position = UDim2.new(0, 15, 0, 95)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Hitbox Size: 2"
ValueLabel.TextColor3 = Color3.fromRGB(180, 180, 195)
ValueLabel.TextSize = 12
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
ValueLabel.Parent = MainFrame

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(0, 250, 0, 8)
SliderBar.Position = UDim2.new(0.5, -125, 0, 120)
SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
SliderBar.Parent = MainFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 4)
SliderCorner.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.01, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(110, 80, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 4)
SliderFillCorner.Parent = SliderFill

-- 2. Modül: Touch Fling Toggle Butonu
local FlingToggle = Instance.new("TextButton")
FlingToggle.Size = UDim2.new(0, 250, 0, 38)
FlingToggle.Position = UDim2.new(0.5, -125, 0, 145)
FlingToggle.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
FlingToggle.Text = "Touch Fling: OFF"
FlingToggle.TextColor3 = Color3.fromRGB(160, 160, 175)
FlingToggle.TextSize = 13
FlingToggle.Font = Enum.Font.GothamMedium
FlingToggle.Parent = MainFrame

local FlingCorner = Instance.new("UICorner")
FlingCorner.CornerRadius = UDim.new(0, 8)
FlingCorner.Parent = FlingToggle

-- Unload Butonu
local UnloadButton = Instance.new("TextButton")
UnloadButton.Size = UDim2.new(0, 250, 0, 35)
UnloadButton.Position = UDim2.new(0.5, -125, 0, 205)
UnloadButton.BackgroundColor3 = Color3.fromRGB(55, 25, 30)
UnloadButton.Text = "Unload Script"
UnloadButton.TextColor3 = Color3.fromRGB(255, 100, 100)
UnloadButton.TextSize = 13
UnloadButton.Font = Enum.Font.GothamMedium
UnloadButton.Parent = MainFrame

local UnloadCorner = Instance.new("UICorner")
UnloadCorner.CornerRadius = UDim.new(0, 8)
UnloadCorner.Parent = UnloadButton

-- Bilgilendirme Notu
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -30, 0, 20)
InfoLabel.Position = UDim2.new(0, 15, 0, 255)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "[RightShift] Menu Toggle"
InfoLabel.TextColor3 = Color3.fromRGB(100, 100, 115)
InfoLabel.TextSize = 11
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextXAlignment = Enum.TextXAlignment.Center
InfoLabel.Parent = MainFrame

-- --- SCRIPT MANTIKLARI ---

-- Değişkenler
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

-- Hitbox Toggle
HitboxToggle.MouseButton1Click:Connect(function()
    hbEnabled = not hbEnabled
    if hbEnabled then
        HitboxToggle.Text = "HitBoxes: ON"
        HitboxToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
        HitboxToggle.BackgroundColor3 = Color3.fromRGB(35, 50, 35)
    else
        HitboxToggle.Text = "HitBoxes: OFF"
        HitboxToggle.TextColor3 = Color3.fromRGB(160, 160, 175)
        HitboxToggle.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
        
        for player, size in pairs(originalSizes) do
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = size
                player.Character.HumanoidRootPart.Transparency = 1
            end
        end
        originalSizes = {}
    end
end)

-- Slider Kontrolü (1 - 100)
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
        ValueLabel.Text = "Hitbox Size: " .. hitboxSize
    end
end)

-- Touch Fling Fonksiyonu
local function flingLoop()
    local lp = Players.LocalPlayer
    local c, hrp, vel, movel = nil, nil, nil, 0.1

    while flingEnabled do
        RunService.Heartbeat:Wait()
        c = lp.Character
        hrp = c and c:FindFirstChild("HumanoidRootPart")

        if hrp then
            vel = hrp.Velocity
            hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            RunService.RenderStepped:Wait()
            hrp.Velocity = vel
            RunService.Stepped:Wait()
            hrp.Velocity = vel + Vector3.new(0, movel, 0)
            movel = -movel
        end
    end
end

-- Fling Toggle
FlingToggle.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        FlingToggle.Text = "Touch Fling: ON"
        FlingToggle.TextColor3 = Color3.fromRGB(100, 255, 100)
        FlingToggle.BackgroundColor3 = Color3.fromRGB(35, 50, 35)
        
        flingThread = coroutine.create(flingLoop)
        coroutine.resume(flingThread)
    else
        FlingToggle.Text = "Touch Fling: OFF"
        FlingToggle.TextColor3 = Color3.fromRGB(160, 160, 175)
        FlingToggle.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    end
end)

-- Sağ Shift ile Arayüz Gizleme/Gösterme
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Kökten Kapanış (Unload)
UnloadButton.MouseButton1Click:Connect(function()
    hbEnabled = false
    flingEnabled = false
    if hbConnection then hbConnection:Disconnect() end
    
    for player, size in pairs(originalSizes) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Size = size
            player.Character.HumanoidRootPart.Transparency = 1
        end
    end
    
    ScreenGui:Destroy()
end)
