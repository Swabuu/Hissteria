-- Modules/MockMode.lua
local ADDON_NAME, Hissteria = ...

local MockMode = {}

local MOCK_CLASSES = { "WARRIOR", "PALADIN", "HUNTER", "ROGUE", "PRIEST", "DEATHKNIGHT", "SHAMAN", "MAGE", "WARLOCK", "DRUID" }
local MOCK_SPECS = {
    WARRIOR = { "Arms", "Fury", "Protection" },
    PALADIN = { "Holy", "Protection", "Retribution" },
    HUNTER = { "Beast Mastery", "Marksmanship", "Survival" },
    ROGUE = { "Assassination", "Combat", "Subtlety" },
    PRIEST = { "Discipline", "Holy", "Shadow" },
    DEATHKNIGHT = { "Blood", "Frost", "Unholy" },
    SHAMAN = { "Elemental", "Enhancement", "Restoration" },
    MAGE = { "Arcane", "Fire", "Frost" },
    WARLOCK = { "Affliction", "Demonology", "Destruction" },
    DRUID = { "Balance", "Feral", "Restoration" },
}
local MOCK_NAMES = { "Stabsworth", "Healzalot", "Pwncakes", "Noobslayer", "Critmaster", "Facemelt", "Sheepmage", "Dotlord", "Zugzug", "Loktar" }

function MockMode:OnInitialize() self.fluctuationTimer = nil end
function MockMode:OnEnable() end

function MockMode:GenerateMockEnemies(count)
    count = count or 10
    local enemies = {}
    local healerSetup = {
        { class = "PRIEST", spec = "Holy" },
        { class = "PALADIN", spec = "Holy" },
        { class = "DRUID", spec = "Restoration" },
    }
    
    for i = 1, math.min(3, count) do
        local name = MOCK_NAMES[i] .. i
        local setup = healerSetup[i]
        enemies[name] = {
            name = name, class = setup.class, spec = setup.spec,
            hp = math.random(60, 100) / 100, maxHp = math.random(26000, 30000),
            trinketUsed = math.random() > 0.5 and GetTime() - math.random(0, 90) or nil,
            trinketTime = math.random() > 0.5 and GetTime() - math.random(0, 90) or nil,
            targetCount = math.random(0, 5), isHealer = true, isDead = false,
            lastSeen = GetTime(),
        }
    end
    
    for i = 4, count do
        local class = MOCK_CLASSES[math.random(#MOCK_CLASSES)]
        local specs = MOCK_SPECS[class]
        local spec = specs[math.random(#specs)]
        local name = MOCK_NAMES[math.random(#MOCK_NAMES)] .. i
        local isHealer = Hissteria:IsHealer(class, spec)
        enemies[name] = {
            name = name, class = class, spec = spec,
            hp = math.random(10, 100) / 100, maxHp = math.random(22000, 32000),
            trinketUsed = math.random() > 0.7 and GetTime() or nil,
            trinketTime = math.random() > 0.7 and GetTime() or nil,
            targetCount = math.random(0, 8), isHealer = isHealer,
            isDead = math.random() > 0.92, lastSeen = GetTime(),
        }
    end
    return enemies
end

function MockMode:Toggle()
    Hissteria.mockModeEnabled = not Hissteria.mockModeEnabled
    if Hissteria.mockModeEnabled then
        Hissteria:Print("|cFF00FF00Mock Mode ENABLED|r")
        Hissteria.enemies = self:GenerateMockEnemies(10)
        self:StartFluctuation()
        local Grid = Hissteria:GetModule("Grid")
        if Grid then Grid:Show(); Grid:Update() end
    else
        Hissteria:Print("|cFFFF0000Mock Mode DISABLED|r")
        self:StopFluctuation()
        Hissteria.enemies = {}
        local Grid = Hissteria:GetModule("Grid")
        if Grid then Grid:Update(); Grid:Hide() end
    end
end

function MockMode:StartFluctuation()
    if self.fluctuationTimer then return end
    self.fluctuationTimer = CreateFrame("Frame")
    self.fluctuationTimer.elapsed = 0
    self.fluctuationTimer:SetScript("OnUpdate", function(frame, elapsed)
        frame.elapsed = frame.elapsed + elapsed
        if frame.elapsed < 0.5 then return end
        frame.elapsed = 0
        for name, enemy in pairs(Hissteria.enemies) do
            if not enemy.isDead then
                enemy.hp = math.max(0, math.min(1, enemy.hp + (math.random() - 0.6) * 0.15))
                if enemy.hp <= 0.01 then enemy.isDead = true; enemy.hp = 0 end
                if math.random() > 0.7 then enemy.targetCount = math.max(0, enemy.targetCount + math.random(-2, 2)) end
            else
                if math.random() > 0.99 then enemy.isDead = false; enemy.hp = 1.0 end
            end
        end
        local Grid = Hissteria:GetModule("Grid")
        if Grid then Grid:Update() end
    end)
end

function MockMode:StopFluctuation()
    if self.fluctuationTimer then
        self.fluctuationTimer:SetScript("OnUpdate", nil)
        self.fluctuationTimer = nil
    end
end

Hissteria:RegisterModule("MockMode", MockMode)
