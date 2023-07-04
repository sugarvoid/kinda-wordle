--sound.lua

function loadSounds()
  local Sounds = {}
  Sounds.wrong = love.audio.newSource("audio/wrong.wav", "static")
  Sounds.correct = love.audio.newSource("audio/correct.wav", "static")
  return Sounds
end

function playSound(sound)
  love.audio.stop(sound)
  love.audio.play(sound)
end
