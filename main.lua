--[[
-- main.lua
-- Root of the game
-- Will do something, at least
-- ]]

local ground = {}
local PlayerModule = require ("game.player")
local Player = PlayerModule.new (100, love.graphics.getHeight () * 3 / 4 - 64) -- Set to ground height
local Input = require ("game.input.input")
local debug = false

local moon = {}

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
end

function love.update (dt)
    -- Will do some CRAZY stuff!
    Input.handleInputs ()

    Player:movement (dt)
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
    -- Draw the platform as a white rectangle while taking in the variables we declared above
    love.graphics.rectangle ('fill', ground.x, ground.y, ground.width, ground.height)
    
    if debug then
        love.graphics.setColor (255, 255, 255)
        love.graphics.print ("FPS: "..tostring (love.timer.getFPS ()), 10, 10)
    end
    
    love.graphics.setColor (0xBF, 0xD7, 0xEA)
    love.graphics.draw (moon.img, moon.x, moon.y, 0, .25, .25, 0, 0)

    Player:draw ()
end
