-- Modules/Scanner.lua
-- Fix: Detect Death via Scoreboard increment

local ADDON_NAME, Hissteria = ...
local Scanner = {}
local SCAN_INTERVAL = 0.5
local SCORE_INTERVAL = 2.0

function Scanner:OnInitialize()
    self.scanFrame = nil
    self.lastScan = 0
    self.lastScoreRequest = 0
end
function Scanner:OnEnable() self:SetupEventFrame() end

function Scanner:SetupEventFrame()
    self.scanFrame = CreateFrame("Frame")
    self.scanFrame:RegisterEvent("UPDATE_BATTLEFIELD_SCORE")
    self.scanFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
    self.scanFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    self.scanFrame:SetScript("OnEvent", function(frame, event, ...)
        if event == "UPDATE_BATTLEFIELD_SCORE" then self:ScanScoreboard()
        elseif event == "PLAYER_ENTERING_WORLD" or event == "ZONE_CHANGED_NEW_AREA" then self:CheckBattleground() end
    end)
    self.scanFrame:SetScript("OnUpdate", function(frame, elapsed)
        if not Hissteria.inBattleground or Hissteria.mockModeEnabled then return end
        self.lastScan = self.lastScan + elapsed
        self.lastScoreRequest = self.lastScoreRequest + elapsed
        if self.lastScoreRequest >= SCORE_INTERVAL then
            self.lastScoreRequest = 0
            RequestBattlefieldScoreData()
        end
        if self.lastScan >= SCAN_INTERVAL then
            self.lastScan = 0
            self:ScanRaidTargets()
            local Grid = Hissteria:GetModule("Grid")
            if Grid and Grid:IsShown() then Grid:Update() end
        end
    end)
end

function Scanner:CheckBattleground()
    local inInstance, instanceType = IsInInstance()
    local wasInBG = Hissteria.inBattleground
    Hissteria.inBattleground = (instanceType == "pvp")
    if Hissteria.inBattleground and not wasInBG then
        Hissteria:Print("Entered Battleground.")
        Hissteria.enemies = {}
        RequestBattlefieldScoreData()
        local Grid = Hissteria:GetModule("Grid")
        if Grid and Hissteria.db and Hissteria.db.autoShowInBG then Grid:Show() end
    elseif not Hissteria.inBattleground and wasInBG then
        Hissteria:Print("Left Battleground.")
        Hissteria.enemies = {}
        local Grid = Hissteria:GetModule("Grid")
        if Grid and Hissteria.db and Hissteria.db.autoHideOutOfBG then Grid:Hide() end
    end
end

function Scanner:ScanScoreboard()
    if Hissteria.mockModeEnabled then return end
    local playerFaction = UnitFactionGroup("player")
    local numScores = GetNumBattlefieldScores()
    
    for i = 1, numScores do
        local name, _, _, deaths, _, faction, _, _, class = GetBattlefieldScore(i)
        local isEnemy = (faction == 0 and playerFaction == "Alliance") or (faction == 1 and playerFaction == "Horde")
        
        if isEnemy and name then
            local cleanName = Hissteria:CleanName(name)
            local enemy = Hissteria.enemies[cleanName]
            
            if not enemy then
                local normalizedClass = class and class:upper():gsub(" ", "") or "UNKNOWN"
                Hissteria.enemies[cleanName] = {
                    name = cleanName, class = normalizedClass, hp = 1, maxHp = nil, spec = nil,
                    trinketUsed = nil, targetCount = 0, isHealer = false, isThreat = false,
                    isDead = false, deaths = deaths, fromScore = true,
                    lastSeen = GetTime(),
                }
            else
                -- DEATH DETECTION LOGIC
                if enemy.deaths and deaths > enemy.deaths then
                    enemy.isDead = true -- De har dött nyss!
                    enemy.hp = 0
                    enemy.lastSeen = GetTime() -- Uppdatera så de inte blir out-of-range
                end
                enemy.deaths = deaths
            end
        end
    end
end

function Scanner:ScanRaidTargets()
    if Hissteria.mockModeEnabled then return end
    for _, enemy in pairs(Hissteria.enemies) do enemy.targetCount = 0 end
    local numRaid = GetNumRaidMembers()
    if numRaid == 0 then return end
    for i = 1, numRaid do
        local target = "raid" .. i .. "target"
        if UnitExists(target) and UnitIsEnemy("player", target) and UnitIsPlayer(target) then
            local name = UnitName(target)
            if name then
                local cleanName = Hissteria:CleanName(name)
                local enemy = Hissteria.enemies[cleanName]
                if enemy then
                    enemy.lastSeen = GetTime()
                    local hp = UnitHealth(target)
                    local maxHp = UnitHealthMax(target)
                    if maxHp and maxHp > 0 then
                        enemy.hp = hp / maxHp
                        enemy.maxHp = maxHp
                        -- Update Alive/Dead status instantly if in range
                        enemy.isDead = (hp <= 0)
                    end
                    if not enemy.class or enemy.class == "UNKNOWN" then
                        local _, unitClass = UnitClass(target)
                        if unitClass then enemy.class = unitClass end
                    end
                    enemy.targetCount = (enemy.targetCount or 0) + 1
                end
            end
        end
    end
end

function Scanner:PrintEnemyReport() end
function Scanner:PrintTeamStatus() end
function Scanner:PrintPerformance() end
function Scanner:ResetPerformance() end

Hissteria:RegisterModule("Scanner", Scanner)