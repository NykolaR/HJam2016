--[[
-- grass.lua
-- Contains all things grass-like
-- It's pretty wild in here. Right. Now.
-- ]]

Grass = {}
Grass.__index = Grass

-- Grass Gameplay variables --
Grass.__y = love.graphics.getHeight () * 3 / 4 -- Grass bottom
Grass.__minHeight = -80 -- Min. Height

--   Grass Position Constraints   --
-- Can/Will probably be tightened --
--Grass.__minX = love.graphics.getWidth () / 4
--Grass.__maxX = love.graphics.getWidth () * 3 / 4
Grass.__middleX = love.graphics.getWidth () / 2
Grass.__minX = Grass.__middleX - 300
Grass.__maxX = Grass.__middleX + 300

--[[
-- Creates a grass table with x, height, and offset properties
-- ]]
function Grass.new (x, height, offset)
    return setmetatable ({x = x or Grass.__middleX, height = height or Grass.__minHeight, offset = offset or 0}, Grass)
end

function Grass:move (amount)
    self.x = self.x + amount
end

function Grass:wrap ()
    if self.x > Grass.__maxX then
        self.x = self.x - (Grass.__maxX - Grass.__minX)
    end
    if self.x < Grass.__minX then
        self.x = self.x + (Grass.__maxX - Grass.__minX)
    end
end

function Grass:wrapReset ()
    if self.x > Grass.__maxX then
        self.x = self.x - (Grass.__maxX - Grass.__minX)
        self:reset ()
    end
    if self.x < Grass.__minX then
        self.x = self.x + (Grass.__maxX - Grass.__minX)
        self:reset ()
    end
end

-- A gorgeous, all purpose update function --
-- Takes in x movement --
function Grass:moveWrapReset (amount)
    local amount = amount * -1
    self:move (amount)
    self:wrapReset ()
end

function Grass:reset ()
    self.height = Grass.__minHeight + love.math.random (40)
    self.offset = 10 - love.math.random (19)
    if self.x > Grass.__middleX then
        self.x = self.x - love.math.random (10)
    else
        self.x = self.x + love.math.random (10)
    end
end

function Grass:draw ()
    love.graphics.line (self.x, Grass.__y, self.x + self.offset, Grass.__y + self.height)
end

return Grass
