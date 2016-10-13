--[[
-- conf.lua
-- Configures the window, game, etc.
-- Disables unused modules to enhance performance
-- ]]

function love.conf (t)
    -- Set window configurations
    t.window.width = 160 * 7
    t.window.height = 90 * 7
    t.window.title = "run"
    t.window.icon = "resources/images/icon.png"
    t.window.minwidth = 160
    t.window.minheight = 1

    -- Disable joystick, mouse, physics
    t.modules.joystick = false
    t.modules.physics = false
    t.modules.mouse = false
    t.modules.touch = false

end
