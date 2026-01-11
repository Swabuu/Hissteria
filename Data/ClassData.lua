-- Data/ClassData.lua
local ADDON_NAME, Hissteria = ...

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

function Hissteria:SetClassIcon(texture, class)
    if not class or not self.ClassIconCoords[class] then
        texture:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
        texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
        return false
    end
    local coords = self.ClassIconCoords[class]
    texture:SetTexture(self.ClassIconTexture)
    texture:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
    return true
end

function Hissteria:GetClassColorHex(class)
    local color = self.ClassColors[class]
    if not color then return "FFFFFF" end
    return string.format("%02X%02X%02X", color.r * 255, color.g * 255, color.b * 255)
end
