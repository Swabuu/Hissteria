-- Modules/CommandBar.lua
-- Quick action buttons panel (WotLK 3.3.5a compatible)
local ADDON_NAME, Hissteria = ...
print("|cFFFF6600[Hissteria]|r CommandBar.lua loaded")

local CommandBar = {}
local BUTTON_SIZE = 26
local BUTTON_SPACING = 3

function CommandBar:OnInitialize()
    self.frame = nil
    self.isExpanded = false
    self.buttons = {}
end

function CommandBar:OnEnable()
    -- Delayed creation after Grid is ready
    local delayFrame = CreateFrame("Frame")
    delayFrame.elapsed = 0
    delayFrame:SetScript("OnUpdate", function(f, elapsed)
        f.elapsed = f.elapsed + elapsed
        if f.elapsed > 1.0 then
            f:SetScript("OnUpdate", nil)
            self:CreateFrame()
        end
    end)
end

-- Helper: Create black border
local function CreateBorder(frame)
    local border = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
    border:SetPoint("TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", 1, -1)
    border:SetTexture("Interface\\Buttons\\WHITE8x8")
    border:SetVertexColor(0, 0, 0, 1)
    return border
end

function CommandBar:CreateFrame()
    local Grid = Hissteria:GetModule("Grid")
    if not Grid or not Grid.frame then return end
    if self.frame then return end
    
    -- Main container
    self.frame = CreateFrame("Frame", "HissteriaCommandBar", Grid.frame)
    self.frame:SetWidth(BUTTON_SIZE + 8)
    self.frame:SetHeight(BUTTON_SIZE + 8)
    self.frame:SetPoint("TOPRIGHT", Grid.frame, "TOPLEFT", -4, 0)
    
    -- Toggle button (paw icon)
    self.toggleBtn = CreateFrame("Button", nil, self.frame)
    self.toggleBtn:SetWidth(BUTTON_SIZE)
    self.toggleBtn:SetHeight(BUTTON_SIZE)
    self.toggleBtn:SetPoint("CENTER")
    self.toggleBtn:SetNormalTexture("Interface\\Icons\\Ability_Druid_Ravage")
    self.toggleBtn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    CreateBorder(self.toggleBtn)
    
    self.toggleBtn:SetScript("OnClick", function() self:ToggleExpand() end)
    self.toggleBtn:SetScript("OnEnter", function(btn)
        GameTooltip:SetOwner(btn, "ANCHOR_RIGHT")
        GameTooltip:AddLine("|cFFFF6600Hissteria Commands|r")
        GameTooltip:AddLine("Click to " .. (self.isExpanded and "collapse" or "expand"), 0.7, 0.7, 0.7)
        GameTooltip:Show()
    end)
    self.toggleBtn:SetScript("OnLeave", function() GameTooltip:Hide() end)
    
    -- Expanded panel (hidden by default)
    self.expandedFrame = CreateFrame("Frame", nil, self.frame)
    self.expandedFrame:SetWidth(BUTTON_SIZE + 8)
    self.expandedFrame:SetHeight((BUTTON_SIZE + BUTTON_SPACING) * 5 + 8)
    self.expandedFrame:SetPoint("TOP", self.toggleBtn, "BOTTOM", 0, -4)
    
    -- Panel background
    self.expandedFrame.bg = self.expandedFrame:CreateTexture(nil, "BACKGROUND")
    self.expandedFrame.bg:SetAllPoints()
    self.expandedFrame.bg:SetTexture("Interface\\Buttons\\WHITE8x8")
    self.expandedFrame.bg:SetVertexColor(0.02, 0.02, 0.02, 0.95)
    
    -- Orange border
    local bc = {1, 0.4, 0, 0.9}
    self.expandedFrame.bTop = self.expandedFrame:CreateTexture(nil, "BORDER")
    self.expandedFrame.bTop:SetTexture("Interface\\Buttons\\WHITE8x8")
    self.expandedFrame.bTop:SetVertexColor(unpack(bc))
    self.expandedFrame.bTop:SetPoint("TOPLEFT")
    self.expandedFrame.bTop:SetPoint("TOPRIGHT")
    self.expandedFrame.bTop:SetHeight(2)
    
    self.expandedFrame.bBot = self.expandedFrame:CreateTexture(nil, "BORDER")
    self.expandedFrame.bBot:SetTexture("Interface\\Buttons\\WHITE8x8")
    self.expandedFrame.bBot:SetVertexColor(unpack(bc))
    self.expandedFrame.bBot:SetPoint("BOTTOMLEFT")
    self.expandedFrame.bBot:SetPoint("BOTTOMRIGHT")
    self.expandedFrame.bBot:SetHeight(2)
    
    self.expandedFrame.bLeft = self.expandedFrame:CreateTexture(nil, "BORDER")
    self.expandedFrame.bLeft:SetTexture("Interface\\Buttons\\WHITE8x8")
    self.expandedFrame.bLeft:SetVertexColor(unpack(bc))
    self.expandedFrame.bLeft:SetPoint("TOPLEFT")
    self.expandedFrame.bLeft:SetPoint("BOTTOMLEFT")
    self.expandedFrame.bLeft:SetWidth(2)
    
    self.expandedFrame.bRight = self.expandedFrame:CreateTexture(nil, "BORDER")
    self.expandedFrame.bRight:SetTexture("Interface\\Buttons\\WHITE8x8")
    self.expandedFrame.bRight:SetVertexColor(unpack(bc))
    self.expandedFrame.bRight:SetPoint("TOPRIGHT")
    self.expandedFrame.bRight:SetPoint("BOTTOMRIGHT")
    self.expandedFrame.bRight:SetWidth(2)
    
    self.expandedFrame:Hide()
    
    -- =============================================
    -- CREATE COMMAND BUTTONS
    -- =============================================
    
    -- 1. ENEMY REPORT
    self:CreateButton(1, "Interface\\Icons\\Ability_Hunter_SniperShot", "Enemy Report", 
        "Show detailed enemy team analysis",
        function()
            local Scanner = Hissteria:GetModule("Scanner")
            if Scanner then 
                Scanner:PrintEnemyReport() 
            else
                Hissteria:Print("Scanner module not loaded!")
            end
        end)
    
    -- 2. TEAM STATUS
    self:CreateButton(2, "Interface\\Icons\\Spell_Nature_Regeneration", "Battle Status",
        "Compare your team vs enemies",
        function()
            local Scanner = Hissteria:GetModule("Scanner")
            if Scanner then 
                Scanner:PrintTeamStatus() 
            else
                Hissteria:Print("Scanner module not loaded!")
            end
        end)
    
    -- 3. LOCK/UNLOCK GRID
    self:CreateButton(3, "Interface\\Icons\\INV_Misc_Key_01", "Lock/Unlock Grid",
        "Toggle grid dragging",
        function()
            local Grid = Hissteria:GetModule("Grid")
            if Grid then 
                Grid:ToggleLock() 
            end
        end)
    
    -- 4. RESET POSITION
    self:CreateButton(4, "Interface\\Icons\\Ability_Rogue_Sprint", "Reset Position",
        "Move grid to default position",
        function()
            local Grid = Hissteria:GetModule("Grid")
            if Grid then 
                Grid:ResetPosition() 
                Hissteria:Print("Grid position reset.")
            end
        end)
    
    -- 5. PERFORMANCE STATS
    self:CreateButton(5, "Interface\\Icons\\INV_Gizmo_02", "Performance",
        "Show addon performance stats",
        function()
            local Scanner = Hissteria:GetModule("Scanner")
            if Scanner then 
                Scanner:PrintPerformance() 
            end
        end)
end

function CommandBar:CreateButton(index, icon, name, tooltip, callback)
    local btn = CreateFrame("Button", nil, self.expandedFrame)
    btn:SetWidth(BUTTON_SIZE)
    btn:SetHeight(BUTTON_SIZE)
    btn:SetPoint("TOP", self.expandedFrame, "TOP", 0, -4 - (index - 1) * (BUTTON_SIZE + BUTTON_SPACING))
    btn:SetNormalTexture(icon)
    btn:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square", "ADD")
    CreateBorder(btn)
    
    btn:SetScript("OnClick", function()
        callback()
        -- Collapse after clicking
        self.isExpanded = false
        self.expandedFrame:Hide()
    end)
    
    btn:SetScript("OnEnter", function(b)
        GameTooltip:SetOwner(b, "ANCHOR_RIGHT")
        GameTooltip:AddLine("|cFFFF6600" .. name .. "|r")
        if tooltip then
            GameTooltip:AddLine(tooltip, 0.7, 0.7, 0.7)
        end
        GameTooltip:Show()
    end)
    btn:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    self.buttons[index] = btn
end

function CommandBar:ToggleExpand()
    self.isExpanded = not self.isExpanded
    if self.isExpanded then
        self.expandedFrame:Show()
    else
        self.expandedFrame:Hide()
    end
end

Hissteria:RegisterModule("CommandBar", CommandBar)
