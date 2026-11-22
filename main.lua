--============================================================--
--  JDEV BLOX 🤫🌙  |  PAINEL PREMIUM MULTI-JOGO  |  v1.0
--============================================================--

if not game:IsLoaded() then game.Loaded:Wait() end
if getgenv and getgenv().JDEV_BLOX_UNLOAD then pcall(getgenv().JDEV_BLOX_UNLOAD) end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LP = Players.LocalPlayer

--==================== TEMA ====================--
local T = {
    Bg      = Color3.fromRGB(9, 6, 14),
    Panel   = Color3.fromRGB(19, 13, 28),
    Panel2  = Color3.fromRGB(27, 19, 39),
    Panel3  = Color3.fromRGB(35, 24, 50),
    Stroke  = Color3.fromRGB(124, 58, 237),
    Accent  = Color3.fromRGB(168, 85, 247),
    Accent2 = Color3.fromRGB(109, 40, 217),
    Text    = Color3.fromRGB(240, 236, 248),
    Sub     = Color3.fromRGB(148, 138, 168),
    Green   = Color3.fromRGB(74, 222, 128),
    Red     = Color3.fromRGB(248, 113, 113),
}

local function mk(cls, props, parent)
    local o = Instance.new(cls)
    for k, v in pairs(props) do o[k] = v end
    if parent then o.Parent = parent end
    return o
end

local function corner(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 8)
    c.Parent = o
    return c
end

local function stroke(o, color, thick, trans)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thick or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local function grad(o, c1, c2, rot)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(c1, c2)
    g.Rotation = rot or 0
    g.Parent = o
    return g
end

local function padding(o, l, t, r, b)
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, l or 0)
    p.PaddingTop = UDim.new(0, t or 0)
    p.PaddingRight = UDim.new(0, r or 0)
    p.PaddingBottom = UDim.new(0, b or 0)
    p.Parent = o
    return p
end

--==================== REGISTRO DE JOGOS ====================--
-- PlaceIds opcional (serve só de referência). Script = nil -> "EM BREVE"
local GAMES = {
    {
        Name = "Universal",
        Icon = "🌐",
        Tag = "QUALQUER JOGO",
        Script = function(api)
            local tab = api:Tab("Universal")
            tab:Slider("FOV", 70, 120, 70, function(v)
                local cam = workspace.CurrentCamera
                if cam then cam.FieldOfView = v end
            end)
            tab:Toggle("Fullbright", false, function(on)
                if on then
                    api.genv.oldB = Lighting.Brightness
                    api.genv.oldA = Lighting.Ambient
                    Lighting.Brightness = 2
                    Lighting.Ambient = Color3.fromRGB(180, 180, 180)
                else
                    Lighting.Brightness = api.genv.oldB or 1
                    Lighting.Ambient = api.genv.oldA or Color3.fromRGB(70, 70, 70)
                end
            end)
            tab:Toggle("Infinite Jump", false, function(on)
                if on then
                    api:Connect(UserInputService.JumpRequest, function()
                        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                    end)
                end
            end)
            local misc = api:Tab("Misc")
            misc:Button("Rejoin", function()
                pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
            end)
        end,
    },
    {
        Name = "Blox Fruits",
        Icon = "⚔️",
        Tag = "FARM",
        PlaceIds = { 2753915549, 4442272183, 7449423635 },
        Script = function(api)
            local p = api:Tab("Player")
            p:Slider("WalkSpeed", 16, 300, 16, function(v)
                local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                if hum then hum.WalkSpeed = v end
            end)
            p:Toggle("Infinite Jump", false, function(on)
                if on then
                    api:Connect(UserInputService.JumpRequest, function()
                        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
                        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
                    end)
                end
            end)
            local f = api:Tab("Farm")
            f:Toggle("Auto Farm (loop)", false, function(on)
                if not on then return end
                api:Thread(function()
                    while api.alive() do
                        local char = LP.Character
                        local root = char and char:FindFirstChild("HumanoidRootPart")
                        local enemy = workspace:FindFirstChild("Enemies")
                        if root and enemy then
                            local closest, dist = nil, math.huge
                            for _, m in ipairs(enemy:GetChildren()) do
                                local h = m:FindFirstChildOfClass("Humanoid")
                                local hrp = m:FindFirstChild("HumanoidRootPart")
                                if h and hrp and h.Health > 0 then
                                    local d = (hrp.Position - root.Position).Magnitude
                                    if d < dist then closest, dist = hrp, d end
                                end
                            end
                            if closest then root.CFrame = closest.CFrame * CFrame.new(0, 0, 6) end
                        end
                        task.wait(0.25)
                    end
                end)
            end)
            f:Button("Reset Character", function()
                pcall(function() LP.Character:BreakJoints() end)
            end)
        end,
    },
    { Name = "Pet Simulator 99", Icon = "🐾", Tag = "FARM" },
    { Name = "Grow a Garden", Icon = "🌱", Tag = "FARM" },
    { Name = "Arsenal", Icon = "🔫", Tag = "COMBAT" },
    { Name = "Doors", Icon = "🚪", Tag = "HORROR" },
    { Name = "Brookhaven", Icon = "🏡", Tag = "RP" },
    { Name = "Adopt Me", Icon = "🦄", Tag = "RP" },
    { Name = "Murder Mystery 2", Icon = "🔪", Tag = "COMBAT" },
    { Name = "Jujutsu Shenanigans", Icon = "👊", Tag = "COMBAT" },
    { Name = "Blue Lock Rivals", Icon = "⚽", Tag = "PVP" },
    { Name = "Steal a Brainrot", Icon = "🧠", Tag = "FARM" },
}

--==================== GUI ROOT ====================--
local function guiParent()
    local ok, hui = pcall(function() return gethui() end)
    if ok and hui then return hui end
    if ok and syn and syn.protect_gui then
        local g = Instance.new("ScreenGui")
        pcall(syn.protect_gui, g)
        g.Parent = game:GetService("CoreGui")
        return g.Parent
    end
    return LP:WaitForChild("PlayerGui")
end

local old = (guiParent()):FindFirstChild("JDEV_BLOX")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "JDEV_BLOX"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 999
gui.Parent = guiParent()

local Main = mk("Frame", {
    Name = "Main",
    Size = UDim2.fromOffset(620, 430),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = T.Bg,
    BorderSizePixel = 0,
    Parent = gui,
})
corner(Main, 14)
local mainStroke = stroke(Main, T.Stroke, 1.5, 0.45)
local mainGlow = mk("ImageLabel", {
    Size = UDim2.new(1, 24, 1, 24),
    Position = UDim2.fromOffset(-12, -12),
    BackgroundTransparency = 1,
    Image = "rbxassetid://1316045217",
    ImageColor3 = T.Accent,
    ImageTransparency = 0.75,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(10, 10, 118, 118),
    ZIndex = 0,
    Parent = Main,
})

--==================== HEADER ====================--
local Header = mk("Frame", {
    Size = UDim2.new(1, 0, 0, 52),
    BackgroundColor3 = T.Panel,
    BorderSizePixel = 0,
    Parent = Main,
})
corner(Header, 14)
mk("Frame", {
    Size = UDim2.new(1, 0, 0, 20),
    Position = UDim2.new(0, 0, 1, -20),
    BackgroundColor3 = T.Panel,
    BorderSizePixel = 0,
    Parent = Header,
})
mk("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = T.Stroke,
    BackgroundTransparency = 0.6,
    BorderSizePixel = 0,
    Parent = Header,
})

local LogoBox = mk("Frame", {
    Size = UDim2.fromOffset(30, 30),
    Position = UDim2.fromOffset(14, 11),
    BackgroundColor3 = T.Accent,
    BorderSizePixel = 0,
    Parent = Header,
})
corner(LogoBox, 9)
grad(LogoBox, T.Accent, T.Accent2, 45)
mk("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "🌙",
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.new(1, 1, 1),
    Parent = LogoBox,
})

mk("TextLabel", {
    Size = UDim2.fromOffset(220, 18),
    Position = UDim2.fromOffset(52, 10),
    BackgroundTransparency = 1,
    Text = "JDEV BLOX🤫🌙",
    TextSize = 16,
    Font = Enum.Font.GothamBlack,
    TextColor3 = T.Text,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header,
})
mk("TextLabel", {
    Size = UDim2.fromOffset(220, 14),
    Position = UDim2.fromOffset(52, 29),
    BackgroundTransparency = 1,
    Text = "PAINEL PREMIUM  •  MULTI-JOGO  •  v1.0",
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextColor3 = T.Sub,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Header,
})

local function headerBtn(txt, xoff, col, hover)
    local b = mk("TextButton", {
        Size = UDim2.fromOffset(24, 24),
        Position = UDim2.new(1, xoff, 0, 14),
        BackgroundColor3 = T.Panel3,
        BorderSizePixel = 0,
        Text = txt,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextColor3 = col,
        AutoButtonColor = false,
        Parent = Header,
    })
    corner(b, 7)
    b.MouseEnter:Connect(function() TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = hover }):Play() end)
    b.MouseLeave:Connect(function() TweenService:Create(b, TweenInfo.new(0.15), { BackgroundColor3 = T.Panel3 }):Play() end)
    return b
end

local MinBtn = headerBtn("–", -66, T.Sub, T.Panel2)
local CloseBtn = headerBtn("✕", -36, T.Red, Color3.fromRGB(80, 30, 40))

--==================== FOOTER ====================--
local Footer = mk("Frame", {
    Size = UDim2.new(1, 0, 0, 26),
    Position = UDim2.new(0, 0, 1, -26),
    BackgroundColor3 = T.Panel,
    BorderSizePixel = 0,
    Parent = Main,
})
corner(Footer, 14)
mk("Frame", { Size = UDim2.new(1, 0, 0, 14), Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = T.Panel, BorderSizePixel = 0, Parent = Footer })
mk("Frame", { Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = T.Stroke,
    BackgroundTransparency = 0.7, BorderSizePixel = 0, Parent = Footer })

local StatusDot = mk("Frame", { Size = UDim2.fromOffset(6, 6), Position = UDim2.fromOffset(14, 10),
    BackgroundColor3 = T.Red, BorderSizePixel = 0, Parent = Footer })
corner(StatusDot, 3)

local Status = mk("TextLabel", {
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.fromOffset(26, 0),
    BackgroundTransparency = 1,
    Text = "Aguardando seleção de jogo...",
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextColor3 = T.Sub,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = Footer,
})

local function setStatus(txt, col)
    Status.Text = txt
    StatusDot.BackgroundColor3 = col or T.Red
end

--==================== TOAST ====================--
local ToastHolder = mk("Frame", {
    Size = UDim2.fromOffset(300, 52),
    Position = UDim2.new(1, -14, 1, -66),
    AnchorPoint = Vector2.new(1, 1),
    BackgroundColor3 = T.Panel2,
    BorderSizePixel = 0,
    ZIndex = 50,
    Parent = Main,
})
corner(ToastHolder, 10)
stroke(ToastHolder, T.Accent, 1, 0.3)
ToastHolder.Visible = false

local ToastTitle = mk("TextLabel", {
    Size = UDim2.new(1, -18, 0, 16), Position = UDim2.fromOffset(12, 9),
    BackgroundTransparency = 1, Text = "", TextSize = 12,
    Font = Enum.Font.GothamBlack, TextColor3 = T.Accent,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = ToastHolder,
})
local ToastMsg = mk("TextLabel", {
    Size = UDim2.new(1, -18, 0, 14), Position = UDim2.fromOffset(12, 27),
    BackgroundTransparency = 1, Text = "", TextSize = 10,
    Font = Enum.Font.GothamMedium, TextColor3 = T.Sub,
    TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true, Parent = ToastHolder,
})

local toastToken = 0
local function Toast(title, msg, col)
    toastToken = toastToken + 1
    local token = toastToken
    ToastTitle.Text = title
    ToastTitle.TextColor3 = col or T.Accent
    ToastMsg.Text = msg or ""
    ToastHolder.Visible = true
    ToastHolder.Position = UDim2.new(1, -14, 1, -50)
    ToastHolder.BackgroundTransparency = 1
    TweenService:Create(ToastHolder, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -14, 1, -66),
        BackgroundTransparency = 0,
    }):Play()
    task.delay(2.4, function()
        if token ~= toastToken then return end
        local tw = TweenService:Create(ToastHolder, TweenInfo.new(0.2), {
            Position = UDim2.new(1, -14, 1, -50), BackgroundTransparency = 1,
        })
        tw:Play()
        tw.Completed:Wait()
        if token == toastToken then ToastHolder.Visible = false end
    end)
end

--==================== PÁGINA SELETOR ====================--
local SelectorPage = mk("Frame", {
    Size = UDim2.new(1, -20, 1, -96),
    Position = UDim2.fromOffset(10, 58),
    BackgroundTransparency = 1,
    Parent = Main,
})

local SearchBox = mk("Frame", {
    Size = UDim2.new(1, 0, 0, 32),
    BackgroundColor3 = T.Panel,
    BorderSizePixel = 0,
    Parent = SelectorPage,
})
corner(SearchBox, 9)
stroke(SearchBox, T.Stroke, 1, 0.8)
mk("TextLabel", {
    Size = UDim2.fromOffset(20, 32), Position = UDim2.fromOffset(8, 0),
    BackgroundTransparency = 1, Text = "🔍", TextSize = 12,
    TextColor3 = T.Sub, Parent = SearchBox,
})
local SearchInput = mk("TextBox", {
    Size = UDim2.new(1, -40, 1, 0), Position = UDim2.fromOffset(30, 0),
    BackgroundTransparency = 1, Text = "", PlaceholderText = "Buscar jogo...",
    PlaceholderColor3 = Color3.fromRGB(95, 88, 112), TextSize = 11,
    Font = Enum.Font.GothamMedium, TextColor3 = T.Text,
    TextXAlignment = Enum.TextXAlignment.Left, ClearTextOnFocus = false, Parent = SearchBox,
})

local GridScroll = mk("ScrollingFrame", {
    Size = UDim2.new(1, 0, 1, -40), Position = UDim2.fromOffset(0, 40),
    BackgroundTransparency = 1, BorderSizePixel = 0,
    ScrollBarThickness = 4, ScrollBarImageColor3 = T.Accent,
    CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
    Parent = SelectorPage,
})
mk("UIGridLayout", {
    CellSize = UDim2.fromOffset(268, 64),
    CellPadding = UDim2.fromOffset(8, 8),
    SortOrder = Enum.SortOrder.LayoutOrder,
    Parent = GridScroll,
})

--==================== PÁGINA DE FEATURES ====================--
local FeaturePage = mk("Frame", {
    Size = UDim2.new(1, -20, 1, -96),
    Position = UDim2.fromOffset(10, 58),
    BackgroundTransparency = 1,
    Visible = false,
    Parent = Main,
})

local TopBar = mk("Frame", {
    Size = UDim2.new(1, 0, 0, 34),
    BackgroundColor3 = T.Panel,
    BorderSizePixel = 0,
    Parent = FeaturePage,
})
corner(TopBar, 9)

local BackBtn = mk("TextButton", {
    Size = UDim2.fromOffset(28, 22), Position = UDim2.fromOffset(6, 6),
    BackgroundColor3 = T.Panel3, BorderSizePixel = 0, Text = "‹",
    TextSize = 15, Font = Enum.Font.GothamBlack, TextColor3 = T.Accent,
    AutoButtonColor = false, Parent = TopBar,
})
corner(BackBtn, 6)

local GameTitle = mk("TextLabel", {
    Size = UDim2.new(1, -90, 1, 0), Position = UDim2.fromOffset(40, 0),
    BackgroundTransparency = 1, Text = "", TextSize = 12,
    Font = Enum.Font.GothamBold, TextColor3 = T.Text,
    TextXAlignment = Enum.TextXAlignment.Left, Parent = TopBar,
})

local LiveBadge = mk("TextLabel", {
    Size = UDim2.fromOffset(58, 18), Position = UDim2.new(1, -66, 0, 8),
    BackgroundColor3 = Color3.fromRGB(20, 60, 35), BorderSizePixel = 0,
    Text = "ATIVO", TextSize = 9, Font = Enum.Font.GothamBold,
    TextColor3 = T.Green, Parent = TopBar,
})
corner(LiveBadge, 5)

local Sidebar = mk("ScrollingFrame", {
    Size = UDim2.fromOffset(130, 1), Position = UDim2.fromOffset(0, 42),
    BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
    ScrollBarImageColor3 = T.Accent, Parent = FeaturePage,
})
mk("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Sidebar })

local Content = mk("ScrollingFrame", {
    Size = UDim2.new(1, -142, 1, -42), Position = UDim2.fromOffset(142, 42),
    BackgroundTransparency = 1, BorderSizePixel = 0, CanvasSize = UDim2.new(),
    AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3,
    ScrollBarImageColor3 = T.Accent, Parent = FeaturePage,
})
mk("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = Content })

--==================== SESSÃO / ISOLAMENTO ====================--
local Session = { env = nil, def = nil }

local function UnloadSession()
    local env = Session.env
    Session.env, Session.def = nil, nil
    if not env then return end
    env.alive = false
    for i = #env.cleanups, 1, -1 do pcall(env.cleanups[i]) end
    for _, c in ipairs(env.conns) do pcall(function() c:Disconnect() end) end
    for _, co in ipairs(env.threads) do pcall(function() coroutine.close(co) end) end
    env.conns, env.cleanups, env.threads = {}, {}, {}
end

local function ClearPage()
    for _, o in ipairs(Sidebar:GetChildren()) do
        if o:IsA("Frame") or o:IsA("TextButton") then o:Destroy() end
    end
    for _, o in ipairs(Content:GetChildren()) do
        if not o:IsA("UIListLayout") then o:Destroy() end
    end
end

local function Row(parent)
    local row = mk("Frame", {
        Size = UDim2.new(1, 0, 0, 38),
        BackgroundColor3 = T.Panel2,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Parent = parent,
    })
    corner(row, 8)
    stroke(row, T.Stroke, 1, 0.82)
    return row
end

local function NewEnv(def)
    local env = { alive = true, conns = {}, cleanups = {}, threads = {}, genv = {} }
    local api = {}
    api.Name = def.Name
    api.genv = env.genv
    api.alive = function() return env.alive end

    function api:Connect(sig, fn)
        local c = sig:Connect(function(...)
            if not env.alive then return end
            local ok, err = pcall(fn, ...)
            if not ok then warn("[JDEV BLOX][" .. def.Name .. "] " .. tostring(err)) end
        end)
        table.insert(env.conns, c)
        return c
    end

    function api:Thread(fn)
        local co = coroutine.create(function()
            local ok, err = pcall(fn)
            if not ok then warn("[JDEV BLOX][" .. def.Name .. "] " .. tostring(err)) end
        end)
        table.insert(env.threads, co)
        task.spawn(function() coroutine.resume(co) end)
        return co
    end

    function api:OnCleanup(fn) table.insert(env.cleanups, fn) end
    function api:Notify(a, b) Toast(a, b) end

    function api:Tab(name)
        local btn = mk("TextButton", {
            Size = UDim2.new(1, 0, 0, 30),
            BackgroundColor3 = T.Panel,
            BackgroundTransparency = 0.4,
            BorderSizePixel = 0,
            Text = "  " .. name,
            TextSize = 11,
            Font = Enum.Font.GothamMedium,
            TextColor3 = T.Sub,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            Parent = Sidebar,
        })
        corner(btn, 7)

        local bar = mk("Frame", {
            Size = UDim2.new(0, 3, 0, 16),
            Position = UDim2.fromOffset(0, 7),
            BackgroundColor3 = T.Accent,
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            Parent = btn,
        })
        corner(bar, 2)

        local holder = mk("Frame", {
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            Parent = Content,
        })
        mk("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = holder })
        mk("UIPadding", { PaddingBottom = UDim.new(0, 6), Parent = holder })

        local tabs = {}
        btn.MouseButton1Click:Connect(function()
            for _, o in ipairs(Sidebar:GetChildren()) do
                if o:IsA("TextButton") then
                    o.BackgroundColor3 = T.Panel
                    o.BackgroundTransparency = 0.4
                    o.TextColor3 = T.Sub
                    local b = o:FindFirstChildOfClass("Frame")
                    if b then b.BackgroundTransparency = 1 end
                end
            end
            for _, o in ipairs(Content:GetChildren()) do
                if o:IsA("Frame") then o.Visible = false end
            end
            btn.BackgroundColor3 = T.Panel3
            btn.BackgroundTransparency = 0
            btn.TextColor3 = T.Text
            bar.BackgroundTransparency = 0
            holder.Visible = true
        end)

        local tab = {}

        function tab:Toggle(text, default, cb)
            local on = default and true or false
            local row = Row(holder)
            mk("TextLabel", {
                Size = UDim2.new(1, -56, 1, 0), Position = UDim2.fromOffset(12, 0),
                BackgroundTransparency = 1, Text = text, TextSize = 11,
                Font = Enum.Font.GothamMedium, TextColor3 = T.Text,
                TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
            })
            local pill = mk("Frame", {
                Size = UDim2.fromOffset(38, 19), Position = UDim2.new(1, -49, 0.5, 0),
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = T.Panel3, BorderSizePixel = 0, Parent = row,
            })
            corner(pill, 10)
            local knob = mk("Frame", {
                Size = UDim2.fromOffset(13, 13), Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = Color3.fromRGB(140, 132, 158), BorderSizePixel = 0, Parent = pill,
            })
            corner(knob, 7)

            local function render()
                TweenService:Create(pill, TweenInfo.new(0.18), {
                    BackgroundColor3 = on and T.Accent or T.Panel3,
                }):Play()
                TweenService:Create(knob, TweenInfo.new(0.18), {
                    Position = on and UDim2.fromOffset(22, 3) or UDim2.fromOffset(3, 3),
                    BackgroundColor3 = on and Color3.new(1, 1, 1) or Color3.fromRGB(140, 132, 158),
                }):Play()
            end

            local hit = mk("TextButton", {
                Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
                Text = "", Parent = row,
            })
            hit.MouseButton1Click:Connect(function()
                on = not on
                render()
                if cb then
                    local ok, err = pcall(cb, on)
                    if not ok then warn("[JDEV BLOX][" .. def.Name .. "] " .. tostring(err)) end
                end
            end)
            render()

            table.insert(env.cleanups, function()
                if on and cb then pcall(cb, false) end
            end)
            return row
        end

        function tab:Slider(text, min, max, default, cb)
            local value = default or min
            local row = Row(holder)
            row.Size = UDim2.new(1, 0, 0, 50)
            mk("TextLabel", {
                Size = UDim2.new(1, -50, 0, 18), Position = UDim2.fromOffset(12, 5),
                BackgroundTransparency = 1, Text = text, TextSize = 11,
                Font = Enum.Font.GothamMedium, TextColor3 = T.Text,
                TextXAlignment = Enum.TextXAlignment.Left, Parent = row,
            })
            local valLbl = mk("TextLabel", {
                Size = UDim2.fromOffset(42, 18), Position = UDim2.new(1, -52, 0, 5),
                BackgroundTransparency = 1, Text = tostring(value), TextSize = 11,
                Font = Enum.Font.GothamBold, TextColor3 = T.Accent,
                TextXAlignment = Enum.TextXAlignment.Right, Parent = row,
            })
            local track = mk("Frame", {
                Size = UDim2.new(1, -24, 0, 5), Position = UDim2.fromOffset(12, 32),
                BackgroundColor3 = T.Panel3, BorderSizePixel = 0, Parent = row,
            })
            corner(track, 3)
            local fill = mk("Frame", {
                Size = UDim2.fromScale(0, 1), BackgroundColor3 = T.Accent,
                BorderSizePixel = 0, Parent = track,
            })
            corner(fill, 3)
            grad(fill, T.Accent, T.Accent2, 0)
            local knob = mk("Frame", {
                Size = UDim2.fromOffset(11, 11), AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0, 0, 0.5, 0),
                BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Parent = track,
            })
            corner(knob, 6)

            local function set(v, fire)
                value = math.clamp(math.floor(v + 0.5), min, max)
                local a = (value - min) / math.max(1, (max - min))
                fill.Size = UDim2.fromScale(a, 1)
                knob.Position = UDim2.new(a, 0, 0.5, 0)
                valLbl.Text = tostring(value)
                if fire and cb then
                    local ok, err = pcall(cb, value)
                    if not ok then warn("[JDEV BLOX][" .. def.Name .. "] " .. tostring(err)) end
                end
            end

            local dragging = false
            local function upd(input)
                local rel = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                set(min + rel * (max - min), true)
            end
            track.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    upd(i)
                end
            end)
            UserInputService.InputChanged:Connect(function(i)
                if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                    upd(i)
                end
            end)
            UserInputService.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            set(value, false)
            table.insert(env.cleanups, function() if cb then pcall(cb, default or min) end end)
            return row
        end

        function tab:Button(text, cb)
            local btn = mk("TextButton", {
                Size = UDim2.new(1, 0, 0, 34),
                BackgroundColor3 = T.Accent2, BorderSizePixel = 0,
                Text = text, TextSize = 11, Font = Enum.Font.GothamBold,
                TextColor3 = Color3.new(1, 1, 1), AutoButtonColor = false,
                Parent = holder,
            })
            corner(btn, 8)
            grad(btn, T.Accent, T.Accent2, 25)
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = T.Accent }):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = T.Accent2 }):Play()
            end)
            btn.MouseButton1Click:Connect(function()
                if not env.alive then return end
                local ok, err = pcall(cb)
                if not ok then warn("[JDEV BLOX][" .. def.Name .. "] " .. tostring(err)) end
            end)
            return btn
        end

        function tab:Label(text)
            local lbl = mk("TextLabel", {
                Size = UDim2.new(1, 0, 0, 26), BackgroundColor3 = T.Panel,
                BackgroundTransparency = 0.5, Text = "  " .. text, TextSize = 10,
                Font = Enum.Font.GothamMedium, TextColor3 = T.Sub,
                TextXAlignment = Enum.TextXAlignment.Left, Parent = holder,
            })
            corner(lbl, 8)
            return lbl
        end

        table.insert(tabs, btn)
        return tab
    end

    return env, api
end

--==================== SELEÇÃO ====================--
local function LoadGame(def)
    UnloadSession()
    ClearPage()

    Session.def = def
    GameTitle.Text = def.Icon .. "  " .. def.Name
    SelectorPage.Visible = false
    FeaturePage.Visible = true
    setStatus("Script carregado: " .. def.Name, T.Green)

    local env, api = NewEnv(def)
    Session.env = env

    local ok, err = pcall(def.Script, api)
    if not ok then
        warn("[JDEV BLOX] Falha ao carregar " .. def.Name .. ": " .. tostring(err))
        Toast("ERRO", "Falha ao iniciar o script deste jogo.", T.Red)
    end

    local first = Sidebar:FindFirstChildOfClass("TextButton")
    if first then
        task.defer(function() fireclickdetector = nil; first:Fire("MouseButton1Click") end)
    end
end

local cards = {}

local function CreateCard(def, order)
    local card = mk("TextButton", {
        Size = UDim2.fromOffset(268, 64),
        BackgroundColor3 = T.Panel,
        BorderSizePixel = 0,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
        Parent = GridScroll,
    })
    corner(card, 10)
    local st = stroke(card, T.Stroke, 1, 0.85)
    local glow = mk("ImageLabel", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217", ImageColor3 = T.Accent,
        ImageTransparency = 1, ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118), ZIndex = 0, Parent = card,
    })

    local iconBox = mk("Frame", {
        Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(12, 13),
        BackgroundColor3 = T.Panel3, BorderSizePixel = 0, Parent = card,
    })
    corner(iconBox, 10)
    mk("TextLabel", {
        Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
        Text = def.Icon, TextSize = 18, Parent = iconBox,
    })

    mk("TextLabel", {
        Size = UDim2.new(1, -70, 0, 15), Position = UDim2.fromOffset(60, 14),
        BackgroundTransparency = 1, Text = def.Name, TextSize = 12,
        Font = Enum.Font.GothamBold, TextColor3 = T.Text,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = card,
    })

    local tagColor = def.Script and T.Green or Color3.fromRGB(255, 196, 92)
    local tagBg = def.Script and Color3.fromRGB(20, 50, 32) or Color3.fromRGB(58, 44, 18)
    local tag = mk("TextLabel", {
        Size = UDim2.fromOffset(def.Script and 42 or 62, 15), Position = UDim2.fromOffset(60, 33),
        BackgroundColor3 = tagBg, BorderSizePixel = 0,
        Text = def.Script and (def.Tag or "SCRIPT") or "EM BREVE",
        TextSize = 8, Font = Enum.Font.GothamBold, TextColor3 = tagColor, Parent = card,
    })
    corner(tag, 4)

    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = T.Panel2 }):Play()
        TweenService:Create(st, TweenInfo.new(0.15), { Transparency = 0.35, Thickness = 1.5 }):Play()
        TweenService:Create(glow, TweenInfo.new(0.15), { ImageTransparency = 0.86 }):Play()
    end)
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = T.Panel }):Play()
        TweenService:Create(st, TweenInfo.new(0.15), { Transparency = 0.85, Thickness = 1 }):Play()
        TweenService:Create(glow, TweenInfo.new(0.15), { ImageTransparency = 1 }):Play()
    end)

    card.MouseButton1Click:Connect(function()
        if not def.Script then
            -- força nova escolha: nenhum jogo é carregado
            UnloadSession()
            FeaturePage.Visible = false
            SelectorPage.Visible = true
            setStatus("Sem script para " .. def.Name .. " — escolha outro jogo.", Color3.fromRGB(255, 196, 92))
            Toast("EM BREVE 🌙", "O script de \"" .. def.Name .. "\" ainda não foi lançado.", Color3.fromRGB(255, 196, 92))
            local base = card.Position
            for i = 1, 3 do
                TweenService:Create(card, TweenInfo.new(0.05), { Position = base + UDim2.fromOffset(6, 0) }):Play()
                task.wait(0.05)
                TweenService:Create(card, TweenInfo.new(0.05), { Position = base - UDim2.fromOffset(6, 0) }):Play()
                task.wait(0.05)
            end
            card.Position = base
            return
        end
        LoadGame(def)
    end)

    cards[#cards + 1] = { def = def, card = card }
    return card
end

for i, def in ipairs(GAMES) do CreateCard(def, i) end

SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(SearchInput.Text)
    for _, entry in ipairs(cards) do
        entry.card.Visible = (q == "" or string.find(string.lower(entry.def.Name), q, 1, true) ~= nil)
    end
end)

--==================== AÇÕES ====================--
BackBtn.MouseButton1Click:Connect(function()
    UnloadSession()
    ClearPage()
    FeaturePage.Visible = false
    SelectorPage.Visible = true
    setStatus("Aguardando seleção de jogo...", T.Red)
end)

MinBtn.MouseButton1Click:Connect(function()
    local target = (Main.Size.Y.Offset > 100) and UDim2.fromOffset(620, 52) or UDim2.fromOffset(620, 430)
    TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = target }):Play()
    local hide = target.Y.Offset < 100
    SelectorPage.Visible = not hide and (not Session.env)
    FeaturePage.Visible = not hide and (Session.env ~= nil)
    Footer.Visible = not hide
end)

CloseBtn.MouseButton1Click:Connect(function()
    UnloadSession()
    gui:Destroy()
    if getgenv then getgenv().JDEV_BLOX_UNLOAD = nil end
end)

--==================== DRAG ====================--
do
    local dragging, startPos, startInput = false, nil, nil
    Header.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = Main.Position
            startInput = i.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(i)
        if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - startInput
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

--==================== KEYBIND ====================--
local visible = true
UserInputService.InputBegan:Connect(function(i, gp)
    if gp then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        visible = not visible
        gui.Enabled = visible
    end
end)

--==================== UNLOAD GLOBAL ====================--
if getgenv then
    getgenv().JDEV_BLOX_UNLOAD = function()
        UnloadSession()
        pcall(function() gui:Destroy() end)
        if getgenv then getgenv().JDEV_BLOX_UNLOAD = nil end
    end
end

setStatus("Painel pronto — selecione um jogo.", T.Green)
Toast("JDEV BLOX 🌙", "Bem-vindo. Escolha um jogo para executar.")
