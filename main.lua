-- [[ PUULHUB V5.2 - RAYFIELD EDITION ]] --
-- Fitur: Auto-AFK ON, Speed, Jump, Shop Sidebar

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PuulHub | Grow a Garden",
   LoadingTitle = "Menyiapkan PuulStore...",
   LoadingSubtitle = "by putrarizkipradana",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

-- [[ AUTO ANTI-AFK SYSTEM ]] --
-- Fitur ini langsung berjalan tanpa perlu ditekan
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- [[ TAB UTAMA ]] --
local MainTab = Window:CreateTab("Utama", 4483362458) 

MainTab:CreateSection("Informasi Skrip")

MainTab:CreateLabel("Anti-AFK: OTOMATIS AKTIF ✅")
MainTab:CreateLabel("Versi: 5.2 (Stable)")

-- [[ TAB KARAKTER ]] --
local CharTab = Window:CreateTab("Karakter", 4483362458)

CharTab:CreateSlider({
   Name = "WalkSpeed (Kecepatan)",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

CharTab:CreateSlider({
   Name = "JumpPower (Lompatan)",
   Range = {50, 300},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

CharTab:CreateButton({
   Name = "Reset Karakter",
   Callback = function()
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
   end,
})

-- [[ TAB SHOP ]] --
local ShopTab = Window:CreateTab("Shop", 4483362458)

ShopTab:CreateSection("PuulStore Marketplace")

ShopTab:CreateButton({
   Name = "Salin Link Toko Eldorado",
   Callback = function()
      setclipboard("https://www.eldorado.gg/users/PuulStore")
      Rayfield:Notify({
         Title = "PuulStore",
         Content = "Link berhasil disalin ke clipboard!",
         Duration = 5,
         Image = 4483362458,
      })
   end,
})

Rayfield:Notify({
   Title = "PuulHub Aktif!",
   Content = "Selamat datang di toko PuulStore, silakan gunakan fitur yang tersedia.",
   Duration = 5,
   Image = 4483362458,
})
