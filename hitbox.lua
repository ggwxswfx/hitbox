-- Modern Client Style GUI (Multi-Category Container)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- Eski GUI kalıntısını temizle
if CoreGui:FindFirstChild("ModernClientGui") then
    CoreGui.ModernClientGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernClientGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Ana Arka Plan / Taşıyıcı Çerçeve
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 850, 0, 480)
MainContainer.Position = UDim2.new(0.5, -425, 0.5, -240)
MainContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Active = true
MainContainer.Draggable = true
MainContainer.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainContainer

-- Kategori Sekmeleri İçin Layout Oluşturucu Fonksiyon
local function createCategory(name, positionX)
    local CategoryFrame = Instance.new("ScrollingFrame")
    CategoryFrame.Name = name .. "Category"
    CategoryFrame.Size = UDim2.new(0, 130, 1, -20)
    CategoryFrame.Position = UDim2.new(0, positionX, 0, 10)
    CategoryFrame.BackgroundTransparency = 1
    CategoryFrame.BorderSizePixel = 0
    CategoryFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    CategoryFrame.ScrollBarThickness = 2
    CategoryFrame.Parent = MainContainer

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = name
    TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
    TitleLabel.TextSize = 13
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = CategoryFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = CategoryFrame

    -- Üst boşluk için dummy
    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 35)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.Parent = CategoryFrame

    return CategoryFrame
end

-- Modül Toggle Butonu Oluşturucu
local function addModuleButton(parent, text, callback)
    local ModuleButton = Instance.new("TextButton")
    ModuleButton.Size = UDim2.new(1, 0, 0, 32)
    ModuleButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    ModuleButton.Text = "  " .. text
    ModuleButton.TextColor3 = Color3.fromRGB(150, 150, 165)
    ModuleButton.TextSize = 12
    ModuleButton.Font = Enum.Font.GothamMedium
    ModuleButton.TextXAlignment = Enum.TextXAlignment.Left
    ModuleButton.AutoButtonColor = false
    ModuleButton.Parent = parent

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = ModuleButton

    local enabled = false
    ModuleButton.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            ModuleButton.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
            ModuleButton.TextColor3 = Color3.fromRGB(15, 15, 20)
        else
            ModuleButton.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
            ModuleButton.TextColor3 = Color3.fromRGB(150, 150, 165)
        end
        if callback then callback(enabled) end
    end)

    return ModuleButton
end

-- Sekmeleri Oluşturuyoruz (Görseldeki dizilime benzer)
local combatCol = createCategory("Combat", 10)
local movementCol = createCategory("Movement", 150)
local visualsCol = createCategory("Visuals", 290)
local utilityCol = createCategory("Utility", 430)
local playerCol = createCategory("Player", 570)
local themesCol = createCategory("Themes", 710)

-- Combat Modülleri Örnekleri
addModuleButton(combatCol, "KillAura", function(v) print("KillAura:", v) end)
addModuleButton(combatCol, "Velocity", function(v) print("Velocity:", v) end)
addModuleButton(combatCol, "AutoClicker", function(v) print("AutoClicker:", v) end)
addModuleButton(combatCol, "HitBox", function(v) print("HitBox:", v) end)

-- Movement Modülleri Örnekleri
addModuleButton(movementCol, "AirJump", function(v) print("AirJump:", v) end)
addModuleButton(movementCol, "Flight", function(v) print("Flight:", v) end)
addModuleButton(movementCol, "HighJump", function(v) print("HighJump:", v) end)
addModuleButton(movementCol, "Speed", function(v) print("Speed:", v) end)
addModuleButton(movementCol, "Sprint", function(v) print("Sprint:", v) end)

-- Visuals Modülleri Örnekleri
addModuleButton(visualsCol, "Chams", function(v) print("Chams:", v) end)
addModuleButton(visualsCol, "ESP", function(v) print("ESP:", v) end)
addModuleButton(visualsCol, "FullBright", function(v) print("FullBright:", v) end)
addModuleButton(visualsCol, "NameTags", function(v) print("NameTags:", v) end)

-- Utility Modülleri Örnekleri
addModuleButton(utilityCol, "AntiPush", function(v) print("AntiPush:", v) end)
addModuleButton(utilityCol, "AutoBuy", function(v) print("AutoBuy:", v) end)
addModuleButton(utilityCol, "Disabler", function(v) print("Disabler:", v) end)
addModuleButton(utilityCol, "Panic", function(v) print("Panic:", v) end)

-- Player Modülleri Örnekleri
addModuleButton(playerCol, "AntiAFK", function(v) print("AntiAFK:", v) end)
addModuleButton(playerCol, "AutoEat", function(v) print("AutoEat:", v) end)
addModuleButton(playerCol, "FastBreak", function(v) print("FastBreak:", v) end)
addModuleButton(playerCol, "FreeCamera", function(v) print("FreeCamera:", v) end)

-- Themes Modülleri Örnekleri
addModuleButton(themesCol, "Rose", function(v) print("Theme Rose") end)
addModuleButton(themesCol, "Gold", function(v) print("Theme Gold") end)
addModuleButton(themesCol, "Emerald", function(v) print("Theme Emerald") end)
addModuleButton(themesCol, "Midnight", function(v) print("Midnight") end)

-- Sağ Shift ile Arayüzü Gizleyip Açma
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainContainer.Visible = not MainContainer.Visible
    end
end)
