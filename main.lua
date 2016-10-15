--[[
-- main.lua
-- Root of the game
-- Will do something, at least
-- ]]

local ground = {}
local PlayerModule = require ("game.player")
local Input = require ("game.input.input")
local GrassModule = require ("game.grass")
local debug = false
local Player = PlayerModule.new (GrassModule.__middleX, love.graphics.getHeight () * 3 / 4 - 64) -- Set to ground height

local shadow = {}

local moon = {}

local grassFront = {}
local grassBack = {}

for x = 1, GrassModule.__middleX, 3 do
    table.insert (grassFront, GrassModule.new (GrassModule.__minX + x, nil, nil))
    table.insert (grassBack, GrassModule.new (GrassModule.__minX + x + 1, nil, nil))
end

for k,g in pairs (grassFront) do
    g:reset ()
end

for k,g in pairs (grassBack) do
    g:reset ()
end

function love.load ()
    love.graphics.setBackgroundColor (0x0B, 0x39, 0x54)

    -- The ground
    ground.width = love.graphics.getWidth () -- Platform = whole game window width
    ground.height = love.graphics.getHeight () / 2 -- As tall as half the window

    ground.x = 0
    ground.y = love.graphics.getHeight () * 3 / 4 -- 3/4 down screen

    moon.x = love.graphics.getWidth () * 3 / 4 -- One quarter down screen
    moon.y = love.graphics.getHeight () / 6 -- 1/6 down screen width

    moon.img = love.graphics.newImage ("resources/images/moon.png")
    shadow.img = love.graphics.newImage ("resources/images/shadow.png")
end

function love.update (dt)
    -- Will do some CRAZY stuff!
    Input.handleInputs ()

    Player:movement ()

    for i,k in pairs (grassFront) do
        k:moveWrapReset (Player:getXSpeed () * dt)
    end

    for i,k in pairs (grassBack) do
        k:moveWrapReset (Player:getXSpeed () * dt)
    end
end

--[[
-- So, some temp. palette colors:
-- Black / Ground: 0x070707
-- Blue / Sky: 0x0B3954
-- Red / Blood: 0xB80C09
-- White / Moon: 0xFDFFFC
-- Lighter Blue / ??: 0x1F7A8C
-- Silver: 0xBFD7EA
--]]

function love.draw ()
    love.graphics.setColor (0x07, 0x07, 0x07)
    for i,k in pairs (grassBack) do
        k:draw ()
    end

    -- Draw the ground as a rectangle
    love.graphics.rectangle ('fill', ground.x, ground.y, ground.width, ground.height)
    
    if debug then
        love.graphics.setColor (255, 255, 255)
        love.graphics.print ("FPS: "..tostring (love.timer.getFPS ()), 10, 10)
    end
    
    love.graphics.setColor (0xBF, 0xD7, 0xEA)
    love.graphics.draw (moon.img, moon.x, moon.y, 0, .25, .25, 0, 0)

    Player:draw ()
    love.graphics.setColor (0x07, 0x07, 0x07)
    for i,k in pairs(grassFront) do
        k:draw ()
    end
end
