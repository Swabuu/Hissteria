-- Modules/Grid.lua
local ADDON_NAME, Hissteria = ...
local Grid = {}
local MAX_ENEMIES = 15
local PADDING = 6

function Grid:OnInitialize()
    self.bars = {}
    self.frame = nil
    self.isLocked = true
end
function Grid:OnEnable() self:CreateFrame() end

function Grid:CreateFrame()
    if self.frame then return end
    local EnemyBar = Hissteria:GetModule("EnemyBar")
    if not EnemyBar then return end
    
    local barWidth = EnemyBar.BAR_WIDTH
    local barHeight = EnemyBar.BAR_HEIGHT
    local spacing = EnemyBar.BAR_SPACING
    local totalWidth = PADDING + EnemyBar.TRINKET_SIZE + 2 + EnemyBar.ICON_SIZE + 2 + barWidth + 2 + EnemyBar.ICON_SIZE + PADDING
    local totalHeight = (barHeight + spacing) * 10 + PADDING * 2
    
    self.frame = CreateFrame("Frame", "HissteriaGrid", UIParent)
    self.frame:SetWidth(totalWidth)
    self.frame:SetHeight(totalHeight)
    self.frame:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    self.frame:SetFrameStrata("MEDIUM")
    self.frame.bg = self.frame:CreateTexture(nil, "BACKGROUND")
    self.frame.bg:SetAllPoints()
    self.frame.bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    self.frame.bg:SetVertexColor(0, 0, 0, 0.5)
    
    self.frame.header = self.frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    self.frame.header:SetPoint("BOTTOMLEFT", self.frame, "TOPLEFT", 0, 2)
    self.frame.header:SetText("Hissteria Grid")
    
    self.frame:SetMovable(true)
    self.frame:EnableMouse(true)
    self.frame:RegisterForDrag("LeftButton")
    self.frame:SetScript("OnDragStart", function(f) if not Grid.isLocked then f:StartMoving() end end)
    self.frame:SetScript("OnDragStop", function(f) f:StopMovingOrSizing() end)
    
    for i = 1, MAX_ENEMIES do
        local bar = EnemyBar:Create(self.frame, i)
        local yPos = -PADDING - (i - 1) * (barHeight + spacing)
        bar:SetPoint("TOPLEFT", self.frame, "TOPLEFT", PADDING, yPos)
        bar:Hide()
        self.bars[i] = bar
    end
    self.frame:Hide()
end

local function GetRoleScore(data)
    if data.isDead then return 4 end
    if data.spec == "Protection" or data.spec == "Blood" then return 1 end
    if data.isHealer then return 2 end
    return 3
end

function Grid:Update()
    if not self.frame then return end
    local EnemyBar = Hissteria:GetModule("EnemyBar")
    local enemyList = {}
    if Hissteria.enemies then 
        for _, data in pairs(Hissteria.enemies) do 
            table.insert(enemyList, data) 
        end 
    end
    
    -- Sort ONLY by name (alphabetically) - stable order, no re-sorting by status
    table.sort(enemyList, function(a, b)
        return a.name < b.name
    end)
    
    local visibleCount = 0
    for i, bar in ipairs(self.bars) do
        if enemyList[i] then
            EnemyBar:Update(bar, enemyList[i])
            visibleCount = visibleCount + 1
        else
            bar:Hide()
        end
    end
    
    local barHeight = EnemyBar.BAR_HEIGHT
    local spacing = EnemyBar.BAR_SPACING
    if visibleCount > 0 then
        local newHeight = (barHeight + spacing) * visibleCount + PADDING * 2 - spacing
        self.frame:SetHeight(newHeight)
        self.frame.bg:Show()
    else
        self.frame:SetHeight(30)
        if self.isLocked then self.frame.bg:Hide() else self.frame.bg:Show() end
    end
end

function Grid:Show() if self.frame then self.frame:Show() end end
function Grid:Hide() if self.frame then self.frame:Hide() end end
function Grid:IsShown() return self.frame and self.frame:IsShown() end
function Grid:ToggleLock()
    self.isLocked = not self.isLocked
    if self.isLocked then
        Hissteria:Print("Grid LOCKED")
        self.frame.bg:SetVertexColor(0,0,0,0)
        self.frame.header:Hide()
    else
        Hissteria:Print("Grid UNLOCKED")
        self.frame.bg:SetVertexColor(0,0,0,0.5)
        self.frame.header:Show()
        self:Show()
    end
    self:Update()
end
function Grid:ResetPosition()
    if self.frame then
        self.frame:ClearAllPoints()
        self.frame:SetPoint("CENTER", UIParent, "CENTER", 300, 0)
    end
end

Hissteria:RegisterModule("Grid", Grid)
