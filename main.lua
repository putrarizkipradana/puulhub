-- [[ PUULHUB V5 - SIDEBAR EDITION ]] --
-- Fitur: Auto-AFK (Default ON), Speed, Jump, Shop Info

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "PuulHub | Grow a Garden", HidePremium = false, SaveConfig = false, IntroText = "Memuat PuulStore..."})

-- [[ FUNGSI ANTI-AFK ]] --
-- Dibuat agar langsung berjalan otomatis (Auto-ON)
local function StartAntiAfk()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        print("PuulHub: Anti-AFK Aktif Otomatis.")
    end)
end

-- Menjalankan Anti-AFK saat script di-execute
StartAntiAfk()

-- [[ TAB 1: UTAMA ]] --
local MainTab = Window:MakeTab({
	Name = "Utama",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

MainTab:AddParagraph("Status System", "Anti-AFK: OTOMATIS AKTIF (ON)")

-- [[ TAB 2: KARAKTER ]] --
local CharTab = Window:MakeTab({
	Name = "Karakter",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

CharTab:AddSlider({
	Name = "WalkSpeed (Kecepatan)",
	Min = 16,
	Max = 300,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

CharTab:AddSlider({
	Name = "JumpPower (Lompatan)",
	Min = 50,
	Max = 300,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- [[ TAB 3: SHOP ]] --
local ShopTab = Window:MakeTab({
	Name = "Shop",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

ShopTab:AddLabel("Selamat datang di PuulStore")
ShopTab:AddButton({
	Name = "Copy Link Toko Eldorado",
	Callback = function()
		setclipboard("https://www.eldorado.gg/users/PuulStore") -- Sesuaikan link toko kamu
		OrionLib:MakeNotification({
			Name = "Berhasil!",
			Content = "Link toko telah disalin ke clipboard.",
			Image = "rbxassetid://4483345998",
			Time = 5
		})
	end    
})

OrionLib:Init()
