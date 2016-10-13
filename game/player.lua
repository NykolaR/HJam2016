--[[
-- player.lua
-- Contains all things player-like
-- It's pretty wild in here. Some day.
-- ]]

local Input = require ("game.input.input")

Player = {}
Player.__index = Player

-- Player Gameplay variables --
Player.__width = 32
Player.__height = 64
Player.__walkSpeedCap = 110 -- Player movement speed
Player.__xSpeedCap = 250 -- Player xSpeed limit
Player.__walkRate = 15
Player.__runRate = 20
Player.__friction = 5

--[[
-- Creates a Player table with x and y properties, metatable'd to Player
-- ]]
function Player.new (x, y)
    return setmetatable ({x = x or 0, y = y or 0, xSpeed = 0, ySpeed = 0}, Player)
end

function Player:update (dt)
    dt = dt or 10
end

function Player:movement (dt)
    local cap = self.__walkSpeedCap
    if Input:keyDown (Input ["KEYS"].LEFT) then
        if Input:keyDown (Input ["KEYS"].ACTION) then
            self:addXSpeed (-self.__runRate)
            cap = self.__xSpeedCap
        else
            self:addXSpeed (-self.__walkRate)
        end
    end

    if Input:keyDown (Input ["KEYS"].RIGHT) then
        if Input:keyDown (Input ["KEYS"].ACTION) then
            self:addXSpeed (self.__runRate)
            cap = self.__xSpeedCap
        else
            self:addXSpeed (self.__walkRate)
        end
    end
    
    self:horiLimits (cap)
    self:updateX (dt)
    self:friction ()
end

-- Increment xSpeed
function Player:addXSpeed (speed)
    self.xSpeed = self.xSpeed + speed
end

-- Speed naturally approaches zero
function Player:friction ()
    if self.xSpeed > 0 then
        self.xSpeed = self.xSpeed - self.__friction
        if self.xSpeed < 0 then
            self.xSpeed = 0
        end
    elseif self.xSpeed < 0 then
        self.xSpeed = self.xSpeed + self.__friction
        if self.xSpeed > 0 then
            self.xSpeed = 0
        end
    else
        self.xSpeed = 0
    end
end

function Player:moveX (x)
    self.x = self.x + x
end

-- Limit horizontal speed
function Player:horiLimits (cap)
    cap = cap or self.__xSpeedCap
    if self.xSpeed > cap then
        self.xSpeed = cap
    end

    if self.xSpeed < -cap then
        self.xSpeed = -cap
    end
end

-- The preferred method of movement
-- Will automatically multiply by supplied dt or by 10, and move by xSpeed
function Player:updateX (dt)
    dt = dt or 10
    self.x = self.x + self.xSpeed * dt
end

-- Draws the player.
-- No physical updates or variable changes. Simple a draw call
function Player:draw ()
    -- Temp --
    love.graphics.setColor (255, 255, 255)
    love.graphics.rectangle ('fill', self.x, self.y, self.__width, self.__height)
end

return Player
