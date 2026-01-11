-- Modules/CombatLog.lua
-- Logic: Actions = Alive

local ADDON_NAME, Hissteria = ...
local CombatLog = {}
function CombatLog:OnInitialize() end
function CombatLog:OnEnable()
    local f = CreateFrame("Frame")
    f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    f:SetScript("OnEvent", function() 
        self:ProcessLog(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12) 
    end)
end

function CombatLog:ProcessLog(timestamp, event, srcGUID, srcName, srcFlags, destGUID, destName, destFlags, spellId, ...)
    if not Hissteria.enemies then return end
    local now = GetTime()

    -- SOURCE: Fienden gjorde något -> De lever!
    if srcName then
        local src = Hissteria.enemies[Hissteria:CleanName(srcName)]
        if src then
            src.lastSeen = now
            src.isDead = false -- ALIVE!
            
            if event == "SPELL_CAST_SUCCESS" or event == "SPELL_AURA_APPLIED" then
                if spellId and Hissteria:IsTrinketSpell(spellId) then 
                    src.trinketUsed = now; src.trinketTime = now 
                end
                if event == "SPELL_CAST_SUCCESS" then
                    local SpecDetector = Hissteria:GetModule("SpecDetector")
                    if SpecDetector then
                        local spec, isHealer = SpecDetector:DetectSpec(src.class, spellId)
                        if spec then src.spec = spec; src.isHealer = isHealer end
                    end
                end
            end
        end
    end

    -- DEST: Fienden tog skada/heal -> De är nära
    if destName then
        local dest = Hissteria.enemies[Hissteria:CleanName(destName)]
        if dest then
            dest.lastSeen = now
            
            if event == "UNIT_DIED" then 
                dest.isDead = true
                dest.hp = 0
            elseif event == "SPELL_RESURRECT" then
                dest.isDead = false -- REZ!
                dest.hp = 1
            end
        end
    end
end

Hissteria:RegisterModule("CombatLog", CombatLog)