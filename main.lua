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
    "S",
    "T",
    "O",
    "N",
    "E"
}

function love.load()
    font = love.graphics.newFont("monogram.ttf", 60)
    love.graphics.setFont(font)
    loadWord("grate")
    print(roundWord[1])
end


function love.draw()
  local x = 50 -- Starting x-coordinate for the labels
  local y = 50 -- Starting y-coordinate for the labels
  
  for i, letter in ipairs(letters) do
    if letter.is_used then
      love.graphics.setColor(255, 0, 0) -- Red color for used letters
    else
      love.graphics.setColor(255, 255, 255) -- White color for used letters
    end
    
    love.graphics.print(letter.value, x, y)
    x = x + 25 -- Increase the x-coordinate for the next label
  end
end

function resetLetters()
    for i, letter in ipairs(letters) do
        letter.is_used = false
    end
end

function love.keypressed(key, scancode)
    --print(key:upper())
    for i, letter in ipairs(letters) do
        if key:upper() == letter.value then
            if letter.is_used == true then
                print("letter already used")
                break
            else
                print("setting letter to used")
                letter.is_used = true
                break
            end
        end
    end
end

function loadWord(word)
    for i = 1, #word do
        local c = word:sub(i,i):upper()
        roundWord[i] = c
    end
end


