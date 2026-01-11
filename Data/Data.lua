-- Data/Data.lua
-- ALL static data for Hissteria (Consolidated)
local ADDON_NAME, Hissteria = ...
print("|cFFFF6600[Hissteria]|r Data.lua loaded")

-- 1. CLASS COLORS
Hissteria.ClassColors = {
    WARRIOR     = { r = 0.78, g = 0.61, b = 0.43 },
    PALADIN     = { r = 0.96, g = 0.55, b = 0.73 },
    HUNTER      = { r = 0.67, g = 0.83, b = 0.45 },
    ROGUE       = { r = 1.00, g = 0.96, b = 0.41 },
    PRIEST      = { r = 1.00, g = 1.00, b = 1.00 },
    DEATHKNIGHT = { r = 0.77, g = 0.12, b = 0.23 },
    SHAMAN      = { r = 0.00, g = 0.44, b = 0.87 },
    MAGE        = { r = 0.41, g = 0.80, b = 0.94 },
    WARLOCK     = { r = 0.58, g = 0.51, b = 0.79 },
    DRUID       = { r = 1.00, g = 0.49, b = 0.04 },
}

-- 2. CLASS ICONS (Atlas)
Hissteria.ClassIconTexture = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"
Hissteria.ClassIconCoords = {
    WARRIOR     = { 0.00, 0.25, 0.00, 0.25 },
    MAGE        = { 0.25, 0.50, 0.00, 0.25 },
    ROGUE       = { 0.50, 0.75, 0.00, 0.25 },
    DRUID       = { 0.75, 1.00, 0.00, 0.25 },
    HUNTER      = { 0.00, 0.25, 0.25, 0.50 },
    SHAMAN      = { 0.25, 0.50, 0.25, 0.50 },
    PRIEST      = { 0.50, 0.75, 0.25, 0.50 },
    WARLOCK     = { 0.75, 1.00, 0.25, 0.50 },
    PALADIN     = { 0.00, 0.25, 0.50, 0.75 },
    DEATHKNIGHT = { 0.25, 0.50, 0.50, 0.75 },
}

-- 3. SPEC ICONS (Hardcoded Paths for WotLK 3.3.5a)
Hissteria.SpecIcons = {
    PALADIN = {
        ["Holy"]        = "Interface\\Icons\\Spell_Holy_HolyBolt",
        ["Protection"]  = "Interface\\Icons\\Spell_Holy_SealOfProtection",
        ["Retribution"] = "Interface\\Icons\\Spell_Holy_AuraOfLight",
    },
    PRIEST = {
        ["Discipline"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
        ["Holy"]       = "Interface\\Icons\\Spell_Holy_Renew",
        ["Shadow"]     = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
    },
    DRUID = {
        ["Balance"]     = "Interface\\Icons\\Spell_Nature_ForceOfNature",
        ["Feral"]       = "Interface\\Icons\\Ability_Druid_CatForm",
        ["Restoration"] = "Interface\\Icons\\Spell_Nature_HealingTouch",
    },
    SHAMAN = {
        ["Elemental"]   = "Interface\\Icons\\Spell_Nature_Lightning",
        ["Enhancement"] = "Interface\\Icons\\Spell_Nature_LightningShield",
        ["Restoration"] = "Interface\\Icons\\Spell_Nature_MagicImmunity",
    },
    WARRIOR = {
        ["Arms"]       = "Interface\\Icons\\Ability_Warrior_SavageBlow",
        ["Fury"]       = "Interface\\Icons\\Ability_Warrior_InnerRage",
        ["Protection"] = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
    },
    DEATHKNIGHT = {
        ["Blood"]  = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
        ["Frost"]  = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
        ["Unholy"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
    },
    MAGE = {
        ["Arcane"] = "Interface\\Icons\\Spell_Holy_MagicalSentry",
        ["Fire"]   = "Interface\\Icons\\Spell_Fire_FireBolt02",
        ["Frost"]  = "Interface\\Icons\\Spell_Frost_FrostBolt02",
    },
    WARLOCK = {
        ["Affliction"]  = "Interface\\Icons\\Spell_Shadow_DeathCoil",
        ["Demonology"]  = "Interface\\Icons\\Spell_Shadow_Metamorphosis",
        ["Destruction"] = "Interface\\Icons\\Spell_Shadow_RainOfFire",
    },
    ROGUE = {
        ["Assassination"] = "Interface\\Icons\\Ability_Rogue_Eviscerate",
        ["Combat"]        = "Interface\\Icons\\Ability_BackStab",
        ["Subtlety"]      = "Interface\\Icons\\Ability_Stealth",
    },
    HUNTER = {
        ["Beast Mastery"] = "Interface\\Icons\\Ability_Hunter_BeastCall",
        ["Marksmanship"]  = "Interface\\Icons\\Ability_Marksmanship",
        ["Survival"]      = "Interface\\Icons\\Ability_Hunter_Swiftstrike",
    },
}

-- 4. HEALER DEFINITIONS
Hissteria.HealerSpecs = {
    ["Holy"] = true, ["Discipline"] = true, ["Restoration"] = true
}

-- 5. TRINKET SPELLS
Hissteria.TrinketSpells = {
    [42292] = true, [59752] = true, [7744] = true
}

-- 6. FUNCTIONS

-- Get Class Icon
function Hissteria:SetClassIcon(texture, class)
    if not class or not self.ClassIconCoords[class] then
        texture:SetTexture("")
        texture:Hide()
        return false
    end
    
    local coords = self.ClassIconCoords[class]
    texture:SetTexture(self.ClassIconTexture)
    texture:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    texture:Show()
    return true
end

-- Get Spec Icon
function Hissteria:GetSpecIcon(class, spec)
    if not class or not spec then return nil end
    
    if self.SpecIcons[class] and self.SpecIcons[class][spec] then
        return self.SpecIcons[class][spec]
    end
    
    return nil
end

-- Is Healer?
function Hissteria:IsHealer(class, spec)
    if not spec then return false end
    return self.HealerSpecs[spec] == true
end

-- Is Trinket?
function Hissteria:IsTrinketSpell(spellId)
    return self.TrinketSpells[spellId] == true
end

-- Get Class Color Hex
function Hissteria:GetClassColorHex(class)
    local color = self.ClassColors[class]
    if not color then return "FFFFFF" end
    return string.format("%02X%02X%02X", color.r * 255, color.g * 255, color.b * 255)
end

print("|cFFFF6600[Hissteria]|r Data.lua functions ready: GetSpecIcon=" .. tostring(Hissteria.GetSpecIcon ~= nil))
