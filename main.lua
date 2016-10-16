--[[
-- main.lua
-- Root of the game
-- Will do something, at least
-- ]]

local skybars = {}
local PlayerModule = require ("game.player")
local Input = require ("game.input.input")
local Colors = require ("game.display.colors")
local ClumpModule = require ("game.grassclump")
local GrassModule = require ("game.grass")
local GrassControlModule = require ("game.grasscontrol")
local debug = true
local Player = PlayerModule.new (GrassModule.__middleX, love.graphics.getHeight () * 3 / 4 - 64) -- Set to ground height
local playerPosition = 0

local shadow = {}
--local moon = {}

local grassFrontControl = GrassControlModule.new ()
local grassBackControl = GrassControlModule.new ()

grassFrontControl:fillRange (100)
grassBackControl:fillRange (100)
grassFrontControl:fillRange (300)
grassBackControl:fillRange (300)
grassFrontControl:fillRange (500)
grassBackControl:fillRange (500)
grassFrontControl:fillRange (-300)
grassBackControl:fillRange (-300)

local grassFront = ClumpModule.new (0)
local grassBack = ClumpModule.new (1)

grassFront:fill ()
grassBack:fill ()

function love.load ()
    setSky (Colors.DarkBlue)

    loadConstants ()

    --moon.x = love.graphics.getWidth () * 3 / 4 -- One quarter down screen
    --moon.y = love.graphics.getHeight () / 6 -- 1/6 down screen width
    --moon.img = love.graphics.newImage ("resources/images/moon.png")
    shadow.img = love.graphics.newImage ("resources/images/shadow.png")
end

function loadConstants ()
    love.graphics.setLineWidth (2) -- Grass lines. Width. The usual.

    -- The ground
    skybars.gWidth = love.graphics.getWidth () -- Platform = whole game window width
    skybars.gHeight = love.graphics.getHeight () / 4 -- As tall as one quarter the window

    skybars.edgeWidth = love.graphics.getWidth () / 2 - 300 -- Width of bars
    skybars.edgeHeight = love.graphics.getHeight () * 3 / 4
    skybars.midWidth = 600
    skybars.midHeight = Player.y - 300
    skybars.edgeTwoX = Player.x + 300
    skybars.groundY = love.graphics.getHeight () * 3 / 4 -- 3/4 down screen
end

-- Updates inputs, movement calls, and any game logic
-- Also will exit game on ESC pressed!
-- The gameplay heart
function love.update (dt)

    if love.keyboard.isDown ("escape") then
        love.event.quit ()
    end

    Input.handleInputs () -- Update input handler

    Player:movement () -- Update players hSpeed

    grassFront:update (Player:getXSpeed () * dt)
    grassBack:update (Player:getXSpeed () * dt)
    playerPosition = playerPosition + Player:getXSpeed () * dt
end

-- Handles all rendering
-- Don't do any logic in here! None! Nada!
-- It'll mess you if/when you add a pause screen!
function love.draw ()

    grassBack:draw (playerPosition, grassBackControl) -- Draw background grass

    if grassFrontControl:playerOnEmpty (playerPosition) then
        love.graphics.setColor (Colors.DarkBlue)
    else
        love.graphics.setColor (Colors.Black)
    end
    fillSky () -- Fill out dark areas

    --
    --love.graphics.setColor (Colors.Silver)
    --love.graphics.draw (moon.img, moon.x, moon.y, 0, .25, .25, 0, 0)
    --

    Player:draw () -- Draw player

    grassFront:draw (playerPosition, grassFrontControl) -- Draw Front grass

    -- Draw overlay circle --
    love.graphics.draw (shadow.img, Player.x - 300, Player.y - 300, 0, 1, 1, 0, 0)
    
    if debug then FPS () end -- Draw FPS to screen
    
end

function FPS ()
    love.graphics.setColor (Colors.Silver)
    love.graphics.print ("FPS: "..tostring (love.timer.getFPS ()), 15, 15)
    love.graphics.print ("PlayerPos:"..tostring (playerPosition), 15, 35)
end

-- setSky (color)
-- Sets the sky color to arg
function setSky (color)
    love.graphics.setBackgroundColor (color)
end

-- fillSky ()
-- Fills the sky with skyboxes
function fillSky ()
    -- Draw the ground and skybars as rectangles --
    love.graphics.rectangle ('fill', 0, skybars.groundY, skybars.gWidth, skybars.gHeight)
    love.graphics.rectangle ('fill', 0, 0, skybars.edgeWidth, skybars.edgeHeight)
    love.graphics.rectangle ('fill', skybars.edgeWidth, 0, skybars.midWidth, skybars.midHeight)
    love.graphics.rectangle ('fill', skybars.edgeTwoX, 0, skybars.edgeWidth, skybars.edgeHeight)
end
