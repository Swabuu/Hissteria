-- Data/HealerSpecs.lua
local ADDON_NAME, Hissteria = ...

Hissteria.HealerSpecs = {
    ["Holy"] = true,
    ["Discipline"] = true,
    ["Restoration"] = true,
}

Hissteria.HealerClassSpecs = {
    PRIEST = { ["Holy"] = true, ["Discipline"] = true },
    PALADIN = { ["Holy"] = true },
    SHAMAN = { ["Restoration"] = true },
    DRUID = { ["Restoration"] = true },
}

function Hissteria:IsHealer(class, spec)
    if not class or not spec then return false end
    local classSpecs = self.HealerClassSpecs[class]
    if classSpecs and classSpecs[spec] then return true end
    return false
end
