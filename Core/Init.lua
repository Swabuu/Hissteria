local ADDON_NAME, Hissteria = ...
print("|cFFFF6600[Hissteria]|r Initializing... Meow :3 xoxo") -- BRANDING!

_G.Hissteria = Hissteria
Hissteria.VERSION = "1.0.0"
Hissteria.modules = {}
Hissteria.enemies = {}
Hissteria.inBattleground = false
Hissteria.mockModeEnabled = false

function Hissteria:RegisterModule(name, module)
    self.modules[name] = module
    if module.OnInitialize then module:OnInitialize() end
end

function Hissteria:GetModule(name) return self.modules[name] end

function Hissteria:Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cFFFF6600[Hissteria]|r " .. tostring(msg))
end

function Hissteria:Debug(msg)
    if self.db and self.db.debug then
        DEFAULT_CHAT_FRAME:AddMessage("|cFF666666[Debug]|r " .. tostring(msg))
    end
end

local function InitializeDB()
    if not HissteriaDB then HissteriaDB = {} end
    Hissteria.db = setmetatable(HissteriaDB, { __index = Hissteria.defaults or {} })
end

local loadFrame = CreateFrame("Frame")
loadFrame:RegisterEvent("ADDON_LOADED")
loadFrame:RegisterEvent("PLAYER_LOGIN")
loadFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == ADDON_NAME then
        InitializeDB()
        Hissteria:Print("Loaded! Time to hunt! Meow. 🐾")
    elseif event == "PLAYER_LOGIN" then
        for name, module in pairs(Hissteria.modules) do
            if module.OnEnable then module:OnEnable() end
        end
        local Grid = Hissteria:GetModule("Grid")
        if Grid and not Grid.frame then Grid:CreateFrame() end
    end
end)