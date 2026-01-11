-- Core/SlashCommands.lua
local ADDON_NAME, Hissteria = ...

SLASH_HISSTERIA1 = "/hissteria"
SLASH_HISSTERIA2 = "/hiss"
SLASH_HISSTERIA3 = "/hst"

local commands = {}

function Hissteria:RegisterCommand(cmd, handler, description)
    commands[cmd:lower()] = { handler = handler, description = description }
end

SlashCmdList["HISSTERIA"] = function(msg)
    local args = {}
    for word in msg:gmatch("%S+") do table.insert(args, word:lower()) end
    local cmd = args[1] or "help"
    table.remove(args, 1)
    if commands[cmd] then
        commands[cmd].handler(unpack(args))
    else
        Hissteria:Print("Unknown command: " .. cmd)
        commands["help"].handler()
    end
end

Hissteria:RegisterCommand("help", function()
    Hissteria:Print("|cFFFF6600=== HISSTERIA ===|r")
    Hissteria:Print("  /hiss test - Toggle mock mode")
    Hissteria:Print("  /hiss show - Show grid")
    Hissteria:Print("  /hiss hide - Hide grid")
    Hissteria:Print("  /hiss lock - Lock/unlock grid")
    Hissteria:Print("  /hiss reset - Reset position")
end, "Show help")

Hissteria:RegisterCommand("test", function()
    local MockMode = Hissteria:GetModule("MockMode")
    if MockMode then MockMode:Toggle() end
end, "Toggle mock mode")

Hissteria:RegisterCommand("show", function()
    local Grid = Hissteria:GetModule("Grid")
    if Grid then Grid:Show(); Hissteria:Print("Grid shown.") end
end, "Show grid")

Hissteria:RegisterCommand("hide", function()
    local Grid = Hissteria:GetModule("Grid")
    if Grid then Grid:Hide(); Hissteria:Print("Grid hidden.") end
end, "Hide grid")

Hissteria:RegisterCommand("lock", function()
    local Grid = Hissteria:GetModule("Grid")
    if Grid then Grid:ToggleLock() end
end, "Toggle lock")

Hissteria:RegisterCommand("reset", function()
    local Grid = Hissteria:GetModule("Grid")
    if Grid then Grid:ResetPosition(); Hissteria:Print("Position reset.") end
end, "Reset position")

Hissteria:RegisterCommand("debug", function()
    if Hissteria.db then
        Hissteria.db.debug = not Hissteria.db.debug
        Hissteria:Print("Debug: " .. (Hissteria.db.debug and "ON" or "OFF"))
    end
end, "Toggle debug")
