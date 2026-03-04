-- [[ PUULHUB V6.1 - GROW A GARDEN FULL AUTO ]] --
-- Fitur: Auto-AFK, Auto Sell, Auto Plant, Auto Buy, Karakter

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PuulHub | Grow a Garden",
   LoadingTitle = "Menyiapkan PuulStore...",
   LoadingSubtitle = "Sistem Otomatisasi Aktif",
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

-- Variabel Toggles
getgenv().AutoSell = false
getgenv().AutoPlant = false
getgenv().AutoBuy = false
getgenv().AutoHarvest = false
getgenv().AutoShovel = false

local TargetPlant = "Sunflower" -- Default
local TargetBuyItem = "Sunflower" -- Default

-- [[ TAB 1: KARAKTER ]] --
local CharTab = Window:CreateTab("Karakter", 4483362458)
local targetSpeed = 16

CharTab:CreateSlider({
   Name = "Kecepatan Lari (WalkSpeed)",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value) targetSpeed = Value end,
})

CharTab:CreateSlider({
   Name = "Tinggi Lompatan (JumpPower)",
   Range = {50, 300},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Callback = function(Value) game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value end,
})

task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= targetSpeed then hum.WalkSpeed = targetSpeed end
        end)
    end
end)


-- [[ TAB 2: UTAMA ]] --
local MainTab = Window:CreateTab("Utama", 4483362458)

MainTab:CreateSection("Target Tanaman")
MainTab:CreateInput({
   Name = "Nama Bibit (Harus sesuai nama item)",
   PlaceholderText = "Contoh: Blueberry",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) TargetPlant = Text end,
})

MainTab:CreateSection("Otomatisasi Lahan")

-- AUTO HARVEST (Panen)
MainTab:CreateToggle({
   Name = "Auto Panen (Harvest)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoHarvest = Value
      task.spawn(function()
         while getgenv().AutoHarvest do
            task.wait(0.2)
            pcall(function()
                for _, prompt in pairs(workspace:GetDescendants()) do
                    if prompt:IsA("ProximityPrompt") and prompt.ActionText == "Harvest" then
                        fireproximityprompt(prompt)
                    end
                end
            end)
         end
      end)
   end,
})

-- AUTO PLANT (Tanam Asli)
MainTab:CreateToggle({
   Name = "Auto Tanam (Plant)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoPlant = Value
      task.spawn(function()
         while getgenv().AutoPlant do
            task.wait(0.5) -- Jeda aman setengah detik
            pcall(function()
                -- Mencari lahan milikmu
                for _, farm in pairs(workspace.Farm:GetChildren()) do
                    if farm.Important.Data.Owner.Value == game.Players.LocalPlayer.Name then
                        local dirt = farm.Important.Plant_Locations:FindFirstChildOfClass("Part")
                        if dirt then
                            -- Menghitung koordinat acak di lahanmu
                            local x = math.random(dirt.Position.X - dirt.Size.X/2, dirt.Position.X + dirt.Size.X/2)
                            local z = math.random(dirt.Position.Z - dirt.Size.Z/2, dirt.Position.Z + dirt.Size.Z/2)
                            local pos = Vector3.new(x, 4, z)
                            GameEvents.Plant_RE:FireServer(pos, TargetPlant)
                        end
                    end
                end
            end)
         end
      end)
   end,
})

-- AUTO SELL
MainTab:CreateToggle({
   Name = "Auto Jual (Sell Inventory)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoSell = Value
      task.spawn(function()
         while getgenv().AutoSell do
            task.wait(2) -- Jangan terlalu cepat agar server tidak curiga
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local prevPos = char:GetPivot()
                -- Teleport ke tempat jual seperti skrip asli
                char:PivotTo(CFrame.new(62, 4, -26))
                task.wait(0.3)
                GameEvents.Sell_Inventory:FireServer()
                task.wait(0.2)
                char:PivotTo(prevPos) -- Kembali ke posisi semula
            end)
         end
      end)
   end,
})

MainTab:CreateSection("Belum Tersedia")
MainTab:CreateLabel("Auto Shovel belum memiliki kode asli dari game.")


-- [[ TAB 3: SHOP ]] --
local ShopTab = Window:CreateTab("Shop", 4483362458)

ShopTab:CreateSection("Toko In-Game")

ShopTab:CreateInput({
   Name = "Nama Item yang Dibeli",
   PlaceholderText = "Ketik nama Seed/Gear/Egg",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) TargetBuyItem = Text end,
})

ShopTab:CreateToggle({
   Name = "Auto Beli Item (Buy)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().AutoBuy = Value
      task.spawn(function()
         while getgenv().AutoBuy do
            task.wait(0.5)
            pcall(function()
                GameEvents.BuySeedStock:FireServer(TargetBuyItem)
            end)
         end
      end)
   end,
})

ShopTab:CreateSection("Marketplace Eksternal")
ShopTab:CreateButton({
   Name = "Salin Link Toko Eldorado",
   Callback = function()
      setclipboard("https://www.eldorado.gg/users/PuulStore")
      Rayfield:Notify({Title = "Tersalin!", Content = "Link toko siap dibagikan.", Duration = 3})
   end,
})

Rayfield:Notify({Title = "PuulHub Siap!", Content = "Otomatisasi game telah aktif.", Duration = 5})
