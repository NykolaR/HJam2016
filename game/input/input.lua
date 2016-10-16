--[[
-- input.lua
-- Input handling
-- Can get key pressed / key held / key released
-- ]]

local input = {}
input ["INPUT"] = {KEY_DOWN = 1, KEY_PRESSED = 2}
input ["KEYS"] = {LEFT = 1, RIGHT = 2, UP = 3, DOWN = 4, ACTION = 5}
input ["KEYBOARD_KEYS"] = {LEFT = {"left", "a"}, RIGHT = {"right", "d"}, UP = {"up", "w"}, DOWN = {"down", "s"}, ACTION = {" ", "z"}}

input ["keys"] = {}

for x = 1, 2 do -- 2 columns
    input.keys [x] = {}

    for y = 1, #input.KEYS do
        input.keys [x][y] = false
    end
end

function input.handleInputs ()
    input:handleKeyboard ()
end

function input:handleKeyboard ()
    self:checkDown (self.KEYBOARD_KEYS.LEFT, self.KEYS.LEFT )
    self:checkDown (self.KEYBOARD_KEYS.RIGHT, self.KEYS.RIGHT )
    self:checkDown (self.KEYBOARD_KEYS.UP, self.KEYS.UP)
    self:checkDown (self.KEYBOARD_KEYS.DOWN, self.KEYS.DOWN)
    self:checkDown (self.KEYBOARD_KEYS.ACTION, self.KEYS.ACTION)
end

function input:checkDown (keyKeyboard, keyAction)
    if love.keyboard.isDown (keyKeyboard [1], keyKeyboard [2]) then
        self:setKey (keyAction, true)
    else
        self:setKey (keyAction, false)
    end
end

function input:setKey (key, value)
    if value then
        if self.keys [self.INPUT.KEY_DOWN][key] then
            -- Input is being held
            self.keys [self.INPUT.KEY_PRESSED][key] = false
            self.keys [self.INPUT.KEY_DOWN][key] = true
        else
            -- This is the first frame it was pressed
            self.keys [self.INPUT.KEY_DOWN][key] = true
            self.keys [self.INPUT.KEY_PRESSED][key] = true
        end
    else
        -- Not pressed
        self.keys [self.INPUT.KEY_DOWN][key] = false
        self.keys [self.INPUT.KEY_PRESSED][key] = false
    end
end

function input:keyPressed (key)
    return self.keys [self.INPUT.KEY_PRESSED][key]
end

function input:keyDown (key)
    return self.keys [self.INPUT.KEY_DOWN][key]
end

return input
