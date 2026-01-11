-- Core/Events.lua
local ADDON_NAME, Hissteria = ...

local Events = {}
local eventCallbacks = {}

function Events:OnInitialize()
    self.frame = CreateFrame("Frame")
    self.frame:SetScript("OnEvent", function(frame, event, ...)
        self:FireEvent(event, ...)
    end)
end

function Events:OnEnable()
    self:RegisterEvent("PLAYER_TARGET_CHANGED")
    self:RegisterEvent("UNIT_HEALTH")
end

function Events:RegisterEvent(event)
    if self.frame then self.frame:RegisterEvent(event) end
    if not eventCallbacks[event] then eventCallbacks[event] = {} end
end

function Events:Subscribe(event, callback, owner)
    if not eventCallbacks[event] then self:RegisterEvent(event) end
    table.insert(eventCallbacks[event], { callback = callback, owner = owner })
end

function Events:FireEvent(event, ...)
    if not eventCallbacks[event] then return end
    for _, entry in ipairs(eventCallbacks[event]) do
        pcall(entry.callback, entry.owner, event, ...)
    end
end

Hissteria:RegisterModule("Events", Events)
