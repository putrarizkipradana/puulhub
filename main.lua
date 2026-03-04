-- [[ PUULHUB MODERN UI - MOBILE OPTIMIZED ]] --
-- Dibuat untuk PuulStore

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PuulHub v3 | Mobile Edition",
   LoadingTitle = "Menyiapkan Antarmuka...",
   LoadingSubtitle = "oleh PuulStore",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false -- Kita matikan agar langsung masuk
})

-- Tab Utama
local MainTab = Window:CreateTab("Utama", 4483362458) 

-- Pengaturan Kecepatan (Slider Besar untuk Jari)
MainTab:CreateSlider({
   Name = "Kecepatan Lari (WalkSpeed)",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Pengaturan Lompatan
MainTab:CreateSlider({
   Name = "Tinggi Lompatan (JumpPower)",
   Range = {50, 300},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

-- Tab AFK
local AfkTab = Window:NewTab("Anti-AFK", 4483362458)

AfkTab:CreateToggle({
   Name = "Aktifkan Mode Anti-AFK",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiAfk = Value
      while _G.AntiAfk do
         local vu = game:GetService("VirtualUser")
         vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         task.wait(1)
         vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         task.wait(60) -- Cukup cek setiap 1 menit agar hemat baterai HP
      end
   end,
})

-- Tombol Sembunyikan UI yang Ramah Mobile
Rayfield:Notify({
   Title = "PuulHub Aktif!",
   Content = "Gunakan tombol di pojok untuk menyembunyikan menu.",
   Duration = 5,
   Image = 4483362458,
})
