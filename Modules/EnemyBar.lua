-- Modules/EnemyBar.lua
-- Fix: NUCLEAR Angel Layering (Parent to Bar, Max Strata)
-- Fix: Improved Range Fading visuals

local ADDON_NAME, Hissteria = ...
print("|cFFFF6600[Hissteria]|r EnemyBar loaded")

local EnemyBar = {}

EnemyBar.BAR_WIDTH = 180
EnemyBar.BAR_HEIGHT = 28
EnemyBar.BAR_SPACING = 3 
EnemyBar.ICON_SIZE = 28
EnemyBar.TRINKET_SIZE = 28

local BAR_TEXTURE = "Interface\\TargetingFrame\\UI-StatusBar" 
local FONT_PATH = "Fonts\\FRIZQT__.TTF" 

function EnemyBar:OnInitialize() end
function EnemyBar:OnEnable() end

local function CreateBorder(frame)
    local border = frame:CreateTexture(nil, "BACKGROUND", nil, -7)
    border:SetPoint("TOPLEFT", -1, 1)
    border:SetPoint("BOTTOMRIGHT", 1, -1)
    border:SetTexture("Interface\\Buttons\\WHITE8x8")
    border:SetVertexColor(0, 0, 0, 1)
    return border
end

function EnemyBar:Create(parent, index)
    -- Main Button
    local bar = CreateFrame("Button", "HissteriaBar" .. index, parent, "SecureActionButtonTemplate")
    bar:RegisterForClicks("AnyUp")
    
    local totalWidth = EnemyBar.TRINKET_SIZE + 2 + EnemyBar.ICON_SIZE + 2 + EnemyBar.BAR_WIDTH + 2 + EnemyBar.ICON_SIZE
    bar:SetWidth(totalWidth)
    bar:SetHeight(EnemyBar.BAR_HEIGHT)
    
    bar.targetHealth = 1
    bar.currentHealth = 1
    
    -- 1. Trinket
    bar.trinket = CreateFrame("Frame", nil, bar)
    bar.trinket:SetSize(EnemyBar.TRINKET_SIZE, EnemyBar.TRINKET_SIZE)
    bar.trinket:SetPoint("LEFT", 0, 0)
    CreateBorder(bar.trinket)
    
    bar.trinketBg = bar.trinket:CreateTexture(nil, "ARTWORK")
    bar.trinketBg:SetAllPoints()
    bar.trinketBg:SetTexture("Interface\\Buttons\\UI-EmptySlot-White")
    bar.trinketBg:SetVertexColor(0.2, 0.2, 0.2, 1)
    
    bar.trinketIcon = bar.trinket:CreateTexture(nil, "OVERLAY")
    bar.trinketIcon:SetAllPoints()
    bar.trinketIcon:SetTexture("Interface\\Icons\\INV_Jewelry_TrinketPVP_02")
    bar.trinketIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    bar.trinketIcon:Hide()
    
    bar.trinketCD = CreateFrame("Cooldown", nil, bar.trinket, "CooldownFrameTemplate")
    bar.trinketCD:SetAllPoints()
    bar.trinketCD:SetReverse(true)
    
    -- 2. Class Portrait
    bar.classFrame = CreateFrame("Frame", nil, bar)
    bar.classFrame:SetSize(EnemyBar.ICON_SIZE, EnemyBar.ICON_SIZE)
    bar.classFrame:SetPoint("LEFT", bar.trinket, "RIGHT", 2, 0)
    CreateBorder(bar.classFrame)
    
    bar.classIcon = bar.classFrame:CreateTexture(nil, "ARTWORK")
    bar.classIcon:SetAllPoints()
    bar.classIcon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
    bar.classIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    
    -- 3. Health Bar
    bar.healthFrame = CreateFrame("Frame", nil, bar)
    bar.healthFrame:SetSize(EnemyBar.BAR_WIDTH, EnemyBar.BAR_HEIGHT)
    bar.healthFrame:SetPoint("LEFT", bar.classFrame, "RIGHT", 2, 0)
    CreateBorder(bar.healthFrame)
    
    bar.bg = bar.healthFrame:CreateTexture(nil, "BORDER")
    bar.bg:SetAllPoints()
    bar.bg:SetTexture(BAR_TEXTURE)
    bar.bg:SetVertexColor(0.1, 0.1, 0.1, 1)
    
    bar.healthBar = bar.healthFrame:CreateTexture(nil, "ARTWORK")
    bar.healthBar:SetPoint("TOPLEFT", 0, 0)
    bar.healthBar:SetPoint("BOTTOMLEFT", 0, 0)
    bar.healthBar:SetWidth(EnemyBar.BAR_WIDTH)
    bar.healthBar:SetTexture(BAR_TEXTURE)
    
    bar.gloss = bar.healthFrame:CreateTexture(nil, "OVERLAY")
    bar.gloss:SetPoint("TOPLEFT", 0, 0)
    bar.gloss:SetPoint("TOPRIGHT", 0, 0)
    bar.gloss:SetHeight(EnemyBar.BAR_HEIGHT / 2.5)
    bar.gloss:SetTexture("Interface\\Buttons\\WHITE8x8")
    bar.gloss:SetVertexColor(1, 1, 1, 0.15)
    
    bar.nameText = bar.healthFrame:CreateFontString(nil, "OVERLAY", nil, 7)
    bar.nameText:SetPoint("LEFT", 6, 1)
    bar.nameText:SetFont(FONT_PATH, 11, "OUTLINE")
    bar.nameText:SetTextColor(1, 1, 1)
    
    bar.hpText = bar.healthFrame:CreateFontString(nil, "OVERLAY", nil, 7)
    bar.hpText:SetPoint("RIGHT", -6, 1)
    bar.hpText:SetFont(FONT_PATH, 11, "OUTLINE")
    bar.hpText:SetTextColor(1, 1, 1)
    
    -- Spec/Healer Badges
    bar.specIcon = bar.classFrame:CreateTexture(nil, "OVERLAY", nil, 5)
    bar.specIcon:SetSize(14, 14)
    bar.specIcon:SetPoint("BOTTOMRIGHT", 2, -2)
    bar.specIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
    
    bar.specBg = bar.classFrame:CreateTexture(nil, "OVERLAY", nil, 4)
    bar.specBg:SetPoint("TOPLEFT", bar.specIcon, -1, 1)
    bar.specBg:SetPoint("BOTTOMRIGHT", bar.specIcon, 1, -1)
    bar.specBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bar.specBg:SetVertexColor(0,0,0,1)
    
    bar.healerIcon = bar.classFrame:CreateTexture(nil, "OVERLAY", nil, 7)
    bar.healerIcon:SetSize(14, 14)
    bar.healerIcon:SetPoint("TOPLEFT", -2, 2)
    bar.healerIcon:SetTexture("Interface\\Icons\\Spell_Holy_FlashHeal")
    bar.healerIcon:Hide()

    -- 4. Target Count
    bar.countFrame = CreateFrame("Frame", nil, bar)
    bar.countFrame:SetSize(EnemyBar.ICON_SIZE, EnemyBar.ICON_SIZE)
    bar.countFrame:SetPoint("LEFT", bar.healthFrame, "RIGHT", 2, 0)
    CreateBorder(bar.countFrame)
    
    bar.countBg = bar.countFrame:CreateTexture(nil, "BACKGROUND")
    bar.countBg:SetAllPoints()
    bar.countBg:SetTexture("Interface\\Buttons\\WHITE8x8")
    bar.countBg:SetVertexColor(0.1, 0.1, 0.1, 1)
    
    bar.targetCount = bar.countFrame:CreateFontString(nil, "OVERLAY")
    bar.targetCount:SetPoint("CENTER", 0, 0)
    bar.targetCount:SetFont(FONT_PATH, 14, "OUTLINE")
    bar.targetCount:SetTextColor(1, 0.2, 0.2)
    bar.countFrame:Hide()
    
    -- ============================================================
    -- 5. DEAD STATUS (NUCLEAR FIX) ☢️
    -- ============================================================
    -- Vi fäster dessa direkt på 'bar' (knappen) istället för 'healthFrame'
    -- Detta gör att de renderas över ALLT annat innehåll.
    
    -- Mörk bakgrund
    bar.deadOverlay = bar:CreateTexture(nil, "OVERLAY", nil, 6)
    bar.deadOverlay:SetPoint("TOPLEFT", bar.healthFrame, "TOPLEFT")
    bar.deadOverlay:SetPoint("BOTTOMRIGHT", bar.healthFrame, "BOTTOMRIGHT")
    bar.deadOverlay:SetTexture(BAR_TEXTURE)
    bar.deadOverlay:SetVertexColor(0.1, 0.1, 0.1, 0.9)
    bar.deadOverlay:Hide()
    
    -- Ängeln (Max Level 7 Overlay)
    bar.deadIcon = bar:CreateTexture(nil, "OVERLAY", nil, 7)
    bar.deadIcon:SetSize(30, 30) -- Stor och tydlig
    bar.deadIcon:SetPoint("CENTER", bar.healthFrame, "CENTER", 0, 0)
    bar.deadIcon:SetTexture("Interface\\Icons\\Spell_Holy_SpiritOfRedemption")
    bar.deadIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
    bar.deadIcon:Hide()
    
    bar.enemyName = nil
    
    -- Animation & Range Fader
    bar:SetScript("OnUpdate", function(self, elapsed)
        if not self:IsShown() then return end
        
        -- HP Animation
        local diff = self.targetHealth - self.currentHealth
        if math.abs(diff) > 0.005 then
            self.currentHealth = self.currentHealth + (diff * 0.2)
        else
            self.currentHealth = self.targetHealth
        end
        local w = math.max(0.01, EnemyBar.BAR_WIDTH * self.currentHealth)
        self.healthBar:SetWidth(w)
        
        -- Range Fading
        if self.enemyName and Hissteria.enemies[self.enemyName] then
            local data = Hissteria.enemies[self.enemyName]
            if Hissteria.mockModeEnabled then
                self:SetAlpha(1)
            else
                local lastSeen = data.lastSeen or 0
                local timeSince = GetTime() - lastSeen
                
                if data.isDead then
                    -- Död = Tydligt synlig (för att se ängeln)
                    self:SetAlpha(0.9)
                elseif timeSince < 10 then 
                    -- Aktiv = Full styrka
                    self:SetAlpha(1.0)
                else
                    -- Range/Inaktiv = Halv styrka
                    self:SetAlpha(0.5)
                end
            end
        else
            self:SetAlpha(1)
        end
    end)
    
    return bar
end

function EnemyBar:Update(bar, enemyData)
    if not bar then return end
    if not enemyData then bar:Hide(); return end
    
    bar:Show()
    bar.enemyName = enemyData.name
    
    -- Secure Click
    if not InCombatLockdown() then
        bar:SetAttribute("type1", "macro")
        bar:SetAttribute("macrotext1", "/target " .. enemyData.name)
        bar:SetAttribute("type2", "macro")
        bar:SetAttribute("macrotext2", "/focus " .. enemyData.name)
    end
    
    local className = enemyData.class or "WARRIOR"
    local r, g, b = 0.5, 0.5, 0.5
    if Hissteria.ClassColors and Hissteria.ClassColors[className] then
        local c = Hissteria.ClassColors[className]
        r, g, b = c.r, c.g, c.b
    end
    
    bar.healthBar:SetVertexColor(r, g, b, 1)
    bar.bg:SetVertexColor(r * 0.3, g * 0.3, b * 0.3, 1) 
    
    local hp = enemyData.hp or 1
    bar.targetHealth = hp
    bar.hpText:SetText(string.format("%.0f%%", hp * 100))
    bar.nameText:SetText(enemyData.name or "Unknown")
    
    if Hissteria.SetClassIcon then Hissteria:SetClassIcon(bar.classIcon, className) end
    
    local iconTexture = nil
    if Hissteria.GetSpecIcon and enemyData.spec then
        iconTexture = Hissteria:GetSpecIcon(className, enemyData.spec)
    end
    
    if iconTexture and not string.find(iconTexture, "QuestionMark") then
        bar.specIcon:SetTexture(iconTexture)
        bar.specIcon:Show(); bar.specBg:Show()
    else
        bar.specIcon:Hide(); bar.specBg:Hide()
    end
    
    if enemyData.isHealer then bar.healerIcon:Show() else bar.healerIcon:Hide() end
    
    if enemyData.targetCount and enemyData.targetCount > 0 then
        bar.targetCount:SetText(enemyData.targetCount)
        bar.countFrame:Show()
        if enemyData.targetCount >= 3 then bar.countBg:SetVertexColor(0.6, 0, 0, 1) 
        else bar.countBg:SetVertexColor(0.1, 0.1, 0.1, 1) end
    else
        bar.countFrame:Hide()
    end
    
    if enemyData.trinketUsed then
        bar.trinketIcon:Show()
        if enemyData.trinketTime then bar.trinketCD:SetCooldown(enemyData.trinketTime, 120) end
    else
        bar.trinketIcon:Hide()
    end
    
    -- DEAD STATE LOGIC
    if enemyData.isDead then
        bar.deadOverlay:Show()
        bar.deadIcon:Show() -- MÅSTE visas nu med nya lagren
        
        bar.hpText:Hide()
        bar.nameText:SetTextColor(0.5, 0.5, 0.5)
        bar.specIcon:SetDesaturated(true)
    else
        bar.deadOverlay:Hide()
        bar.deadIcon:Hide()
        
        bar.hpText:Show()
        bar.nameText:SetTextColor(1, 1, 1)
        bar.specIcon:SetDesaturated(false)
    end
end

Hissteria:RegisterModule("EnemyBar", EnemyBar)