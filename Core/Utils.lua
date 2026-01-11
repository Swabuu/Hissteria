-- Core/Utils.lua
local ADDON_NAME, Hissteria = ...

function Hissteria:TableCount(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

function Hissteria:CleanName(name)
    if not name then return nil end
    return name:match("([^-]+)") or name
end

function Hissteria:FormatHP(hp, maxHp)
    if not hp or not maxHp or maxHp == 0 then return "??%" end
    return string.format("%d%%", (hp / maxHp) * 100)
end

function Hissteria:RGBToHex(r, g, b)
    return string.format("%02X%02X%02X", r * 255, g * 255, b * 255)
end

function Hissteria:ColorText(text, r, g, b)
    return string.format("|cFF%s%s|r", self:RGBToHex(r, g, b), text)
end

function Hissteria:ClassColorText(text, class)
    local color = self.ClassColors and self.ClassColors[class]
    if not color then return text end
    return self:ColorText(text, color.r, color.g, color.b)
end
