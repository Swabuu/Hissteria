-- Data/TrinketSpells.lua
local ADDON_NAME, Hissteria = ...

Hissteria.TrinketSpells = {
    [42292] = true,   -- PvP Trinket
    [59752] = true,   -- Every Man for Himself (Human)
    [7744]  = true,   -- Will of the Forsaken (Undead)
}

Hissteria.TRINKET_COOLDOWN = 120

function Hissteria:IsTrinketSpell(spellId)
    return self.TrinketSpells[spellId] == true
end
