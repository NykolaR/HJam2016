-- grasscontrol.lua
-- Contains information on if a range has grass or not
-- Used by main/grass to know whether to render or not
--

local GrassModule = require ("game.grass")

local GrassControl = {}
GrassControl.__index = GrassControl

function GrassControl.new ()
    return setmetatable ({range = {}}, GrassControl)
end

-- Left x of empty range
-- Is empty for a width of 32
function GrassControl:fillRange (x1)
    table.insert (self.range, x1)
end

-- Returns true if the area has grass
-- False if not
function GrassControl:empty (x)
    local max = x + 32
    for i,v in pairs (self.range) do
        if v > x and v < max then
            return true
        end
    end
    return false
end

function GrassControl:anyEmpty (x)
    local min = x - 300
    local max = x + 300
    for i,v in pairs (self.range) do
        if v > min and v < max then
            return true
        end
    end
    return false
end

function GrassControl:playerOnEmpty (playerX)
    local max = playerX + 64
    local min = playerX
    for i,v in pairs (self.range) do
        if v > min and v < max then
            return true
        end
    end
    return false
end

return GrassControl
