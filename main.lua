
--main.lua

require("lib.color")

local COLOR_DEFAULT
local COLOR_HIGHLIGHT
local font

local gamestate -- 0 = title, 1 = play, 2 = gameover
local letters = {
  {value = "A", is_used = false},
  {value = "B", is_used = false},
  {value = "C", is_used = false},
  {value = "D", is_used = false},
  {value = "E", is_used = false},
  {value = "F", is_used = false},
  {value = "G", is_used = false},
  {value = "H", is_used = false},
  {value = "I", is_used = false},
  {value = "J", is_used = false},
  {value = "K", is_used = false},
  {value = "L", is_used = false},
  {value = "M", is_used = false},
  {value = "N", is_used = false},
  {value = "O", is_used = false},
  {value = "P", is_used = false},
  {value = "Q", is_used = false},
  {value = "R", is_used = false},
  {value = "S", is_used = false},
  {value = "T", is_used = false},
  {value = "U", is_used = false},
  {value = "V", is_used = false},
  {value = "W", is_used = false},
  {value = "X", is_used = false},
  {value = "Y", is_used = false},
  {value = "Z", is_used = false}
}


local roundWord = {
    {value = "", font_color = COLOR_DEFAULT, is_showing = false},
    {value = "", font_color = COLOR_DEFAULT, is_showing = false},
    {value = "", font_color = COLOR_DEFAULT, is_showing = false},
    {value = "", font_color = COLOR_DEFAULT, is_showing = false},
    {value = "", font_color = COLOR_DEFAULT, is_showing = false}
}


local FILLERCHAR = "_"
local freeGuesses = 3
local allowedMisses = 5
local current_word

function love.load()
    gamestate = 0 
    font = love.graphics.newFont("monogram.ttf", 44)
    love.graphics.setFont(font)
    font:setFilter("nearest")
    startNewRound()
end


function love.draw()
    changeBgColor("#000000")
    drawLetters()
    drawWordDisplay()
    drawMisses()
end

function drawTitle()
    love.graphics.print("Game Title", 50, 200)
end

function drawLetters()
    local l_x = 50 -- Starting x-coordinate for the labels
    local l_y = 400 -- Starting y-coordinate for the labels
  
    for i, letter in ipairs(letters) do
        if letter.is_used then
            changeFontColor("#8F8F8F")
        else
            changeFontColor("#FFFFFF")
        end

        love.graphics.print(letter.value, l_x, l_y)
        if l_x >= 400 then
            l_x = 50
            l_y = 430
        end
        l_x = l_x + 25 -- Increase the x-coordinate for the next label
    end
end

function drawMisses()
    local d_x = 200
    local d_y = 140
    local w = 15
    local h=15

    for i = 1, allowedMisses do
        love.graphics.rectangle( "fill", d_x, d_y, w, h)
        d_x = d_x + 20
    end
end

function drawWordDisplay()
    local d_x = 200
    local d_y = 50

    for i, char in ipairs(roundWord) do
        if char.is_showing then
            love.graphics.print(char.value, d_x, d_y)
        else
            love.graphics.print(FILLERCHAR, d_x, d_y)
        end

        d_x = d_x + 25 -- Increase the x-coordinate for the next label
    end
end


function startNewRound()
    resetLetters()
    loadWord(getRandomWord())
end

function resetLetters()
    for i, letter in ipairs(letters) do
        letter.is_used = false
    end
    for i = 1, #roundWord do
        roundWord[i].is_showing = false
    end
end

function love.keypressed(key, scancode)
    if key == "escape" then
        if gamestate ~= 0 then
            gamestate = 0
        else
            love.event.quit()
        end
    end
    --print(key:upper())
    for i, letter in ipairs(letters) do
        if key:upper() == letter.value:upper() then
            print(letter.value)

            if letter.is_used == true then
                print("letter already used")

                break
            else
                print("setting letter to used")
                freeGuesses = freeGuesses - 1
                letter.is_used = true
                if checkWordForLetter(key) then
                    print("ding!!")
                else
                    print("wrong!!")
                    allowedMisses = allowedMisses - 1
                end
                print(allowedMisses)
                checkIfWordComplete()
                break
            end
        end
    end
end



function loadWord(word)
    for i = 1, #word do
        local c = word:sub(i,i):upper()
        roundWord[i].value = c
    end
end

function checkWordForLetter(letter)
    has_letter = false
    for i = 1, #roundWord do
        if roundWord[i].value == letter:upper() then
            --print("ding!!")
            roundWord[i].is_showing = true
            has_letter = true
            break
        else
            has_letter = false
        end
    end
    return has_letter
end

function checkIfWordComplete()
    if roundWord[1].is_showing == true and
        roundWord[2].is_showing == true and
        roundWord[3].is_showing == true and
        roundWord[4].is_showing == true and
        roundWord[5].is_showing == true then
        print("Word Done!!")
        startNewRound()
        return true
    --startNextRound()
    end
end

function getRandomWord()
    math.randomseed(os.time())
    local _ran = math.random(1,5757)
    local count = 0
    local _word 

    for line in love.filesystem.lines("sgb-words.txt") do
        count = count + 1
        if count == _ran then
            _word = line
            print(_word)
        end
    end
    return _word
end

