-- Modules/SpecDetector.lua
-- Reliable Spec Detection from Combat Log
-- WotLK 3.3.5a Compatible

local ADDON_NAME, Hissteria = ...
print("|cFFFF6600[Hissteria]|r SpecDetector.lua loaded")

local SpecDetector = {}

-- Cache for detected specs
local detectedSpecs = {}

function SpecDetector:OnInitialize()
    -- Clear cache on init
    detectedSpecs = {}
end

function SpecDetector:OnEnable()
end

-- Main detection function
-- Returns: specName, isHealer
function SpecDetector:DetectSpec(class, spellId)
    if not class or not spellId then 
        return nil, false 
    end
    
    if not Hissteria.SpecSpells then 
        return nil, false 
    end
    
    local data = Hissteria.SpecSpells[spellId]
    if data and data.spec then
        return data.spec, data.isHealer or false
    end
    
    return nil, false
end

-- Get cached spec for an enemy (or detect from spellId)
function SpecDetector:GetEnemySpec(enemyName, class, spellId)
    if not enemyName then return nil, false end
    
    -- Check cache first
    if detectedSpecs[enemyName] then
        return detectedSpecs[enemyName].spec, detectedSpecs[enemyName].isHealer
    end
    
    -- Try to detect from spellId
    if spellId then
        local spec, isHealer = self:DetectSpec(class, spellId)
        if spec then
            -- Cache it
            detectedSpecs[enemyName] = {
                spec = spec,
                isHealer = isHealer,
                class = class
            }
            return spec, isHealer
        end
    end
    
    return nil, false
end

-- Clear cache for a specific enemy or all
function SpecDetector:ClearCache(enemyName)
    if enemyName then
        detectedSpecs[enemyName] = nil
    else
        detectedSpecs = {}
    end
end

-- Get all specs for a class (for debugging/display)
function SpecDetector:GetClassSpecs(class)
    local specs = {
        WARRIOR     = { "Arms", "Fury", "Protection" },
        PALADIN     = { "Holy", "Protection", "Retribution" },
        HUNTER      = { "Beast Mastery", "Marksmanship", "Survival" },
        ROGUE       = { "Assassination", "Combat", "Subtlety" },
        PRIEST      = { "Discipline", "Holy", "Shadow" },
        DEATHKNIGHT = { "Blood", "Frost", "Unholy" },
        SHAMAN      = { "Elemental", "Enhancement", "Restoration" },
        MAGE        = { "Arcane", "Fire", "Frost" },
        WARLOCK     = { "Affliction", "Demonology", "Destruction" },
        DRUID       = { "Balance", "Feral", "Restoration" },
    }
    return specs[class] or {}
end

Hissteria:RegisterModule("SpecDetector", SpecDetector)
