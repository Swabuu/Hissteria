-- Data/SpecIcons.lua
-- Hardcoded Spec Icons for WotLK 3.3.5a
-- Keys MUST match the spec names in SpecSpells.lua

local ADDON_NAME, Hissteria = ...
print("|cFFFF6600[Hissteria]|r SpecIcons.lua loaded")

Hissteria.SpecIcons = {
    
    -- ================================================================
    -- DEATH KNIGHT
    -- ================================================================
    ["DEATHKNIGHT"] = {
        ["Blood"]  = "Interface\\Icons\\Spell_Deathknight_BloodPresence",
        ["Frost"]  = "Interface\\Icons\\Spell_Deathknight_FrostPresence",
        ["Unholy"] = "Interface\\Icons\\Spell_Deathknight_UnholyPresence",
    },
    
    -- ================================================================
    -- DRUID
    -- ================================================================
    ["DRUID"] = {
        ["Balance"]     = "Interface\\Icons\\Spell_Nature_StarFall",
        ["Feral"]       = "Interface\\Icons\\Ability_Druid_CatForm",
        ["Restoration"] = "Interface\\Icons\\Spell_Nature_HealingTouch",
    },
    
    -- ================================================================
    -- HUNTER
    -- ================================================================
    ["HUNTER"] = {
        ["Beast Mastery"] = "Interface\\Icons\\Ability_Hunter_BeastCall",
        ["Marksmanship"]  = "Interface\\Icons\\Ability_Marksmanship",
        ["Survival"]      = "Interface\\Icons\\Ability_Hunter_Swiftstrike",
    },
    
    -- ================================================================
    -- MAGE
    -- ================================================================
    ["MAGE"] = {
        ["Arcane"] = "Interface\\Icons\\Spell_Holy_MagicalSentry",
        ["Fire"]   = "Interface\\Icons\\Spell_Fire_FlameBolt",
        ["Frost"]  = "Interface\\Icons\\Spell_Frost_FrostBolt02",
    },
    
    -- ================================================================
    -- PALADIN
    -- ================================================================
    ["PALADIN"] = {
        ["Holy"]        = "Interface\\Icons\\Spell_Holy_HolyBolt",
        ["Protection"]  = "Interface\\Icons\\Spell_Holy_DevotionAura",
        ["Retribution"] = "Interface\\Icons\\Spell_Holy_AuraOfLight",
    },
    
    -- ================================================================
    -- PRIEST
    -- ================================================================
    ["PRIEST"] = {
        ["Discipline"] = "Interface\\Icons\\Spell_Holy_PowerWordShield",
        ["Holy"]       = "Interface\\Icons\\Spell_Holy_GuardianSpirit",
        ["Shadow"]     = "Interface\\Icons\\Spell_Shadow_ShadowWordPain",
    },
    
    -- ================================================================
    -- ROGUE
    -- ================================================================
    ["ROGUE"] = {
        ["Assassination"] = "Interface\\Icons\\Ability_Rogue_Eviscerate",
        ["Combat"]        = "Interface\\Icons\\Ability_BackStab",
        ["Subtlety"]      = "Interface\\Icons\\Ability_Stealth",
    },
    
    -- ================================================================
    -- SHAMAN
    -- ================================================================
    ["SHAMAN"] = {
        ["Elemental"]   = "Interface\\Icons\\Spell_Nature_Lightning",
        ["Enhancement"] = "Interface\\Icons\\Spell_Nature_LightningShield",
        ["Restoration"] = "Interface\\Icons\\Spell_Nature_MagicImmunity",
    },
    
    -- ================================================================
    -- WARLOCK
    -- ================================================================
    ["WARLOCK"] = {
        ["Affliction"]  = "Interface\\Icons\\Spell_Shadow_DeathCoil",
        ["Demonology"]  = "Interface\\Icons\\Spell_Shadow_Metamorphosis",
        ["Destruction"] = "Interface\\Icons\\Spell_Shadow_RainOfFire",
    },
    
    -- ================================================================
    -- WARRIOR
    -- ================================================================
    ["WARRIOR"] = {
        ["Arms"]       = "Interface\\Icons\\Ability_Warrior_SavageBlow",
        ["Fury"]       = "Interface\\Icons\\Ability_Warrior_InnerRage",
        ["Protection"] = "Interface\\Icons\\Ability_Warrior_DefensiveStance",
    },
}

-- Get spec icon texture path
-- Returns nil if not found (no question mark fallback)
function Hissteria:GetSpecIcon(class, spec)
    if not class or not spec then
        return nil
    end
    
    local classIcons = self.SpecIcons[class]
    if not classIcons then
        return nil
    end
    
    local icon = classIcons[spec]
    if icon then
        return icon
    end
    
    return nil
end

-- Check if we have an icon for this spec
function Hissteria:HasSpecIcon(class, spec)
    return self:GetSpecIcon(class, spec) ~= nil
end
