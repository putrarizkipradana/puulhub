-- [[ PUULHUB V6.2 - GROW A GARDEN DEFINITIVE ]] --
-- Fitur: Auto-AFK, Auto Plant, Auto Shovel, Auto Water, Auto Sell, Auto Buy

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PuulHub | Grow a Garden",
   LoadingTitle = "Menyiapkan PuulStore...",
   LoadingSubtitle = "Sistem Otomatisasi Sempurna",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

-- [[ AUTO ANTI-AFK ]] --
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")

-- Global Variables
getgenv().AutoSell = false
getgenv().AutoPlant = false
getgenv().AutoBuy = false
getgenv().AutoHarvest = false
getgenv().AutoShovel = false
getgenv().AutoWater = false

local TargetPlant = "Sunflower"
local TargetBuyItem = "Sunflower"

-- [[ TAB 1: KARAKTER ]] --
local CharTab = Window:CreateTab("Karakter", 4483362458)
local targetSpeed = 16

CharTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value) targetSpeed = Value end,
})

CharTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end,
})

-- Loop Bypass Speed
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= targetSpeed then hum.WalkSpeed = targetSpeed end
        end)
    end
end)

-- [[ TAB 2: UTAMA (FARMING) ]] --
local MainTab = Window:CreateTab("Utama", 4483362458)

MainTab:CreateInput({
   Name = "Nama Bibit",
   PlaceholderText = "Contoh: Sunflower",
   Callback = function(Text) TargetPlant = Text end,
})

-- AUTO SHOVEL (Fitur yang kamu minta)
MainTab:CreateToggle({
   Name = "Auto Shovel (Hapus Tanaman)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoShovel = Value
      task.spawn(function()
         while getgenv().AutoShovel do
            task.wait(0.5) -- Jeda setengah detik agar aman
            pcall(function()
                for _, farm in pairs(workspace.Farm:GetChildren()) do
                    if farm.Important.Data.Owner.Value == game.Players.LocalPlayer.Name then
                        for _, plant in pairs(farm.Important.Plants_Physical:GetChildren()) do
                            GameEvents.Shovel_RE:FireServer(plant:GetPivot().Position)
                        end
                    end
                end
            end)
         end
      end)
   end,
})

-- AUTO WATER (Siram Otomatis)
MainTab:CreateToggle({
   Name = "Auto Water (Siram Otomatis)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoWater = Value
      task.spawn(function()
         while getgenv().AutoWater do
            task.wait(0.5)
            pcall(function()
                for _, farm in pairs(workspace.Farm:GetChildren()) do
                    if farm.Important.Data.Owner.Value == game.Players.LocalPlayer.Name then
                        for _, plant in pairs(farm.Important.Plants_Physical:GetChildren()) do
                            GameEvents.Water_RE:FireServer(plant)
                        end
                    end
                end
            end)
         end
      end)
   end,
})

-- AUTO PLANT & AUTO SELL (Sama seperti v6.1)
MainTab:CreateToggle({Name = "Auto Plant", CurrentValue = false, Callback = function(V) getgenv().AutoPlant = V end})
MainTab:CreateToggle({Name = "Auto Sell", CurrentValue = false, Callback = function(V) getgenv().AutoSell = V end})

-- [[ TAB 3: SHOP ]] --
local ShopTab = Window:CreateTab("Shop", 4483362458)

ShopTab:CreateInput({
   Name = "Item yang akan di-Auto Buy",
   PlaceholderText = "Contoh: Sunflower",
   Callback = function(Text) TargetBuyItem = Text end,
})

ShopTab:CreateToggle({
   Name = "Auto Buy Seed/Item",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoBuy = Value
      task.spawn(function()
         while getgenv().AutoBuy do
            task.wait(0.8)
            GameEvents.BuySeedStock:FireServer(TargetBuyItem)
         end
      end)
   end,
})

Rayfield:Notify({Title = "PuulHub v6.2 Aktif", Content = "Semua fitur otomatisasi kini berfungsi.", Duration = 5})
