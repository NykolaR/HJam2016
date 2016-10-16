-- grassclump.lua
-- contains a clump of grass
-- the main game contains 2 of these: front, and back

local GrassModule = require ("game.grass")
local Colors = require ("game.display.colors")

local Clump = {}
Clump.__index = Clump

function Clump.new (offset)
    return setmetatable ({offset = offset or 0, grass = {}}, Clump)
end

function Clump:fill ()
    if #self.grass == 0 then
        for x = 1, (GrassModule.__maxX - GrassModule.__minX), 3 do
            table.insert (self.grass, GrassModule.new (GrassModule.__minX + x + self.offset, nil, nil))
        end
        
        for k,g in pairs (self.grass) do
            g:reset ()
        end
    end
end

function Clump:update (speed)
    for i,k in pairs (self.grass) do
        k:moveWrapReset (speed)
    end
end

-- Draws grass clump
-- Fills grass relative to player position / whether there's grass or not
function Clump:draw (playerPosition, grassControl)
    love.graphics.setColor (Colors.DarkGrey)
    if grassControl:anyEmpty (playerPosition) then
       for i,g in pairs (self.grass) do
           if not grassControl:empty (playerPosition + g.x - GrassModule.__middleX) then
               g:draw ()
           end
       end
    else
        for i,k in pairs (self.grass) do
            k:draw ()
        end
    end
end

return Clump
