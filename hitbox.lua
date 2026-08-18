-- Liquid Style Clean GUI (Hitbox + Touch Fling Only)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Eski GUI kalıntısını temizle
if CoreGui:FindFirstChild("LiquidCleanGui") then
    CoreGui.LiquidCleanGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LiquidCleanGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Ana Pencere (Gönderdiğin görseldeki modern grid yapısı)
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 780, 0, 420)
MainContainer.Position = UDim2.new(0.5, -390, 0.5, -210)
MainContainer.BackgroundColor3 = Color3.fromRGB(13, 13, 16)
MainContainer.BackgroundTransparency = 0.05
MainContainer.BorderSizePixel = 0
MainContainer.Active = true
MainContainer.Draggable = true
MainContainer.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainContainer

-- Sütun (Kategori) Oluşturucu Fonksiyon
local function createCategory(name, positionX)
    local CategoryFrame = Instance.new("ScrollingFrame")
    CategoryFrame.Name = name .. "Category"
    CategoryFrame.Size = UDim2.new(0, 120, 1, -20)
    CategoryFrame.Position = UDim2.new(0, positionX, 0, 10)
    CategoryFrame.BackgroundTransparency = 1
    CategoryFrame.BorderSizePixel = 0
    CategoryFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    CategoryFrame.ScrollBarThickness = 2
    CategoryFrame.Parent = MainContainer

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = name
    TitleLabel.TextColor3 = Color3.fromRGB(180, 180, 195)
    TitleLabel.TextSize = 13
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = CategoryFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = CategoryFrame

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 35)
    UIPadding.PaddingLeft = UDim.new(0, 4)
    UIPadding.PaddingRight = UDim.new(0, 4)
    UIPadding.Parent = CategoryFrame

    return CategoryFrame
end

-- 6 Sütunlu Modern Tasarım Sekmeleri
local combatCol = createCategory("Combat", 15)
local movementCol = createCategory("Movement", 140)
local visualsCol = createCategory("Visuals", 265)
local utilityCol = createCategory("Utility", 390)
local playerCol = createCategory("Player", 515)
local themesCol = createCategory("Themes", 640)

-- 1. Sütun (Combat): HitBox Butonu ve Slider'ı
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(1, 0, 0, 32)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
HitboxToggle.Text = "  HitBox: OFF"
HitboxToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
HitboxToggle.TextSize = 11
HitboxToggle.Font = Enum.Font.GothamMedium
HitboxToggle.TextXAlignment = Enum.TextXAlignment.Left
HitboxToggle.AutoButtonColor = false
HitboxToggle.Parent = combatCol

local HBCorner = Instance.new("UICorner")
HBCorner.CornerRadius = UDim.new(0, 6)
HBCorner.Parent = HitboxToggle

-- Hitbox Slider Paneli (Combat Sütununun hemen altında)
local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(1, 0, 0, 45)
SliderContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
SliderContainer.BorderSizePixel = 0
SliderContainer.Parent = combatCol

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 6)
SliderCorner.Parent = SliderContainer

local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(1, -6, 0, 18)
ValueLabel.Position = UDim2.new(0, 4, 0, 4)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Size: 2"
ValueLabel.TextColor3 = Color3.fromRGB(160, 160, 175)
ValueLabel.TextSize = 10
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
ValueLabel.Parent = SliderContainer

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(1, -12, 0, 5)
SliderBar.Position = UDim2.new(0, 6, 0, 28)
SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
SliderBar.Parent = SliderContainer

local SliderBarCorner = Instance.new("UICorner")
SliderBarCorner.CornerRadius = UDim.new(0, 3)
SliderBarCorner.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.01, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(110, 80, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 3)
SliderFillCorner.Parent = SliderFill

-- 4. Sütun (Utility): Touch Fling Butonu ve Unload Butonu
local FlingToggle = Instance.new("TextButton")
FlingToggle.Size = UDim2.new(1, 0, 0, 32)
FlingToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
FlingToggle.Text = "  Touch Fling"
FlingToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
FlingToggle.TextSize = 11
FlingToggle.Font = Enum.Font.GothamMedium
FlingToggle.TextXAlignment = Enum.TextXAlignment.Left
FlingToggle.AutoButtonColor = false
FlingToggle.Parent = utilityCol

local FlingCorner = Instance.new("UICorner")
FlingCorner.CornerRadius = UDim.new(0, 6)
FlingCorner.Parent = FlingToggle

-- Unload Butonu (Utility Sütununa eklendi)
local UnloadButton = Instance.new("TextButton")
UnloadButton.Size = UDim2.new(1, 0, 0, 32)
UnloadButton.BackgroundColor3 = Color3.fromRGB(45, 20, 25)
UnloadButton.Text = "  Unload Script"
UnloadButton.TextColor3 = Color3.fromRGB(255, 100, 100)
UnloadButton.TextSize = 11
UnloadButton.Font = Enum.Font.GothamMedium
UnloadButton.TextXAlignment = Enum.TextXAlignment.Left
UnloadButton.AutoButtonColor = false
UnloadButton.Parent = utilityCol

local UnloadCorner = Instance.new("UICorner")
UnloadCorner.CornerRadius = UDim.new(0, 6)
UnloadCorner.Parent = UnloadButton


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
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if hrp and humanoid and humanoid.Health > 0 then
                    if not originalSizes[player] then
                        originalSizes[player] = hrp.Size
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

-- Hitbox Toggle
HitboxToggle.MouseButton1Click:Connect(function()
    hbEnabled = not hbEnabled
    if hbEnabled then
        HitboxToggle.Text = "  HitBox: ON"
        HitboxToggle.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
        HitboxToggle.TextColor3 = Color3.fromRGB(15, 15, 20)
    else
        HitboxToggle.Text = "  HitBox: OFF"
        HitboxToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        HitboxToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
        
        for player, size in pairs(originalSizes) do
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = size
                player.Character.HumanoidRootPart.Transparency = 1
                player.Character.HumanoidRootPart.CustomPhysicalProperties = nil
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
        ValueLabel.Text = "Size: " .. hitboxSize
    end
end)

-- Touch Fling Mantığı
local function flingLoop()
    local lp = Players.LocalPlayer
    local c, hrp, vel, movel = nil, nil, nil, 0.1

    while flingEnabled do
        RunService.Heartbeat:Wait()
        c = lp.Character
        hrp = c and c:FindFirstChild("HumanoidRootPart")

        if hrp then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character then
                    local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
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

-- Fling Toggle
FlingToggle.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        FlingToggle.Text = "  Touch Fling: ON"
        FlingToggle.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
        FlingToggle.TextColor3 = Color3.fromRGB(15, 15, 20)
        
        flingThread = coroutine.create(flingLoop)
        coroutine.resume(flingThread)
    else
        FlingToggle.Text = "  Touch Fling"
        FlingToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        FlingToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
    end
end)

-- Sağ Shift ile Arayüz Gizleme/Gösterme
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainContainer.Visible = not MainContainer.Visible
    end
end)

-- Unload Butonu
UnloadButton.MouseButton1Click:Connect(function()
    hbEnabled = false
    flingEnabled = false
    if hbConnection then hbConnection:Disconnect() end
    
    for player, size in pairs(originalSizes) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Size = size
            player.Character.HumanoidRootPart.Transparency = 1
            player.Character.HumanoidRootPart.CustomPhysicalProperties = nil
        end
    end
    
    ScreenGui:Destroy()
end)
