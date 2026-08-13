--==================================================
-- ZRYX AUTO FARM - FINAL VERSION
-- Obsidian UI + Beat Survivor + Smart Server Hop
--==================================================

pcall(function()
    setfflag("TeleportService", "DisableTeleportErrors", "true")
end)

--==================================================
-- LIBRARY LOADER
--==================================================
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

--==================================================
-- CONFIGURATION
--==================================================
local ZRYX_LOGO_ID = 94272208451726
local ZRYX_LOGO_FALLBACK = "https://www.roblox.com/asset-thumbnail/image?assetId=" 
    .. ZRYX_LOGO_ID 
    .. "&width=512&height=512&format=png"

local ZRYX_COLORS = {
    SkyBlue      = Color3.fromHex("29B6F6"),
    White        = Color3.fromHex("FFFFFF"),
    Magenta      = Color3.fromHex("EC407A"),
    LightGray    = Color3.fromHex("F5F5F5"),
    DarkBlueGray = Color3.fromHex("37474F"),
    DarkBlue     = Color3.fromHex("0277BD"),
    BorderBlue   = Color3.fromHex("81D4FA"),
}

--==================================================
-- WINDOW CREATION
--==================================================
local Window = Library:CreateWindow({
    Title = "Zryx Auto Farm",
    Footer = "version: 1.0.1",
    Icon = ZRYX_LOGO_ID,
    NotifySide = "Right",
    ShowCustomCursor = true,
})

pcall(function()
    Window:SetCornerRadius(14)
end)

--==================================================
-- ZRYX THEME APPLIER
--==================================================
local function ApplyZryxTheme()
    task.wait(2)
    pcall(function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

        local targetGui = nil
        for _, gui in ipairs(PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") then
                targetGui = gui
                break
            end
        end
        if not targetGui then
            for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
                if gui:IsA("ScreenGui") then
                    targetGui = gui
                    break
                end
            end
        end
        if not targetGui then return end

        local LOGO_ID = "rbxassetid://" .. ZRYX_LOGO_ID

        -- Perbesar icon header
        for _, obj in ipairs(targetGui:GetDescendants()) do
            if (obj:IsA("ImageLabel") or obj:IsA("ImageButton")) then
                local size = obj.AbsoluteSize
                if size and size.X >= 14 and size.X <= 50 and size.Y >= 14 and size.Y <= 50 then
                    local pos = obj.AbsolutePosition
                    if pos and pos.Y < 80 then
                        obj.Image = LOGO_ID
                        obj.ImageTransparency = 0
                        pcall(function() obj.ImageColor3 = Color3.new(1,1,1) end)
                        pcall(function() obj.Size = UDim2.new(0, 48, 0, 48) end)
                    end
                end
            end
        end

        -- Apply warna ke semua elemen
        local function applyColorsRecursive(parent)
            for _, obj in ipairs(parent:GetChildren()) do
                pcall(function()
                    if obj:IsA("Frame") then
                        local name = obj.Name or ""
                        if name == "Screen" or name == "Background" or name == "Main" then
                            obj.BackgroundColor3 = ZRYX_COLORS.SkyBlue
                        elseif name == "Content" or name == "Container" or name == "Body" or name == "InnerFrame" then
                            obj.BackgroundColor3 = ZRYX_COLORS.White
                        elseif name:find("Groupbox") or name:find("Group") then
                            obj.BackgroundColor3 = ZRYX_COLORS.White
                            pcall(function()
                                obj.BorderSizePixel = 1
                                obj.BorderColor3 = ZRYX_COLORS.BorderBlue
                            end)
                        end
                    end

                    if obj:IsA("TextLabel") then
                        local text = obj.Text or ""
                        local parentName = obj.Parent and obj.Parent.Name or ""
                        if text:find("Zryx") or text:find("Auto Farm") or text:find("AUTO FARM") then
                            obj.TextColor3 = ZRYX_COLORS.Magenta
                            pcall(function()
                                obj.Font = Enum.Font.GothamBold
                                obj.TextSize = 20
                            end)
                        elseif parentName:find("Header") or parentName:find("Title") then
                            obj.TextColor3 = ZRYX_COLORS.Magenta
                        else
                            obj.TextColor3 = ZRYX_COLORS.DarkBlueGray
                        end
                    end

                    if obj:IsA("TextButton") then
                        local text = obj.Text or ""
                        if text:find("ACTIVATE") or text:find("ENABLE") or text:find("START") then
                            obj.BackgroundColor3 = ZRYX_COLORS.DarkBlue
                            obj.BorderSizePixel = 0
                            for _, child in ipairs(obj:GetChildren()) do
                                if child:IsA("TextLabel") or child:IsA("TextButton") then
                                    child.TextColor3 = ZRYX_COLORS.White
                                end
                            end
                        else
                            obj.BackgroundColor3 = ZRYX_COLORS.White
                            obj.BorderSizePixel = 2
                            obj.BorderColor3 = ZRYX_COLORS.SkyBlue
                            for _, child in ipairs(obj:GetChildren()) do
                                if child:IsA("TextLabel") then
                                    child.TextColor3 = ZRYX_COLORS.DarkBlueGray
                                end
                                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                                    child.ImageColor3 = ZRYX_COLORS.DarkBlue
                                end
                            end
                        end
                        pcall(function()
                            local corner = obj:FindFirstChildOfClass("UICorner")
                            if corner then
                                corner.CornerRadius = UDim.new(0, 10)
                            else
                                local newCorner = Instance.new("UICorner")
                                newCorner.CornerRadius = UDim.new(0, 10)
                                newCorner.Parent = obj
                            end
                        end)
                    end

                    if obj:IsA("UICorner") then
                        pcall(function()
                            if obj.CornerRadius.Offset < 10 then
                                obj.CornerRadius = UDim.new(0, 12)
                            end
                        end)
                    end
                end)
                applyColorsRecursive(obj)
            end
        end
        applyColorsRecursive(targetGui)

        -- Logo besar di panel
        local mainFrame = nil
        for _, obj in ipairs(targetGui:GetDescendants()) do
            if obj:IsA("Frame") and (obj.Name == "Main" or obj.Name == "Content" or obj.Name == "Container") then
                mainFrame = obj
                break
            end
        end
        if not mainFrame then
            local maxSize = 0
            for _, obj in ipairs(targetGui:GetDescendants()) do
                if obj:IsA("Frame") then
                    local s = obj.AbsoluteSize
                    if s and (s.X * s.Y) > maxSize then
                        maxSize = s.X * s.Y
                        mainFrame = obj
                    end
                end
            end
        end

        if mainFrame then
            pcall(function()
                local old = mainFrame:FindFirstChild("ZryxLogoContainer")
                if old then old:Destroy() end
            end)
            pcall(function()
                mainFrame.BackgroundColor3 = ZRYX_COLORS.White
            end)

            local logoFrame = Instance.new("Frame")
            logoFrame.Name = "ZryxLogoContainer"
            logoFrame.Size = UDim2.new(1, 0, 0, 200)
            logoFrame.Position = UDim2.new(0, 0, 0, 0)
            logoFrame.BackgroundTransparency = 1
            logoFrame.ZIndex = 100
            logoFrame.Parent = mainFrame

            local bgLogo = Instance.new("ImageLabel")
            bgLogo.Name = "ZryxLogoBackground"
            bgLogo.Size = UDim2.new(0, 500, 0, 160)
            bgLogo.Position = UDim2.new(0.5, -250, 0, 15)
            bgLogo.Image = LOGO_ID
            bgLogo.BackgroundTransparency = 1
            bgLogo.ImageTransparency = 0.85
            bgLogo.ScaleType = Enum.ScaleType.Fit
            bgLogo.ZIndex = 101
            bgLogo.Parent = logoFrame
            local bgLogoCorner = Instance.new("UICorner")
            bgLogoCorner.CornerRadius = UDim.new(0, 25)
            bgLogoCorner.Parent = bgLogo

            local mainLogo = Instance.new("ImageLabel")
            mainLogo.Name = "ZryxMainLogo"
            mainLogo.Size = UDim2.new(0, 420, 0, 135)
            mainLogo.Position = UDim2.new(0.5, -210, 0.5, -67)
            mainLogo.Image = LOGO_ID
            mainLogo.BackgroundTransparency = 1
            mainLogo.ImageTransparency = 0
            mainLogo.ScaleType = Enum.ScaleType.Fit
            mainLogo.ZIndex = 102
            mainLogo.Parent = logoFrame
            local mainLogoCorner = Instance.new("UICorner")
            mainLogoCorner.CornerRadius = UDim.new(0, 22)
            mainLogoCorner.Parent = mainLogo

            local titleText = Instance.new("TextLabel")
            titleText.Name = "ZryxTitle"
            titleText.Size = UDim2.new(1, 0, 0, 30)
            titleText.Position = UDim2.new(0, 0, 0, 170)
            titleText.BackgroundTransparency = 1
            titleText.Text = "AUTO FARM MENU"
            titleText.TextColor3 = ZRYX_COLORS.Magenta
            titleText.TextSize = 20
            titleText.Font = Enum.Font.GothamBold
            titleText.ZIndex = 101
            titleText.Parent = logoFrame
        end
    end)
end

task.spawn(ApplyZryxTheme)
pcall(function()
    task.spawn(function()
        while not Library.Unloaded do
            task.wait(5)
            pcall(ApplyZryxTheme)
        end
    end)
end)

--==================================================
-- TABS & UI GROUPS
--==================================================
Window:SetSidebarWidth(40)
local Tabs = {
    AutoFarm = Window:AddTab("", "zap"),
    Settings = Window:AddTab("", "settings"),
}
local AutoFarmGroup = Tabs.AutoFarm:AddLeftGroupbox("Auto Farm", "zap")
local WebhookGroup = Tabs.AutoFarm:AddRightGroupbox("Webhook", "webhook")

--==================================================
-- STATE VARIABLES
--==================================================
local BeatState = {
    LastFinishPos = nil,
    BeatSurvivorDone = false,
}
local HopAfterBeatTriggered = false

--==================================================
-- HELPER FUNCTIONS
--==================================================
local function GetRole()
    local player = game:GetService("Players").LocalPlayer
    if not player.Team then return "Unknown" end
    local name = player.Team.Name
    if name == "Killer" then return "Killer" end
    if name == "Survivors" then return "Survivor" end
    if name == "Spectator" or name == "Spectators" then return "Spectator" end
    return "Lobby"
end

local function GetCharacterRoot()
    local player = game:GetService("Players").LocalPlayer
    local character = player.Character
    return character and character:FindFirstChild("HumanoidRootPart")
end

local function safeRequest(options)
    local req = (syn and syn.request)
             or (http and http.request)
             or http_request
             or request
             or (fluxus and fluxus.request)
             or (krnl and krnl.request)
    if req then return req(options) end
    return nil
end

local function GetExecutorName()
    return (identifyexecutor and identifyexecutor())
        or (getexecutorname and getexecutorname())
        or "Unknown Executor"
end

--==================================================
-- 🔔 SMART NOTIFY (HORMATI TOGGLE NOTIFIKASI)
--==================================================
local function ZryxNotify(config)
    if Toggles.EnableNotifications and Toggles.EnableNotifications.Value == false then
        return
    end
    Library:Notify(config)
end

--==================================================
-- WEBHOOK ASSET URLs (LOGO & AVATAR)
--==================================================
local function GetZryxLogoUrl()
    local success, response = pcall(function()
        return game:HttpGet(
            "https://thumbnails.roblox.com/v1/assets?assetIds="
            .. ZRYX_LOGO_ID
            .. "&size=512x512&format=Png&isCircular=false"
        )
    end)
    if success and response then
        local HttpService = game:GetService("HttpService")
        local ok, data = pcall(function()
            return HttpService:JSONDecode(response)
        end)
        if ok and data and data.data and data.data[1] and data.data[1].imageUrl then
            return data.data[1].imageUrl 
                .. "?t=" .. tostring(os.time()) 
                .. "&r=" .. tostring(math.random(1000, 9999))
        end
    end
    return ZRYX_LOGO_FALLBACK 
        .. "?t=" .. tostring(os.time()) 
        .. "&r=" .. tostring(math.random(1000, 9999))
end

local cachedLogoUrl = nil
local function GetCachedLogoUrl()
    if not cachedLogoUrl then
        cachedLogoUrl = GetZryxLogoUrl()
    end
    return cachedLogoUrl
end

local function GetPlayerHeadshotUrl(userId)
    local HttpService = game:GetService("HttpService")
    local cacheBuster = "?t=" .. tostring(os.time()) 
        .. "&r=" .. tostring(math.random(10000, 99999))
    
    local ok1, res1 = pcall(function()
        return game:HttpGet(
            "https://thumbnails.roblox.com/v1/users/avatar-headshot"
            .. "?userIds=" .. userId
            .. "&size=100x100&format=Png&isCircular=false"
        )
    end)
    if ok1 and res1 then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(res1)
        end)
        if ok and data and data.data and data.data[1] 
            and data.data[1].state == "Completed" 
            and data.data[1].imageUrl then
            return data.data[1].imageUrl .. cacheBuster
        end
    end
    
    local ok2, res2 = pcall(function()
        return game:HttpGet(
            "https://thumbnails.roblox.com/v1/avatar-headshot"
            .. "?userIds=" .. userId
            .. "&size=100x100&format=Png&isCircular=false"
        )
    end)
    if ok2 and res2 then
        local ok, data = pcall(function()
            return HttpService:JSONDecode(res2)
        end)
        if ok and data and data.data and data.data[1] and data.data[1].imageUrl then
            return data.data[1].imageUrl .. cacheBuster
        end
    end
    
    return "https://www.roblox.com/headshot-thumbnail/image?userId="
        .. userId
        .. "&width=150&height=150&format=png"
        .. cacheBuster
end

local cachedAvatarUrls = {}
local function GetCachedAvatarUrl(userId)
    if not cachedAvatarUrls[userId] then
        cachedAvatarUrls[userId] = GetPlayerHeadshotUrl(userId)
    end
    return cachedAvatarUrls[userId]
end

--==================================================
-- WEBHOOK ATTRIBUTE PERSISTENCE
--==================================================
local ATTRIBUTE_FILE = "VD_AutoFarm_Attributes.json"
local PreviousAttributes = nil

local function LoadPreviousAttributes()
    if type(isfile) ~= "function" or type(readfile) ~= "function" then
        return nil
    end
    if not isfile(ATTRIBUTE_FILE) then
        return nil
    end
    local HttpService = game:GetService("HttpService")
    local success, data = pcall(function()
        return HttpService:JSONDecode(readfile(ATTRIBUTE_FILE))
    end)
    if not success or type(data) ~= "table" then
        return nil
    end
    local LocalPlayer = game:GetService("Players").LocalPlayer
    if tonumber(data.UserId) ~= LocalPlayer.UserId then
        return nil
    end
    return {
        KillerChance = tonumber(data.KillerChance),
        EXP = tonumber(data.EXP),
        Screws = tonumber(data.Screws),
        Gears = tonumber(data.Gears)
    }
end

local function SavePreviousAttributes(attributes)
    if type(writefile) ~= "function" then
        return false
    end
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local data = {
        UserId = LocalPlayer.UserId,
        KillerChance = attributes.KillerChance,
        EXP = attributes.EXP,
        Screws = attributes.Screws,
        Gears = attributes.Gears,
        UpdatedAt = os.time()
    }
    return pcall(function()
        writefile(ATTRIBUTE_FILE, HttpService:JSONEncode(data))
    end)
end

PreviousAttributes = LoadPreviousAttributes()

local function GetAttributeDelta(currentValue, previousValue)
    currentValue = tonumber(currentValue) or 0
    if previousValue == nil then return 0 end
    return currentValue - (tonumber(previousValue) or 0)
end

--==================================================
-- WEBHOOK SYSTEM
--==================================================
local function SendDiscordWebhook(customTitle, customDesc, forceSend)
    if not forceSend and (not Toggles.EnableWebhook or not Toggles.EnableWebhook.Value) then
        return false, "Webhook Disabled"
    end
    
    local webhookUrl = Options.WebhookLink and Options.WebhookLink.Value or ""
    if not webhookUrl or webhookUrl == "" 
        or not string.find(webhookUrl, "discord.com/api/webhooks") then
        return false, "Invalid Webhook URL"
    end
    
    local HttpService = game:GetService("HttpService")
    local LocalPlayer = game:GetService("Players").LocalPlayer
    local displayName = LocalPlayer.DisplayName
    local userId = LocalPlayer.UserId
    local serverId = game.JobId ~= "" and game.JobId or "Singleplayer"
    local profileUrl = "https://www.roblox.com/users/" .. userId .. "/profile"
    
    local attrs = LocalPlayer:GetAttributes()
    local KillerChance = tonumber(attrs.KillerChance) or 0
    local EXP = tonumber(attrs.EXP) or 0
    local Screws = tonumber(attrs.Screws) or 0
    local Gears = tonumber(attrs.Gears) or 0
    local Level = tonumber(attrs.Level) or 0
    
    if not PreviousAttributes then
        PreviousAttributes = {
            KillerChance = KillerChance,
            EXP = EXP,
            Screws = Screws,
            Gears = Gears
        }
    end
    
    local logoUrl = GetCachedLogoUrl()
    local avatarUrl = GetCachedAvatarUrl(userId)
    
    local payload = {
        ["username"] = "Zryx Auto Farm",
        ["avatar_url"] = logoUrl,
        ["embeds"] = {{
            ["author"] = {
                ["name"] = string.format("%s · Level %d", displayName, Level),
                ["url"] = profileUrl,
                ["icon_url"] = avatarUrl
            },
            ["title"] = customTitle or "Zryx Auto Farm",
            ["description"] = customDesc or "Auto Farm Session",
            ["url"] = profileUrl,
            ["color"] = 2733558,
            ["fields"] = {
                {
                    ["name"] = "💀 SIN",
                    ["value"] = string.format(
                        "%s (**%+d**)",
                        tostring(KillerChance),
                        GetAttributeDelta(KillerChance, PreviousAttributes.KillerChance)
                    ),
                    ["inline"] = false
                },
                {
                    ["name"] = "🧪 EXP",
                    ["value"] = string.format(
                        "%s (**%+d**)",
                        tostring(EXP),
                        GetAttributeDelta(EXP, PreviousAttributes.EXP)
                    ),
                    ["inline"] = false
                },
                {
                    ["name"] = "🔩 Screws",
                    ["value"] = string.format(
                        "%s (**%+d**)",
                        tostring(Screws),
                        GetAttributeDelta(Screws, PreviousAttributes.Screws)
                    ),
                    ["inline"] = false
                },
                {
                    ["name"] = "⚙️ Gears",
                    ["value"] = string.format(
                        "%s (**%+d**)",
                        tostring(Gears),
                        GetAttributeDelta(Gears, PreviousAttributes.Gears)
                    ),
                    ["inline"] = false
                },
                {
                    ["name"] = "🆔 Server ID",
                    ["value"] = string.format("```\n%s\n```", serverId),
                    ["inline"] = false
                }
            },
            ["thumbnail"] = {["url"] = logoUrl},
            ["footer"] = {
                ["text"] = string.format("Zryx Auto Farm · %s", GetExecutorName()),
                ["icon_url"] = logoUrl
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%S.000Z")
        }}
    }
    
    local response = safeRequest({
        Url = webhookUrl,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(payload)
    })
    
    if response and (response.StatusCode == 200 or response.StatusCode == 204) then
        local newSnapshot = {
            KillerChance = KillerChance,
            EXP = EXP,
            Screws = Screws,
            Gears = Gears
        }
        PreviousAttributes = newSnapshot
        SavePreviousAttributes(newSnapshot)
        return true, "Webhook successfully sent!"
    end
    
    return false, "Failed Status: " .. tostring(response and response.StatusCode or "No Response")
end

--==================================================
-- BEAT GAME SURVIVOR (AUTO FARM)
--==================================================
local function BeatGameSurvivor()
    if not Toggles.EnableAutoFarm.Value then
        BeatState.BeatSurvivorDone = false
        BeatState.LastFinishPos = nil
        return
    end
    if GetRole() ~= "Survivor" then return end
    
    local root = GetCharacterRoot()
    if not root then return end
    
    local map = game:GetService("Workspace"):FindFirstChild("Map")
    if not map then return end
    
    local exitPos = nil
    pcall(function()
        if map:FindFirstChild("RooftopHitbox") or map:FindFirstChild("Rooftop") then
            exitPos = Vector3.new(3098.16, 454.04, -4918.74)
            return
        end
        if map:FindFirstChild("HooksMeat") then
            exitPos = Vector3.new(1546.12, 152.21, -796.72)
            return
        end
        if map:FindFirstChild("churchbell") then
            exitPos = Vector3.new(760.98, -20.14, -78.48)
            return
        end
        
        local finish = map:FindFirstChild("Finishline")
            or map:FindFirstChild("FinishLine")
            or map:FindFirstChild("Fininshline")
        if finish then
            if finish:IsA("BasePart") then
                exitPos = finish.Position
            elseif finish:IsA("Model") then
                local part = finish:FindFirstChildWhichIsA("BasePart")
                if part then exitPos = part.Position end
            end
            return
        end
        
        for _, obj in ipairs(map:GetDescendants()) do
            if obj.Name:lower():find("finish") then
                if obj:IsA("BasePart") then
                    exitPos = obj.Position
                    break
                elseif obj:IsA("Model") then
                    local part = obj:FindFirstChildWhichIsA("BasePart")
                    if part then
                        exitPos = part.Position
                        break
                    end
                end
            end
        end
        
        if not exitPos then
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("MeshPart") and obj.Material == Enum.Material.Limestone then
                    exitPos = Vector3.new(-947.90, 152.12, -7579.52)
                    break
                end
            end
        end
        
        if not exitPos then
            for _, obj in ipairs(map:GetDescendants()) do
                if obj:IsA("MeshPart") and obj.Material == Enum.Material.Leather then
                    exitPos = Vector3.new(1546.12, 152.21, -796.72)
                    break
                end
            end
        end
    end)
    
    if not exitPos then return end
    
    if BeatState.LastFinishPos then
        local dist = (exitPos - BeatState.LastFinishPos).Magnitude
        if dist > 50 then
            BeatState.BeatSurvivorDone = false
        end
    end
    
    if BeatState.BeatSurvivorDone then return end
    
    task.wait(6)
    local currentRoot = GetCharacterRoot()
    if not currentRoot then return end
    
    currentRoot.CFrame = CFrame.new(exitPos + Vector3.new(0, 3, 0))
    BeatState.BeatSurvivorDone = true
    BeatState.LastFinishPos = exitPos
    
    task.wait(5)
    SendDiscordWebhook()
    
    if Toggles.ServerHop and Toggles.ServerHop.Value then
        HopAfterBeatTriggered = true
    end
end

--==================================================
-- SERVER HOP SYSTEM
--==================================================
local IGNORE_FILE = "ServerHop.txt"
local HOUR = 3600
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local IgnoredServers = {}

local RATE_LIMIT_WAIT = 8
local GENERAL_ERROR_WAIT = 3
local TWO_PLAYER_WAIT = 90  -- 🔥 TUNGGU 90 DETIK KALAU ADA 2 PLAYER

local function GetIgnoredServers()
    if not isfile(IGNORE_FILE) then return {} end
    local list = {}
    local now = os.time()
    for _, line in ipairs(readfile(IGNORE_FILE):split("\n")) do
        local serverId, timestamp = line:match("([^|]+)|?(%d*)")
        timestamp = tonumber(timestamp) or 0
        if serverId and serverId ~= "" and now - timestamp < HOUR then
            list[serverId] = timestamp
        end
    end
    return list
end

local function UpdateIgnoredServers(list)
    local lines = {}
    for serverId, timestamp in pairs(list) do
        table.insert(lines, serverId .. "|" .. timestamp)
    end
    writefile(IGNORE_FILE, table.concat(lines, "\n"))
end

IgnoredServers = GetIgnoredServers()

-- Round detection
local IsRound = false
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local StatusUpdateEvent = Remotes:WaitForChild("StatusUpdateEvent")
local TimeUpdateEvent = Remotes:WaitForChild("TimeUpdateEvent")

StatusUpdateEvent.OnClientEvent:Connect(function(Status)
    if Status == "WaitingForPlayers" 
        or Status == "IntermissionStarting" 
        or Status == "Intermission" then
        IsRound = false
        BeatState.BeatSurvivorDone = false
    end
end)

TimeUpdateEvent.OnClientEvent:Connect(function(Status)
    if Status == "Round" then
        IsRound = true
    end
end)

-- Persistent hop (tidak menyerah sampai berhasil)
local function PersistentServerHop()
    local totalAttempts = 0
    local cursor = ""

    while Toggles.ServerHop.Value and not Library.Unloaded do
        totalAttempts = totalAttempts + 1
        
        local success, result = pcall(function()
            return HttpService:JSONDecode(game:HttpGet(
                "https://games.roblox.com/v1/games/"
                .. game.PlaceId
                .. "/servers/Public?limit=100"
                .. "&sortOrder=Asc"
                .. "&excludeFullGames=true"
                .. "&cursor=" .. cursor
            ))
        end)

        if not success or not result or not result.data then
            task.wait(5)
            cursor = ""
            continue
        end

        local foundTarget = false
        for _, server in ipairs(result.data) do
            if not Toggles.ServerHop.Value or Library.Unloaded then return end
            
            if server.id
                and server.id ~= game.JobId
                and server.playing
                and server.playing >= 1
                and server.playing <= 3
                and not IgnoredServers[server.id]
            then
                foundTarget = true
                local teleportSuccess = false
                local attemptOnThisServer = 0

                while not teleportSuccess 
                    and Toggles.ServerHop.Value 
                    and not Library.Unloaded 
                do
                    attemptOnThisServer = attemptOnThisServer + 1
                    
                    local teleportOk, teleportErr = pcall(function()
                        TeleportService:TeleportToPlaceInstance(
                            game.PlaceId,
                            server.id,
                            Players.LocalPlayer
                        )
                    end)

                    if teleportOk then
                        ZryxNotify({
                            Title = "✅ HOP SUCCESS!",
                            Description = string.format(
                                "Teleported after %d attempts",
                                totalAttempts
                            ),
                            Time = 3
                        })
                        return true
                    else
                        local errMsg = tostring(teleportErr)
                        
                        if string.find(errMsg, "771") 
                            or string.find(errMsg, "Server is no longer available") then
                            IgnoredServers[server.id] = os.time() + 300
                            UpdateIgnoredServers(IgnoredServers)
                            break
                        elseif string.find(errMsg, "772") 
                            or string.find(errMsg, "TooManyRequests") then
                            task.wait(RATE_LIMIT_WAIT)
                        elseif string.find(errMsg:lower(), "full") 
                            or string.find(errMsg, "751") then
                            IgnoredServers[server.id] = os.time() + 600
                            UpdateIgnoredServers(IgnoredServers)
                            break
                        else
                            task.wait(GENERAL_ERROR_WAIT)
                        end
                    end
                end
                task.wait(1)
            end
        end

        if not foundTarget then
            cursor = result.nextPageCursor or ""
            if cursor == "" then
                task.wait(5)
                cursor = ""
                local now = os.time()
                for id, ts in pairs(IgnoredServers) do
                    if now - ts > HOUR then
                        IgnoredServers[id] = nil
                    end
                end
                UpdateIgnoredServers(IgnoredServers)
            else
                task.wait(0.5)
            end
        else
            cursor = ""
        end
        task.wait(1)
    end
end

--==================================================
-- 🎯 SMART SERVER HOP (MAIN LOGIC)
-- 
-- 1. Habis Escape       → HOP + NOTIF
-- 2. Sendirian (≤1)     → HOP + NOTIF
-- 3. 2 Player           → TUNGGU 90 DETIK → HOP + NOTIF
-- 4. Round + Survivor   → DIAM (auto farm)
-- 5. Round + Killer     → HOP + NOTIF
-- 6. Round + Spectator  → HOP SILENT (tanpa notif)
-- 7. Tidak ada round    → DIAM
--==================================================
local function ServerHop()
    -- 🔥 Variabel tracking untuk 2 player
    local twoPlayerStartTime = nil
    local twoPlayerNotified = false

    while Toggles.ServerHop.Value and not Library.Unloaded do
        local playerCount = #Players:GetPlayers()
        local role = GetRole()

        -- 1. Habis Escape → HOP + NOTIF
        if HopAfterBeatTriggered then
            HopAfterBeatTriggered = false
            twoPlayerStartTime = nil  -- Reset timer 2 player
            twoPlayerNotified = false
            ZryxNotify({
                Title = "🏁 Escape Done!",
                Description = "Hopping to new server NOW...",
                Time = 2
            })
            PersistentServerHop()
            task.wait(3)
            continue
        end

        -- 2. Sendirian → HOP + NOTIF
        if playerCount <= 1 then
            twoPlayerStartTime = nil  -- Reset timer 2 player
            twoPlayerNotified = false
            ZryxNotify({
                Title = "👤 Alone!",
                Description = "Hopping immediately...",
                Time = 2
            })
            PersistentServerHop()
            task.wait(3)
            continue
        end

        -- 3. 🔥 2 PLAYER → TUNGGU 90 DETIK → HOP
        if playerCount == 2 then
            -- Mulai timer kalau belum ada
            if not twoPlayerStartTime then
                twoPlayerStartTime = os.time()
                twoPlayerNotified = false
                ZryxNotify({
                    Title = "👥 2 Players Detected",
                    Description = string.format(
                        "Waiting %ds before hopping...",
                        TWO_PLAYER_WAIT
                    ),
                    Time = 3
                })
            end

            local elapsed = os.time() - twoPlayerStartTime

            -- Notif countdown tiap 30 detik
            if not twoPlayerNotified and elapsed >= 30 then
                ZryxNotify({
                    Title = "⏱️ Still 2 Players",
                    Description = string.format(
                        "Hopping in %ds...",
                        TWO_PLAYER_WAIT - elapsed
                    ),
                    Time = 2
                })
                twoPlayerNotified = true
            end

            -- Setelah 90 detik → HOP
            if elapsed >= TWO_PLAYER_WAIT then
                ZryxNotify({
                    Title = "🔄 2 Players Timeout",
                    Description = "90s passed, hopping now...",
                    Time = 2
                })
                twoPlayerStartTime = nil
                twoPlayerNotified = false
                PersistentServerHop()
                task.wait(3)
                continue
            end

            -- Tunggu 1 detik sambil tetap di loop (biar bisa cek kondisi lain)
            task.wait(1)
            continue
        else
            -- Player count berubah (bukan 2), reset timer
            if twoPlayerStartTime then
                twoPlayerStartTime = nil
                twoPlayerNotified = false
            end
        end

        -- 4. Round + Survivor → DIAM
        if IsRound and role == "Survivor" then
            task.wait(1)
            continue
        end

        -- 5. Round + Killer → HOP + NOTIF
        if IsRound and role == "Killer" then
            twoPlayerStartTime = nil
            twoPlayerNotified = false
            ZryxNotify({
                Title = "🔪 Killer in Round",
                Description = "Hopping now...",
                Time = 2
            })
            PersistentServerHop()
            task.wait(3)
            continue
        end

        -- 6. Round + Spectator → HOP SILENT
        if IsRound and role == "Spectator" then
            twoPlayerStartTime = nil
            twoPlayerNotified = false
            PersistentServerHop()
            task.wait(3)
            continue
        end

        -- 7. Tidak ada round / Lobby → DIAM
        task.wait(1)
    end
end

--==================================================
-- UI CONTROLS - AUTO FARM TAB
--==================================================
AutoFarmGroup:AddToggle("EnableAutoFarm", {
    Text = "Enable Auto Farm",
    Tooltip = "Teleport Survivor to the detected finish location",
    Default = false,
})

AutoFarmGroup:AddToggle("ServerHop", {
    Text = "Server Hop (Smart)",
    Tooltip = "Alone/2p/Killer/Spec=Hop | Survivor=Farm | NoRound=Wait",
    Default = false,
    Callback = function(Value)
        if Value then
            task.spawn(function()
                ServerHop()
            end)
        end
    end,
})

--==================================================
-- AUTO EXECUTE
--==================================================
local LOADER_URL = "https://raw.githubusercontent.com/zaerrruwww/zaerytta/refs/heads/main/zaer.lua"
local AutoExecuteQueued = false

local function QueueAutoExecute()
    if AutoExecuteQueued then return end
    if not Toggles.AutoExecute.Value then return end
    
    if type(queue_on_teleport) ~= "function" then
        ZryxNotify({
            Title = "Auto Execute",
            Description = "queue_on_teleport is not available.",
            Time = 5,
        })
        return
    end
    
    local queued = string.format([[loadstring(game:HttpGet(%q))()]], LOADER_URL)
    local success, err = pcall(function()
        queue_on_teleport(queued)
    end)
    
    if success then
        AutoExecuteQueued = true
        ZryxNotify({
            Title = "Auto Execute",
            Description = "Script queued for next teleport.",
            Time = 3,
        })
    else
        ZryxNotify({
            Title = "Auto Execute",
            Description = "Failed: " .. tostring(err),
            Time = 5,
        })
    end
end

AutoFarmGroup:AddToggle("AutoExecute", {
    Text = "Auto Execute",
    Tooltip = "Execute zaer.lua after server hop",
    Default = false,
    Callback = function(Value)
        if Value then
            QueueAutoExecute()
        else
            AutoExecuteQueued = false
        end
    end,
})

--==================================================
-- WEBHOOK UI
--==================================================
WebhookGroup:AddToggle("EnableWebhook", {
    Text = "Enable Webhook",
    Tooltip = "Enable webhook notifications with Zryx branding",
    Default = false,
})

WebhookGroup:AddInput("WebhookLink", {
    Text = "Webhook Link",
    Default = "",
    Placeholder = "Enter webhook URL...",
    Numeric = false,
    Finished = false,
    ClearTextOnFocus = false,
})

WebhookGroup:AddButton("Test Webhook", function()
    cachedAvatarUrls = {}
    cachedLogoUrl = nil
    
    local ok, msg = SendDiscordWebhook(
        "🔔 Webhook Test",
        "Configuration test from **Zryx Auto Farm**!",
        true
    )
    
    if ok then
        ZryxNotify({
            Title = "Webhook Success",
            Description = "Test message sent!",
            Icon = "check",
            Time = 3
        })
    else
        ZryxNotify({
            Title = "Webhook Failed",
            Description = msg,
            Icon = "x",
            Time = 4
        })
    end
end)

--==================================================
-- SETTINGS TAB
--==================================================
local MenuGroup = Tabs.Settings:AddLeftGroupbox("Menu", "wrench")

MenuGroup:AddToggle("KeybindMenuOpen", {
    Default = Library.KeybindFrame.Visible,
    Text = "Open Keybind Menu",
    Callback = function(Value)
        Library.KeybindFrame.Visible = Value
    end,
})

MenuGroup:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = Library.ShowCustomCursor,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

MenuGroup:AddToggle("EnableNotifications", {
    Text = "Enable Notifications",
    Tooltip = "Toggle on/off semua notifikasi script",
    Default = true,
})

MenuGroup:AddDropdown("NotificationSide", {
    Values = {"Left", "Right"},
    Default = "Right",
    Text = "Notification Side",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

MenuGroup:AddDropdown("DPIDropdown", {
    Values = {"50%", "75%", "100%", "125%", "150%", "175%", "200%"},
    Default = "100%",
    Text = "DPI Scale",
    Callback = function(Value)
        local DPI = tonumber(Value:gsub("%%", ""))
        Library:SetDPIScale(DPI)
    end,
})

MenuGroup:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = 14,
    Min = 0,
    Max = 25,
    Rounding = 0,
    Callback = function(Value)
        Window:SetCornerRadius(Value)
    end,
})

MenuGroup:AddDivider()

MenuGroup:AddLabel("Menu bind")
    :AddKeyPicker("MenuKeybind", {
        Default = "RightShift",
        NoUI = true,
        Text = "Menu keybind",
    })

MenuGroup:AddButton("Unload", function()
    Library:Unload()
end)

Library.ToggleKeybind = Options.MenuKeybind

--==================================================
-- SAVE / THEME MANAGER
--==================================================
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
ThemeManager:SetFolder("AutoFarm")
SaveManager:SetFolder("AutoFarm")
SaveManager:SetSubFolder("Settings")
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
SaveManager:BuildConfigSection(Tabs.Settings)
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

--==================================================
-- INITIALIZATION
--==================================================
QueueAutoExecute()

Library:Notify({
    Title = "Zryx Auto Farm",
    Description = "Script Loaded Successfully!",
    Icon = "rbxassetid://" .. ZRYX_LOGO_ID,
    Time = 4
})

--==================================================
-- MAIN LOOP
--==================================================
task.spawn(function()
    while not Library.Unloaded do
        pcall(function()
            BeatGameSurvivor()
        end)
        task.wait(1)
    end
end)
