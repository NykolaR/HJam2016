--[[
-- main.lua
-- Root of the game
-- Will do something, at least
-- ]]

ground = {}

function love.load ()
    love.graphics.setBackgroundColor (0x0B, 0x39, 0x54, 0)

    love.window.setTitle ("run")

    -- The ground
    ground.width = love.graphics.getWidth () -- Platform = whole game window width
    ground.height = love.graphics.getHeight () / 2 -- As tall as half the window

    ground.x = 0
    ground.y = love.graphics.getHeight () * 3 / 4 -- 3/4 down screen
end

function love.update (dt)
    -- Will do some CRAZY stuff!
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

end


